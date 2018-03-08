Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCHTvN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeCHTvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB790205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/54] perf record: Combine some auxtrace initialization into a single function
Date: Thu,  8 Mar 2018 16:49:45 -0300
Message-Id: <20180308195029.14991-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for adding AUX area sampling support, combine some
auxtrace initialization into a single function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 12230ddb6506..14d82f0fe5cc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -274,6 +274,24 @@ static void record__read_auxtrace_snapshot(struct record *rec)
 	}
 }
 
+static int record__auxtrace_init(struct record *rec)
+{
+	int err;
+
+	if (!rec->itr) {
+		rec->itr = auxtrace_record__init(rec->evlist, &err);
+		if (err)
+			return err;
+	}
+
+	err = auxtrace_parse_snapshot_options(rec->itr, &rec->opts,
+					      rec->opts.auxtrace_snapshot_opts);
+	if (err)
+		return err;
+
+	return auxtrace_parse_filters(rec->evlist);
+}
+
 #else
 
 static inline
@@ -294,6 +312,11 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
 	return 0;
 }
 
+static int record__auxtrace_init(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
 #endif
 
 static int record__mmap_evlist(struct record *rec,
@@ -1727,17 +1750,6 @@ int cmd_record(int argc, const char **argv)
 		alarm(rec->switch_output.time);
 	}
 
-	if (!rec->itr) {
-		rec->itr = auxtrace_record__init(rec->evlist, &err);
-		if (err)
-			goto out;
-	}
-
-	err = auxtrace_parse_snapshot_options(rec->itr, &rec->opts,
-					      rec->opts.auxtrace_snapshot_opts);
-	if (err)
-		goto out;
-
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
@@ -1746,7 +1758,7 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
-	err = auxtrace_parse_filters(rec->evlist);
+	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
 
-- 
2.14.3
