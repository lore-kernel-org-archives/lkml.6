Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0871C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A97A206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A97A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeJANMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:12:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:28751 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbeJANMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:12:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466522"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:19 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables
Date:   Mon,  1 Oct 2018 09:28:50 +0300
Message-Id: <20181001062853.28285-17-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying all the database tables can help make the database easier to
understand.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 694 ++++++++++++++++++
 1 file changed, 694 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 310ba7147583..ef822d850109 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -50,10 +50,15 @@ import sys
 import weakref
 import threading
 import string
+import cPickle
+import re
+import os
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
 from decimal import *
+from ctypes import *
+from multiprocessing import Process, Array, Value, Event
 
 # Data formatting helpers
 
@@ -146,6 +151,68 @@ class TreeModel(QAbstractItemModel):
 	def DisplayData(self, item, index):
 		return item.getData(index.column())
 
+	def FetchIfNeeded(self, row):
+		if row > self.last_row_read:
+			self.last_row_read = row
+			if row + 10 >= self.root.child_count:
+				self.fetcher.Fetch(glb_chunk_sz)
+
+	def columnAlignment(self, column):
+		return Qt.AlignLeft
+
+	def columnFont(self, column):
+		return None
+
+	def data(self, index, role):
+		if role == Qt.TextAlignmentRole:
+			return self.columnAlignment(index.column())
+		if role == Qt.FontRole:
+			return self.columnFont(index.column())
+		if role != Qt.DisplayRole:
+			return None
+		item = index.internalPointer()
+		return self.DisplayData(item, index)
+
+# Table data model
+
+class TableModel(QAbstractTableModel):
+
+	def __init__(self, parent=None):
+		super(TableModel, self).__init__(parent)
+		self.child_count = 0
+		self.child_items = []
+		self.last_row_read = 0
+
+	def Item(self, parent):
+		if parent.isValid():
+			return parent.internalPointer()
+		else:
+			return self
+
+	def rowCount(self, parent):
+		return self.child_count
+
+	def headerData(self, section, orientation, role):
+		if role == Qt.TextAlignmentRole:
+			return self.columnAlignment(section)
+		if role != Qt.DisplayRole:
+			return None
+		if orientation != Qt.Horizontal:
+			return None
+		return self.columnHeader(section)
+
+	def index(self, row, column, parent):
+		return self.createIndex(row, column, self.child_items[row])
+
+	def DisplayData(self, item, index):
+		return item.getData(index.column())
+
+	def FetchIfNeeded(self, row):
+		if row > self.last_row_read:
+			self.last_row_read = row
+			if row + 10 >= self.child_count:
+				self.fetcher.Fetch(glb_chunk_sz)
+
 	def columnAlignment(self, column):
 		return Qt.AlignLeft
 
@@ -620,6 +687,601 @@ class CallGraphWindow(QMdiSubWindow):
 		if not found:
 			self.find_bar.NotFound()
 
+# Child data item  finder
+
+class ChildDataItemFinder():
+
+	def __init__(self, root):
+		self.root = root
+		self.value, self.direction, self.pattern, self.last_value, self.last_pattern = (None,) * 5
+		self.rows = []
+		self.pos = 0
+
+	def FindSelect(self):
+		self.rows = []
+		if self.pattern:
+			pattern = re.compile(self.value)
+			for child in self.root.child_items:
+				for column_data in child.data:
+					if re.search(pattern, str(column_data)) is not None:
+						self.rows.append(child.row)
+						break
+		else:
+			for child in self.root.child_items:
+				for column_data in child.data:
+					if self.value in str(column_data):
+						self.rows.append(child.row)
+						break
+
+	def FindValue(self):
+		self.pos = 0
+		if self.last_value != self.value or self.pattern != self.last_pattern:
+			self.FindSelect()
+		if not len(self.rows):
+			return -1
+		return self.rows[self.pos]
+
+	def FindThread(self):
+		if self.direction == 0 or self.value != self.last_value or self.pattern != self.last_pattern:
+			row = self.FindValue()
+		elif len(self.rows):
+			if self.direction > 0:
+				self.pos += 1
+				if self.pos >= len(self.rows):
+					self.pos = 0
+			else:
+				self.pos -= 1
+				if self.pos < 0:
+					self.pos = len(self.rows) - 1
+			row = self.rows[self.pos]
+		else:
+			row = -1
+		return (True, row)
+
+	def Find(self, value, direction, pattern, context, callback):
+		self.value, self.direction, self.pattern, self.last_value, self.last_pattern = (value, direction,pattern, self.value, self.pattern)
+		# Use a thread so the UI is not blocked
+		thread = Thread(self.FindThread)
+		thread.done.connect(lambda row, t=thread, c=callback: self.FindDone(t, c, row), Qt.QueuedConnection)
+		thread.start()
+
+	def FindDone(self, thread, callback, row):
+		callback(row)
+
+# Number of database records to fetch in one go
+
+glb_chunk_sz = 10000
+
+# size of pickled integer big enough for record size
+
+glb_nsz = 8
+
+# Background process for SQL data fetcher
+
+class SQLFetcherProcess():
+
+	def __init__(self, dbref, sql, buffer, head, tail, fetch_count, fetching_done, process_target, wait_event, fetched_event, prep):
+		# Need a unique connection name
+		conn_name = "SQLFetcher" + str(os.getpid())
+		self.db, dbname = dbref.Open(conn_name)
+		self.sql = sql
+		self.buffer = buffer
+		self.head = head
+		self.tail = tail
+		self.fetch_count = fetch_count
+		self.fetching_done = fetching_done
+		self.process_target = process_target
+		self.wait_event = wait_event
+		self.fetched_event = fetched_event
+		self.prep = prep
+		self.query = QSqlQuery(self.db)
+		self.query_limit = 0 if "$$last_id$$" in sql else 2
+		self.last_id = -1
+		self.fetched = 0
+		self.more = True
+		self.local_head = self.head.value
+		self.local_tail = self.tail.value
+
+	def Select(self):
+		if self.query_limit:
+			if self.query_limit == 1:
+				return
+			self.query_limit -= 1
+		stmt = self.sql.replace("$$last_id$$", str(self.last_id))
+		QueryExec(self.query, stmt)
+
+	def Next(self):
+		if not self.query.next():
+			self.Select()
+			if not self.query.next():
+				return None
+		self.last_id = self.query.value(0)
+		return self.prep(self.query)
+
+	def WaitForTarget(self):
+		while True:
+			self.wait_event.clear()
+			target = self.process_target.value
+			if target > self.fetched or target < 0:
+				break
+			self.wait_event.wait()
+		return target
+
+	def HasSpace(self, sz):
+		if self.local_tail <= self.local_head:
+			space = len(self.buffer) - self.local_head
+			if space > sz:
+				return True
+			if space >= glb_nsz:
+				# Use 0 (or space < glb_nsz) to mean there is no more at the top of the buffer
+				nd = cPickle.dumps(0, cPickle.HIGHEST_PROTOCOL)
+				self.buffer[self.local_head : self.local_head + len(nd)] = nd
+			self.local_head = 0
+		if self.local_tail - self.local_head > sz:
+			return True
+		return False
+
+	def WaitForSpace(self, sz):
+		if self.HasSpace(sz):
+			return
+		while True:
+			self.wait_event.clear()
+			self.local_tail = self.tail.value
+			if self.HasSpace(sz):
+				return
+			self.wait_event.wait()
+
+	def AddToBuffer(self, obj):
+		d = cPickle.dumps(obj, cPickle.HIGHEST_PROTOCOL)
+		n = len(d)
+		nd = cPickle.dumps(n, cPickle.HIGHEST_PROTOCOL)
+		sz = n + glb_nsz
+		self.WaitForSpace(sz)
+		pos = self.local_head
+		self.buffer[pos : pos + len(nd)] = nd
+		self.buffer[pos + glb_nsz : pos + sz] = d
+		self.local_head += sz
+
+	def FetchBatch(self, batch_size):
+		fetched = 0
+		while batch_size > fetched:
+			obj = self.Next()
+			if obj is None:
+				self.more = False
+				break
+			self.AddToBuffer(obj)
+			fetched += 1
+		if fetched:
+			self.fetched += fetched
+			with self.fetch_count.get_lock():
+				self.fetch_count.value += fetched
+			self.head.value = self.local_head
+			self.fetched_event.set()
+
+	def Run(self):
+		while self.more:
+			target = self.WaitForTarget()
+			if target < 0:
+				break
+			batch_size = min(glb_chunk_sz, target - self.fetched)
+			self.FetchBatch(batch_size)
+		self.fetching_done.value = True
+		self.fetched_event.set()
+
+def SQLFetcherFn(*x):
+	process = SQLFetcherProcess(*x)
+	process.Run()
+
+# SQL data fetcher
+
+class SQLFetcher(QObject):
+
+	done = Signal(object)
+
+	def __init__(self, glb, sql, prep, process_data, parent=None):
+		super(SQLFetcher, self).__init__(parent)
+		self.process_data = process_data
+		self.more = True
+		self.target = 0
+		self.last_target = 0
+		self.fetched = 0
+		self.buffer_size = 16 * 1024 * 1024
+		self.buffer = Array(c_char, self.buffer_size, lock=False)
+		self.head = Value(c_longlong)
+		self.tail = Value(c_longlong)
+		self.local_tail = 0
+		self.fetch_count = Value(c_longlong)
+		self.fetching_done = Value(c_bool)
+		self.last_count = 0
+		self.process_target = Value(c_longlong)
+		self.wait_event = Event()
+		self.fetched_event = Event()
+		glb.AddInstanceToShutdownOnExit(self)
+		self.process = Process(target=SQLFetcherFn, args=(glb.dbref, sql, self.buffer, self.head, self.tail, self.fetch_count, self.fetching_done, self.process_target, self.wait_event, self.fetched_event, prep))
+		self.process.start()
+		self.thread = Thread(self.Thread)
+		self.thread.done.connect(self.ProcessData, Qt.QueuedConnection)
+		self.thread.start()
+
+	def Shutdown(self):
+		# Tell the thread and process to exit
+		self.process_target.value = -1
+		self.wait_event.set()
+		self.more = False
+		self.fetching_done.value = True
+		self.fetched_event.set()
+
+	def Thread(self):
+		if not self.more:
+			return True, 0
+		while True:
+			self.fetched_event.clear()
+			fetch_count = self.fetch_count.value
+			if fetch_count != self.last_count:
+				break
+			if self.fetching_done.value:
+				self.more = False
+				return True, 0
+			self.fetched_event.wait()
+		count = fetch_count - self.last_count
+		self.last_count = fetch_count
+		self.fetched += count
+		return False, count
+
+	def Fetch(self, nr):
+		if not self.more:
+			# -1 inidcates there are no more
+			return -1
+		result = self.fetched
+		extra = result + nr - self.target
+		if extra > 0:
+			self.target += extra
+			# process_target < 0 indicates shutting down
+			if self.process_target.value >= 0:
+				self.process_target.value = self.target
+			self.wait_event.set()
+		return result
+
+	def RemoveFromBuffer(self):
+		pos = self.local_tail
+		if len(self.buffer) - pos < glb_nsz:
+			pos = 0
+		n = cPickle.loads(self.buffer[pos : pos + glb_nsz])
+		if n == 0:
+			pos = 0
+			n = cPickle.loads(self.buffer[0 : glb_nsz])
+		pos += glb_nsz
+		obj = cPickle.loads(self.buffer[pos : pos + n])
+		self.local_tail = pos + n
+		return obj
+
+	def ProcessData(self, count):
+		for i in xrange(count):
+			obj = self.RemoveFromBuffer()
+			self.process_data(obj)
+		self.tail.value = self.local_tail
+		self.wait_event.set()
+		self.done.emit(count)
+
+# Fetch more records bar
+
+class FetchMoreRecordsBar():
+
+	def __init__(self, model, parent):
+		self.model = model
+
+		self.label = QLabel("Number of records (x " + "{:,}".format(glb_chunk_sz) + ") to fetch:")
+		self.label.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.fetch_count = QSpinBox()
+		self.fetch_count.setRange(1, 1000000)
+		self.fetch_count.setValue(10)
+		self.fetch_count.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.fetch = QPushButton("Go!")
+		self.fetch.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+		self.fetch.released.connect(self.FetchMoreRecords)
+
+		self.progress = QProgressBar()
+		self.progress.setRange(0, 100)
+		self.progress.hide()
+
+		self.done_label = QLabel("All records fetched")
+		self.done_label.hide()
+
+		self.spacer = QLabel("")
+
+		self.close_button = QToolButton()
+		self.close_button.setIcon(parent.style().standardIcon(QStyle.SP_DockWidgetCloseButton))
+		self.close_button.released.connect(self.Deactivate)
+
+		self.hbox = QHBoxLayout()
+		self.hbox.setContentsMargins(0, 0, 0, 0)
+
+		self.hbox.addWidget(self.label)
+		self.hbox.addWidget(self.fetch_count)
+		self.hbox.addWidget(self.fetch)
+		self.hbox.addWidget(self.spacer)
+		self.hbox.addWidget(self.progress)
+		self.hbox.addWidget(self.done_label)
+		self.hbox.addWidget(self.close_button)
+
+		self.bar = QWidget()
+		self.bar.setLayout(self.hbox);
+		self.bar.show()
+
+		self.in_progress = False
+		self.model.progress.connect(self.Progress)
+
+		self.done = False
+
+		if not model.HasMoreRecords():
+			self.Done()
+
+	def Widget(self):
+		return self.bar
+
+	def Activate(self):
+		self.bar.show()
+		self.fetch.setFocus()
+
+	def Deactivate(self):
+		self.bar.hide()
+
+	def Enable(self, enable):
+		self.fetch.setEnabled(enable)
+		self.fetch_count.setEnabled(enable)
+
+	def Busy(self):
+		self.Enable(False)
+		self.fetch.hide()
+		self.spacer.hide()
+		self.progress.show()
+
+	def Idle(self):
+		self.in_progress = False
+		self.Enable(True)
+		self.progress.hide()
+		self.fetch.show()
+		self.spacer.show()
+
+	def Target(self):
+		return self.fetch_count.value() * glb_chunk_sz
+
+	def Done(self):
+		self.done = True
+		self.Idle()
+		self.label.hide()
+		self.fetch_count.hide()
+		self.fetch.hide()
+		self.spacer.hide()
+		self.done_label.show()
+
+	def Progress(self, count):
+		if self.in_progress:
+			if count:
+				percent = ((count - self.start) * 100) / self.Target()
+				if percent >= 100:
+					self.Idle()
+				else:
+					self.progress.setValue(percent)
+		if not count:
+			# Count value of zero means no more records
+			self.Done()
+
+	def FetchMoreRecords(self):
+		if self.done:
+			return
+		self.progress.setValue(0)
+		self.Busy()
+		self.in_progress = True
+		self.start = self.model.FetchMoreRecords(self.Target())
+
+# SQL data preparation
+
+def SQLTableDataPrep(query, count):
+	data = []
+	for i in xrange(count):
+		data.append(query.value(i))
+	return data
+
+# SQL table data model item
+
+class SQLTableItem():
+
+	def __init__(self, row, data):
+		self.row = row
+		self.data = data
+
+	def getData(self, column):
+		return self.data[column]
+
+# SQL table data model
+
+class SQLTableModel(TableModel):
+
+	progress = Signal(object)
+
+	def __init__(self, glb, sql, column_count, parent=None):
+		super(SQLTableModel, self).__init__(parent)
+		self.glb = glb
+		self.more = True
+		self.populated = 0
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=column_count: SQLTableDataPrep(x, y), self.AddSample)
+		self.fetcher.done.connect(self.Update)
+		self.fetcher.Fetch(glb_chunk_sz)
+
+	def DisplayData(self, item, index):
+		self.FetchIfNeeded(item.row)
+		return item.getData(index.column())
+
+	def AddSample(self, data):
+		child = SQLTableItem(self.populated, data)
+		self.child_items.append(child)
+		self.populated += 1
+
+	def Update(self, fetched):
+		if not fetched:
+			self.more = False
+			self.progress.emit(0)
+		child_count = self.child_count
+		count = self.populated - child_count
+		if count > 0:
+			parent = QModelIndex()
+			self.beginInsertRows(parent, child_count, child_count + count - 1)
+			self.insertRows(child_count, count, parent)
+			self.child_count += count
+			self.endInsertRows()
+			self.progress.emit(self.child_count)
+
+	def FetchMoreRecords(self, count):
+		current = self.child_count
+		if self.more:
+			self.fetcher.Fetch(count)
+		else:
+			self.progress.emit(0)
+		return current
+
+	def HasMoreRecords(self):
+		return self.more
+
+# SQL automatic table data model
+
+class SQLAutoTableModel(SQLTableModel):
+
+	def __init__(self, glb, table_name, parent=None):
+		sql = "SELECT * FROM " + table_name + " WHERE id > $$last_id$$ ORDER BY id LIMIT " + str(glb_chunk_sz)
+		if table_name == "comm_threads_view":
+			# For now, comm_threads_view has no id column
+			sql = "SELECT * FROM " + table_name + " WHERE comm_id > $$last_id$$ ORDER BY comm_id LIMIT " + str(glb_chunk_sz)
+		self.column_headers = []
+		query = QSqlQuery(glb.db)
+		if glb.dbref.is_sqlite3:
+			QueryExec(query, "PRAGMA table_info(" + table_name + ")")
+			while query.next():
+				self.column_headers.append(query.value(1))
+			if table_name == "sqlite_master":
+				sql = "SELECT * FROM " + table_name
+		else:
+			if table_name[:19] == "information_schema.":
+				sql = "SELECT * FROM " + table_name
+				select_table_name = table_name[19:]
+				schema = "information_schema"
+			else:
+				select_table_name = table_name
+				schema = "public"
+			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
+			while query.next():
+				self.column_headers.append(query.value(0))
+		super(SQLAutoTableModel, self).__init__(glb, sql, len(self.column_headers), parent)
+
+	def columnCount(self, parent=None):
+		return len(self.column_headers)
+
+	def columnHeader(self, column):
+		return self.column_headers[column]
+
+# Base class for custom ResizeColumnsToContents
+
+class ResizeColumnsToContentsBase(QObject):
+
+	def __init__(self, parent=None):
+		super(ResizeColumnsToContentsBase, self).__init__(parent)
+
+	def ResizeColumnToContents(self, column, n):
+		# Using the view's resizeColumnToContents() here is extrememly slow
+		# so implement a crude alternative
+		font = self.view.font()
+		metrics = QFontMetrics(font)
+		max = 0
+		for row in xrange(n):
+			val = self.data_model.child_items[row].data[column]
+			len = metrics.width(str(val) + "MM")
+			max = len if len > max else max
+		val = self.data_model.columnHeader(column)
+		len = metrics.width(str(val) + "MM")
+		max = len if len > max else max
+		self.view.setColumnWidth(column, max)
+
+	def ResizeColumnsToContents(self):
+		n = min(self.data_model.child_count, 100)
+		if n < 1:
+			# No data yet, so connect a signal to notify when there is
+			self.data_model.rowsInserted.connect(self.UpdateColumnWidths)
+			return
+		columns = self.data_model.columnCount()
+		for i in xrange(columns):
+			self.ResizeColumnToContents(i, n)
+
+	def UpdateColumnWidths(self, *x):
+		# This only needs to be done once, so disconnect the signal now
+		self.data_model.rowsInserted.disconnect(self.UpdateColumnWidths)
+		self.ResizeColumnsToContents()
+
+# Table window
+
+class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
+
+	def __init__(self, glb, table_name, parent=None):
+		super(TableWindow, self).__init__(parent)
+
+		self.data_model = LookupCreateModel(table_name + " Table", lambda: SQLAutoTableModel(glb, table_name))
+
+		self.model = QSortFilterProxyModel()
+		self.model.setSourceModel(self.data_model)
+
+		self.view = QTableView()
+		self.view.setModel(self.model)
+		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
+		self.view.verticalHeader().setVisible(False)
+		self.view.sortByColumn(-1, Qt.AscendingOrder)
+		self.view.setSortingEnabled(True)
+
+		self.ResizeColumnsToContents()
+
+		self.find_bar = FindBar(self, self, True)
+
+		self.finder = ChildDataItemFinder(self.data_model)
+
+		self.fetch_bar = FetchMoreRecordsBar(self.data_model, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget(), self.fetch_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, table_name + " Table")
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
+# Table list
+
+def GetTableList(glb):
+	tables = []
+	query = QSqlQuery(glb.db)
+	if glb.dbref.is_sqlite3:
+		QueryExec(query, "SELECT name FROM sqlite_master WHERE type IN ( 'table' , 'view' ) ORDER BY name")
+	else:
+		QueryExec(query, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type IN ( 'BASE TABLE' , 'VIEW' ) ORDER BY table_name")
+	while query.next():
+		tables.append(query.value(0))
+	if glb.dbref.is_sqlite3:
+		tables.append("sqlite_master")
+	else:
+		tables.append("information_schema.tables")
+		tables.append("information_schema.views")
+		tables.append("information_schema.columns")
+	return tables
+
 # Action Definition
 
 def CreateAction(label, tip, callback, parent=None, shortcut=None):
@@ -779,12 +1441,15 @@ class MainWindow(QMainWindow):
 
 		edit_menu = menu.addMenu("&Edit")
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
+		edit_menu.addAction(CreateAction("Fetch &more records...", "Fetch more records", self.FetchMoreRecords, self, [QKeySequence(Qt.Key_F8)]))
 		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
 		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
+		self.TableMenu(GetTableList(glb), menu)
+
 		self.window_menu = WindowMenu(self.mdi_area, menu)
 
 	def Find(self):
@@ -795,6 +1460,14 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def FetchMoreRecords(self):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				win.fetch_bar.Activate()
+			except:
+				pass
+
 	def ShrinkFont(self):
 		win = self.mdi_area.activeSubWindow()
 		ShrinkFont(win.view)
@@ -803,9 +1476,17 @@ class MainWindow(QMainWindow):
 		win = self.mdi_area.activeSubWindow()
 		EnlargeFont(win.view)
 
+	def TableMenu(self, tables, menu):
+		table_menu = menu.addMenu("&Tables")
+		for table in tables:
+			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda t=table: self.NewTableView(t), self))
+
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
+	def NewTableView(self, table_name):
+		TableWindow(self.glb, table_name, self)
+
 # Global data
 
 class Glb():
@@ -816,6 +1497,18 @@ class Glb():
 		self.dbname = dbname
 		self.app = None
 		self.mainwindow = None
+		self.instances_to_shutdown_on_exit = weakref.WeakSet()
+
+	def AddInstanceToShutdownOnExit(self, instance):
+		self.instances_to_shutdown_on_exit.add(instance)
+
+	# Shutdown any background processes or threads
+	def ShutdownInstances(self):
+		for x in self.instances_to_shutdown_on_exit:
+			try:
+				x.Shutdown()
+			except:
+				pass
 
 # Database reference
 
@@ -880,6 +1573,7 @@ def Main():
 	glb.mainwindow = mainwindow
 	mainwindow.show()
 	err = app.exec_()
+	glb.ShutdownInstances()
 	db.close()
 	sys.exit(err)
 
-- 
2.17.1

