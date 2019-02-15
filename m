Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7702070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393532AbfBOJuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:50:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390930AbfBOJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:50:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9oRKZ1121645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:50:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9oQ8l1121642;
        Fri, 15 Feb 2019 01:50:26 -0800
Date:   Fri, 15 Feb 2019 01:50:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-33bbc571ed79cace481fae4031b80a51d93ae997@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org
Reply-To: mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
          namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <20190213123246.4015-6-jolsa@kernel.org>
References: <20190213123246.4015-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Display metric expressions for --details
 option
Git-Commit-ID: 33bbc571ed79cace481fae4031b80a51d93ae997
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

Commit-ID:  33bbc571ed79cace481fae4031b80a51d93ae997
Gitweb:     https://git.kernel.org/tip/33bbc571ed79cace481fae4031b80a51d93ae997
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:41 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:09 -0300

perf list: Display metric expressions for --details option

Display metric expression itself when --details is specified.

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
