Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667AE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667AE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeJANM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:12:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:10732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbeJANLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466495"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] perf scripts python: call-graph-from-sql.py: Add a class for global data
Date:   Mon,  1 Oct 2018 09:28:41 +0300
Message-Id: <20181001062853.28285-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep global data in a single object that is easy to pass around as needed,
without polluting the global namespace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/call-graph-from-sql.py     | 26 +++++++++++++++----
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
2.17.1

