Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08474C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA513222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061181;
	bh=n0ktzzO56LZoJNbRiaBvSuyi71FScblpRCfbN0ehm6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRHZ2yjZEmNrW9tBJD/A6nuP8YLM69Nzfjz3Qkhq9DLj9skjr478W9QZWMID5bhNS
	 Xt2qdorcBxKexqMiqqR+2SOZCJQ3dqCj11R2gLT0+qovq+VoxdD02o4CftnADUxSh+
	 ndLNY5h1eJIJF0Jr/BrwilAi2yha8nFMWScUXnIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfBMMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404179AbfBMMc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB722C057F99;
        Wed, 13 Feb 2019 12:32:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8BA60856;
        Wed, 13 Feb 2019 12:32:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 05/10] perf list: Display metric expressions for --details option
Date:   Wed, 13 Feb 2019 13:32:41 +0100
Message-Id: <20190213123246.4015-6-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 13 Feb 2019 12:32:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying metric expression itself when --details
is specified.

Current list with no details:

  # perf list metrics
  ...
  TopDownL1:
    IPC
         [Instructions Per Cycle (per logical thread)]
    SLOTS
         [Total issue-pipeline slots]
  ...

Detailed output with metric formula:

  # perf list --details metrics
  ...
  TopDownL1:
    IPC
         [Instructions Per Cycle (per logical thread)]
         [inst_retired.any / cpu_clk_unhalted.thread]
    SLOTS
         [Total issue-pipeline slots]
         [4*(( cpu_clk_unhalted.thread_any / 2 ) if #smt_on else cycles)]
  ...

Link: http://lkml.kernel.org/n/tip-12vdvybkrbrhjzerkgidis5k@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-list.c      | 8 ++++----
 tools/perf/util/metricgroup.c  | 8 +++++++-
 tools/perf/util/metricgroup.h  | 3 ++-
 tools/perf/util/parse-events.c | 2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index ead221e49f00..c9f98d00c0e9 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -82,9 +82,9 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if (strcmp(argv[i], "metric") == 0)
-			metricgroup__print(true, false, NULL, raw_dump);
+			metricgroup__print(true, false, NULL, raw_dump, details_flag);
 		else if (strcmp(argv[i], "metricgroup") == 0)
-			metricgroup__print(false, true, NULL, raw_dump);
+			metricgroup__print(false, true, NULL, raw_dump, details_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
@@ -102,7 +102,7 @@ int cmd_list(int argc, const char **argv)
 			s[sep_idx] = '\0';
 			print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
 			print_sdt_events(s, s + sep_idx + 1, raw_dump);
-			metricgroup__print(true, true, s, raw_dump);
+			metricgroup__print(true, true, s, raw_dump, details_flag);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
@@ -119,7 +119,7 @@ int cmd_list(int argc, const char **argv)
 						details_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, NULL, raw_dump);
+			metricgroup__print(true, true, NULL, raw_dump, details_flag);
 			free(s);
 		}
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8529cbd3955b..b8d864ed4afe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -270,7 +270,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 }
 
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
-			bool raw)
+			bool raw, bool details)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
@@ -329,6 +329,12 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 					if (asprintf(&s, "%s\n%*s%s]",
 						     pe->metric_name, 8, "[", pe->desc) < 0)
 						return;
+
+					if (details) {
+						if (asprintf(&s, "%s\n%*s%s]",
+							     s, 8, "[", pe->metric_expr) < 0)
+							return;
+					}
 				}
 
 				if (!s)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8a155dba0581..5c52097a5c63 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -27,6 +27,7 @@ int metricgroup__parse_groups(const struct option *opt,
 			const char *str,
 			struct rblist *metric_events);
 
-void metricgroup__print(bool metrics, bool groups, char *filter, bool raw);
+void metricgroup__print(bool metrics, bool groups, char *filter,
+			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
 #endif
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 920e1e6551dd..4dcc01b2532c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2540,7 +2540,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_sdt_events(NULL, NULL, name_only);
 
-	metricgroup__print(true, true, NULL, name_only);
+	metricgroup__print(true, true, NULL, name_only, details_flag);
 }
 
 int parse_events__is_hardcoded_term(struct parse_events_term *term)
-- 
2.17.2

