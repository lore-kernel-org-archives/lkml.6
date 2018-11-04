Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD1C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7B22085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7B22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKEA3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:29:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:64597 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbeKEA3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:29:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 07:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,464,1534834800"; 
   d="scan'208";a="105303530"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2018 07:14:30 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] perf scripts python: exported-sql-viewer.py: Add help window
Date:   Sun,  4 Nov 2018 17:12:37 +0200
Message-Id: <20181104151238.15947-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104151238.15947-1-adrian.hunter@intel.com>
References: <20181104151238.15947-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a window to display help. It is also possible to display the help only, by
using the option "--help-only" instead of a database name.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 155 +++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index a9d2b3170141..c2fcf6c5237a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2084,6 +2084,147 @@ class WindowMenu():
 	def setActiveSubWindow(self, nr):
 		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
 
+# Help text
+
+glb_help_text = """
+<h1>Contents</h1>
+<style>
+p.c1 {
+    text-indent: 40px;
+}
+p.c2 {
+    text-indent: 80px;
+}
+}
+</style>
+<p class=c1><a href=#reports>1. Reports</a></p>
+<p class=c2><a href=#callgraph>1.1 Context-Sensitive Call Graph</a></p>
+<p class=c2><a href=#allbranches>1.2 All branches</a></p>
+<p class=c2><a href=#selectedbranches>1.3 Selected branches</a></p>
+<p class=c1><a href=#tables>2. Tables</a></p>
+<h1 id=reports>1. Reports</h1>
+<h2 id=callgraph>1.1 Context-Sensitive Call Graph</h2>
+The result is a GUI window with a tree representing a context-sensitive
+call-graph. Expanding a couple of levels of the tree and adjusting column
+widths to suit will display something like:
+<pre>
+                                         Call Graph: pt_example
+Call Path                          Object      Count   Time(ns)  Time(%)  Branch Count   Branch Count(%)
+v- ls
+    v- 2638:2638
+        v- _start                  ld-2.19.so    1     10074071   100.0         211135            100.0
+          |- unknown               unknown       1        13198     0.1              1              0.0
+          >- _dl_start             ld-2.19.so    1      1400980    13.9          19637              9.3
+          >- _d_linit_internal     ld-2.19.so    1       448152     4.4          11094              5.3
+          v-__libc_start_main@plt  ls            1      8211741    81.5         180397             85.4
+             >- _dl_fixup          ld-2.19.so    1         7607     0.1            108              0.1
+             >- __cxa_atexit       libc-2.19.so  1        11737     0.1             10              0.0
+             >- __libc_csu_init    ls            1        10354     0.1             10              0.0
+             |- _setjmp            libc-2.19.so  1            0     0.0              4              0.0
+             v- main               ls            1      8182043    99.6         180254             99.9
+</pre>
+<h3>Points to note:</h3>
+<ul>
+<li>The top level is a command name (comm)</li>
+<li>The next level is a thread (pid:tid)</li>
+<li>Subsequent levels are functions</li>
+<li>'Count' is the number of calls</li>
+<li>'Time' is the elapsed time until the function returns</li>
+<li>Percentages are relative to the level above</li>
+<li>'Branch Count' is the total number of branches for that function and all functions that it calls
+</ul>
+<h3>Find</h3>
+Ctrl-F displays a Find bar which finds function names by either an exact match or a pattern match.
+The pattern matching symbols are ? for any character and * for zero or more characters.
+<h2 id=allbranches>1.2 All branches</h2>
+The All branches report displays all branches in chronological order.
+Not all data is fetched immediately. More records can be fetched using the Fetch bar provided.
+<h3>Disassembly</h3>
+Open a branch to display disassembly. This only works if:
+<ol>
+<li>The disassembler is available. Currently, only Intel XED is supported - see <a href=#xed>Intel XED Setup</a></li>
+<li>The object code is available. Currently, only the perf build ID cache is searched for object code.
+The default directory ~/.debug can be overridden by setting environment variable PERF_BUILDID_DIR.
+One exception is kcore where the DSO long name is used (refer dsos_view on the Tables menu),
+or alternatively, set environment variable PERF_KCORE to the kcore file name.</li>
+</ol>
+<h4 id=xed>Intel XED Setup</h4>
+To use Intel XED, libxed.so must be present.  To build and install libxed.so:
+<pre>
+git clone https://github.com/intelxed/mbuild.git mbuild
+git clone https://github.com/intelxed/xed
+cd xed
+./mfile.py --share
+sudo ./mfile.py --prefix=/usr/local install
+sudo ldconfig
+</pre>
+<h3>Find</h3>
+Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
+Refer to Python documentation for the regular expression syntax.
+All columns are searched, but only currently fetched rows are searched.
+<h2 id=selectedbranches>1.3 Selected branches</h2>
+This is the same as the <a href=#allbranches>All branches</a> report but with the data reduced
+by various selection criteria. A dialog box displays available criteria which are AND'ed together.
+<h3>1.3.1 Time ranges</h3>
+The time ranges hint text shows the total time range. Relative time ranges can also be entered in
+ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
+<pre>
+	81073085947329-81073085958238	From 81073085947329 to 81073085958238
+	100us-200us		From 100us to 200us
+	10ms-			From 10ms to the end
+	-100ns			The first 100ns
+	-10ms-			The last 10ms
+</pre>
+N.B. Due to the granularity of timestamps, there could be no branches in any given time range.
+<h1 id=tables>2. Tables</h1>
+The Tables menu shows all tables and views in the database. Most tables have an associated view
+which displays the information in a more friendly way. Not all data for large tables is fetched
+immediately. More records can be fetched using the Fetch bar provided. Columns can be sorted,
+but that can be slow for large tables.
+<p>There are also tables of database meta-information.
+For SQLite3 databases, the sqlite_master table is included.
+For PostgreSQL databases, information_schema.tables/views/columns are included.
+<h3>Find</h3>
+Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
+Refer to Python documentation for the regular expression syntax.
+All columns are searched, but only currently fetched rows are searched.
+"""
+
+# Help window
+
+class HelpWindow(QMdiSubWindow):
+
+	def __init__(self, glb, parent=None):
+		super(HelpWindow, self).__init__(parent)
+
+		self.text = QTextBrowser()
+		self.text.setHtml(glb_help_text)
+		self.text.setReadOnly(True)
+		self.text.setOpenExternalLinks(True)
+
+		self.setWidget(self.text)
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Exported SQL Viewer Help")
+
+# Main window that only displays the help text
+
+class HelpOnlyWindow(QMainWindow):
+
+	def __init__(self, parent=None):
+		super(HelpOnlyWindow, self).__init__(parent)
+
+		self.setMinimumSize(200, 100)
+		self.resize(800, 600)
+		self.setWindowTitle("Exported SQL Viewer Help")
+		self.setWindowIcon(self.style().standardIcon(QStyle.SP_MessageBoxInformation))
+
+		self.text = QTextBrowser()
+		self.text.setHtml(glb_help_text)
+		self.text.setReadOnly(True)
+		self.text.setOpenExternalLinks(True)
+
+		self.setCentralWidget(self.text)
+
 # Font resize
 
 def ResizeFont(widget, diff):
@@ -2170,6 +2311,9 @@ class MainWindow(QMainWindow):
 
 		self.window_menu = WindowMenu(self.mdi_area, menu)
 
+		help_menu = menu.addMenu("&Help")
+		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
@@ -2230,6 +2374,9 @@ class MainWindow(QMainWindow):
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
 
+	def Help(self):
+		HelpWindow(self.glb, self)
+
 # XED Disassembler
 
 class xed_state_t(Structure):
@@ -2429,10 +2576,16 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: exported-sql-viewer.py <database name>"
+		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
+	if dbname == "--help-only":
+		app = QApplication(sys.argv)
+		mainwindow = HelpOnlyWindow()
+		mainwindow.show()
+		err = app.exec_()
+		sys.exit(err)
 
 	is_sqlite3 = False
 	try:
-- 
2.17.1

