Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160D21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129681;
	bh=ZWYSu2JuWqvPiGCKfiG+/cxt6B+Yj1nU3PbW5oilles=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vy6yZGVDi9Uxex0xNC3yxYSw97Zyrp0xhim42yXNwPYKKYD9TJEM9W0rD1cwu1UYw
	 3lXQLvrW0ALky7aG1eWhCYVXCsP1j+YcU2FUsCIFX5HQgNjmvFwYZ7W+M5Gsc2S33m
	 ErLZxK+xav1u1WNhbFWIv65EXUsO+qImtJpkurA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfBYVVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfBYVVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:16 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A81D21848;
        Mon, 25 Feb 2019 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129676;
        bh=ZWYSu2JuWqvPiGCKfiG+/cxt6B+Yj1nU3PbW5oilles=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7fddjOaZ7l3MqXPL1+G5SCMx3VzccFg3OCQesTq4Uv+DB50Z8N47cgjSrR2SQNn6
         G1imTa1NS16BjcE7RWSt+T5OntypFx077txy7wSO6MD69jfMWGZcbqRLg92cGn9TD4
         UU1FBFu7mGAB+aLL0LIwQwhxkSD7xOoYGekq+2XM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/37] perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
Date:   Mon, 25 Feb 2019 18:20:04 -0300
Message-Id: <20190225212035.24781-7-acme@kernel.org>
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

The Call Graph depends on the calls table which is optional when exporting
data, so hide the Call Graph option if there is no calls table.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c20b510ace8f..58a95241ff70 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1786,6 +1786,16 @@ def GetEventList(db):
 		events.append(query.value(0))
 	return events
 
+# Is a table selectable
+
+def IsSelectable(db, table):
+	query = QSqlQuery(db)
+	try:
+		QueryExec(query, "SELECT * FROM " + table + " LIMIT 1")
+	except:
+		return False
+	return True
+
 # SQL data preparation
 
 def SQLTableDataPrep(query, count):
@@ -2298,7 +2308,8 @@ class MainWindow(QMainWindow):
 		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
-		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
+		if IsSelectable(glb.db, "calls"):
+			reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
 		self.EventMenu(GetEventList(glb.db), reports_menu)
 
-- 
2.20.1

