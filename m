Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33032C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287121841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129687;
	bh=BjipRNf6wHhLWtVwvGPFUrPXU6dPEtP3Tw17yPh5/II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vgISVJC2bU0XBD4/iFti3P3ouktgrrJjWvYLgYesAzyNqWs1DzMYImgeX8ZHoC4W0
	 TYTxaSSqH9CypJWr1Ynbr8Ps44UefmPUEy1LQbfB/LALzgMnnNub/KqfqpchOa0cMf
	 n51vbOkSknTrShLUIkvnPpQK6W+wY8ey1qBVSHlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfBYVVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfBYVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:20 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9844821841;
        Mon, 25 Feb 2019 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129679;
        bh=BjipRNf6wHhLWtVwvGPFUrPXU6dPEtP3Tw17yPh5/II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s29KTZYutWXN7Kh8rX1/nhad9OXk++npxQC8EjepudMW5+WBy5mCJpiyLAW8wGx1u
         minhaGGxBbdfrHASdn0Bq8QA+ir6nCvXwkQIh0cnf1O77EIUBKs9p3m3mLYSi2FYwD
         lxqaDuZbcvaQAVNT9R32sLj8+yXq6vGXs6eX8oXU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/37] perf scripts python: exported-sql-viewer.py: Move column headers
Date:   Mon, 25 Feb 2019 18:20:05 -0300
Message-Id: <20190225212035.24781-8-acme@kernel.org>
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

Move column headers from SQLAutoTableModel into SQLTableModel so that
they can be used for other models based on SQLTableModel.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 58a95241ff70..7bd5263d3f39 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1821,12 +1821,13 @@ class SQLTableModel(TableModel):
 
 	progress = Signal(object)
 
-	def __init__(self, glb, sql, column_count, parent=None):
+	def __init__(self, glb, sql, column_headers, parent=None):
 		super(SQLTableModel, self).__init__(parent)
 		self.glb = glb
 		self.more = True
 		self.populated = 0
-		self.fetcher = SQLFetcher(glb, sql, lambda x, y=column_count: SQLTableDataPrep(x, y), self.AddSample)
+		self.column_headers = column_headers
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): SQLTableDataPrep(x, y), self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -1864,6 +1865,12 @@ class SQLTableModel(TableModel):
 	def HasMoreRecords(self):
 		return self.more
 
+	def columnCount(self, parent=None):
+		return len(self.column_headers)
+
+	def columnHeader(self, column):
+		return self.column_headers[column]
+
 # SQL automatic table data model
 
 class SQLAutoTableModel(SQLTableModel):
@@ -1873,12 +1880,12 @@ class SQLAutoTableModel(SQLTableModel):
 		if table_name == "comm_threads_view":
 			# For now, comm_threads_view has no id column
 			sql = "SELECT * FROM " + table_name + " WHERE comm_id > $$last_id$$ ORDER BY comm_id LIMIT " + str(glb_chunk_sz)
-		self.column_headers = []
+		column_headers = []
 		query = QSqlQuery(glb.db)
 		if glb.dbref.is_sqlite3:
 			QueryExec(query, "PRAGMA table_info(" + table_name + ")")
 			while query.next():
-				self.column_headers.append(query.value(1))
+				column_headers.append(query.value(1))
 			if table_name == "sqlite_master":
 				sql = "SELECT * FROM " + table_name
 		else:
@@ -1891,14 +1898,8 @@ class SQLAutoTableModel(SQLTableModel):
 				schema = "public"
 			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
 			while query.next():
-				self.column_headers.append(query.value(0))
-		super(SQLAutoTableModel, self).__init__(glb, sql, len(self.column_headers), parent)
-
-	def columnCount(self, parent=None):
-		return len(self.column_headers)
-
-	def columnHeader(self, column):
-		return self.column_headers[column]
+				column_headers.append(query.value(0))
+		super(SQLAutoTableModel, self).__init__(glb, sql, column_headers, parent)
 
 # Base class for custom ResizeColumnsToContents
 
-- 
2.20.1

