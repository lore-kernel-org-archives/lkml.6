Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D13C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DF620665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DF620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJZQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:17:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:17:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7f5Tg138591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:41:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7f4kF138588;
        Fri, 26 Oct 2018 00:41:04 -0700
Date:   Fri, 26 Oct 2018 00:41:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4be9ace7e1cdcb44c1fba1fb41ec2b92dda06732@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, adrian.hunter@intel.com, ak@linux.intel.com,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          ak@linux.intel.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20181001062853.28285-11-adrian.hunter@intel.com>
References: <20181001062853.28285-11-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py: Add
 data helper functions
Git-Commit-ID: 4be9ace7e1cdcb44c1fba1fb41ec2b92dda06732
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4be9ace7e1cdcb44c1fba1fb41ec2b92dda06732
Gitweb:     https://git.kernel.org/tip/4be9ace7e1cdcb44c1fba1fb41ec2b92dda06732
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:25:42 -0300

perf scripts python: call-graph-from-sql.py: Add data helper functions

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
