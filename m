Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76918C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu5jnwmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbeKFVcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:03 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E7B20869;
        Tue,  6 Nov 2018 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506028;
        bh=RqAZvwk9dEwLwOqn1co+SEb5XI6KNZPYtRARnLcRt5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tu5jnwmTTo8njeFid/Lg3ZVY7Vs+yw8cUnumHmPKPv4U/Wdu+hUENlvrMkmR1Clgu
         7m+X7ADnNLPsoAquhHxpzTfHRSSuwah3gZ8xWdHdBXD1r6bSY+4c9YhJlyIDrfNrzb
         viy6Zm/f9priMPTqP6TmTcaTBGGsOhu7LotWXicw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/18] perf scripts python: exported-sql-viewer.py: Add Selected branches report
Date:   Tue,  6 Nov 2018 09:06:05 -0300
Message-Id: <20181106120612.8262-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fetching data from the database can be slow. Add a report that provides
the ability to select a subset of branches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 327 +++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 20cc8e7879b9..a9d2b3170141 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -119,6 +119,14 @@ def dsoname(name):
 		return "[kernel]"
 	return name
 
+def findnth(s, sub, n, offs=0):
+	pos = s.find(sub)
+	if pos < 0:
+		return pos
+	if n <= 1:
+		return offs + pos
+	return findnth(s[pos + 1:], sub, n - 1, offs + pos + 1)
+
 # Percent to one decimal place
 
 def PercentToOneDP(n, d):
@@ -1464,6 +1472,317 @@ class BranchWindow(QMdiSubWindow):
 		else:
 			self.find_bar.NotFound()
 
+# Dialog data item converted and validated using a SQL table
+
+class SQLTableDialogDataItem():
+
+	def __init__(self, glb, label, placeholder_text, table_name, match_column, column_name1, column_name2, parent):
+		self.glb = glb
+		self.label = label
+		self.placeholder_text = placeholder_text
+		self.table_name = table_name
+		self.match_column = match_column
+		self.column_name1 = column_name1
+		self.column_name2 = column_name2
+		self.parent = parent
+
+		self.value = ""
+
+		self.widget = QLineEdit()
+		self.widget.editingFinished.connect(self.Validate)
+		self.widget.textChanged.connect(self.Invalidate)
+		self.red = False
+		self.error = ""
+		self.validated = True
+
+		self.last_id = 0
+		self.first_time = 0
+		self.last_time = 2 ** 64
+		if self.table_name == "<timeranges>":
+			query = QSqlQuery(self.glb.db)
+			QueryExec(query, "SELECT id, time FROM samples ORDER BY id DESC LIMIT 1")
+			if query.next():
+				self.last_id = int(query.value(0))
+				self.last_time = int(query.value(1))
+			QueryExec(query, "SELECT time FROM samples WHERE time != 0 ORDER BY id LIMIT 1")
+			if query.next():
+				self.first_time = int(query.value(0))
+			if placeholder_text:
+				placeholder_text += ", between " + str(self.first_time) + " and " + str(self.last_time)
+
+		if placeholder_text:
+			self.widget.setPlaceholderText(placeholder_text)
+
+	def ValueToIds(self, value):
+		ids = []
+		query = QSqlQuery(self.glb.db)
+		stmt = "SELECT id FROM " + self.table_name + " WHERE " + self.match_column + " = '" + value + "'"
+		ret = query.exec_(stmt)
+		if ret:
+			while query.next():
+				ids.append(str(query.value(0)))
+		return ids
+
+	def IdBetween(self, query, lower_id, higher_id, order):
+		QueryExec(query, "SELECT id FROM samples WHERE id > " + str(lower_id) + " AND id < " + str(higher_id) + " ORDER BY id " + order + " LIMIT 1")
+		if query.next():
+			return True, int(query.value(0))
+		else:
+			return False, 0
+
+	def BinarySearchTime(self, lower_id, higher_id, target_time, get_floor):
+		query = QSqlQuery(self.glb.db)
+		while True:
+			next_id = int((lower_id + higher_id) / 2)
+			QueryExec(query, "SELECT time FROM samples WHERE id = " + str(next_id))
+			if not query.next():
+				ok, dbid = self.IdBetween(query, lower_id, next_id, "DESC")
+				if not ok:
+					ok, dbid = self.IdBetween(query, next_id, higher_id, "")
+					if not ok:
+						return str(higher_id)
+				next_id = dbid
+				QueryExec(query, "SELECT time FROM samples WHERE id = " + str(next_id))
+			next_time = int(query.value(0))
+			if get_floor:
+				if target_time > next_time:
+					lower_id = next_id
+				else:
+					higher_id = next_id
+				if higher_id <= lower_id + 1:
+					return str(higher_id)
+			else:
+				if target_time >= next_time:
+					lower_id = next_id
+				else:
+					higher_id = next_id
+				if higher_id <= lower_id + 1:
+					return str(lower_id)
+
+	def ConvertRelativeTime(self, val):
+		print "val ", val
+		mult = 1
+		suffix = val[-2:]
+		if suffix == "ms":
+			mult = 1000000
+		elif suffix == "us":
+			mult = 1000
+		elif suffix == "ns":
+			mult = 1
+		else:
+			return val
+		val = val[:-2].strip()
+		if not self.IsNumber(val):
+			return val
+		val = int(val) * mult
+		if val >= 0:
+			val += self.first_time
+		else:
+			val += self.last_time
+		return str(val)
+
+	def ConvertTimeRange(self, vrange):
+		print "vrange ", vrange
+		if vrange[0] == "":
+			vrange[0] = str(self.first_time)
+		if vrange[1] == "":
+			vrange[1] = str(self.last_time)
+		vrange[0] = self.ConvertRelativeTime(vrange[0])
+		vrange[1] = self.ConvertRelativeTime(vrange[1])
+		print "vrange2 ", vrange
+		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
+			return False
+		print "ok1"
+		beg_range = max(int(vrange[0]), self.first_time)
+		end_range = min(int(vrange[1]), self.last_time)
+		if beg_range > self.last_time or end_range < self.first_time:
+			return False
+		print "ok2"
+		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
+		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
+		print "vrange3 ", vrange
+		return True
+
+	def AddTimeRange(self, value, ranges):
+		print "value ", value
+		n = value.count("-")
+		if n == 1:
+			pass
+		elif n == 2:
+			if value.split("-")[1].strip() == "":
+				n = 1
+		elif n == 3:
+			n = 2
+		else:
+			return False
+		pos = findnth(value, "-", n)
+		vrange = [value[:pos].strip() ,value[pos+1:].strip()]
+		if self.ConvertTimeRange(vrange):
+			ranges.append(vrange)
+			return True
+		return False
+
+	def InvalidValue(self, value):
+		self.value = ""
+		palette = QPalette()
+		palette.setColor(QPalette.Text,Qt.red)
+		self.widget.setPalette(palette)
+		self.red = True
+		self.error = self.label + " invalid value '" + value + "'"
+		self.parent.ShowMessage(self.error)
+
+	def IsNumber(self, value):
+		try:
+			x = int(value)
+		except:
+			x = 0
+		return str(x) == value
+
+	def Invalidate(self):
+		self.validated = False
+
+	def Validate(self):
+		input_string = self.widget.text()
+		self.validated = True
+		if self.red:
+			palette = QPalette()
+			self.widget.setPalette(palette)
+			self.red = False
+		if not len(input_string.strip()):
+			self.error = ""
+			self.value = ""
+			return
+		if self.table_name == "<timeranges>":
+			ranges = []
+			for value in [x.strip() for x in input_string.split(",")]:
+				if not self.AddTimeRange(value, ranges):
+					return self.InvalidValue(value)
+			ranges = [("(" + self.column_name1 + " >= " + r[0] + " AND " + self.column_name1 + " <= " + r[1] + ")") for r in ranges]
+			self.value = " OR ".join(ranges)
+		elif self.table_name == "<ranges>":
+			singles = []
+			ranges = []
+			for value in [x.strip() for x in input_string.split(",")]:
+				if "-" in value:
+					vrange = value.split("-")
+					if len(vrange) != 2 or not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
+						return self.InvalidValue(value)
+					ranges.append(vrange)
+				else:
+					if not self.IsNumber(value):
+						return self.InvalidValue(value)
+					singles.append(value)
+			ranges = [("(" + self.column_name1 + " >= " + r[0] + " AND " + self.column_name1 + " <= " + r[1] + ")") for r in ranges]
+			if len(singles):
+				ranges.append(self.column_name1 + " IN (" + ",".join(singles) + ")")
+			self.value = " OR ".join(ranges)
+		elif self.table_name:
+			all_ids = []
+			for value in [x.strip() for x in input_string.split(",")]:
+				ids = self.ValueToIds(value)
+				if len(ids):
+					all_ids.extend(ids)
+				else:
+					return self.InvalidValue(value)
+			self.value = self.column_name1 + " IN (" + ",".join(all_ids) + ")"
+			if self.column_name2:
+				self.value = "( " + self.value + " OR " + self.column_name2 + " IN (" + ",".join(all_ids) + ") )"
+		else:
+			self.value = input_string.strip()
+		self.error = ""
+		self.parent.ClearMessage()
+
+	def IsValid(self):
+		if not self.validated:
+			self.Validate()
+		if len(self.error):
+			self.parent.ShowMessage(self.error)
+			return False
+		return True
+
+# Selected branch report creation dialog
+
+class SelectedBranchDialog(QDialog):
+
+	def __init__(self, glb, parent=None):
+		super(SelectedBranchDialog, self).__init__(parent)
+
+		self.glb = glb
+
+		self.name = ""
+		self.where_clause = ""
+
+		self.setWindowTitle("Selected Branches")
+		self.setMinimumWidth(600)
+
+		items = (
+			("Report name:", "Enter a name to appear in the window title bar", "", "", "", ""),
+			("Time ranges:", "Enter time ranges", "<timeranges>", "", "samples.id", ""),
+			("CPUs:", "Enter CPUs or ranges e.g. 0,5-6", "<ranges>", "", "cpu", ""),
+			("Commands:", "Only branches with these commands will be included", "comms", "comm", "comm_id", ""),
+			("PIDs:", "Only branches with these process IDs will be included", "threads", "pid", "thread_id", ""),
+			("TIDs:", "Only branches with these thread IDs will be included", "threads", "tid", "thread_id", ""),
+			("DSOs:", "Only branches with these DSOs will be included", "dsos", "short_name", "samples.dso_id", "to_dso_id"),
+			("Symbols:", "Only branches with these symbols will be included", "symbols", "name", "symbol_id", "to_symbol_id"),
+			("Raw SQL clause: ", "Enter a raw SQL WHERE clause", "", "", "", ""),
+			)
+		self.data_items = [SQLTableDialogDataItem(glb, *x, parent=self) for x in items]
+
+		self.grid = QGridLayout()
+
+		for row in xrange(len(self.data_items)):
+			self.grid.addWidget(QLabel(self.data_items[row].label), row, 0)
+			self.grid.addWidget(self.data_items[row].widget, row, 1)
+
+		self.status = QLabel()
+
+		self.ok_button = QPushButton("Ok", self)
+		self.ok_button.setDefault(True)
+		self.ok_button.released.connect(self.Ok)
+		self.ok_button.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.cancel_button = QPushButton("Cancel", self)
+		self.cancel_button.released.connect(self.reject)
+		self.cancel_button.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
+
+		self.hbox = QHBoxLayout()
+		#self.hbox.addStretch()
+		self.hbox.addWidget(self.status)
+		self.hbox.addWidget(self.ok_button)
+		self.hbox.addWidget(self.cancel_button)
+
+		self.vbox = QVBoxLayout()
+		self.vbox.addLayout(self.grid)
+		self.vbox.addLayout(self.hbox)
+
+		self.setLayout(self.vbox);
+
+	def Ok(self):
+		self.name = self.data_items[0].value
+		if not self.name:
+			self.ShowMessage("Report name is required")
+			return
+		for d in self.data_items:
+			if not d.IsValid():
+				return
+		for d in self.data_items[1:]:
+			if len(d.value):
+				if len(self.where_clause):
+					self.where_clause += " AND "
+				self.where_clause += d.value
+		if len(self.where_clause):
+			self.where_clause = " AND ( " + self.where_clause + " ) "
+		else:
+			self.ShowMessage("No selection")
+			return
+		self.accept()
+
+	def ShowMessage(self, msg):
+		self.status.setText("<font color=#FF0000>" + msg)
+
+	def ClearMessage(self):
+		self.status.setText("")
+
 # Event list
 
 def GetEventList(db):
@@ -1888,6 +2207,8 @@ class MainWindow(QMainWindow):
 			if event == "branches":
 				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
 				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewSelectedBranchView(x), self))
 
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
@@ -1900,6 +2221,12 @@ class MainWindow(QMainWindow):
 	def NewBranchView(self, event_id):
 		BranchWindow(self.glb, event_id, "", "", self)
 
+	def NewSelectedBranchView(self, event_id):
+		dialog = SelectedBranchDialog(self.glb, self)
+		ret = dialog.exec_()
+		if ret:
+			BranchWindow(self.glb, event_id, dialog.name, dialog.where_clause, self)
+
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
 
-- 
2.14.4

