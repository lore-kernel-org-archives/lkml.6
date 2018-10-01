Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230CC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619AC2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619AC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeJANMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:12:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:10732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeJANL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466514"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
Date:   Mon,  1 Oct 2018 09:28:47 +0300
Message-Id: <20181001062853.28285-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Qt MDI (multiple document interface) to support multiple sub-windows.
Put the data model in a cache so that each sub-window can share the same
data. This allows mutiple views of the call-graph at the same time and
paves the way to add more reports.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 182 +++++++++++++++++-
 1 file changed, 173 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 03e7a1de7f31..c2f44351821e 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -47,6 +47,8 @@
 #       functions that it calls
 
 import sys
+import weakref
+import threading
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
@@ -138,6 +140,23 @@ class TreeModel(QAbstractItemModel):
 		item = index.internalPointer()
 		return self.DisplayData(item, index)
 
+# Model cache
+
+model_cache = weakref.WeakValueDictionary()
+model_cache_lock = threading.Lock()
+
+def LookupCreateModel(model_name, create_fn):
+	model_cache_lock.acquire()
+	try:
+		model = model_cache[model_name]
+	except:
+		model = None
+	if model is None:
+		model = create_fn()
+		model_cache[model_name] = model
+	model_cache_lock.release()
+	return model
+
 # Context-sensitive call graph data model item base
 
 class CallGraphLevelItemBase(object):
@@ -289,6 +308,144 @@ class CallGraphModel(TreeModel):
 		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
 		return alignment[column]
 
+# Context-sensitive call graph window
+
+class CallGraphWindow(QMdiSubWindow):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.setWidget(self.view)
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+
+# Action Definition
+
+def CreateAction(label, tip, callback, parent=None, shortcut=None):
+	action = QAction(label, parent)
+	if shortcut != None:
+		action.setShortcuts(shortcut)
+	action.setStatusTip(tip)
+	action.triggered.connect(callback)
+	return action
+
+# Typical application actions
+
+def CreateExitAction(app, parent=None):
+	return CreateAction("&Quit", "Exit the application", app.closeAllWindows, parent, QKeySequence.Quit)
+
+# Typical MDI actions
+
+def CreateCloseActiveWindowAction(mdi_area):
+	return CreateAction("Cl&ose", "Close the active window", mdi_area.closeActiveSubWindow, mdi_area)
+
+def CreateCloseAllWindowsAction(mdi_area):
+	return CreateAction("Close &All", "Close all the windows", mdi_area.closeAllSubWindows, mdi_area)
+
+def CreateTileWindowsAction(mdi_area):
+	return CreateAction("&Tile", "Tile the windows", mdi_area.tileSubWindows, mdi_area)
+
+def CreateCascadeWindowsAction(mdi_area):
+	return CreateAction("&Cascade", "Cascade the windows", mdi_area.cascadeSubWindows, mdi_area)
+
+def CreateNextWindowAction(mdi_area):
+	return CreateAction("Ne&xt", "Move the focus to the next window", mdi_area.activateNextSubWindow, mdi_area, QKeySequence.NextChild)
+
+def CreatePreviousWindowAction(mdi_area):
+	return CreateAction("Pre&vious", "Move the focus to the previous window", mdi_area.activatePreviousSubWindow, mdi_area, QKeySequence.PreviousChild)
+
+# Typical MDI window menu
+
+class WindowMenu():
+
+	def __init__(self, mdi_area, menu):
+		self.mdi_area = mdi_area
+		self.window_menu = menu.addMenu("&Windows")
+		self.close_active_window = CreateCloseActiveWindowAction(mdi_area)
+		self.close_all_windows = CreateCloseAllWindowsAction(mdi_area)
+		self.tile_windows = CreateTileWindowsAction(mdi_area)
+		self.cascade_windows = CreateCascadeWindowsAction(mdi_area)
+		self.next_window = CreateNextWindowAction(mdi_area)
+		self.previous_window = CreatePreviousWindowAction(mdi_area)
+		self.window_menu.aboutToShow.connect(self.Update)
+
+	def Update(self):
+		self.window_menu.clear()
+		sub_window_count = len(self.mdi_area.subWindowList())
+		have_sub_windows = sub_window_count != 0
+		self.close_active_window.setEnabled(have_sub_windows)
+		self.close_all_windows.setEnabled(have_sub_windows)
+		self.tile_windows.setEnabled(have_sub_windows)
+		self.cascade_windows.setEnabled(have_sub_windows)
+		self.next_window.setEnabled(have_sub_windows)
+		self.previous_window.setEnabled(have_sub_windows)
+		self.window_menu.addAction(self.close_active_window)
+		self.window_menu.addAction(self.close_all_windows)
+		self.window_menu.addSeparator()
+		self.window_menu.addAction(self.tile_windows)
+		self.window_menu.addAction(self.cascade_windows)
+		self.window_menu.addSeparator()
+		self.window_menu.addAction(self.next_window)
+		self.window_menu.addAction(self.previous_window)
+		if sub_window_count == 0:
+			return
+		self.window_menu.addSeparator()
+		nr = 1
+		for sub_window in self.mdi_area.subWindowList():
+			label = str(nr) + " " + sub_window.name
+			if nr < 10:
+				label = "&" + label
+			action = self.window_menu.addAction(label)
+			action.setCheckable(True)
+			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
+			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			self.window_menu.addAction(action)
+			nr += 1
+
+	def setActiveSubWindow(self, nr):
+		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
+
+# Unique name for sub-windows
+
+def NumberedWindowName(name, nr):
+	if nr > 1:
+		name += " <" + str(nr) + ">"
+	return name
+
+def UniqueSubWindowName(mdi_area, name):
+	nr = 1
+	while True:
+		unique_name = NumberedWindowName(name, nr)
+		ok = True
+		for sub_window in mdi_area.subWindowList():
+			if sub_window.name == unique_name:
+				ok = False
+				break
+		if ok:
+			return unique_name
+		nr += 1
+
+# Add a sub-window
+
+def AddSubWindow(mdi_area, sub_window, name):
+	unique_name = UniqueSubWindowName(mdi_area, name)
+	sub_window.setMinimumSize(200, 100)
+	sub_window.resize(800, 600)
+	sub_window.setWindowTitle(unique_name)
+	sub_window.setAttribute(Qt.WA_DeleteOnClose)
+	sub_window.setWindowIcon(sub_window.style().standardIcon(QStyle.SP_FileIcon))
+	sub_window.name = unique_name
+	mdi_area.addSubWindow(sub_window)
+	sub_window.show()
+
 # Main window
 
 class MainWindow(QMainWindow):
@@ -298,21 +455,28 @@ class MainWindow(QMainWindow):
 
 		self.glb = glb
 
-		self.setWindowTitle("Call Graph: " + glb.dbname)
-		self.move(100, 100)
-		self.resize(800, 600)
+		self.setWindowTitle("Exported SQL Viewer: " + glb.dbname)
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = CallGraphModel(glb)
+		self.mdi_area = QMdiArea()
+		self.mdi_area.setHorizontalScrollBarPolicy(Qt.ScrollBarAsNeeded)
+		self.mdi_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
 
-		self.view = QTreeView()
-		self.view.setModel(self.model)
+		self.setCentralWidget(self.mdi_area)
 
-		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
-			self.view.setColumnWidth(c, w)
+		menu = self.menuBar()
+
+		file_menu = menu.addMenu("&File")
+		file_menu.addAction(CreateExitAction(glb.app, self))
+
+		reports_menu = menu.addMenu("&Reports")
+		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
+
+		self.window_menu = WindowMenu(self.mdi_area, menu)
 
-		self.setCentralWidget(self.view)
+	def NewCallGraph(self):
+		CallGraphWindow(self.glb, self)
 
 # Global data
 
-- 
2.17.1

