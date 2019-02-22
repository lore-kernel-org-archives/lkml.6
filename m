Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697FE20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBVXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:07:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:52640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727718AbfBVXHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:07:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35727B60F;
        Fri, 22 Feb 2019 23:07:13 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH 15/15] perf script python: add Python3 support to sql scripts
Date:   Fri, 22 Feb 2019 15:06:19 -0800
Message-Id: <20190222230619.17887-16-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the exported-sql-viewer.py,
export-to-postgresql.py and export-to-sqlite.py scripts

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 .../scripts/python/export-to-postgresql.py    | 31 ++++++----
 tools/perf/scripts/python/export-to-sqlite.py | 26 ++++++---
 .../scripts/python/exported-sql-viewer.py     | 56 ++++++++++++-------
 3 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 30130213da7e..baf972680dc7 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -234,12 +236,17 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **kw_args):
+    print(*args, file=sys.stderr, **kw_args)
+
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	print >> sys.stderr, "Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
+	printerr("where:	columns		'all' or 'branches'")
+	printerr("		calls		'calls' => create calls and call_paths table")
+	printerr("		callchains	'callchains' => create call_paths table")
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -273,7 +280,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+printdate("Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -564,7 +571,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing to intermediate files..."
+	printdate("Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -579,7 +586,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print datetime.datetime.today(), "Copying to database..."
+	printdate("Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -594,7 +601,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print datetime.datetime.today(), "Removing intermediate files..."
+	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -609,7 +616,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print datetime.datetime.today(), "Adding primary keys"
+	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -624,7 +631,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print datetime.datetime.today(), "Adding foreign keys"
+	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -659,8 +666,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index ed237f2ed03f..f56222d22a6e 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -60,11 +62,17 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **keyword_args):
+    print(*args, file=sys.stderr, **keyword_args)
+
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
+
 def usage():
-	print >> sys.stderr, "Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
+	printerr("where:	columns		'all' or 'branches'");
+	printerr("		calls		'calls' => create calls and call_paths table");
+	printerr("		callchains	'callchains' => create call_paths table");
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -100,7 +108,7 @@ def do_query_(q):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+printdate("Creating database ...")
 
 db_exists = False
 try:
@@ -376,7 +384,7 @@ if perf_db_export_calls:
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing records..."
+	printdate("Writing records...")
 	do_query(query, 'BEGIN TRANSACTION')
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
@@ -394,13 +402,13 @@ unhandled_count = 0
 def trace_end():
 	do_query(query, 'END TRANSACTION')
 
-	print datetime.datetime.today(), "Adding indexes"
+	printdate("Adding indexes")
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c3091401df91..9bc03b8f77a5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -87,11 +87,20 @@
 #                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
 # 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
 
+from __future__ import print_function
+
 import sys
 import weakref
 import threading
 import string
-import cPickle
+try:
+    # Python2
+    import cPickle as pickle
+    # size of pickled integer big enough for record size
+    glb_nsz = 8
+except ImportError:
+    import pickle
+    glb_nsz = 16
 import re
 import os
 from PySide.QtCore import *
@@ -101,6 +110,15 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+# xrange is range in Python3
+try:
+    xrange
+except NameError:
+    xrange = range
+
+def printerr(*args, **keyword_args):
+    print(*args, file=sys.stderr, **keyword_args)
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -811,10 +829,6 @@ class ChildDataItemFinder():
 
 glb_chunk_sz = 10000
 
-# size of pickled integer big enough for record size
-
-glb_nsz = 8
-
 # Background process for SQL data fetcher
 
 class SQLFetcherProcess():
@@ -873,7 +887,7 @@ class SQLFetcherProcess():
 				return True
 			if space >= glb_nsz:
 				# Use 0 (or space < glb_nsz) to mean there is no more at the top of the buffer
-				nd = cPickle.dumps(0, cPickle.HIGHEST_PROTOCOL)
+				nd = pickle.dumps(0, pickle.HIGHEST_PROTOCOL)
 				self.buffer[self.local_head : self.local_head + len(nd)] = nd
 			self.local_head = 0
 		if self.local_tail - self.local_head > sz:
@@ -891,9 +905,9 @@ class SQLFetcherProcess():
 			self.wait_event.wait()
 
 	def AddToBuffer(self, obj):
-		d = cPickle.dumps(obj, cPickle.HIGHEST_PROTOCOL)
+		d = pickle.dumps(obj, pickle.HIGHEST_PROTOCOL)
 		n = len(d)
-		nd = cPickle.dumps(n, cPickle.HIGHEST_PROTOCOL)
+		nd = pickle.dumps(n, pickle.HIGHEST_PROTOCOL)
 		sz = n + glb_nsz
 		self.WaitForSpace(sz)
 		pos = self.local_head
@@ -1005,12 +1019,12 @@ class SQLFetcher(QObject):
 		pos = self.local_tail
 		if len(self.buffer) - pos < glb_nsz:
 			pos = 0
-		n = cPickle.loads(self.buffer[pos : pos + glb_nsz])
+		n = pickle.loads(self.buffer[pos : pos + glb_nsz])
 		if n == 0:
 			pos = 0
-			n = cPickle.loads(self.buffer[0 : glb_nsz])
+			n = pickle.loads(self.buffer[0 : glb_nsz])
 		pos += glb_nsz
-		obj = cPickle.loads(self.buffer[pos : pos + n])
+		obj = pickle.loads(self.buffer[pos : pos + n])
 		self.local_tail = pos + n
 		return obj
 
@@ -1559,7 +1573,7 @@ class SQLTableDialogDataItem():
 					return str(lower_id)
 
 	def ConvertRelativeTime(self, val):
-		print "val ", val
+		print("val ", val)
 		mult = 1
 		suffix = val[-2:]
 		if suffix == "ms":
@@ -1581,29 +1595,29 @@ class SQLTableDialogDataItem():
 		return str(val)
 
 	def ConvertTimeRange(self, vrange):
-		print "vrange ", vrange
+		print("vrange ", vrange)
 		if vrange[0] == "":
 			vrange[0] = str(self.first_time)
 		if vrange[1] == "":
 			vrange[1] = str(self.last_time)
 		vrange[0] = self.ConvertRelativeTime(vrange[0])
 		vrange[1] = self.ConvertRelativeTime(vrange[1])
-		print "vrange2 ", vrange
+		print("vrange2 ", vrange)
 		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
 			return False
-		print "ok1"
+		print("ok1")
 		beg_range = max(int(vrange[0]), self.first_time)
 		end_range = min(int(vrange[1]), self.last_time)
 		if beg_range > self.last_time or end_range < self.first_time:
 			return False
-		print "ok2"
+		print("ok2")
 		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
 		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
-		print "vrange3 ", vrange
+		print("vrange3 ", vrange)
 		return True
 
 	def AddTimeRange(self, value, ranges):
-		print "value ", value
+		print("value ", value)
 		n = value.count("-")
 		if n == 1:
 			pass
@@ -2577,7 +2591,7 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
+		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
@@ -2590,8 +2604,8 @@ def Main():
 
 	is_sqlite3 = False
 	try:
-		f = open(dbname)
-		if f.read(15) == "SQLite format 3":
+		f = open(dbname, "rb")
+		if f.read(15) == b'SQLite format 3':
 			is_sqlite3 = True
 		f.close()
 	except:
-- 
2.20.1

