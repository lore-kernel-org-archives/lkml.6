Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbeCBXmA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:42:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934731AbeCBXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:41:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CEBD607F5
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
Subject: [RFC V2 2/3] perf, tools: Display pmu name when printing unmerged events in stat
Date: Fri,  2 Mar 2018 18:41:31 -0500
Message-Id: <1520034092-35275-3-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify creation of events accross multiple instances of the same type
of PMU stat supports two methods for creating multiple events from a single
event specification:
1. A prefix or glob can be used in the PMU name.
2. Aliases, which are listed immediately after the Kernel PMU events
   by perf list, are used.

When the --no-merge option is passed and these events are displayed
individually the PMU name is lost and it's not possible to see which
count corresponds to which pmu:

    $ ./perf stat -a -e l3cache/read-miss/ --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    67      l3cache/read-miss/
                    67      l3cache/read-miss/
                    63      l3cache/read-miss/
                    60      l3cache/read-miss/

           0.001675706 seconds time elapsed

    $ ./perf stat -a -e l3cache_read_miss --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    12      l3cache_read_miss
                    17      l3cache_read_miss
                    10      l3cache_read_miss
                     8      l3cache_read_miss

           0.001661305 seconds time elapsed

This change adds the original pmu name to the event. For dynamic pmu
events the pmu name is restored in the event name:

    $ ./perf stat -a -e l3cache/read-miss/ --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    63      l3cache_0_3/read-miss/
                    74      l3cache_0_1/read-miss/
                    64      l3cache_0_2/read-miss/
                    74      l3cache_0_0/read-miss/

           0.001675706 seconds time elapsed

For alias events the name is added after the event name:

    $ ./perf stat -a -e l3cache_read_miss --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    10      l3cache_read_miss [l3cache_0_3]
                    12      l3cache_read_miss [l3cache_0_1]
                    10      l3cache_read_miss [l3cache_0_2]
                    17      l3cache_read_miss [l3cache_0_0]

           0.001661305 seconds time elapsed

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 tools/perf/builtin-stat.c      | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c        |  1 +
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c |  8 +++++++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d3..d196972 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1225,6 +1225,31 @@ static void aggr_update_shadow(void)
 	}
 }

+static void uniquify_event_name(struct perf_evsel *counter)
+{
+	char *new_name;
+	char *config;
+
+	if (!counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+					   strlen(counter->pmu_name)))
+		return;
+
+	config = strchr(counter->name, '/');
+	if (config) {
+		if (asprintf(&new_name,
+			     "%s%s", counter->pmu_name, config) > 0) {
+			free(counter->name);
+			counter->name = new_name;
+		}
+	} else {
+		if (asprintf(&new_name,
+			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
+			free(counter->name);
+			counter->name = new_name;
+		}
+	}
+}
+
 static void collect_all_aliases(struct perf_evsel *counter,
 			    void (*cb)(struct perf_evsel *counter, void *data,
 				       bool first),
@@ -1253,7 +1278,9 @@ static bool collect_data(struct perf_evsel *counter,
 	if (counter->merged_stat)
 		return false;
 	cb(counter, data, true);
-	if (!no_merge && counter->auto_merge_stats)
+	if (no_merge)
+		uniquify_event_name(counter);
+	else if (counter->auto_merge_stats)
 		collect_all_aliases(counter, cb, data);
 	return true;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef35168..4841000 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -244,6 +244,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->metric_name   = NULL;
 	evsel->metric_events = NULL;
 	evsel->collect_stat  = false;
+	evsel->pmu_name      = NULL;
 }

 struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a7487c6..c2ac16a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -142,6 +142,7 @@ struct perf_evsel {
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
+	const char		*pmu_name;
 };

 union u64_swap {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 34589c4..bafc91e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1247,7 +1247,12 @@ static int __parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (!head_config) {
 		attr.type = pmu->type;
 		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL, auto_merge_stats);
-		return evsel ? 0 : -ENOMEM;
+		if (evsel) {
+			evsel->pmu_name = name;
+			return 0;
+		} else {
+			return -ENOMEM;
+		}
 	}

 	if (perf_pmu__check_alias(pmu, head_config, &info))
@@ -1276,6 +1281,7 @@ static int __parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->snapshot = info.snapshot;
 		evsel->metric_expr = info.metric_expr;
 		evsel->metric_name = info.metric_name;
+		evsel->pmu_name = name;
 	}

 	return evsel ? 0 : -ENOMEM;
--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
