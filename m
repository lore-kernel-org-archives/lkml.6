Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75220665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD75220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJZQQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:16:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:16:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7eVwO138530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:40:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7eV6W138527;
        Fri, 26 Oct 2018 00:40:31 -0700
Date:   Fri, 26 Oct 2018 00:40:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-70d831e85c1bdd87d193e85666bf3aa39aab7f21@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, ak@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com
In-Reply-To: <20181001062853.28285-10-adrian.hunter@intel.com>
References: <20181001062853.28285-10-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py:
 Factor out CallGraphModel from TreeModel
Git-Commit-ID: 70d831e85c1bdd87d193e85666bf3aa39aab7f21
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

Commit-ID:  70d831e85c1bdd87d193e85666bf3aa39aab7f21
Gitweb:     https://git.kernel.org/tip/70d831e85c1bdd87d193e85666bf3aa39aab7f21
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:43 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:23:52 -0300

perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel

Factor out CallGraphModel from TreeModel, which paves the way to reuse
TreeModel in future reports.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 90 ++++++++++++++++--------
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
