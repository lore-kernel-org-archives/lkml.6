Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2FBC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D016D20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D016D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJZQP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:15:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:15:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7dP00138315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:39:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7dPrd138312;
        Fri, 26 Oct 2018 00:39:25 -0700
Date:   Fri, 26 Oct 2018 00:39:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5f9dfef1bb7fadfb2d001244ef23359982fedd06@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com
Reply-To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
          ak@linux.intel.com, adrian.hunter@intel.com
In-Reply-To: <20181001062853.28285-8-adrian.hunter@intel.com>
References: <20181001062853.28285-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py: Add
 a class for global data
Git-Commit-ID: 5f9dfef1bb7fadfb2d001244ef23359982fedd06
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5f9dfef1bb7fadfb2d001244ef23359982fedd06
Gitweb:     https://git.kernel.org/tip/5f9dfef1bb7fadfb2d001244ef23359982fedd06
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:41 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:23:31 -0300

perf scripts python: call-graph-from-sql.py: Add a class for global data

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
