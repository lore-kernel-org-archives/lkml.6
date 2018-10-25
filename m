Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3BCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20EF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="veVb5aCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20EF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeJYTo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbeJYToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:25 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1662520840;
        Thu, 25 Oct 2018 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465926;
        bh=0U54lKmUGiiYvINWpSQmyrp/bxNkf0ojlTOCrkhfj5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veVb5aCi0og1EH4Ff8WCn2L0h+rYpEVA9e9NWEoqvwLr23CPGDIpSyiJboENTcbh8
         08kBeQDUU2ihCvZD43he+6gX+NiC4nf9Vxa3xNNo/P1wq8SCL0YgMCa2JvFYO+tBtn
         XqpOLLFgnfGUMbXgQQocwCRj4iWW/apBM4hE+F3A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/37] perf scripts python: exported-sql-viewer.py: Add ability to find symbols in the call-graph
Date:   Thu, 25 Oct 2018 08:10:23 -0300
Message-Id: <20181025111031.3440-30-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a Find bar that appears at the bottom of the call-graph window.

Committer testing:

Using:

  python tools/perf/scripts/python/exported-sql-viewer.py pt_example branches calls

Using the database built in the first "Committer Testing" section in
this patch series I was able to:

  "Reports"
      "Context-Sensitive Call Graphs"
           Control+F or select "Edit" in the top menu then "Find"
                __poll<ENTER>

and find the first place where the "__poll" function appears, then
press the down arrow in the lower right corner and go to the next, etc.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 306 ++++++++++++++++++++++-
 1 file changed, 305 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c2f44351821e..0386a600ffc7 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -49,6 +49,7 @@
 import sys
 import weakref
 import threading
+import string
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
@@ -76,6 +77,27 @@ def QueryExec(query, stmt):
 	if not ret:
 		raise Exception("Query failed: " + query.lastError().text())
 
+# Background thread
+
+class Thread(QThread):
+
+	done = Signal(object)
+
+	def __init__(self, task, param=None, parent=None):
+		super(Thread, self).__init__(parent)
+		self.task = task
+		self.param = param
+
+	def run(self):
+		while True:
+			if self.param is None:
+				done, result = self.task()
+			else:
+				done, result = self.task(self.param)
+			self.done.emit(result)
+			if done:
+				break
+
 # Tree data model
 
 class TreeModel(QAbstractItemModel):
@@ -157,6 +179,125 @@ def LookupCreateModel(model_name, create_fn):
 	model_cache_lock.release()
 	return model
 
+# Find bar
+
+class FindBar():
+
+	def __init__(self, parent, finder, is_reg_expr=False):
+		self.finder = finder
+		self.context = []
+		self.last_value = None
+		self.last_pattern = None
+
+		label = QLabel("Find:")
+		label.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.textbox = QComboBox()
+		self.textbox.setEditable(True)
+		self.textbox.currentIndexChanged.connect(self.ValueChanged)
+
+		self.progress = QProgressBar()
+		self.progress.setRange(0, 0)
+		self.progress.hide()
+
+		if is_reg_expr:
+			self.pattern = QCheckBox("Regular Expression")
+		else:
+			self.pattern = QCheckBox("Pattern")
+		self.pattern.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.next_button = QToolButton()
+		self.next_button.setIcon(parent.style().standardIcon(QStyle.SP_ArrowDown))
+		self.next_button.released.connect(lambda: self.NextPrev(1))
+
+		self.prev_button = QToolButton()
+		self.prev_button.setIcon(parent.style().standardIcon(QStyle.SP_ArrowUp))
+		self.prev_button.released.connect(lambda: self.NextPrev(-1))
+
+		self.close_button = QToolButton()
+		self.close_button.setIcon(parent.style().standardIcon(QStyle.SP_DockWidgetCloseButton))
+		self.close_button.released.connect(self.Deactivate)
+
+		self.hbox = QHBoxLayout()
+		self.hbox.setContentsMargins(0, 0, 0, 0)
+
+		self.hbox.addWidget(label)
+		self.hbox.addWidget(self.textbox)
+		self.hbox.addWidget(self.progress)
+		self.hbox.addWidget(self.pattern)
+		self.hbox.addWidget(self.next_button)
+		self.hbox.addWidget(self.prev_button)
+		self.hbox.addWidget(self.close_button)
+
+		self.bar = QWidget()
+		self.bar.setLayout(self.hbox);
+		self.bar.hide()
+
+	def Widget(self):
+		return self.bar
+
+	def Activate(self):
+		self.bar.show()
+		self.textbox.setFocus()
+
+	def Deactivate(self):
+		self.bar.hide()
+
+	def Busy(self):
+		self.textbox.setEnabled(False)
+		self.pattern.hide()
+		self.next_button.hide()
+		self.prev_button.hide()
+		self.progress.show()
+
+	def Idle(self):
+		self.textbox.setEnabled(True)
+		self.progress.hide()
+		self.pattern.show()
+		self.next_button.show()
+		self.prev_button.show()
+
+	def Find(self, direction):
+		value = self.textbox.currentText()
+		pattern = self.pattern.isChecked()
+		self.last_value = value
+		self.last_pattern = pattern
+		self.finder.Find(value, direction, pattern, self.context)
+
+	def ValueChanged(self):
+		value = self.textbox.currentText()
+		pattern = self.pattern.isChecked()
+		index = self.textbox.currentIndex()
+		data = self.textbox.itemData(index)
+		# Store the pattern in the combo box to keep it with the text value
+		if data == None:
+			self.textbox.setItemData(index, pattern)
+		else:
+			self.pattern.setChecked(data)
+		self.Find(0)
+
+	def NextPrev(self, direction):
+		value = self.textbox.currentText()
+		pattern = self.pattern.isChecked()
+		if value != self.last_value:
+			index = self.textbox.findText(value)
+			# Allow for a button press before the value has been added to the combo box
+			if index < 0:
+				index = self.textbox.count()
+				self.textbox.addItem(value, pattern)
+				self.textbox.setCurrentIndex(index)
+				return
+			else:
+				self.textbox.setItemData(index, pattern)
+		elif pattern != self.last_pattern:
+			# Keep the pattern recorded in the combo box up to date
+			index = self.textbox.currentIndex()
+			self.textbox.setItemData(index, pattern)
+		self.Find(direction)
+
+	def NotFound(self):
+		QMessageBox.information(self.bar, "Find", "'" + self.textbox.currentText() + "' not found")
+
 # Context-sensitive call graph data model item base
 
 class CallGraphLevelItemBase(object):
@@ -308,6 +449,123 @@ class CallGraphModel(TreeModel):
 		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
 		return alignment[column]
 
+	def FindSelect(self, value, pattern, query):
+		if pattern:
+			# postgresql and sqlite pattern patching differences:
+			#   postgresql LIKE is case sensitive but sqlite LIKE is not
+			#   postgresql LIKE allows % and _ to be escaped with \ but sqlite LIKE does not
+			#   postgresql supports ILIKE which is case insensitive
+			#   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
+			if not self.glb.dbref.is_sqlite3:
+				# Escape % and _
+				s = value.replace("%", "\%")
+				s = s.replace("_", "\_")
+				# Translate * and ? into SQL LIKE pattern characters % and _
+				trans = string.maketrans("*?", "%_")
+				match = " LIKE '" + str(s).translate(trans) + "'"
+			else:
+				match = " GLOB '" + str(value) + "'"
+		else:
+			match = " = '" + str(value) + "'"
+		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" GROUP BY comm_id, thread_id, call_path_id"
+						" ORDER BY comm_id, thread_id, call_path_id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM call_paths"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		# The call path root is not used
+		if ids[0] == 1:
+			del ids[0]
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
+	def Found(self, query, found):
+		if found:
+			return self.FindPath(query)
+		return []
+
+	def FindValue(self, value, pattern, query, last_value, last_pattern):
+		if last_value == value and pattern == last_pattern:
+			found = query.first()
+		else:
+			self.FindSelect(value, pattern, query)
+			found = query.next()
+		return self.Found(query, found)
+
+	def FindNext(self, query):
+		found = query.next()
+		if not found:
+			found = query.first()
+		return self.Found(query, found)
+
+	def FindPrev(self, query):
+		found = query.previous()
+		if not found:
+			found = query.last()
+		return self.Found(query, found)
+
+	def FindThread(self, c):
+		if c.direction == 0 or c.value != c.last_value or c.pattern != c.last_pattern:
+			ids = self.FindValue(c.value, c.pattern, c.query, c.last_value, c.last_pattern)
+		elif c.direction > 0:
+			ids = self.FindNext(c.query)
+		else:
+			ids = self.FindPrev(c.query)
+		return (True, ids)
+
+	def Find(self, value, direction, pattern, context, callback):
+		class Context():
+			def __init__(self, *x):
+				self.value, self.direction, self.pattern, self.query, self.last_value, self.last_pattern = x
+			def Update(self, *x):
+				self.value, self.direction, self.pattern, self.last_value, self.last_pattern = x + (self.value, self.pattern)
+		if len(context):
+			context[0].Update(value, direction, pattern)
+		else:
+			context.append(Context(value, direction, pattern, QSqlQuery(self.glb.db), None, None))
+		# Use a thread so the UI is not blocked during the SELECT
+		thread = Thread(self.FindThread, context[0])
+		thread.done.connect(lambda ids, t=thread, c=callback: self.FindDone(t, c, ids), Qt.QueuedConnection)
+		thread.start()
+
+	def FindDone(self, thread, callback, ids):
+		callback(ids)
+
+# Vertical widget layout
+
+class VBox():
+
+	def __init__(self, w1, w2, w3=None):
+		self.vbox = QWidget()
+		self.vbox.setLayout(QVBoxLayout());
+
+		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
+
+		self.vbox.layout().addWidget(w1)
+		self.vbox.layout().addWidget(w2)
+		if w3:
+			self.vbox.layout().addWidget(w3)
+
+	def Widget(self):
+		return self.vbox
+
 # Context-sensitive call graph window
 
 class CallGraphWindow(QMdiSubWindow):
@@ -323,10 +581,45 @@ class CallGraphWindow(QMdiSubWindow):
 		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
 			self.view.setColumnWidth(c, w)
 
-		self.setWidget(self.view)
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
 
 		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
 
+	def DisplayFound(self, ids):
+		if not len(ids):
+			return False
+		parent = QModelIndex()
+		for dbid in ids:
+			found = False
+			n = self.model.rowCount(parent)
+			for row in xrange(n):
+				child = self.model.index(row, 0, parent)
+				if child.internalPointer().dbid == dbid:
+					found = True
+					self.view.setCurrentIndex(child)
+					parent = child
+					break
+			if not found:
+				break
+		return found
+
+	def Find(self, value, direction, pattern, context):
+		self.view.setFocus()
+		self.find_bar.Busy()
+		self.model.Find(value, direction, pattern, context, self.FindDone)
+
+	def FindDone(self, ids):
+		found = True
+		if not self.DisplayFound(ids):
+			found = False
+		self.find_bar.Idle()
+		if not found:
+			self.find_bar.NotFound()
+
 # Action Definition
 
 def CreateAction(label, tip, callback, parent=None, shortcut=None):
@@ -470,11 +763,22 @@ class MainWindow(QMainWindow):
 		file_menu = menu.addMenu("&File")
 		file_menu.addAction(CreateExitAction(glb.app, self))
 
+		edit_menu = menu.addMenu("&Edit")
+		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
+
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
 		self.window_menu = WindowMenu(self.mdi_area, menu)
 
+	def Find(self):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				win.find_bar.Activate()
+			except:
+				pass
+
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
-- 
2.14.4

