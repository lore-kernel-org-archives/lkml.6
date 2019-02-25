Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63921841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129691;
	bh=+p+dhbeqoXwqAsOV8YsE4yG7HqHErMK0bD27dkWZhNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/TOB6EJsizR2DdFHuaFk6LuutYA9P7aSzVFYQTkUcRR29hhZR1mZffekO/+9cllM
	 qs0KsQYBjju5LtsgMIVUIBnQPnh0ef4QAS2K7EQKzSi/5oHJIB0Gw5co1nLZFC71Oc
	 C8vZV63YtJQo/PyShd+hF2gz/Jgr6OMN3y20I+AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfBYVVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfBYVV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:27 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC1D21848;
        Mon, 25 Feb 2019 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129686;
        bh=+p+dhbeqoXwqAsOV8YsE4yG7HqHErMK0bD27dkWZhNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3WYMOd2W1dwRjejDU6S+pqEmmUcHByJlfWnjYwN9s8Ar9bQmfPLDqz3y9ndiNv8l
         1KGN9uNrd+bHPOGb+kR9B4DozzkJYAbgp9G6uJOarQ1DtQUePyJldefTCBI8bEvmr+
         4fg5Z765iJlcTPNux3X6LY/goWNYMs1K/B9m5S8k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/37] perf scripts python: exported-sql-viewer.py: Factor out ReportVars
Date:   Mon, 25 Feb 2019 18:20:07 -0300
Message-Id: <20190225212035.24781-10-acme@kernel.org>
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

Factor out ReportVars to provide a single container for information from
report dialogs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index d3ffb3e9d1fc..03428df8ddd5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1398,18 +1398,26 @@ class BranchModel(TreeModel):
 	def HasMoreRecords(self):
 		return self.more
 
+# Report Variables
+
+class ReportVars():
+
+	def __init__(self, where_clause = ""):
+		self.where_clause = where_clause
+
+	def UniqueId(self):
+		return str(self.where_clause)
+
 # Branch window
 
 class BranchWindow(QMdiSubWindow):
 
-	def __init__(self, glb, event_id, name, where_clause, parent=None):
+	def __init__(self, glb, event_id, name, report_vars, parent=None):
 		super(BranchWindow, self).__init__(parent)
 
-		model_name = "Branch Events " + str(event_id)
-		if len(where_clause):
-			model_name = where_clause + " " + model_name
+		model_name = "Branch Events " + str(event_id) +  " " + report_vars.UniqueId()
 
-		self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, where_clause))
+		self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, report_vars.where_clause))
 
 		self.view = QTreeView()
 		self.view.setUniformRowHeights(True)
@@ -1703,7 +1711,7 @@ class ReportDialogBase(QDialog):
 		self.glb = glb
 
 		self.name = ""
-		self.where_clause = ""
+		self.report_vars = ReportVars()
 
 		self.setWindowTitle(title)
 		self.setMinimumWidth(600)
@@ -1742,6 +1750,7 @@ class ReportDialogBase(QDialog):
 		self.setLayout(self.vbox);
 
 	def Ok(self):
+		vars = self.report_vars
 		self.name = self.data_items[0].value
 		if not self.name:
 			self.ShowMessage("Report name is required")
@@ -1751,14 +1760,14 @@ class ReportDialogBase(QDialog):
 				return
 		for d in self.data_items[1:]:
 			if len(d.value):
-				if len(self.where_clause):
-					self.where_clause += " AND "
-				self.where_clause += d.value
-		if len(self.where_clause):
+				if len(vars.where_clause):
+					vars.where_clause += " AND "
+				vars.where_clause += d.value
+		if len(vars.where_clause):
 			if self.partial:
-				self.where_clause = " AND ( " + self.where_clause + " ) "
+				vars.where_clause = " AND ( " + vars.where_clause + " ) "
 			else:
-				self.where_clause = " WHERE " + self.where_clause + " "
+				vars.where_clause = " WHERE " + vars.where_clause + " "
 		else:
 			self.ShowMessage("No selection")
 			return
@@ -2383,13 +2392,13 @@ class MainWindow(QMainWindow):
 		CallGraphWindow(self.glb, self)
 
 	def NewBranchView(self, event_id):
-		BranchWindow(self.glb, event_id, "", "", self)
+		BranchWindow(self.glb, event_id, "", ReportVars(), self)
 
 	def NewSelectedBranchView(self, event_id):
 		dialog = SelectedBranchDialog(self.glb, self)
 		ret = dialog.exec_()
 		if ret:
-			BranchWindow(self.glb, event_id, dialog.name, dialog.where_clause, self)
+			BranchWindow(self.glb, event_id, dialog.name, dialog.report_vars, self)
 
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
-- 
2.20.1

