Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3D20847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILxeNxWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B3D20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJYToE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeJYToD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:03 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E14D20847;
        Thu, 25 Oct 2018 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465905;
        bh=q9nDjFTZ0ujrQbjVcqicP/1vG9kQ2DzOfqfnBnCAR1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILxeNxWfglA2cjlmhfAPK5IniyhKrdOy5US9dtmFtEMYHA3fRlR6aRx6a4FkXcIW4
         b92E+Hcs0NLXamchWuGs1KYXwUpjWBcaQ3/Cd5WvkBPDjDPQW7XIhzdQSdCnKw06vB
         jLysEv11hpJ1sqov+ry3vwsXhOubZL7cdea+PgXg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/37] perf scripts python: call-graph-from-sql.py: Separate the database details into a class
Date:   Thu, 25 Oct 2018 08:10:15 -0300
Message-Id: <20181025111031.3440-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.14.4

