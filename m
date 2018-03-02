Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934862AbeCBXmC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:42:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934821AbeCBXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:41:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80A4E6076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V2 3/3] perf pmu: Auto-merge PMU events created by prefix or glob match
Date: Fri,  2 Mar 2018 18:41:32 -0500
Message-Id: <1520034092-35275-4-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-merge for these events was disabled when auto-merging of non-alias
events was disabled in commit 63ce844 (perf stat: Only auto-merge events
that are PMU aliases).

Non-merging of legacy events is preserved:

    $ ./perf stat -ag -e cache-misses,cache-misses sleep 1

     Performance counter stats for 'system wide':

                86,323      cache-misses
                86,323      cache-misses

           1.002623307 seconds time elapsed

But prefix or glob matching auto-merges the events created:

    $ ./perf stat -a -e l3cache/read-miss/ sleep 1

     Performance counter stats for 'system wide':

                   328      l3cache/read-miss/

           1.002627008 seconds time elapsed

    $ ./perf stat -a -e l3cache_0_[01]/read-miss/ sleep 1

     Performance counter stats for 'system wide':

                   172      l3cache/read-miss/

           1.002627008 seconds time elapsed

As with events created with aliases, auto-merging can be suppressed with
the --no-merge option:

    $ ./perf stat -a -e l3cache/read-miss/ --no-merge sleep 1

     Performance counter stats for 'system wide':

                    67      l3cache/read-miss/
                    67      l3cache/read-miss/
                    63      l3cache/read-miss/
                    60      l3cache/read-miss/

           1.002622192 seconds time elapsed

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 tools/perf/Documentation/perf-stat.txt | 14 +++++++++-----
 tools/perf/util/parse-events.c         | 13 +++----------
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/parse-events.y         |  4 ++--
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 49983a7..ae406f7 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -252,11 +252,15 @@ taskset.
 --no-merge::
 Do not merge results from same PMUs.

-When multiple events are created from a single event alias, stat will,
-by default, aggregate the event counts and show the result in a single
-row. This option disables that behavior and shows the individual events
-and counts. Aliases are listed immediately after the Kernel PMU events
-by perf list.
+When multiple events are created from a single event specification,
+stat will, by default, aggregate the event counts and show the result
+in a single row. This option disables that behavior and shows
+the individual events and counts.
+
+Multiple events are created from a single event specification when:
+1. Prefix or glob matching is used for the PMU name.
+2. Aliases, which are listed immediately after the Kernel PMU events
+   by perf list, are used.

 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index bafc91e..4e80ca3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1217,7 +1217,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			 get_config_name(head_config), &config_terms);
 }

-static int __parse_events_add_pmu(struct parse_events_state *parse_state,
+int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config, bool auto_merge_stats)
 {
@@ -1287,13 +1287,6 @@ static int __parse_events_add_pmu(struct parse_events_state *parse_state,
 	return evsel ? 0 : -ENOMEM;
 }

-int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
-			 struct list_head *head_config)
-{
-	return __parse_events_add_pmu(parse_state, list, name, head_config, false);
-}
-
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head **listp)
 {
@@ -1323,8 +1316,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 					return -1;
 				list_add_tail(&term->list, head);

-				if (!__parse_events_add_pmu(parse_state, list,
-							    pmu->name, head, true)) {
+				if (!parse_events_add_pmu(parse_state, list,
+							  pmu->name, head, true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 88108cd..5015cfd 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -167,7 +167,7 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				void *ptr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
-			 struct list_head *head_config);
+			 struct list_head *head_config, bool auto_merge_stats);

 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c528469..b51278f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -232,7 +232,7 @@ PE_NAME opt_event_config
 		YYABORT;

 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;

@@ -245,7 +245,7 @@ PE_NAME opt_event_config
 			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
+				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
