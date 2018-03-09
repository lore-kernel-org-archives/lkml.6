Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeCIIni (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:43:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeCIIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:43:36 -0500
Date: Fri, 9 Mar 2018 00:43:14 -0800
From: tip-bot for Agustin Vega-Frias <tipbot@zytor.com>
Message-ID: <tip-c199c11dce197b12ff884ac0cfcb527b1164788b@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, agustinv@codeaurora.org, ak@linux.intel.com,
        timur@codeaurora.org
Reply-To: timur@codeaurora.org, ak@linux.intel.com, agustinv@codeaurora.org,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1520345084-42646-4-git-send-email-agustinv@codeaurora.org>
References: <1520345084-42646-4-git-send-email-agustinv@codeaurora.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Auto-merge PMU events created by prefix
 or glob match
Git-Commit-ID: c199c11dce197b12ff884ac0cfcb527b1164788b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c199c11dce197b12ff884ac0cfcb527b1164788b
Gitweb:     https://git.kernel.org/tip/c199c11dce197b12ff884ac0cfcb527b1164788b
Author:     Agustin Vega-Frias <agustinv@codeaurora.org>
AuthorDate: Tue, 6 Mar 2018 09:04:44 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:49 -0300

perf pmu: Auto-merge PMU events created by prefix or glob match

Auto-merge for these events was disabled when auto-merging of non-alias
events was disabled in commit 63ce844 (perf stat: Only auto-merge events
that are PMU aliases).

Non-merging of legacy events is preserved:

    $ perf stat -ag -e cache-misses,cache-misses sleep 1

     Performance counter stats for 'system wide':

                86,323      cache-misses
                86,323      cache-misses

           1.002623307 seconds time elapsed

But prefix or glob matching auto-merges the events created:

    $ perf stat -a -e l3cache/read-miss/ sleep 1

     Performance counter stats for 'system wide':

                   328      l3cache/read-miss/

           1.002627008 seconds time elapsed

    $ perf stat -a -e l3cache_0_[01]/read-miss/ sleep 1

     Performance counter stats for 'system wide':

                   172      l3cache/read-miss/

           1.002627008 seconds time elapsed

As with events created with aliases, auto-merging can be suppressed with
the --no-merge option:

    $ perf stat -a -e l3cache/read-miss/ --no-merge sleep 1

     Performance counter stats for 'system wide':

                    67      l3cache/read-miss/
                    67      l3cache/read-miss/
                    63      l3cache/read-miss/
                    60      l3cache/read-miss/

           1.002622192 seconds time elapsed

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Timur Tabi <timur@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org
Change-Id: I0a47eed54c05e1982ca964d743b37f50f60c508c
Link: http://lkml.kernel.org/r/1520345084-42646-4-git-send-email-agustinv@codeaurora.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 14 +++++++++-----
 tools/perf/util/parse-events.c         | 13 +++----------
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/parse-events.y         |  4 ++--
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 628026dbedc5..f15b306be183 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -267,11 +267,15 @@ taskset.
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
index bafc91edcb44..4e80ca320399 100644
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
index 88108cd11b4c..5015cfd58277 100644
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
index dedf184b5bed..7afeb80cc39e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -232,7 +232,7 @@ PE_NAME opt_event_config
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -251,7 +251,7 @@ PE_NAME opt_event_config
 					free(pattern);
 					YYABORT;
 				}
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
+				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
