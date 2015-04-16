<!DOCTYPE html>
<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="EF" uri="/WEB-INF/framework/tlds/EF-2.0.tld" %>

<%
	String contextpath = request.getContextPath();
	String baseUrl = contextpath;
	String listUrl = baseUrl + "/DispatchAction.do";
	String isView = request.getParameter("isView");
	isView = isView==null?"":isView;
%>

<html>
 <head>	
  <script type="text/javascript" src="./EF/iplat-ui-2.0.js"></script>
  <script type="text/javascript" src="./EC/QM/ECQM01.js"></script>
 </head>
 
 <body class="bodyBackground">
  <form id="form" method="POST" action="<%=listUrl%>">
  
 
  <div id = "ef_region_result" style="overflow:auto;">
  		
  
	<table style="width:100%;height:90%;" border = "0">  
	  <c:set var="isView" value="<%=isView%>"/>
	  <c:set var="form" value="${ei.blocks.r0}"/>
	  <c:set var="question" value="${ei.blocks.r1}"/>
	  <c:set var="selection" value="${ei.blocks.r2}"/>
  	<tr>
  	<td>
  		<!--问卷头-->
  		<p style="text-align:center;font-size:20px;font-weight:bold;">${form.rows[0].questionnaireName}</p>
  		<div style="text-align:center;white-space:nowrap;width:90%;" >开始日期:
	  		<c:if test="${fn:length(form.rows[0].startTime)==8}">
	  			<!--8位日期格式-->
	  			${fn:substring(form.rows[0].startTime,0,4)}-${fn:substring(form.rows[0].startTime,4,6)}-${fn:substring(form.rows[0].startTime,6,8)}
	  		</c:if>
	  		<c:if test="${fn:length(form.rows[0].startTime)==14}">
	  			<!--14位日期格式-->
	  		</c:if>
	  		&nbsp;&nbsp;
	  		结束日期:
	  		<c:if test="${fn:length(form.rows[0].endTime)==8}">
	  			<!--8位日期格式-->
	  			${fn:substring(form.rows[0].endTime,0,4)}-${fn:substring(form.rows[0].endTime,4,6)}-${fn:substring(form.rows[0].endTime,6,8)}
	  		</c:if>
	  		<c:if test="${fn:length(form.rows[0].endTime)==14}">
	  			<!--14位日期格式-->
	  		</c:if>
  		</div>
  		
  		<hr style="width:95%;">
  		
  		<!--问卷主体-->
  				<table align="center" style="width:100%;height:90%;border:0px solid silver;overflow:visible;">
  					<tr>
  					<td>
  						<div style="text-align:left;font-size:15px;width:90%;">&nbsp;&nbsp;&nbsp;&nbsp;${form.rows[0].questionnaireForeword}</div>
  						<input type="hidden" id="isView" value="${isView}"/>
  						<input type="hidden" id="q1-0-questionnaireId" name="q1-0-questionnaireId" value="${form.rows[0].questionnaireId}"/>
  						<input type="hidden" name="q1-0-isAnony" value="${form.rows[0].isAnony}"/>
  						<input type="hidden" id="q1-0-questionnaireState" name="q1-0-questionnaireState" value="${form.rows[0].questionnaireState}"/>
  						<input type="hidden" id="q1-0-startTime" name="q1-0-startTime" value="${form.rows[0].startTime}"/>
  						<input type="hidden" id="q1-0-endTime" name="q1-0-endTime" value="${form.rows[0].endTime}"/>
  					</td>
  					</tr>
  					<tr>
  					<td style="text-align:left;font-size:15px;">
  						<c:set var="questionIndex" value="0"/><!--问题计数器-->
  						<!--问题循环开始-->
  						<c:forEach items="${ei.blocks.r1.rows}" var="question">
  						<ul>
  							<li style="list-style-type:square">
  								${question.orderCondition}.${question.questionDesc}
  										<c:if  test="${question.selectionLimitType=='='}">
  											<u style="font-size:10px;">(选择${question.selectionLimitValue}项)</u>
  										</c:if>
  										<c:if  test="${question.selectionLimitType=='>'}">
  											<u style="font-size:10px;">(选择${question.selectionLimitValue}项以上)</u>
  										</c:if>
  										<c:if  test="${question.selectionLimitType=='>='}">
  											<u style="font-size:10px;">(选择${question.selectionLimitValue}项或以上)</u>
  										</c:if>
  										<c:if  test="${question.selectionLimitType=='<'}">
  											<u style="font-size:10px;">(选择${question.selectionLimitValue}项以下)</u>
  										</c:if>
  										<c:if  test="${question.selectionLimitType=='<='}">
  											<u style="font-size:10px;">(选择${question.selectionLimitValue}项以内)</u>
  										</c:if>
  							</li>
  							<input type="hidden" id="result-${questionIndex}-questionId" name="result-${questionIndex}-questionId" value="${question.questionId}"/>
  							<input type="hidden" id="result-${questionIndex}-questionType" value="${question.questionType}"/>
  							<input type="hidden" id="result-${questionIndex}-selectionLimitType" value="${question.selectionLimitType}"/>
  							<input type="hidden" id="result-${questionIndex}-selectionLimitValue" value="${question.selectionLimitValue}"/>
  							<input type="hidden" id="result-${questionIndex}-selectionId" name="result-${questionIndex}-selectionId"/>
  							<!--选项循环开始-->
  							<c:forEach items="${ei.blocks.r2.rows}" var="selection">
  								<c:if  test="${question.questionId==selection.questionId}">
  									<div style="display:block;">
  										<c:if  test="${question.questionType==0}">
  											<input type="radio" name="r3-${questionIndex}" value="${selection.selectionId}" onclick="setRadioValue(${questionIndex})" ${isView=="true"?"disabled=true":""}/>
  										</c:if>
  										<c:if  test="${question.questionType==1}">
  											<input type="checkbox" name="r3-${questionIndex}" value="${selection.selectionId}" onclick="setCheckboxValue(${questionIndex})" ${isView=="true"?"disabled=true":""}/>
  										</c:if>
  										${selection.selectionDesc}
  									</div>
  								</c:if>
  							</c:forEach>
  							<!--选项循环结束-->
  						</ul>
  						<c:set var="questionIndex" value="${questionIndex+1}"/>
  						</c:forEach>
  						<!--问题循环结束-->
  					</td>
  					
  				</table>
  			
  	</td>
  	</tr>
  </table>
  	<div style="position:relative;text-align:center;"><button type='button' id="submit" onClick="button_submit_onclick()">提交</button> &nbsp;<button type='button' id="viewresult" onClick="button_viewresult_onclick()">查看结果</button></div>
 </div>
  
  </form>
  
  </body>
  </html>