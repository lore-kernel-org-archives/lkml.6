Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D678C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C63206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C63206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeJANL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:3862 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbeJANL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466526"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] perf scripts python: exported-sql-viewer.py: Add All branches report
Date:   Mon,  1 Oct 2018 09:28:51 +0300
Message-Id: <20181001062853.28285-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a report to display branches in a similar fashion to perf script. The
main purpose of this report is to display disassembly, however, presently,
the only supported disassembler is Intel XED, and additionally the object
code must be present in perf build ID cache.

To use Intel XED, libxed.so must be present. To build and install
libxed.so:
	git clone https://github.com/intelxed/mbuild.git mbuild
	git clone https://github.com/intelxed/xed
	cd xed
	./mfile.py --share
	sudo ./mfile.py --prefix=/usr/local install
	sudo ldconfig

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 545 ++++++++++++++++++
 1 file changed, 545 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index ef822d850109..47de923655e9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -46,6 +46,48 @@
 #	'Branch Count' is the total number of branches for that function and all
 #       functions that it calls
 
+# There is also a "All branches" report, which displays branches and
+# possibly disassembly.  However, presently, the only supported disassembler is
+# Intel XED, and additionally the object code must be present in perf build ID
+# cache. To use Intel XED, libxed.so must be present. To build and install
+# libxed.so:
+#            git clone https://github.com/intelxed/mbuild.git mbuild
+#            git clone https://github.com/intelxed/xed
+#            cd xed
+#            ./mfile.py --share
+#            sudo ./mfile.py --prefix=/usr/local install
+#            sudo ldconfig
+#
+# Example report:
+#
+# Time           CPU  Command  PID    TID    Branch Type            In Tx  Branch
+# 8107675239590  2    ls       22011  22011  return from interrupt  No     ffffffff86a00a67 native_irq_return_iret ([kernel]) -> 7fab593ea260 _start (ld-2.19.so)
+#                                                                              7fab593ea260 48 89 e7                                        mov %rsp, %rdi
+# 8107675239899  2    ls       22011  22011  hardware interrupt     No         7fab593ea260 _start (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
+# 8107675241900  2    ls       22011  22011  return from interrupt  No     ffffffff86a00a67 native_irq_return_iret ([kernel]) -> 7fab593ea260 _start (ld-2.19.so)
+#                                                                              7fab593ea260 48 89 e7                                        mov %rsp, %rdi
+#                                                                              7fab593ea263 e8 c8 06 00 00                                  callq  0x7fab593ea930
+# 8107675241900  2    ls       22011  22011  call                   No         7fab593ea263 _start+0x3 (ld-2.19.so) -> 7fab593ea930 _dl_start (ld-2.19.so)
+#                                                                              7fab593ea930 55                                              pushq  %rbp
+#                                                                              7fab593ea931 48 89 e5                                        mov %rsp, %rbp
+#                                                                              7fab593ea934 41 57                                           pushq  %r15
+#                                                                              7fab593ea936 41 56                                           pushq  %r14
+#                                                                              7fab593ea938 41 55                                           pushq  %r13
+#                                                                              7fab593ea93a 41 54                                           pushq  %r12
+#                                                                              7fab593ea93c 53                                              pushq  %rbx
+#                                                                              7fab593ea93d 48 89 fb                                        mov %rdi, %rbx
+#                                                                              7fab593ea940 48 83 ec 68                                     sub $0x68, %rsp
+#                                                                              7fab593ea944 0f 31                                           rdtsc
+#                                                                              7fab593ea946 48 c1 e2 20                                     shl $0x20, %rdx
+#                                                                              7fab593ea94a 89 c0                                           mov %eax, %eax
+#                                                                              7fab593ea94c 48 09 c2                                        or %rax, %rdx
+#                                                                              7fab593ea94f 48 8b 05 1a 15 22 00                            movq  0x22151a(%rip), %rax
+# 8107675242232  2    ls       22011  22011  hardware interrupt     No         7fab593ea94f _dl_start+0x1f (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
+# 8107675242900  2    ls       22011  22011  return from interrupt  No     ffffffff86a00a67 native_irq_return_iret ([kernel]) -> 7fab593ea94f _dl_start+0x1f (ld-2.19.so)
+#                                                                              7fab593ea94f 48 8b 05 1a 15 22 00                            movq  0x22151a(%rip), %rax
+#                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
+# 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
+
 import sys
 import weakref
 import threading
@@ -62,6 +104,16 @@ from multiprocessing import Process, Array, Value, Event
 
 # Data formatting helpers
 
+def tohex(ip):
+	if ip < 0:
+		ip += 1 << 64
+	return "%x" % ip
+
+def offstr(offset):
+	if offset:
+		return "+0x%x" % offset
+	return ""
+
 def dsoname(name):
 	if name == "[kernel.kallsyms]":
 		return "[kernel]"
@@ -1077,6 +1129,351 @@ class FetchMoreRecordsBar():
 		self.in_progress = True
 		self.start = self.model.FetchMoreRecords(self.Target())
 
+# Brance data model level two item
+
+class BranchLevelTwoItem():
+
+	def __init__(self, row, text, parent_item):
+		self.row = row
+		self.parent_item = parent_item
+		self.data = [""] * 8
+		self.data[7] = text
+		self.level = 2
+
+	def getParentItem(self):
+		return self.parent_item
+
+	def getRow(self):
+		return self.row
+
+	def childCount(self):
+		return 0
+
+	def hasChildren(self):
+		return False
+
+	def getData(self, column):
+		return self.data[column]
+
+# Brance data model level one item
+
+class BranchLevelOneItem():
+
+	def __init__(self, glb, row, data, parent_item):
+		self.glb = glb
+		self.row = row
+		self.parent_item = parent_item
+		self.child_count = 0
+		self.child_items = []
+		self.data = data[1:]
+		self.dbid = data[0]
+		self.level = 1
+		self.query_done = False
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
+	def Select(self):
+		self.query_done = True
+
+		if not self.glb.have_disassembler:
+			return
+
+		query = QSqlQuery(self.glb.db)
+
+		QueryExec(query, "SELECT cpu, to_dso_id, to_symbol_id, to_sym_offset, short_name, long_name, build_id, sym_start, to_ip"
+				  " FROM samples"
+				  " INNER JOIN dsos ON samples.to_dso_id = dsos.id"
+				  " INNER JOIN symbols ON samples.to_symbol_id = symbols.id"
+				  " WHERE samples.id = " + str(self.dbid))
+		if not query.next():
+			return
+		cpu = query.value(0)
+		dso = query.value(1)
+		sym = query.value(2)
+		if dso == 0 or sym == 0:
+			return
+		off = query.value(3)
+		short_name = query.value(4)
+		long_name = query.value(5)
+		build_id = query.value(6)
+		sym_start = query.value(7)
+		ip = query.value(8)
+
+		QueryExec(query, "SELECT samples.dso_id, symbol_id, sym_offset, sym_start"
+				  " FROM samples"
+				  " INNER JOIN symbols ON samples.symbol_id = symbols.id"
+				  " WHERE samples.id > " + str(self.dbid) + " AND cpu = " + str(cpu) +
+				  " ORDER BY samples.id"
+				  " LIMIT 1")
+		if not query.next():
+			return
+		if query.value(0) != dso:
+			# Cannot disassemble from one dso to another
+			return
+		bsym = query.value(1)
+		boff = query.value(2)
+		bsym_start = query.value(3)
+		if bsym == 0:
+			return
+		tot = bsym_start + boff + 1 - sym_start - off
+		if tot <= 0 or tot > 16384:
+			return
+
+		inst = self.glb.disassembler.Instruction()
+		f = self.glb.FileFromNamesAndBuildId(short_name, long_name, build_id)
+		if not f:
+			return
+		mode = 0 if Is64Bit(f) else 1
+		self.glb.disassembler.SetMode(inst, mode)
+
+		buf_sz = tot + 16
+		buf = create_string_buffer(tot + 16)
+		f.seek(sym_start + off)
+		buf.value = f.read(buf_sz)
+		buf_ptr = addressof(buf)
+		i = 0
+		while tot > 0:
+			cnt, text = self.glb.disassembler.DisassembleOne(inst, buf_ptr, buf_sz, ip)
+			if cnt:
+				byte_str = tohex(ip).rjust(16)
+				for k in xrange(cnt):
+					byte_str += " %02x" % ord(buf[i])
+					i += 1
+				while k < 15:
+					byte_str += "   "
+					k += 1
+				self.child_items.append(BranchLevelTwoItem(0, byte_str + " " + text, self))
+				self.child_count += 1
+			else:
+				return
+			buf_ptr += cnt
+			tot -= cnt
+			buf_sz -= cnt
+			ip += cnt
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
+# Brance data model root item
+
+class BranchRootItem():
+
+	def __init__(self):
+		self.child_count = 0
+		self.child_items = []
+		self.level = 0
+
+	def getChildItem(self, row):
+		return self.child_items[row]
+
+	def getParentItem(self):
+		return None
+
+	def getRow(self):
+		return 0
+
+	def childCount(self):
+		return self.child_count
+
+	def hasChildren(self):
+		return self.child_count > 0
+
+	def getData(self, column):
+		return ""
+
+# Branch data preparation
+
+def BranchDataPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
+			" (" + dsoname(query.value(11)) + ")" + " -> " +
+			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
+			" (" + dsoname(query.value(15)) + ")")
+	return data
+
+# Branch data model
+
+class BranchModel(TreeModel):
+
+	progress = Signal(object)
+
+	def __init__(self, glb, event_id, where_clause, parent=None):
+		super(BranchModel, self).__init__(BranchRootItem(), parent)
+		self.glb = glb
+		self.event_id = event_id
+		self.more = True
+		self.populated = 0
+		sql = ("SELECT samples.id, time, cpu, comm, pid, tid, branch_types.name,"
+			" CASE WHEN in_tx = '0' THEN 'No' ELSE 'Yes' END,"
+			" ip, symbols.name, sym_offset, dsos.short_name,"
+			" to_ip, to_symbols.name, to_sym_offset, to_dsos.short_name"
+			" FROM samples"
+			" INNER JOIN comms ON comm_id = comms.id"
+			" INNER JOIN threads ON thread_id = threads.id"
+			" INNER JOIN branch_types ON branch_type = branch_types.id"
+			" INNER JOIN symbols ON symbol_id = symbols.id"
+			" INNER JOIN symbols to_symbols ON to_symbol_id = to_symbols.id"
+			" INNER JOIN dsos ON samples.dso_id = dsos.id"
+			" INNER JOIN dsos AS to_dsos ON samples.to_dso_id = to_dsos.id"
+			" WHERE samples.id > $$last_id$$" + where_clause +
+			" AND evsel_id = " + str(self.event_id) +
+			" ORDER BY samples.id"
+			" LIMIT " + str(glb_chunk_sz))
+		self.fetcher = SQLFetcher(glb, sql, BranchDataPrep, self.AddSample)
+		self.fetcher.done.connect(self.Update)
+		self.fetcher.Fetch(glb_chunk_sz)
+
+	def columnCount(self, parent=None):
+		return 8
+
+	def columnHeader(self, column):
+		return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
+
+	def columnFont(self, column):
+		if column != 7:
+			return None
+		return QFont("Monospace")
+
+	def DisplayData(self, item, index):
+		if item.level == 1:
+			self.FetchIfNeeded(item.row)
+		return item.getData(index.column())
+
+	def AddSample(self, data):
+		child = BranchLevelOneItem(self.glb, self.populated, data, self.root)
+		self.root.child_items.append(child)
+		self.populated += 1
+
+	def Update(self, fetched):
+		if not fetched:
+			self.more = False
+			self.progress.emit(0)
+		child_count = self.root.child_count
+		count = self.populated - child_count
+		if count > 0:
+			parent = QModelIndex()
+			self.beginInsertRows(parent, child_count, child_count + count - 1)
+			self.insertRows(child_count, count, parent)
+			self.root.child_count += count
+			self.endInsertRows()
+			self.progress.emit(self.root.child_count)
+
+	def FetchMoreRecords(self, count):
+		current = self.root.child_count
+		if self.more:
+			self.fetcher.Fetch(count)
+		else:
+			self.progress.emit(0)
+		return current
+
+	def HasMoreRecords(self):
+		return self.more
+
+# Branch window
+
+class BranchWindow(QMdiSubWindow):
+
+	def __init__(self, glb, event_id, name, where_clause, parent=None):
+		super(BranchWindow, self).__init__(parent)
+
+		model_name = "Branch Events " + str(event_id)
+		if len(where_clause):
+			model_name = where_clause + " " + model_name
+
+		self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, where_clause))
+
+		self.view = QTreeView()
+		self.view.setUniformRowHeights(True)
+		self.view.setModel(self.model)
+
+		self.ResizeColumnsToContents()
+
+		self.find_bar = FindBar(self, self, True)
+
+		self.finder = ChildDataItemFinder(self.model.root)
+
+		self.fetch_bar = FetchMoreRecordsBar(self.model, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget(), self.fetch_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, name + " Branch Events")
+
+	def ResizeColumnToContents(self, column, n):
+		# Using the view's resizeColumnToContents() here is extrememly slow
+		# so implement a crude alternative
+		mm = "MM" if column else "MMMM"
+		font = self.view.font()
+		metrics = QFontMetrics(font)
+		max = 0
+		for row in xrange(n):
+			val = self.model.root.child_items[row].data[column]
+			len = metrics.width(str(val) + mm)
+			max = len if len > max else max
+		val = self.model.columnHeader(column)
+		len = metrics.width(str(val) + mm)
+		max = len if len > max else max
+		self.view.setColumnWidth(column, max)
+
+	def ResizeColumnsToContents(self):
+		n = min(self.model.root.child_count, 100)
+		if n < 1:
+			# No data yet, so connect a signal to notify when there is
+			self.model.rowsInserted.connect(self.UpdateColumnWidths)
+			return
+		columns = self.model.columnCount()
+		for i in xrange(columns):
+			self.ResizeColumnToContents(i, n)
+
+	def UpdateColumnWidths(self, *x):
+		# This only needs to be done once, so disconnect the signal now
+		self.model.rowsInserted.disconnect(self.UpdateColumnWidths)
+		self.ResizeColumnsToContents()
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
+# Event list
+
+def GetEventList(db):
+	events = []
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT name FROM selected_events WHERE id > 0 ORDER BY id")
+	while query.next():
+		events.append(query.value(0))
+	return events
+
 # SQL data preparation
 
 def SQLTableDataPrep(query, count):
@@ -1448,6 +1845,8 @@ class MainWindow(QMainWindow):
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
+		self.EventMenu(GetEventList(glb.db), reports_menu)
+
 		self.TableMenu(GetTableList(glb), menu)
 
 		self.window_menu = WindowMenu(self.mdi_area, menu)
@@ -1476,6 +1875,18 @@ class MainWindow(QMainWindow):
 		win = self.mdi_area.activeSubWindow()
 		EnlargeFont(win.view)
 
+	def EventMenu(self, events, reports_menu):
+		branches_events = 0
+		for event in events:
+			if event == "branches":
+				branches_events += 1
+		dbid = 0
+		for event in events:
+			dbid += 1
+			if event == "branches":
+				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
@@ -1484,9 +1895,112 @@ class MainWindow(QMainWindow):
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
+	def NewBranchView(self, event_id):
+		BranchWindow(self.glb, event_id, "", "", self)
+
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
 
+# XED Disassembler
+
+class xed_state_t(Structure):
+
+	_fields_ = [
+		("mode", c_int),
+		("width", c_int)
+	]
+
+class XEDInstruction():
+
+	def __init__(self, libxed):
+		# Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow for future expansion
+		xedd_t = c_byte * 512
+		self.xedd = xedd_t()
+		self.xedp = addressof(self.xedd)
+		libxed.xed_decoded_inst_zero(self.xedp)
+		self.state = xed_state_t()
+		self.statep = addressof(self.state)
+		# Buffer for disassembled instruction text
+		self.buffer = create_string_buffer(256)
+		self.bufferp = addressof(self.buffer)
+
+class LibXED():
+
+	def __init__(self):
+		self.libxed = CDLL("libxed.so")
+
+		self.xed_tables_init = self.libxed.xed_tables_init
+		self.xed_tables_init.restype = None
+		self.xed_tables_init.argtypes = []
+
+		self.xed_decoded_inst_zero = self.libxed.xed_decoded_inst_zero
+		self.xed_decoded_inst_zero.restype = None
+		self.xed_decoded_inst_zero.argtypes = [ c_void_p ]
+
+		self.xed_operand_values_set_mode = self.libxed.xed_operand_values_set_mode
+		self.xed_operand_values_set_mode.restype = None
+		self.xed_operand_values_set_mode.argtypes = [ c_void_p, c_void_p ]
+
+		self.xed_decoded_inst_zero_keep_mode = self.libxed.xed_decoded_inst_zero_keep_mode
+		self.xed_decoded_inst_zero_keep_mode.restype = None
+		self.xed_decoded_inst_zero_keep_mode.argtypes = [ c_void_p ]
+
+		self.xed_decode = self.libxed.xed_decode
+		self.xed_decode.restype = c_int
+		self.xed_decode.argtypes = [ c_void_p, c_void_p, c_uint ]
+
+		self.xed_format_context = self.libxed.xed_format_context
+		self.xed_format_context.restype = c_uint
+		self.xed_format_context.argtypes = [ c_int, c_void_p, c_void_p, c_int, c_ulonglong, c_void_p, c_void_p ]
+
+		self.xed_tables_init()
+
+	def Instruction(self):
+		return XEDInstruction(self)
+
+	def SetMode(self, inst, mode):
+		if mode:
+			inst.state.mode = 4 # 32-bit
+			inst.state.width = 4 # 4 bytes
+		else:
+			inst.state.mode = 1 # 64-bit
+			inst.state.width = 8 # 8 bytes
+		self.xed_operand_values_set_mode(inst.xedp, inst.statep)
+
+	def DisassembleOne(self, inst, bytes_ptr, bytes_cnt, ip):
+		self.xed_decoded_inst_zero_keep_mode(inst.xedp)
+		err = self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
+		if err:
+			return 0, ""
+		# Use AT&T mode (2), alternative is Intel (3)
+		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
+		if not ok:
+			return 0, ""
+		# Return instruction length and the disassembled instruction text
+		# For now, assume the length is in byte 166
+		return inst.xedd[166], inst.buffer.value
+
+def TryOpen(file_name):
+	try:
+		return open(file_name, "rb")
+	except:
+		return None
+
+def Is64Bit(f):
+	result = sizeof(c_void_p)
+	# ELF support only
+	pos = f.tell()
+	f.seek(0)
+	header = f.read(7)
+	f.seek(pos)
+	magic = header[0:4]
+	eclass = ord(header[4])
+	encoding = ord(header[5])
+	version = ord(header[6])
+	if magic == chr(127) + "ELF" and eclass > 0 and eclass < 3 and encoding > 0 and encoding < 3 and version == 1:
+		result = True if eclass == 2 else False
+	return result
+
 # Global data
 
 class Glb():
@@ -1495,9 +2009,40 @@ class Glb():
 		self.dbref = dbref
 		self.db = db
 		self.dbname = dbname
+		self.home_dir = os.path.expanduser("~")
+		self.buildid_dir = os.getenv("PERF_BUILDID_DIR")
+		if self.buildid_dir:
+			self.buildid_dir += "/.build-id/"
+		else:
+			self.buildid_dir = self.home_dir + "/.debug/.build-id/"
 		self.app = None
 		self.mainwindow = None
 		self.instances_to_shutdown_on_exit = weakref.WeakSet()
+		try:
+			self.disassembler = LibXED()
+			self.have_disassembler = True
+		except:
+			self.have_disassembler = False
+
+	def FileFromBuildId(self, build_id):
+		file_name = self.buildid_dir + build_id[0:2] + "/" + build_id[2:] + "/elf"
+		return TryOpen(file_name)
+
+	def FileFromNamesAndBuildId(self, short_name, long_name, build_id):
+		# Assume current machine i.e. no support for virtualization
+		if short_name[0:7] == "[kernel" and os.path.basename(long_name) == "kcore":
+			file_name = os.getenv("PERF_KCORE")
+			f = TryOpen(file_name) if file_name else None
+			if f:
+				return f
+			# For now, no special handling if long_name is /proc/kcore
+			f = TryOpen(long_name)
+			if f:
+				return f
+		f = self.FileFromBuildId(build_id)
+		if f:
+			return f
+		return None
 
 	def AddInstanceToShutdownOnExit(self, instance):
 		self.instances_to_shutdown_on_exit.add(instance)
-- 
2.17.1

