Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131750;
	bh=A09G6OwsLvFrMwOY9+Ha6UJH5BW0Qoh3B72neXY2WZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jp1rzR3LerLL0uIRbVIMZFkKjm6X78N4Db6dukNyFPIPNYowxxRoWAs2H0CTal1kB
	 rUuoJ2mIhdST3Wd1+oub905FirVriJUI7tLdvroJ1HJrG1bfc6aCoLxQYueVpES6DA
	 Lv592krNf90HfVyG9eloYgAWso5wE4Z7XCwvLqRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfBYVzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbfBYVVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:41 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01C30217F4;
        Mon, 25 Feb 2019 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129700;
        bh=A09G6OwsLvFrMwOY9+Ha6UJH5BW0Qoh3B72neXY2WZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pms4DiQW0hB7EkLgAwV4bXjQYmQGpCb4CseYpZ4GZDJALxXxMfoUa4Di4KyZFbsi4
         Up5F5ugf/QrNKYxF7OJneyTAFq44p8nR70LHk4IJDChGQXxOn0ZaFZFMqkBcYZSOfr
         /qBSZ1VhzYLrbKyf4jmXiR/CMs75IGDbQWoFZjnY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/37] perf scripts python: exported-sql-viewer.py: Add top calls report
Date:   Mon, 25 Feb 2019 18:20:12 -0300
Message-Id: <20190225212035.24781-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a new report to display top calls by elapsed time. It displays calls
in descending order of time elapsed between when the function was called
and when it returned.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 141 +++++++++++++++++-
 1 file changed, 135 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 728200e3a691..09ce73b07d35 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1402,12 +1402,13 @@ class BranchModel(TreeModel):
 
 class ReportVars():
 
-	def __init__(self, name = "", where_clause = ""):
+	def __init__(self, name = "", where_clause = "", limit = ""):
 		self.name = name
 		self.where_clause = where_clause
+		self.limit = limit
 
 	def UniqueId(self):
-		return str(self.where_clause)
+		return str(self.where_clause + ";" + self.limit)
 
 # Branch window
 
@@ -1485,16 +1486,16 @@ class BranchWindow(QMdiSubWindow):
 
 class LineEditDataItem(object):
 
-	def __init__(self, glb, label, placeholder_text, parent, id = ""):
+	def __init__(self, glb, label, placeholder_text, parent, id = "", default = ""):
 		self.glb = glb
 		self.label = label
 		self.placeholder_text = placeholder_text
 		self.parent = parent
 		self.id = id
 
-		self.value = ""
+		self.value = default
 
-		self.widget = QLineEdit()
+		self.widget = QLineEdit(default)
 		self.widget.editingFinished.connect(self.Validate)
 		self.widget.textChanged.connect(self.Invalidate)
 		self.red = False
@@ -1582,6 +1583,21 @@ class NonNegativeIntegerRangesDataItem(LineEditDataItem):
 			ranges.append(self.column_name + " IN (" + ",".join(singles) + ")")
 		self.value = " OR ".join(ranges)
 
+# Positive integer dialog data item
+
+class PositiveIntegerDataItem(LineEditDataItem):
+
+	def __init__(self, glb, label, placeholder_text, parent, id = "", default = ""):
+		super(PositiveIntegerDataItem, self).__init__(glb, label, placeholder_text, parent, id, default)
+
+	def DoValidate(self, input_string):
+		if not self.IsNumber(input_string.strip()):
+			return self.InvalidValue(input_string)
+		value = int(input_string.strip())
+		if value <= 0:
+			return self.InvalidValue(input_string)
+		self.value = str(value)
+
 # Dialog data item converted and validated using a SQL table
 
 class SQLTableDataItem(LineEditDataItem):
@@ -1799,7 +1815,9 @@ class ReportDialogBase(QDialog):
 			if not d.IsValid():
 				return
 		for d in self.data_items[1:]:
-			if len(d.value):
+			if d.id == "LIMIT":
+				vars.limit = d.value
+			elif len(d.value):
 				if len(vars.where_clause):
 					vars.where_clause += " AND "
 				vars.where_clause += d.value
@@ -2059,6 +2077,103 @@ def GetTableList(glb):
 		tables.append("information_schema.columns")
 	return tables
 
+# Top Calls data model
+
+class TopCallsModel(SQLTableModel):
+
+	def __init__(self, glb, report_vars, parent=None):
+		text = ""
+		if not glb.dbref.is_sqlite3:
+			text = "::text"
+		limit = ""
+		if len(report_vars.limit):
+			limit = " LIMIT " + report_vars.limit
+		sql = ("SELECT comm, pid, tid, name,"
+			" CASE"
+			" WHEN (short_name = '[kernel.kallsyms]') THEN '[kernel]'" + text +
+			" ELSE short_name"
+			" END AS dso,"
+			" call_time, return_time, (return_time - call_time) AS elapsed_time, branch_count, "
+			" CASE"
+			" WHEN (calls.flags = 1) THEN 'no call'" + text +
+			" WHEN (calls.flags = 2) THEN 'no return'" + text +
+			" WHEN (calls.flags = 3) THEN 'no call/return'" + text +
+			" ELSE ''" + text +
+			" END AS flags"
+			" FROM calls"
+			" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+			" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+			" INNER JOIN dsos ON symbols.dso_id = dsos.id"
+			" INNER JOIN comms ON calls.comm_id = comms.id"
+			" INNER JOIN threads ON calls.thread_id = threads.id" +
+			report_vars.where_clause +
+			" ORDER BY elapsed_time DESC" +
+			limit
+			)
+		column_headers = ("Command", "PID", "TID", "Symbol", "Object", "Call Time", "Return Time", "Elapsed Time (ns)", "Branch Count", "Flags")
+		self.alignment = (Qt.AlignLeft, Qt.AlignLeft, Qt.AlignLeft, Qt.AlignLeft, Qt.AlignLeft, Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignLeft)
+		super(TopCallsModel, self).__init__(glb, sql, column_headers, parent)
+
+	def columnAlignment(self, column):
+		return self.alignment[column]
+
+# Top Calls report creation dialog
+
+class TopCallsDialog(ReportDialogBase):
+
+	def __init__(self, glb, parent=None):
+		title = "Top Calls by Elapsed Time"
+		items = (lambda g, p: LineEditDataItem(g, "Report name:", "Enter a name to appear in the window title bar", p, "REPORTNAME"),
+			 lambda g, p: SQLTableDataItem(g, "Commands:", "Only calls with these commands will be included", "comms", "comm", "comm_id", "", p),
+			 lambda g, p: SQLTableDataItem(g, "PIDs:", "Only calls with these process IDs will be included", "threads", "pid", "thread_id", "", p),
+			 lambda g, p: SQLTableDataItem(g, "TIDs:", "Only calls with these thread IDs will be included", "threads", "tid", "thread_id", "", p),
+			 lambda g, p: SQLTableDataItem(g, "DSOs:", "Only calls with these DSOs will be included", "dsos", "short_name", "dso_id", "", p),
+			 lambda g, p: SQLTableDataItem(g, "Symbols:", "Only calls with these symbols will be included", "symbols", "name", "symbol_id", "", p),
+			 lambda g, p: LineEditDataItem(g, "Raw SQL clause: ", "Enter a raw SQL WHERE clause", p),
+			 lambda g, p: PositiveIntegerDataItem(g, "Record limit:", "Limit selection to this number of records", p, "LIMIT", "100"))
+		super(TopCallsDialog, self).__init__(glb, title, items, False, parent)
+
+# Top Calls window
+
+class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
+
+	def __init__(self, glb, report_vars, parent=None):
+		super(TopCallsWindow, self).__init__(parent)
+
+		self.data_model = LookupCreateModel("Top Calls " + report_vars.UniqueId(), lambda: TopCallsModel(glb, report_vars))
+		self.model = self.data_model
+
+		self.view = QTableView()
+		self.view.setModel(self.model)
+		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
+		self.view.verticalHeader().setVisible(False)
+
+		self.ResizeColumnsToContents()
+
+		self.find_bar = FindBar(self, self, True)
+
+		self.finder = ChildDataItemFinder(self.model)
+
+		self.fetch_bar = FetchMoreRecordsBar(self.data_model, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget(), self.fetch_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, report_vars.name)
+
+	def Find(self, value, direction, pattern, context):
+		self.view.setFocus()
+		self.find_bar.Busy()
+		self.finder.Find(value, direction, pattern, context, self.FindDone)
+
+	def FindDone(self, row):
+		self.find_bar.Idle()
+		if row >= 0:
+			self.view.setCurrentIndex(self.model.index(row, 0, QModelIndex()))
+		else:
+			self.find_bar.NotFound()
+
 # Action Definition
 
 def CreateAction(label, tip, callback, parent=None, shortcut=None):
@@ -2162,6 +2277,7 @@ p.c2 {
 <p class=c2><a href=#callgraph>1.1 Context-Sensitive Call Graph</a></p>
 <p class=c2><a href=#allbranches>1.2 All branches</a></p>
 <p class=c2><a href=#selectedbranches>1.3 Selected branches</a></p>
+<p class=c2><a href=#topcallsbyelapsedtime>1.4 Top calls by elapsed time</a></p>
 <p class=c1><a href=#tables>2. Tables</a></p>
 <h1 id=reports>1. Reports</h1>
 <h2 id=callgraph>1.1 Context-Sensitive Call Graph</h2>
@@ -2237,6 +2353,10 @@ ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
 	-10ms-			The last 10ms
 </pre>
 N.B. Due to the granularity of timestamps, there could be no branches in any given time range.
+<h2 id=topcallsbyelapsedtime>1.4 Top calls by elapsed time</h2>
+The Top calls by elapsed time report displays calls in descending order of time elapsed between when the function was called and when it returned.
+The data is reduced by various selection criteria. A dialog box displays available criteria which are AND'ed together.
+If not all data is fetched, a Fetch bar is provided. Ctrl-F displays a Find bar.
 <h1 id=tables>2. Tables</h1>
 The Tables menu shows all tables and views in the database. Most tables have an associated view
 which displays the information in a more friendly way. Not all data for large tables is fetched
@@ -2371,6 +2491,9 @@ class MainWindow(QMainWindow):
 
 		self.EventMenu(GetEventList(glb.db), reports_menu)
 
+		if IsSelectable(glb.db, "calls"):
+			reports_menu.addAction(CreateAction("&Top calls by elapsed time", "Create a new window displaying top calls by elapsed time", self.NewTopCalls, self))
+
 		self.TableMenu(GetTableList(glb), menu)
 
 		self.window_menu = WindowMenu(self.mdi_area, menu)
@@ -2426,6 +2549,12 @@ class MainWindow(QMainWindow):
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
+	def NewTopCalls(self):
+		dialog = TopCallsDialog(self.glb, self)
+		ret = dialog.exec_()
+		if ret:
+			TopCallsWindow(self.glb, dialog.report_vars, self)
+
 	def NewBranchView(self, event_id):
 		BranchWindow(self.glb, event_id, ReportVars(), self)
 
-- 
2.20.1

