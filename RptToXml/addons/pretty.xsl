<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
     version="2.0">
    <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/Report">
        <style>
            .fieldused { color:green; font-weight:bold; }
            .fieldunused {color:grey}
            .label {font-weight:bold; color:black}
            .content {color:blue}
            .contentblock { outline:1px solid black; color: blue; padding: 5px 5px 5px 5px }
            .mainblock {background-color:#d5dff5;}
            .subblock {background-color:#e3eafa;}
        </style>
        <div class="mainblock">
        <h1>Report Detail for <xsl:value-of select="Summaryinfo/@ReportTitle" /></h1>          
        <span class="label">Report File:</span> <xsl:value-of select="@FileName" /><br />
        <span class="label">Comments(Used by Crystal Engine):</span><br />
        <div class="contentblock">
        <xsl:call-template
            name="repcr">
            <xsl:with-param name="text" select="Summaryinfo/@ReportComments" />
        </xsl:call-template>
        </div>   
        <span class="label">Orientation: </span><span class="content"><xsl:value-of select="PrintOptions/@PaperOrientation" /></span><br />
        <span class="label">Paper Size: </span><span class="content"><xsl:value-of select="PrintOptions/@PaperSize" /></span><br />
        <h2>Main Report</h2>
        <h3>Database Information</h3>
        <xsl:call-template name="database_info">
            <xsl:with-param name="dbnode" select="Database" />
        </xsl:call-template>
        <xsl:call-template name="selection_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <xsl:call-template name="group_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        <xsl:call-template name="sort_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <h3>Totals and Summaries</h3>
        <xsl:call-template name="runningtotal_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <xsl:call-template name="summary_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <xsl:call-template name="sqlexpression_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <xsl:call-template name="formula_info">
            <xsl:with-param name="ddefnode" select="DataDefinition" />
        </xsl:call-template>
        
        <h3>Areas &amp; Sections</h3>
        
        <xsl:call-template name="area_info">
            <xsl:with-param name="rptnode" select="ReportDefinition" />
        </xsl:call-template>
        <div class="subblock">
        <xsl:call-template name="subreport_info" />
        </div></div>
    </xsl:template>
    <!-- *************************************************** -->
    <xsl:template name="subreport_info" match="//SubReports/Report"> 
        <xsl:for-each select="//SubReports/Report">
          
            <h2>Sub Report Detail for <xsl:value-of select="@Name" /></h2>          
            <h3>Database Information</h3>
            <xsl:call-template name="database_info">
                <xsl:with-param name="dbnode" select="Database" />
            </xsl:call-template>
            <xsl:call-template name="selection_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
            <xsl:call-template name="group_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            <xsl:call-template name="sort_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
            <h3>Totals and Summaries</h3>
            <xsl:call-template name="runningtotal_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
            <xsl:call-template name="summary_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
            <xsl:call-template name="sqlexpression_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
            <xsl:call-template name="formula_info">
                <xsl:with-param name="ddefnode" select="DataDefinition" />
            </xsl:call-template>
            
         
            <h3>Areas &amp; Sections</h3>
            
            <xsl:call-template name="area_info">
                <xsl:with-param name="rptnode" select="ReportDefinition" />
            </xsl:call-template>
         
           
        </xsl:for-each> 
    
    </xsl:template>
    
    <!-- Calling Templates *************************************** -->
   
    
    <xsl:template name="area_info">
        <xsl:param name="rptnode" />
        
        <dl>
        <xsl:for-each select="$rptnode/Areas/Area">
            <dt><span class="label">Area Name: </span><span class="content"><xsl:value-of select="@Name" /></span></dt>
            <dd><span class="label">Type: </span><span class="content"><xsl:value-of select="@Kind" /></span></dd>
            <dd><span class="label">Sections: </span><br />
                <dl> <xsl:call-template name="section_info">
                    <xsl:with-param name="areanode" select="." />
                </xsl:call-template></dl></dd>
        </xsl:for-each>
        </dl>
    </xsl:template>
    
    <xsl:template name="section_info">
        <xsl:param name="areanode" />
        <dl>
            <xsl:for-each select="$areanode/Sections/Section">
                <dd><span class="label">Section Name: </span><span class="content"><xsl:value-of select="@Name" /></span></dd>
                <dd><dl>
                    <dd><xsl:call-template name="sectiondata_info">
                        <xsl:with-param name="rptobjnode" select="./ReportObjects" />
                    </xsl:call-template></dd>
                </dl></dd>
            
                
            </xsl:for-each>
        </dl>
    </xsl:template>
    
    <xsl:template name="sectiondata_info">
        <xsl:param name="rptobjnode" />
        <dl>
            <xsl:for-each select="$rptobjnode/FieldObject">
                <dt><span class="label">Field Name: </span><span class="content"><xsl:value-of select="@Name" /></span></dt>
                <dd><span class="label">Data Source: </span><span class="content"><xsl:value-of select="@DataSource" /></span></dd>
       
                
            </xsl:for-each>
        </dl>
    </xsl:template>
    
    <xsl:template name="database_info">
        <xsl:param name="dbnode" />
        <h4>Database Tables</h4>
            <xsl:for-each select="$dbnode/Tables/Table">
                <span class="label">Table Name: </span><span class="content"><xsl:value-of select="@Name" /></span><br/>
                <span class="label">Alias: </span><span class="content"><xsl:value-of select="@Alias" /></span><br/>
                <span class="label">Class: </span><span class="content"><xsl:value-of select="@ClassName" /></span><br/>  			
                <h3>Fields <span class="fieldused">(Green Color denotes usage)</span></h3>
                <xsl:call-template name="fields_info">
                    <xsl:with-param name="fieldsnode" select="Fields" />
                </xsl:call-template>
            
            </xsl:for-each>
        
    </xsl:template>
    <xsl:template name="selection_info">
        <xsl:param name="ddefnode" />
        <h4>Record Selection Criteria</h4>
        <div class="contentblock">
        <xsl:call-template
            name="repcr">
            <xsl:with-param name="text" select="$ddefnode/RecordSelectionFormula" />
        </xsl:call-template>
        </div>
       <br/>    
    </xsl:template>
    <xsl:template name="group_info">
        <xsl:param name="ddefnode" />
        <h3>Grouping Levels in Order</h3>
        <xsl:for-each select="$ddefnode/Groups/Group">
            <span class="content"><xsl:value-of select="@ConditionField" /></span><br/>
        </xsl:for-each>     
    </xsl:template>
    
    <xsl:template name="runningtotal_info">
        <xsl:param name="ddefnode" />
        <h4>Running Total Fields</h4>
        <dl>
            <xsl:for-each select="$ddefnode/RunningTotalFieldDefinitions/RunningTotalFieldDefinition">
              <dt>Foo</dt>
                <dt><span class="label">Evaluation Condition:</span><span class="content"><xsl:value-of select="@EvaluationConditionType" /></span></dt>
                <dd><span class="label">Formula Name:</span><span class="content"><xsl:value-of select="@FormulaName" /></span></dd>
                <dd><span class="label">Kind:</span><span class="content"><xsl:value-of select="@Kind" /></span></dd>  
                <dd><span class="label">Operation:</span><span class="content"><xsl:value-of select="@Operation" /></span></dd>                
                <dd><span class="label">Operation Parameter:</span><span class="content"><xsl:value-of select="@OperationParameter" /></span></dd>
                <dd><span class="label">Reset Condition:</span><span class="content"><xsl:value-of select="@ResetConditionType" /></span></dd>
                <dd><span class="label">Summarized Field:</span><span class="content"><xsl:value-of select="@SummarizedField" /></span></dd>     
            </xsl:for-each>
        </dl>    
    </xsl:template>
    
    <xsl:template name="summary_info">
        <xsl:param name="ddefnode" />
        <h4>Summary Fields</h4>
        <dl>
            <xsl:for-each select="$ddefnode/SummaryFields/SummaryFieldDefinition">
                  <dd><span class="label">Formula Name:</span><span class="content"><xsl:value-of select="@FormulaName" /></span></dd>
                <dd><span class="label">Group:</span><span class="content"><xsl:value-of select="@Group" /></span></dd>  
                <dd><span class="label">Operation:</span><span class="content"><xsl:value-of select="@Operation" /></span></dd>                
                <dd><span class="label">Operation Parameter:</span><span class="content"><xsl:value-of select="@OperationParameter" /></span></dd>
            </xsl:for-each>
        </dl>    
    </xsl:template>
    
    <xsl:template name="sort_info">
        <xsl:param name="ddefnode" />
        <h4>Sorting Levels in Order</h4>
        <dl>
        <xsl:for-each select="$ddefnode/SortFields/SortField">
            <dt><span class="label">Field:</span><span class="content"><xsl:value-of select="@Field" /></span></dt>
            <dd><span class="label">Sort Direction:</span><span class="content"><xsl:value-of select="@SortDirection" /></span></dd>
            <dd><span class="label">Sort Type:</span><span class="content"><xsl:value-of select="@SortType" /></span></dd>                
        </xsl:for-each>
        </dl>
    </xsl:template>
    
    <xsl:template name="formula_info">
        <xsl:param name="ddefnode" />
        <h4>Report Formulas</h4>
        <xsl:for-each select="$ddefnode/FormulaFieldDefinitions/FormulaFieldDefinition">
            <dl>
                <dt><span class="label">Formula Name:</span><span class="content"><xsl:value-of select="@FormulaName" /></span></dt>   
            <dd><span class="label">Value Type:</span><span class="content"><xsl:value-of select="@ValueType" /></span></dd>
                <dd><span class="label">Formula Code:</span><br /><div class="contentblock">
            <pre>
            <xsl:value-of select="."/>
            </pre>
        </div></dd></dl>
        </xsl:for-each>
        <br/>    
    </xsl:template>
    
    <xsl:template name="sqlexpression_info">
        <xsl:param name="ddefnode" />
        <h4>SQL Expression Formulas</h4>
        <xsl:for-each select="$ddefnode/SQLExpressionFields/SQLExpressionFieldDefinition">
            <dl>
                <dt><span class="label">SQL Formula Name:</span><span class="content"><xsl:value-of select="@FormulaName" /></span></dt>   
                <dd><span class="label">Kind</span><span class="content"><xsl:value-of select="@Kind" /></span></dd>
                <dd><span class="label">Value Type:</span><span class="content"><xsl:value-of select="@ValueType" /></span></dd>
                <dd><div class="contentblock">
                    <pre>
            <xsl:value-of select="@Text"/>
            </pre>
                </div></dd></dl>
        </xsl:for-each>
        <br/>    
    </xsl:template>
    
    <xsl:template name="repcr">
        <xsl:param name="text" />
        <xsl:for-each select="tokenize($text, '&#xD;&#xA;')">
            <xsl:value-of select="." /><br/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="fields_info">
        <xsl:param name="fieldsnode" />
            <xsl:for-each select="$fieldsnode/Field">
                <xsl:choose>
                    <xsl:when test="@UseCount > 0">
                        <span class="fieldused"><xsl:value-of select="@LongName" /></span><br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="fieldunused"><xsl:value-of select="@LongName" /></span><br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
    </xsl:template>
  
</xsl:stylesheet>