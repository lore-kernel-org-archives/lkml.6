Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED04720842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131800;
	bh=CxTh0CH/9pfumb24Ks2uvLCangD3TMqjHqXNmZy942o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RJXbNTzL5lTyxFY/z/5BMTViBpR2Txj/JlgZdCE+QbCKqf2tKQHu7I0Xh+4Sl7vg/
	 eP7fCpIxiRG/nZj2n8ImsAqTgliSMs8vhK6wbE5F4V+cnsNQ2qd1YYdL+/brWov3sN
	 2dmCZpQchpRPUvIEnwdj8q1hM5dEScrthgxHJYO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfBYV4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730624AbfBYVVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:24 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71202217F4;
        Mon, 25 Feb 2019 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129683;
        bh=CxTh0CH/9pfumb24Ks2uvLCangD3TMqjHqXNmZy942o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxa05N+CV6nbuGcr3+J00B+6DAGCKVis4Mtxanes563ldfg38RADjKGC40LduhUBX
         /UupwYFOlfAMhfdjDDuDoh7vNelo9H8HG26+JohdEX8/lqKJY6mrVpOW+P+IUqra8l
         sNokUcjIwCacO4jS2rAzIaJlamLJhAMVY47PYmJU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/37] perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
Date:   Mon, 25 Feb 2019 18:20:06 -0300
Message-Id: <20190225212035.24781-9-acme@kernel.org>
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

Factor out ReportDialogBase so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 47 ++++++++++++-------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 7bd5263d3f39..d3ffb3e9d1fc 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1693,34 +1693,25 @@ class SQLTableDialogDataItem():
 			return False
 		return True
 
-# Selected branch report creation dialog
+# Report Dialog Base
 
-class SelectedBranchDialog(QDialog):
+class ReportDialogBase(QDialog):
 
-	def __init__(self, glb, parent=None):
-		super(SelectedBranchDialog, self).__init__(parent)
+	def __init__(self, glb, title, items, partial, parent=None):
+		super(ReportDialogBase, self).__init__(parent)
 
 		self.glb = glb
 
 		self.name = ""
 		self.where_clause = ""
 
-		self.setWindowTitle("Selected Branches")
+		self.setWindowTitle(title)
 		self.setMinimumWidth(600)
 
-		items = (
-			("Report name:", "Enter a name to appear in the window title bar", "", "", "", ""),
-			("Time ranges:", "Enter time ranges", "<timeranges>", "", "samples.id", ""),
-			("CPUs:", "Enter CPUs or ranges e.g. 0,5-6", "<ranges>", "", "cpu", ""),
-			("Commands:", "Only branches with these commands will be included", "comms", "comm", "comm_id", ""),
-			("PIDs:", "Only branches with these process IDs will be included", "threads", "pid", "thread_id", ""),
-			("TIDs:", "Only branches with these thread IDs will be included", "threads", "tid", "thread_id", ""),
-			("DSOs:", "Only branches with these DSOs will be included", "dsos", "short_name", "samples.dso_id", "to_dso_id"),
-			("Symbols:", "Only branches with these symbols will be included", "symbols", "name", "symbol_id", "to_symbol_id"),
-			("Raw SQL clause: ", "Enter a raw SQL WHERE clause", "", "", "", ""),
-			)
 		self.data_items = [SQLTableDialogDataItem(glb, *x, parent=self) for x in items]
 
+		self.partial = partial
+
 		self.grid = QGridLayout()
 
 		for row in xrange(len(self.data_items)):
@@ -1764,7 +1755,10 @@ class SelectedBranchDialog(QDialog):
 					self.where_clause += " AND "
 				self.where_clause += d.value
 		if len(self.where_clause):
-			self.where_clause = " AND ( " + self.where_clause + " ) "
+			if self.partial:
+				self.where_clause = " AND ( " + self.where_clause + " ) "
+			else:
+				self.where_clause = " WHERE " + self.where_clause + " "
 		else:
 			self.ShowMessage("No selection")
 			return
@@ -1776,6 +1770,25 @@ class SelectedBranchDialog(QDialog):
 	def ClearMessage(self):
 		self.status.setText("")
 
+# Selected branch report creation dialog
+
+class SelectedBranchDialog(ReportDialogBase):
+
+	def __init__(self, glb, parent=None):
+		title = "Selected Branches"
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
+		super(SelectedBranchDialog, self).__init__(glb, title, items, True, parent)
+
 # Event list
 
 def GetEventList(db):
-- 
2.20.1

