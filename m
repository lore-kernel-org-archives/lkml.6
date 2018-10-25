Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648B820847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnh/xYsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648B820847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJYToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeJYToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1E82075D;
        Thu, 25 Oct 2018 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465916;
        bh=OUEwlRRvDVmQY8fnfRrt8ILasSx6k6ANIu+V4g3hbYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnh/xYsVV2G1L9GWsPNxa7KSsOzVO5Rc/zTQyJXtwshd6MOhYCAo7Xt4UUc7R7PK/
         mE3bAPR8//eVRvhOSfbThAWdtW7Cw7eIEm0qkmz+S75vjx0nCihgOK4vwrB13J5nul
         +YzxlrBBiGtD4Hvbxw1DK8OuMdJVJG+z1+2zBUpo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/37] perf scripts python: call-graph-from-sql.py: Add data helper functions
Date:   Thu, 25 Oct 2018 08:10:19 -0300
Message-Id: <20181025111031.3440-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add helper functions for a few common cases.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 54 +++++++++++++-----------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index ada486048ad8..7f2eabe7dacd 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -52,6 +52,28 @@ from PySide.QtGui import *
 from PySide.QtSql import *
 from decimal import *
 
+# Data formatting helpers
+
+def dsoname(name):
+	if name == "[kernel.kallsyms]":
+		return "[kernel]"
+	return name
+
+# Percent to one decimal place
+
+def PercentToOneDP(n, d):
+	if not d:
+		return "0.0"
+	x = (n * Decimal(100)) / d
+	return str(x.quantize(Decimal(".1"), rounding=ROUND_HALF_UP))
+
+# Helper for queries that must not fail
+
+def QueryExec(query, stmt):
+	ret = query.exec_(stmt)
+	if not ret:
+		raise Exception("Query failed: " + query.lastError().text())
+
 class TreeItem():
 
 	def __init__(self, db, row, parent_item):
@@ -73,9 +95,7 @@ class TreeItem():
 	def setUpRoot(self):
 		self.query_done = True
 		query = QSqlQuery(self.db)
-		ret = query.exec_('SELECT id, comm FROM comms')
-		if not ret:
-			raise Exception("Query failed: " + query.lastError().text())
+		QueryExec(query, 'SELECT id, comm FROM comms')
 		while query.next():
 			if not query.value(0):
 				continue
@@ -91,9 +111,7 @@ class TreeItem():
 		self.child_items = []
 		self.child_count = 0
 		query = QSqlQuery(self.db)
-		ret = query.exec_('SELECT thread_id, ( SELECT pid FROM threads WHERE id = thread_id ), ( SELECT tid FROM threads WHERE id = thread_id ) FROM comm_threads WHERE comm_id = ' + str(comm_id))
-		if not ret:
-			raise Exception("Query failed: " + query.lastError().text())
+		QueryExec(query, 'SELECT thread_id, ( SELECT pid FROM threads WHERE id = thread_id ), ( SELECT tid FROM threads WHERE id = thread_id ) FROM comm_threads WHERE comm_id = ' + str(comm_id))
 		while query.next():
 			child_item = TreeItem(self.db, self.child_count, self)
 			self.child_items.append(child_item)
@@ -114,18 +132,6 @@ class TreeItem():
 	def getRow(self):
 		return self.row
 
-	def timePercent(self, b):
-		if not self.time:
-			return "0.0"
-		x = (b * Decimal(100)) / self.time
-		return str(x.quantize(Decimal('.1'), rounding=ROUND_HALF_UP))
-
-	def branchPercent(self, b):
-		if not self.branch_count:
-			return "0.0"
-		x = (b * Decimal(100)) / self.branch_count
-		return str(x.quantize(Decimal('.1'), rounding=ROUND_HALF_UP))
-
 	def addChild(self, call_path_id, name, dso, count, time, branch_count):
 		child_item = TreeItem(self.db, self.child_count, self)
 		child_item.comm_id = self.comm_id
@@ -134,14 +140,12 @@ class TreeItem():
 		child_item.branch_count = branch_count
 		child_item.time = time
 		child_item.data[0] = name
-		if dso == "[kernel.kallsyms]":
-			dso = "[kernel]"
-		child_item.data[1] = dso
+		child_item.data[1] = dsoname(dso)
 		child_item.data[2] = str(count)
 		child_item.data[3] = str(time)
-		child_item.data[4] = self.timePercent(time)
+		child_item.data[4] = PercentToOneDP(time, self.time)
 		child_item.data[5] = str(branch_count)
-		child_item.data[6] = self.branchPercent(branch_count)
+		child_item.data[6] = PercentToOneDP(branch_count, self.branch_count)
 		self.child_items.append(child_item)
 		self.child_count += 1
 
@@ -189,12 +193,12 @@ class TreeItem():
 			self.branch_count = total_branch_count
 			if self.branch_count:
 				for child_item in self.child_items:
-					child_item.data[6] = self.branchPercent(child_item.branch_count)
+					child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
 		if total_time > self.time:
 			self.time = total_time
 			if self.time:
 				for child_item in self.child_items:
-					child_item.data[4] = self.timePercent(child_item.time)
+					child_item.data[4] = PercentToOneDP(child_item.time, self.time)
 
 	def childCount(self):
 		if not self.query_done:
-- 
2.14.4

