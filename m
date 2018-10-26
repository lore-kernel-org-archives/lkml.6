Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C020834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJZQO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:14:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:14:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7cr7c138042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:38:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7crt3138039;
        Fri, 26 Oct 2018 00:38:53 -0700
Date:   Fri, 26 Oct 2018 00:38:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b2556c46a69b4c0e6bbf690ac4ca2913cbe90e1e@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        jolsa@redhat.com, ak@linux.intel.com
Reply-To: tglx@linutronix.de, ak@linux.intel.com, hpa@zytor.com,
          jolsa@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20181001062853.28285-7-adrian.hunter@intel.com>
References: <20181001062853.28285-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py:
 Separate the database details into a class
Git-Commit-ID: b2556c46a69b4c0e6bbf690ac4ca2913cbe90e1e
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

Commit-ID:  b2556c46a69b4c0e6bbf690ac4ca2913cbe90e1e
Gitweb:     https://git.kernel.org/tip/b2556c46a69b4c0e6bbf690ac4ca2913cbe90e1e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:40 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:23:13 -0300

perf scripts python: call-graph-from-sql.py: Separate the database details into a class

Separate the database details into a class that can provide different
connections using the same connection information.  That paves the way
for sub-processes that require their own connection.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 63 ++++++++++++++----------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 2b74b94eeccc..9d056deab2b1 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -284,6 +284,42 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
+# Database reference
+
+class DBRef():
+
+	def __init__(self, is_sqlite3, dbname):
+		self.is_sqlite3 = is_sqlite3
+		self.dbname = dbname
+
+	def Open(self, connection_name):
+		dbname = self.dbname
+		if self.is_sqlite3:
+			db = QSqlDatabase.addDatabase("QSQLITE", connection_name)
+		else:
+			db = QSqlDatabase.addDatabase("QPSQL", connection_name)
+			opts = dbname.split()
+			for opt in opts:
+				if "=" in opt:
+					opt = opt.split("=")
+					if opt[0] == "hostname":
+						db.setHostName(opt[1])
+					elif opt[0] == "port":
+						db.setPort(int(opt[1]))
+					elif opt[0] == "username":
+						db.setUserName(opt[1])
+					elif opt[0] == "password":
+						db.setPassword(opt[1])
+					elif opt[0] == "dbname":
+						dbname = opt[1]
+				else:
+					dbname = opt
+
+		db.setDatabaseName(dbname)
+		if not db.open():
+			raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
+		return db, dbname
+
 # Main
 
 def Main():
@@ -302,31 +338,8 @@ def Main():
 	except:
 		pass
 
-	if is_sqlite3:
-		db = QSqlDatabase.addDatabase('QSQLITE')
-	else:
-		db = QSqlDatabase.addDatabase('QPSQL')
-		opts = dbname.split()
-		for opt in opts:
-			if '=' in opt:
-				opt = opt.split('=')
-				if opt[0] == 'hostname':
-					db.setHostName(opt[1])
-				elif opt[0] == 'port':
-					db.setPort(int(opt[1]))
-				elif opt[0] == 'username':
-					db.setUserName(opt[1])
-				elif opt[0] == 'password':
-					db.setPassword(opt[1])
-				elif opt[0] == 'dbname':
-					dbname = opt[1]
-			else:
-				dbname = opt
-
-	db.setDatabaseName(dbname)
-	if not db.open():
-		raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
-
+	dbref = DBRef(is_sqlite3, dbname)
+	db, dbname = dbref.Open("main")
 	app = QApplication(sys.argv)
 	window = MainWindow(db, dbname)
 	window.show()
