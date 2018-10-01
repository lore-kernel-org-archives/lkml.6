Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25DEC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1697208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1697208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeJANLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:10732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbeJANLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466493"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:30:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] perf scripts python: call-graph-from-sql.py: Separate the database details into a class
Date:   Mon,  1 Oct 2018 09:28:40 +0300
Message-Id: <20181001062853.28285-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the database details into a class that can provide different
connections using the same connection information.  That paves the way for
sub-processes that require their own connection.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/call-graph-from-sql.py     | 63 +++++++++++--------
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
-- 
2.17.1

