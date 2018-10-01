Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65763C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF04206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF04206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeJANL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:53642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbeJANL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466508"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] perf scripts python: call-graph-from-sql.py: Refactor TreeItem class
Date:   Mon,  1 Oct 2018 09:28:45 +0300
Message-Id: <20181001062853.28285-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

class TreeItem represents items at all levels of the call-graph tree.
However, not all the levels represent the same data i.e. the top-level is
comms, the next level is threads, and subsequent levels are functions.
Consequently it is simpler to have separate classes for different levels
with commonality in a base class. Refactor TreeItem class accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/call-graph-from-sql.py     | 273 +++++++++---------
 1 file changed, 133 insertions(+), 140 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 7f2eabe7dacd..ee1085169a3e 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -74,145 +74,6 @@ def QueryExec(query, stmt):
 	if not ret:
 		raise Exception("Query failed: " + query.lastError().text())
 
-class TreeItem():
-
-	def __init__(self, db, row, parent_item):
-		self.db = db
-		self.row = row
-		self.parent_item = parent_item
-		self.query_done = False;
-		self.child_count = 0
-		self.child_items = []
-		self.data = ["", "", "", "", "", "", ""]
-		self.comm_id = 0
-		self.thread_id = 0
-		self.call_path_id = 1
-		self.branch_count = 0
-		self.time = 0
-		if not parent_item:
-			self.setUpRoot()
-
-	def setUpRoot(self):
-		self.query_done = True
-		query = QSqlQuery(self.db)
-		QueryExec(query, 'SELECT id, comm FROM comms')
-		while query.next():
-			if not query.value(0):
-				continue
-			child_item = TreeItem(self.db, self.child_count, self)
-			self.child_items.append(child_item)
-			self.child_count += 1
-			child_item.setUpLevel1(query.value(0), query.value(1))
-
-	def setUpLevel1(self, comm_id, comm):
-		self.query_done = True;
-		self.comm_id = comm_id
-		self.data[0] = comm
-		self.child_items = []
-		self.child_count = 0
-		query = QSqlQuery(self.db)
-		QueryExec(query, 'SELECT thread_id, ( SELECT pid FROM threads WHERE id = thread_id ), ( SELECT tid FROM threads WHERE id = thread_id ) FROM comm_threads WHERE comm_id = ' + str(comm_id))
-		while query.next():
-			child_item = TreeItem(self.db, self.child_count, self)
-			self.child_items.append(child_item)
-			self.child_count += 1
-			child_item.setUpLevel2(comm_id, query.value(0), query.value(1), query.value(2))
-
-	def setUpLevel2(self, comm_id, thread_id, pid, tid):
-		self.comm_id = comm_id
-		self.thread_id = thread_id
-		self.data[0] = str(pid) + ":" + str(tid)
-
-	def getChildItem(self, row):
-		return self.child_items[row]
-
-	def getParentItem(self):
-		return self.parent_item
-
-	def getRow(self):
-		return self.row
-
-	def addChild(self, call_path_id, name, dso, count, time, branch_count):
-		child_item = TreeItem(self.db, self.child_count, self)
-		child_item.comm_id = self.comm_id
-		child_item.thread_id = self.thread_id
-		child_item.call_path_id = call_path_id
-		child_item.branch_count = branch_count
-		child_item.time = time
-		child_item.data[0] = name
-		child_item.data[1] = dsoname(dso)
-		child_item.data[2] = str(count)
-		child_item.data[3] = str(time)
-		child_item.data[4] = PercentToOneDP(time, self.time)
-		child_item.data[5] = str(branch_count)
-		child_item.data[6] = PercentToOneDP(branch_count, self.branch_count)
-		self.child_items.append(child_item)
-		self.child_count += 1
-
-	def selectCalls(self):
-		self.query_done = True;
-		query = QSqlQuery(self.db)
-		ret = query.exec_('SELECT id, call_path_id, branch_count, call_time, return_time, '
-				  '( SELECT name FROM symbols WHERE id = ( SELECT symbol_id FROM call_paths WHERE id = call_path_id ) ), '
-				  '( SELECT short_name FROM dsos WHERE id = ( SELECT dso_id FROM symbols WHERE id = ( SELECT symbol_id FROM call_paths WHERE id = call_path_id ) ) ), '
-				  '( SELECT ip FROM call_paths where id = call_path_id ) '
-				  'FROM calls WHERE parent_call_path_id = ' + str(self.call_path_id) + ' AND comm_id = ' + str(self.comm_id) + ' AND thread_id = ' + str(self.thread_id) +
-				  ' ORDER BY call_path_id')
-		if not ret:
-			raise Exception("Query failed: " + query.lastError().text())
-		last_call_path_id = 0
-		name = ""
-		dso = ""
-		count = 0
-		branch_count = 0
-		total_branch_count = 0
-		time = 0
-		total_time = 0
-		while query.next():
-			if query.value(1) == last_call_path_id:
-				count += 1
-				branch_count += query.value(2)
-				time += query.value(4) - query.value(3)
-			else:
-				if count:
-					self.addChild(last_call_path_id, name, dso, count, time, branch_count)
-				last_call_path_id = query.value(1)
-				name = query.value(5)
-				dso = query.value(6)
-				count = 1
-				total_branch_count += branch_count
-				total_time += time
-				branch_count = query.value(2)
-				time = query.value(4) - query.value(3)
-		if count:
-			self.addChild(last_call_path_id, name, dso, count, time, branch_count)
-		total_branch_count += branch_count
-		total_time += time
-		# Top level does not have time or branch count, so fix that here
-		if total_branch_count > self.branch_count:
-			self.branch_count = total_branch_count
-			if self.branch_count:
-				for child_item in self.child_items:
-					child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
-		if total_time > self.time:
-			self.time = total_time
-			if self.time:
-				for child_item in self.child_items:
-					child_item.data[4] = PercentToOneDP(child_item.time, self.time)
-
-	def childCount(self):
-		if not self.query_done:
-			self.selectCalls()
-		return self.child_count
-
-	def hasChildren(self):
-		if not self.query_done:
-			return True
-		return self.child_count > 0
-
-	def getData(self, column):
-		return self.data[column]
-
 # Tree data model
 
 class TreeModel(QAbstractItemModel):
@@ -277,12 +138,144 @@ class TreeModel(QAbstractItemModel):
 		item = index.internalPointer()
 		return self.DisplayData(item, index)
 
+# Context-sensitive call graph data model item base
+
+class CallGraphLevelItemBase(object):
+
+	def __init__(self, glb, row, parent_item):
+		self.glb = glb
+		self.row = row
+		self.parent_item = parent_item
+		self.query_done = False;
+		self.child_count = 0
+		self.child_items = []
+
+	def getChildItem(self, row):
+		return self.child_items[row]
+
+	def getParentItem(self):
+		return self.parent_item
+
+	def getRow(self):
+		return self.row
+
+	def childCount(self):
+		if not self.query_done:
+			self.Select()
+			if not self.child_count:
+				return -1
+		return self.child_count
+
+	def hasChildren(self):
+		if not self.query_done:
+			return True
+		return self.child_count > 0
+
+	def getData(self, column):
+		return self.data[column]
+
+# Context-sensitive call graph data model level 2+ item base
+
+class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item):
+		super(CallGraphLevelTwoPlusItemBase, self).__init__(glb, row, parent_item)
+		self.comm_id = comm_id
+		self.thread_id = thread_id
+		self.call_path_id = call_path_id
+		self.branch_count = branch_count
+		self.time = time
+
+	def Select(self):
+		self.query_done = True;
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT call_path_id, name, short_name, COUNT(calls.id), SUM(return_time - call_time), SUM(branch_count)"
+					" FROM calls"
+					" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+					" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+					" INNER JOIN dsos ON symbols.dso_id = dsos.id"
+					" WHERE parent_call_path_id = " + str(self.call_path_id) +
+					" AND comm_id = " + str(self.comm_id) +
+					" AND thread_id = " + str(self.thread_id) +
+					" GROUP BY call_path_id, name, short_name"
+					" ORDER BY call_path_id")
+		while query.next():
+			child_item = CallGraphLevelThreeItem(self.glb, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Context-sensitive call graph data model level three item
+
+class CallGraphLevelThreeItem(CallGraphLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, call_path_id, name, dso, count, time, branch_count, parent_item):
+		super(CallGraphLevelThreeItem, self).__init__(glb, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item)
+		dso = dsoname(dso)
+		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+		self.dbid = call_path_id
+
+# Context-sensitive call graph data model level two item
+
+class CallGraphLevelTwoItem(CallGraphLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, pid, tid, parent_item):
+		super(CallGraphLevelTwoItem, self).__init__(glb, row, comm_id, thread_id, 1, 0, 0, parent_item)
+		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
+		self.dbid = thread_id
+
+	def Select(self):
+		super(CallGraphLevelTwoItem, self).Select()
+		for child_item in self.child_items:
+			self.time += child_item.time
+			self.branch_count += child_item.branch_count
+		for child_item in self.child_items:
+			child_item.data[4] = PercentToOneDP(child_item.time, self.time)
+			child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
+
+# Context-sensitive call graph data model level one item
+
+class CallGraphLevelOneItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, comm, parent_item):
+		super(CallGraphLevelOneItem, self).__init__(glb, row, parent_item)
+		self.data = [comm, "", "", "", "", "", ""]
+		self.dbid = comm_id
+
+	def Select(self):
+		self.query_done = True;
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT thread_id, pid, tid"
+					" FROM comm_threads"
+					" INNER JOIN threads ON thread_id = threads.id"
+					" WHERE comm_id = " + str(self.dbid))
+		while query.next():
+			child_item = CallGraphLevelTwoItem(self.glb, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Context-sensitive call graph data model root item
+
+class CallGraphRootItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb):
+		super(CallGraphRootItem, self).__init__(glb, 0, None)
+		self.dbid = 0
+		self.query_done = True;
+		query = QSqlQuery(glb.db)
+		QueryExec(query, "SELECT id, comm FROM comms")
+		while query.next():
+			if not query.value(0):
+				continue
+			child_item = CallGraphLevelOneItem(glb, self.child_count, query.value(0), query.value(1), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
 # Context-sensitive call graph data model
 
 class CallGraphModel(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(TreeItem(glb.db, 0, None), parent)
+		super(CallGraphModel, self).__init__(CallGraphRootItem(glb), parent)
 		self.glb = glb
 
 	def columnCount(self, parent=None):
-- 
2.17.1

