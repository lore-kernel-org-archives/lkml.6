Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1A5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A922089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A922089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeJANL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:53642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbeJANLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466503"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
Date:   Mon,  1 Oct 2018 09:28:43 +0300
Message-Id: <20181001062853.28285-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out CallGraphModel from TreeModel, which paves the way to reuse
TreeModel in future reports.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/call-graph-from-sql.py     | 90 +++++++++++++------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 65c18e351bc4..ada486048ad8 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -201,42 +201,47 @@ class TreeItem():
 			self.selectCalls()
 		return self.child_count
 
-	def columnCount(self):
-		return 7
-
-	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
-		return headers[column]
+	def hasChildren(self):
+		if not self.query_done:
+			return True
+		return self.child_count > 0
 
 	def getData(self, column):
 		return self.data[column]
 
+# Tree data model
+
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, db, parent=None):
+	def __init__(self, root, parent=None):
 		super(TreeModel, self).__init__(parent)
-		self.db = db
-		self.root = TreeItem(db, 0, None)
+		self.root = root
+		self.last_row_read = 0
 
-	def columnCount(self, parent):
-		return self.root.columnCount()
-
-	def rowCount(self, parent):
+	def Item(self, parent):
 		if parent.isValid():
-			parent_item = parent.internalPointer()
+			return parent.internalPointer()
 		else:
-			parent_item = self.root
-		return parent_item.childCount()
+			return self.root
+
+	def rowCount(self, parent):
+		result = self.Item(parent).childCount()
+		if result < 0:
+			result = 0
+			self.dataChanged.emit(parent, parent)
+		return result
+
+	def hasChildren(self, parent):
+		return self.Item(parent).hasChildren()
 
 	def headerData(self, section, orientation, role):
 		if role == Qt.TextAlignmentRole:
-			if section > 1:
-				return Qt.AlignRight
+			return self.columnAlignment(section)
 		if role != Qt.DisplayRole:
 			return None
 		if orientation != Qt.Horizontal:
 			return None
-		return self.root.columnHeader(section)
+		return self.columnHeader(section)
 
 	def parent(self, child):
 		child_item = child.internalPointer()
@@ -246,21 +251,48 @@ class TreeModel(QAbstractItemModel):
 		return self.createIndex(parent_item.getRow(), 0, parent_item)
 
 	def index(self, row, column, parent):
-		if parent.isValid():
-			parent_item = parent.internalPointer()
-		else:
-			parent_item = self.root
-		child_item = parent_item.getChildItem(row)
+		child_item = self.Item(parent).getChildItem(row)
 		return self.createIndex(row, column, child_item)
 
+	def DisplayData(self, item, index):
+		return item.getData(index.column())
+
+	def columnAlignment(self, column):
+		return Qt.AlignLeft
+
+	def columnFont(self, column):
+		return None
+
 	def data(self, index, role):
 		if role == Qt.TextAlignmentRole:
-			if index.column() > 1:
-				return Qt.AlignRight
+			return self.columnAlignment(index.column())
+		if role == Qt.FontRole:
+			return self.columnFont(index.column())
 		if role != Qt.DisplayRole:
 			return None
-		index_item = index.internalPointer()
-		return index_item.getData(index.column())
+		item = index.internalPointer()
+		return self.DisplayData(item, index)
+
+# Context-sensitive call graph data model
+
+class CallGraphModel(TreeModel):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphModel, self).__init__(TreeItem(glb.db, 0, None), parent)
+		self.glb = glb
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+# Main window
 
 class MainWindow(QMainWindow):
 
@@ -275,7 +307,7 @@ class MainWindow(QMainWindow):
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = TreeModel(glb.db)
+		self.model = CallGraphModel(glb)
 
 		self.view = QTreeView()
 		self.view.setModel(self.model)
-- 
2.17.1

