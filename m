Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeCFJOJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:14:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:28963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753024AbeCFJOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575372"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] perf record: Combine some auxtrace initialization into a single function
Date: Tue,  6 Mar 2018 11:13:12 +0200
Message-Id: <1520327598-1317-2-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding AUX area sampling support, combine some auxtrace
initialization into a single function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 907267206973..9b6338ce9c2b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -273,6 +273,24 @@ static void record__read_auxtrace_snapshot(struct record *rec)
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
@@ -293,6 +311,11 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
 	return 0;
 }
 
+static int record__auxtrace_init(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
 #endif
 
 static int record__mmap_evlist(struct record *rec,
@@ -1711,17 +1734,6 @@ int cmd_record(int argc, const char **argv)
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
@@ -1730,7 +1742,7 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
-	err = auxtrace_parse_filters(rec->evlist);
+	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
 
-- 
1.9.1
