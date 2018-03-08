Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCHTvl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeCHTvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE382177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/54] perf pmu: Display pmu name when printing unmerged events in stat
Date: Thu,  8 Mar 2018 16:49:55 -0300
Message-Id: <20180308195029.14991-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Agustin Vega-Frias <agustinv@codeaurora.org>

To simplify creation of events accross multiple instances of the same
type of PMU stat supports two methods for creating multiple events from
a single event specification:

1. A prefix or glob can be used in the PMU name.
2. Aliases, which are listed immediately after the Kernel PMU events
   by perf list, are used.

When the --no-merge option is passed and these events are displayed
individually the PMU name is lost and it's not possible to see which
count corresponds to which pmu:

    $ perf stat -a -e l3cache/read-miss/ --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    67      l3cache/read-miss/
                    67      l3cache/read-miss/
                    63      l3cache/read-miss/
                    60      l3cache/read-miss/

           0.001675706 seconds time elapsed

    $ perf stat -a -e l3cache_read_miss --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    12      l3cache_read_miss
                    17      l3cache_read_miss
                    10      l3cache_read_miss
                     8      l3cache_read_miss

           0.001661305 seconds time elapsed

This change adds the original pmu name to the event. For dynamic pmu
events the pmu name is restored in the event name:

    $ perf stat -a -e l3cache/read-miss/ --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    63      l3cache_0_3/read-miss/
                    74      l3cache_0_1/read-miss/
                    64      l3cache_0_2/read-miss/
                    74      l3cache_0_0/read-miss/

           0.001675706 seconds time elapsed

For alias events the name is added after the event name:

    $ perf stat -a -e l3cache_read_miss --no-merge ls > /dev/null

     Performance counter stats for 'system wide':

                    10      l3cache_read_miss [l3cache_0_3]
                    12      l3cache_read_miss [l3cache_0_1]
                    10      l3cache_read_miss [l3cache_0_2]
                    17      l3cache_read_miss [l3cache_0_0]

           0.001661305 seconds time elapsed

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Timur Tabi <timur@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org
Change-Id: I8056b9eda74bda33e95065056167ad96e97cb1fb
Link: http://lkml.kernel.org/r/1520345084-42646-3-git-send-email-agustinv@codeaurora.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c      | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c        |  1 +
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c |  8 +++++++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3a022b3e5c02..0fa9ea3a6d92 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1251,6 +1251,31 @@ static void aggr_update_shadow(void)
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
@@ -1279,7 +1304,9 @@ static bool collect_data(struct perf_evsel *counter,
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
index f1f883bb41a8..e937894654b2 100644
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
index 92ba001b627f..55ae1cda7396 100644
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
index 34589c427e52..bafc91edcb44 100644
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
2.14.3
