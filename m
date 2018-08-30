Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF28C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2CF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CF2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeH3Keb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728225AbeH3Kea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89F3087A70;
        Thu, 30 Aug 2018 06:33:54 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23295A9EF6;
        Thu, 30 Aug 2018 06:33:53 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 36/43] perf stat: Move *_aggr_* data into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:45 +0200
Message-Id: <20180830063252.23729-37-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving *_aggr_* data into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-3z70bag45oyahf06loz984uo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 112 ++++++++++++++++++++------------------
 tools/perf/util/stat.h    |   6 ++
 2 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 942ebfd8ef2e..2f606f76b66a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -143,8 +143,6 @@ static struct target target = {
 	.uid	= UINT_MAX,
 };
 
-typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
-
 #define METRIC_ONLY_LEN 20
 
 static volatile pid_t		child_pid			= -1;
@@ -164,8 +162,6 @@ static bool			force_metric_only		= false;
 static bool			no_merge			= false;
 static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
-static struct cpu_map		*aggr_map;
-static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
@@ -920,7 +916,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 {
 	int i;
 
-	if (!aggr_get_id)
+	if (!config->aggr_get_id)
 		return 0;
 
 	if (config->aggr_mode == AGGR_NONE)
@@ -932,7 +928,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
 		int cpu2 = perf_evsel__cpus(evsel)->map[i];
 
-		if (aggr_get_id(evsel_list->cpus, cpu2) == id)
+		if (config->aggr_get_id(config, evsel_list->cpus, cpu2) == id)
 			return cpu2;
 	}
 	return 0;
@@ -1102,12 +1098,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 	u64 val;
 	struct perf_evsel *counter;
 
-	for (s = 0; s < aggr_map->nr; s++) {
-		id = aggr_map->map[s];
+	for (s = 0; s < config->aggr_map->nr; s++) {
+		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
-				s2 = aggr_get_id(evsel_list->cpus, cpu);
+				s2 = config->aggr_get_id(config, evsel_list->cpus, cpu);
 				if (s2 != id)
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
@@ -1147,8 +1143,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 	counter->uniquified_name = true;
 }
 
-static void collect_all_aliases(struct perf_evsel *counter,
-			    void (*cb)(struct perf_evsel *counter, void *data,
+static void collect_all_aliases(struct perf_stat_config *config, struct perf_evsel *counter,
+			    void (*cb)(struct perf_stat_config *config, struct perf_evsel *counter, void *data,
 				       bool first),
 			    void *data)
 {
@@ -1164,22 +1160,22 @@ static void collect_all_aliases(struct perf_evsel *counter,
 		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter))
 			break;
 		alias->merged_stat = true;
-		cb(alias, data, false);
+		cb(config, alias, data, false);
 	}
 }
 
-static bool collect_data(struct perf_evsel *counter,
-			    void (*cb)(struct perf_evsel *counter, void *data,
+static bool collect_data(struct perf_stat_config *config, struct perf_evsel *counter,
+			    void (*cb)(struct perf_stat_config *config, struct perf_evsel *counter, void *data,
 				       bool first),
 			    void *data)
 {
 	if (counter->merged_stat)
 		return false;
-	cb(counter, data, true);
+	cb(config, counter, data, true);
 	if (no_merge)
 		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats)
-		collect_all_aliases(counter, cb, data);
+		collect_all_aliases(config, counter, cb, data);
 	return true;
 }
 
@@ -1190,7 +1186,8 @@ struct aggr_data {
 	int cpu;
 };
 
-static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
+static void aggr_cb(struct perf_stat_config *config,
+		    struct perf_evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
 	int cpu, s2;
@@ -1198,7 +1195,7 @@ static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
 	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
-		s2 = aggr_get_id(perf_evsel__cpus(counter), cpu);
+		s2 = config->aggr_get_id(config, perf_evsel__cpus(counter), cpu);
 		if (s2 != ad->id)
 			continue;
 		if (first)
@@ -1232,7 +1229,7 @@ static void print_aggr(struct perf_stat_config *config,
 	u64 ena, run, val;
 	bool first;
 
-	if (!(aggr_map || aggr_get_id))
+	if (!(config->aggr_map || config->aggr_get_id))
 		return;
 
 	aggr_update_shadow(config, evlist);
@@ -1241,12 +1238,12 @@ static void print_aggr(struct perf_stat_config *config,
 	 * With metric_only everything is on a single line.
 	 * Without each counter has its own line.
 	 */
-	for (s = 0; s < aggr_map->nr; s++) {
+	for (s = 0; s < config->aggr_map->nr; s++) {
 		struct aggr_data ad;
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
-		ad.id = id = aggr_map->map[s];
+		ad.id = id = config->aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
@@ -1254,7 +1251,7 @@ static void print_aggr(struct perf_stat_config *config,
 
 			ad.val = ad.ena = ad.run = 0;
 			ad.nr = 0;
-			if (!collect_data(counter, aggr_cb, &ad))
+			if (!collect_data(config, counter, aggr_cb, &ad))
 				continue;
 			nr = ad.nr;
 			ena = ad.ena;
@@ -1370,7 +1367,8 @@ struct caggr_data {
 	double avg, avg_enabled, avg_running;
 };
 
-static void counter_aggr_cb(struct perf_evsel *counter, void *data,
+static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
+			    struct perf_evsel *counter, void *data,
 			    bool first __maybe_unused)
 {
 	struct caggr_data *cd = data;
@@ -1393,7 +1391,7 @@ static void print_counter_aggr(struct perf_stat_config *config,
 	double uval;
 	struct caggr_data cd = { .avg = 0.0 };
 
-	if (!collect_data(counter, counter_aggr_cb, &cd))
+	if (!collect_data(config, counter, counter_aggr_cb, &cd))
 		return;
 
 	if (prefix && !metric_only)
@@ -1406,7 +1404,8 @@ static void print_counter_aggr(struct perf_stat_config *config,
 		fprintf(output, "\n");
 }
 
-static void counter_cb(struct perf_evsel *counter, void *data,
+static void counter_cb(struct perf_stat_config *config __maybe_unused,
+		       struct perf_evsel *counter, void *data,
 		       bool first __maybe_unused)
 {
 	struct aggr_data *ad = data;
@@ -1431,7 +1430,7 @@ static void print_counter(struct perf_stat_config *config,
 	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 		struct aggr_data ad = { .cpu = cpu };
 
-		if (!collect_data(counter, counter_cb, &ad))
+		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
 		val = ad.val;
 		ena = ad.ena;
@@ -1944,12 +1943,14 @@ static const struct option stat_options[] = {
 	OPT_END()
 };
 
-static int perf_stat__get_socket(struct cpu_map *map, int cpu)
+static int perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
+				 struct cpu_map *map, int cpu)
 {
 	return cpu_map__get_socket(map, cpu, NULL);
 }
 
-static int perf_stat__get_core(struct cpu_map *map, int cpu)
+static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
+			       struct cpu_map *map, int cpu)
 {
 	return cpu_map__get_core(map, cpu, NULL);
 }
@@ -1966,9 +1967,8 @@ static int cpu_map__get_max(struct cpu_map *map)
 	return max;
 }
 
-static struct cpu_map *cpus_aggr_map;
-
-static int perf_stat__get_aggr(aggr_get_id_t get_id, struct cpu_map *map, int idx)
+static int perf_stat__get_aggr(struct perf_stat_config *config,
+			       aggr_get_id_t get_id, struct cpu_map *map, int idx)
 {
 	int cpu;
 
@@ -1977,20 +1977,22 @@ static int perf_stat__get_aggr(aggr_get_id_t get_id, struct cpu_map *map, int id
 
 	cpu = map->map[idx];
 
-	if (cpus_aggr_map->map[cpu] == -1)
-		cpus_aggr_map->map[cpu] = get_id(map, idx);
+	if (config->cpus_aggr_map->map[cpu] == -1)
+		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx);
 
-	return cpus_aggr_map->map[cpu];
+	return config->cpus_aggr_map->map[cpu];
 }
 
-static int perf_stat__get_socket_cached(struct cpu_map *map, int idx)
+static int perf_stat__get_socket_cached(struct perf_stat_config *config,
+					struct cpu_map *map, int idx)
 {
-	return perf_stat__get_aggr(perf_stat__get_socket, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_socket, map, idx);
 }
 
-static int perf_stat__get_core_cached(struct cpu_map *map, int idx)
+static int perf_stat__get_core_cached(struct perf_stat_config *config,
+				      struct cpu_map *map, int idx)
 {
-	return perf_stat__get_aggr(perf_stat__get_core, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
 }
 
 static int perf_stat_init_aggr_mode(void)
@@ -1999,18 +2001,18 @@ static int perf_stat_init_aggr_mode(void)
 
 	switch (stat_config.aggr_mode) {
 	case AGGR_SOCKET:
-		if (cpu_map__build_socket_map(evsel_list->cpus, &aggr_map)) {
+		if (cpu_map__build_socket_map(evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build socket map");
 			return -1;
 		}
-		aggr_get_id = perf_stat__get_socket_cached;
+		stat_config.aggr_get_id = perf_stat__get_socket_cached;
 		break;
 	case AGGR_CORE:
-		if (cpu_map__build_core_map(evsel_list->cpus, &aggr_map)) {
+		if (cpu_map__build_core_map(evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
 			return -1;
 		}
-		aggr_get_id = perf_stat__get_core_cached;
+		stat_config.aggr_get_id = perf_stat__get_core_cached;
 		break;
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
@@ -2026,16 +2028,16 @@ static int perf_stat_init_aggr_mode(void)
 	 * the aggregation translate cpumap.
 	 */
 	nr = cpu_map__get_max(evsel_list->cpus);
-	cpus_aggr_map = cpu_map__empty_new(nr + 1);
-	return cpus_aggr_map ? 0 : -ENOMEM;
+	stat_config.cpus_aggr_map = cpu_map__empty_new(nr + 1);
+	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
 
 static void perf_stat__exit_aggr_mode(void)
 {
-	cpu_map__put(aggr_map);
-	cpu_map__put(cpus_aggr_map);
-	aggr_map = NULL;
-	cpus_aggr_map = NULL;
+	cpu_map__put(stat_config.aggr_map);
+	cpu_map__put(stat_config.cpus_aggr_map);
+	stat_config.aggr_map = NULL;
+	stat_config.cpus_aggr_map = NULL;
 }
 
 static inline int perf_env__get_cpu(struct perf_env *env, struct cpu_map *map, int idx)
@@ -2093,12 +2095,14 @@ static int perf_env__build_core_map(struct perf_env *env, struct cpu_map *cpus,
 	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
 }
 
-static int perf_stat__get_socket_file(struct cpu_map *map, int idx)
+static int perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
+				      struct cpu_map *map, int idx)
 {
 	return perf_env__get_socket(map, idx, &perf_stat.session->header.env);
 }
 
-static int perf_stat__get_core_file(struct cpu_map *map, int idx)
+static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
+				    struct cpu_map *map, int idx)
 {
 	return perf_env__get_core(map, idx, &perf_stat.session->header.env);
 }
@@ -2109,18 +2113,18 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 
 	switch (stat_config.aggr_mode) {
 	case AGGR_SOCKET:
-		if (perf_env__build_socket_map(env, evsel_list->cpus, &aggr_map)) {
+		if (perf_env__build_socket_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build socket map");
 			return -1;
 		}
-		aggr_get_id = perf_stat__get_socket_file;
+		stat_config.aggr_get_id = perf_stat__get_socket_file;
 		break;
 	case AGGR_CORE:
-		if (perf_env__build_core_map(env, evsel_list->cpus, &aggr_map)) {
+		if (perf_env__build_core_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
 			return -1;
 		}
-		aggr_get_id = perf_stat__get_core_file;
+		stat_config.aggr_get_id = perf_stat__get_core_file;
 		break;
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 1fd0b7e196c6..be202b066e62 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,9 @@ struct runtime_stat {
 	struct rblist value_list;
 };
 
+typedef int (*aggr_get_id_t)(struct perf_stat_config *config,
+			     struct cpu_map *m, int cpu);
+
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
@@ -115,6 +118,9 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
+	struct cpu_map		*aggr_map;
+	aggr_get_id_t		 aggr_get_id;
+	struct cpu_map		*cpus_aggr_map;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

