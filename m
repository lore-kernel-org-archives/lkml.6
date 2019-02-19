Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11179C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24832183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfBSUBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:8764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfBSUBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:01:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918131"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:01:04 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 10/10] perf stat: Support per-die aggregation
Date:   Tue, 19 Feb 2019 12:00:11 -0800
Message-Id: <1550606411-5313-11-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It is useful to aggregate counts per processor die.

Introduce a new option "--per-die" to support per-die aggregation.

The global id for each core has been changed to socket + die id + core
id. The global id for each die is socket + die id.

Add die information for per-core aggregation. The output of per-core
aggregation will be changed from "S0-C0" to "S0-D0-C0". Any scripts
which rely on the output format of per-core aggregation probably be
broken.

For perf stat record/report, there is no die information when processing
the old perf.data. The per-die result will be the same as per-socket.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 10 +++++
 tools/perf/builtin-stat.c              | 73 +++++++++++++++++++++++++++++++---
 tools/perf/util/cpumap.c               | 48 +++++++++++++++++++---
 tools/perf/util/cpumap.h               |  9 ++++-
 tools/perf/util/stat-display.c         | 24 ++++++++++-
 tools/perf/util/stat-shadow.c          |  1 +
 tools/perf/util/stat.c                 |  1 +
 tools/perf/util/stat.h                 |  1 +
 8 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4bc2085..4fd68ac 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -197,6 +197,13 @@ use --per-socket in addition to -a. (system-wide).  The output includes the
 socket number and the number of online processors on that socket. This is
 useful to gauge the amount of aggregation.
 
+--per-die::
+Aggregate counts per processor die for system-wide mode measurements.  This
+is a useful mode to detect imbalance between dies.  To enable this mode,
+use --per-die in addition to -a. (system-wide).  The output includes the
+die number and the number of online processors on that die. This is
+useful to gauge the amount of aggregation.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.  This
 is a useful mode to detect imbalance between physical cores.  To enable this mode,
@@ -236,6 +243,9 @@ Input file name.
 --per-socket::
 Aggregate counts per processor socket for system-wide mode measurements.
 
+--per-die::
+Aggregate counts per processor die for system-wide mode measurements.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc..92c6967 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -772,6 +772,8 @@ static struct option stat_options[] = {
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
+	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
+		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
@@ -796,6 +798,12 @@ static int perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_socket(map, cpu, NULL);
 }
 
+static int perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
+			      struct cpu_map *map, int cpu)
+{
+	return cpu_map__get_die(map, cpu, NULL);
+}
+
 static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 			       struct cpu_map *map, int cpu)
 {
@@ -836,6 +844,12 @@ static int perf_stat__get_socket_cached(struct perf_stat_config *config,
 	return perf_stat__get_aggr(config, perf_stat__get_socket, map, idx);
 }
 
+static int perf_stat__get_die_cached(struct perf_stat_config *config,
+					struct cpu_map *map, int idx)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_die, map, idx);
+}
+
 static int perf_stat__get_core_cached(struct perf_stat_config *config,
 				      struct cpu_map *map, int idx)
 {
@@ -854,6 +868,13 @@ static int perf_stat_init_aggr_mode(void)
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_cached;
 		break;
+	case AGGR_DIE:
+		if (cpu_map__build_die_map(evsel_list->cpus, &stat_config.aggr_map)) {
+			perror("cannot build die map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_die_cached;
+		break;
 	case AGGR_CORE:
 		if (cpu_map__build_core_map(evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
@@ -910,21 +931,41 @@ static int perf_env__get_socket(struct cpu_map *map, int idx, void *data)
 	return cpu == -1 ? -1 : env->cpu[cpu].socket_id;
 }
 
+static int perf_env__get_die(struct cpu_map *map, int idx, void *data)
+{
+	struct perf_env *env = data;
+	int die = -1, cpu = perf_env__get_cpu(env, map, idx);
+
+	if (cpu != -1) {
+		/*
+		 * Encode socket in upper 8 bits
+		 * die_id is relative to socket,
+		 * we need a global id. So we combine
+		 * socket + die id
+		 */
+		die = (env->cpu[cpu].socket_id << 8) |
+		      (env->cpu[cpu].die_id & 0xff);
+	}
+
+	return die;
+}
+
 static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
 {
 	struct perf_env *env = data;
 	int core = -1, cpu = perf_env__get_cpu(env, map, idx);
 
 	if (cpu != -1) {
-		int socket_id = env->cpu[cpu].socket_id;
-
 		/*
-		 * Encode socket in upper 16 bits
-		 * core_id is relative to socket, and
+		 * Encode socket in upper 24 bits
+		 * encode die id in upper 16 bits
+		 * core_id is relative to socket and die,
 		 * we need a global id. So we combine
-		 * socket + core id.
+		 * socket + die id + core id
 		 */
-		core = (socket_id << 16) | (env->cpu[cpu].core_id & 0xffff);
+		core = (env->cpu[cpu].socket_id << 24) |
+		       (env->cpu[cpu].die_id << 16) |
+		       (env->cpu[cpu].core_id & 0xffff);
 	}
 
 	return core;
@@ -936,6 +977,12 @@ static int perf_env__build_socket_map(struct perf_env *env, struct cpu_map *cpus
 	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
 }
 
+static int perf_env__build_die_map(struct perf_env *env, struct cpu_map *cpus,
+				   struct cpu_map **diep)
+{
+	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
+}
+
 static int perf_env__build_core_map(struct perf_env *env, struct cpu_map *cpus,
 				    struct cpu_map **corep)
 {
@@ -947,6 +994,11 @@ static int perf_stat__get_socket_file(struct perf_stat_config *config __maybe_un
 {
 	return perf_env__get_socket(map, idx, &perf_stat.session->header.env);
 }
+static int perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
+				   struct cpu_map *map, int idx)
+{
+	return perf_env__get_die(map, idx, &perf_stat.session->header.env);
+}
 
 static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 				    struct cpu_map *map, int idx)
@@ -966,6 +1018,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_file;
 		break;
+	case AGGR_DIE:
+		if (perf_env__build_die_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
+			perror("cannot build die map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_die_file;
+		break;
 	case AGGR_CORE:
 		if (perf_env__build_core_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
@@ -1515,6 +1574,8 @@ static int __cmd_report(int argc, const char **argv)
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_SET_UINT(0, "per-socket", &perf_stat.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
+	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
+		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b84fcd4..f6c7aa1 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -380,6 +380,33 @@ int cpu_map__get_die_id(int cpu)
 	return ret ?: value;
 }
 
+int cpu_map__get_die(struct cpu_map *map, int idx, void *data)
+{
+	int cpu, die, s;
+
+	if (idx > map->nr)
+		return -1;
+
+	cpu = map->map[idx];
+
+	die = cpu_map__get_die_id(cpu);
+	/* There is no die_id on legacy system. */
+	if (die == -1)
+		die = 0;
+
+	s = cpu_map__get_socket(map, idx, data);
+	if (s == -1)
+		return -1;
+
+	/*
+	 * encode socket in upper 8 bits
+	 * die_id is relative to socket, and
+	 * we need a global id. So we combine
+	 * socket + die id
+	 */
+	return (s << 8) | (die & 0xff);
+}
+
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
@@ -388,7 +415,7 @@ int cpu_map__get_core_id(int cpu)
 
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
 {
-	int cpu, s;
+	int cpu, s, die;
 
 	if (idx > map->nr)
 		return -1;
@@ -397,17 +424,23 @@ int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
 
 	cpu = cpu_map__get_core_id(cpu);
 
+	die = cpu_map__get_die(map, idx, data);
+	/* There is no die_id on legacy system. */
+	if (die == -1)
+		die = 0;
+
 	s = cpu_map__get_socket(map, idx, data);
 	if (s == -1)
 		return -1;
 
 	/*
-	 * encode socket in upper 16 bits
-	 * core_id is relative to socket, and
+	 * encode socket in upper 24 bits
+	 * encode die id in upper 16 bits
+	 * core_id is relative to socket and die,
 	 * we need a global id. So we combine
-	 * socket+ core id
+	 * socket + die id + core id
 	 */
-	return (s << 16) | (cpu & 0xffff);
+	return (s << 24) | (die << 16) | (cpu & 0xffff);
 }
 
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp)
@@ -415,6 +448,11 @@ int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp)
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
 }
 
+int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep)
+{
+	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
+}
+
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 4d66f67..3442b7a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -26,9 +26,11 @@ size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
+int cpu_map__get_die(struct cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
+int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep);
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep);
 
 struct cpu_map *cpu_map__get(struct cpu_map *map);
@@ -43,7 +45,12 @@ static inline int cpu_map__socket(struct cpu_map *sock, int s)
 
 static inline int cpu_map__id_to_socket(int id)
 {
-	return id >> 16;
+	return id >> 24;
+}
+
+static inline int cpu_map__id_to_die(int id)
+{
+	return (id >> 16) & 0xff;
 }
 
 static inline int cpu_map__id_to_cpu(int id)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 665ee37..05216a2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -73,8 +73,9 @@ static void aggr_printout(struct perf_stat_config *config,
 {
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(config->output, "S%d-C%*d%s%*d%s",
+		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
 			cpu_map__id_to_socket(id),
+			cpu_map__id_to_die(id),
 			config->csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id),
 			config->csv_sep,
@@ -82,6 +83,16 @@ static void aggr_printout(struct perf_stat_config *config,
 			nr,
 			config->csv_sep);
 		break;
+	case AGGR_DIE:
+		fprintf(config->output, "S%d-D%*d%s%*d%s",
+			cpu_map__id_to_socket(id << 16),
+			config->csv_output ? 0 : -8,
+			cpu_map__id_to_die(id << 16),
+			config->csv_sep,
+			config->csv_output ? 0 : 4,
+			nr,
+			config->csv_sep);
+		break;
 	case AGGR_SOCKET:
 		fprintf(config->output, "S%*d%s%*d%s",
 			config->csv_output ? 0 : -5,
@@ -403,6 +414,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			[AGGR_THREAD] = 1,
 			[AGGR_NONE] = 1,
 			[AGGR_SOCKET] = 2,
+			[AGGR_DIE] = 2,
 			[AGGR_CORE] = 2,
 		};
 
@@ -866,7 +878,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 }
 
 static int aggr_header_lens[] = {
-	[AGGR_CORE] = 18,
+	[AGGR_CORE] = 24,
+	[AGGR_DIE] = 18,
 	[AGGR_SOCKET] = 12,
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
@@ -875,6 +888,7 @@ static int aggr_header_lens[] = {
 
 static const char *aggr_header_csv[] = {
 	[AGGR_CORE] 	= 	"core,cpus,",
+	[AGGR_DIE] 	= 	"die,cpus",
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
@@ -943,6 +957,11 @@ static void print_interval(struct perf_stat_config *config,
 			if (!metric_only)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
+		case AGGR_DIE:
+			fprintf(output, "#           time die cpus");
+			if (!metric_only)
+				fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			break;
 		case AGGR_CORE:
 			fprintf(output, "#           time core         cpus");
 			if (!metric_only)
@@ -1130,6 +1149,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+	case AGGR_DIE:
 	case AGGR_SOCKET:
 		print_aggr(config, evlist, prefix);
 		break;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3c22c58..4d34dc8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -12,6 +12,7 @@
 /*
  * AGGR_GLOBAL: Use CPU 0
  * AGGR_SOCKET: Use first CPU of socket
+ * AGGR_DIE: Use first CPU of die
  * AGGR_CORE: Use first CPU of core
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515..6bad12f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -272,6 +272,7 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
+	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f9c915..7032dd1 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -44,6 +44,7 @@ enum aggr_mode {
 	AGGR_NONE,
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
+	AGGR_DIE,
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
-- 
2.7.4

