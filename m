Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32210ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED43C2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2qPa5KsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED43C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeJYToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeJYToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:06 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020D120854;
        Thu, 25 Oct 2018 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465908;
        bh=tPS/FREJqqSvd03owgxHOtUHd0EdWVO/vP/BX8qh4zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qPa5KsQCOsI3QuMC9DoVcvPi6BeIwOVWYhNmUOxqzDo5tZjDg2Jb43fUZzmAMyex
         sPCLMvseEIPsg5zWmIyxP+VVF+8Ml9zgteMEL+logb9NRHI8PKy5YJkJHPPBCJKxNZ
         vRWqxgkjsd7R29aAhQ17Kli6ep9Eltg/gUmZZw2w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/37] perf scripts python: call-graph-from-sql.py: Add a class for global data
Date:   Thu, 25 Oct 2018 08:10:16 -0300
Message-Id: <20181025111031.3440-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Keep global data in a single object that is easy to pass around as
needed, without polluting the global namespace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 26 +++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 9d056deab2b1..0a4dc13d4818 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -264,17 +264,19 @@ class TreeModel(QAbstractItemModel):
 
 class MainWindow(QMainWindow):
 
-	def __init__(self, db, dbname, parent=None):
+	def __init__(self, glb, parent=None):
 		super(MainWindow, self).__init__(parent)
 
+		self.glb = glb
+
 		self.setObjectName("MainWindow")
-		self.setWindowTitle("Call Graph: " + dbname)
+		self.setWindowTitle("Call Graph: " + glb.dbname)
 		self.move(100, 100)
 		self.resize(800, 600)
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = TreeModel(db)
+		self.model = TreeModel(glb.db)
 
 		self.view = QTreeView()
 		self.view.setModel(self.model)
@@ -284,6 +286,17 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
+# Global data
+
+class Glb():
+
+	def __init__(self, dbref, db, dbname):
+		self.dbref = dbref
+		self.db = db
+		self.dbname = dbname
+		self.app = None
+		self.mainwindow = None
+
 # Database reference
 
 class DBRef():
@@ -340,9 +353,12 @@ def Main():
 
 	dbref = DBRef(is_sqlite3, dbname)
 	db, dbname = dbref.Open("main")
+	glb = Glb(dbref, db, dbname)
 	app = QApplication(sys.argv)
-	window = MainWindow(db, dbname)
-	window.show()
+	glb.app = app
+	mainwindow = MainWindow(glb)
+	glb.mainwindow = mainwindow
+	mainwindow.show()
 	err = app.exec_()
 	db.close()
 	sys.exit(err)
-- 
2.14.4

