Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeEBPdt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeEBPUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:25 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/52] perf stat: Add --table option to display time of each run
Date: Wed,  2 May 2018 12:18:56 -0300
Message-Id: <20180502151942.20542-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add --table option to display time for each run (-r option), like:

  $ perf stat --null -r 5 --table perf bench sched pipe

   Performance counter stats for './perf bench sched pipe' (5 runs):

             # Table of individual measurements:
             5.379 (-0.176)
             5.243 (-0.311)
             5.238 (-0.317)
             5.536 (-0.019)
             6.377 (+0.823)

             # Final result:
             5.555 +- 0.213 seconds time elapsed  ( +-  3.83% )

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-8-jolsa@kernel.org
[ Document the new option in 'perf stat's man page ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 16 ++++++++++
 tools/perf/builtin-stat.c              | 56 +++++++++++++++++++++++++++++++---
 tools/perf/util/stat.h                 |  3 +-
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index e6c3b4e555c2..72a2414513bd 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -116,6 +116,22 @@ Do not aggregate counts across all monitored CPUs.
 print counts using a CSV-style output to make it easy to import directly into
 spreadsheets. Columns are separated by the string specified in SEP.
 
+--table:: Display time for each run (-r option), in a table format, e.g.:
+
+  $ perf stat --null -r 5 --table perf bench sched pipe
+
+   Performance counter stats for 'perf bench sched pipe' (5 runs):
+
+             # Table of individual measurements:
+             5.379 (-0.176)
+             5.243 (-0.311)
+             5.238 (-0.317)
+             5.536 (-0.019)
+             6.377 (+0.823)
+
+             # Final result:
+             5.555 +- 0.213 seconds time elapsed  ( +-  3.83% )
+
 -G name::
 --cgroup name::
 monitor only in the container (cgroup) called "name". This option is available only
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3a94647ef6bc..72553937c010 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,6 +164,7 @@ static bool			forever				= false;
 static bool			metric_only			= false;
 static bool			force_metric_only		= false;
 static bool			no_merge			= false;
+static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
@@ -173,6 +174,7 @@ static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
+static u64			*walltime_run;
 
 struct perf_stat {
 	bool			 record;
@@ -569,7 +571,7 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
-static int __run_perf_stat(int argc, const char **argv)
+static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
 	int times = stat_config.times;
@@ -752,6 +754,9 @@ static int __run_perf_stat(int argc, const char **argv)
 
 	t1 = rdclock();
 
+	if (walltime_run_table)
+		walltime_run[run_idx] = t1 - t0;
+
 	update_stats(&walltime_nsecs_stats, t1 - t0);
 
 	/*
@@ -766,7 +771,7 @@ static int __run_perf_stat(int argc, const char **argv)
 	return WEXITSTATUS(status);
 }
 
-static int run_perf_stat(int argc, const char **argv)
+static int run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int ret;
 
@@ -779,7 +784,7 @@ static int run_perf_stat(int argc, const char **argv)
 	if (sync_run)
 		sync();
 
-	ret = __run_perf_stat(argc, argv);
+	ret = __run_perf_stat(argc, argv, run_idx);
 	if (ret)
 		return ret;
 
@@ -1772,6 +1777,27 @@ static int get_precision(double num)
 	return lround(ceil(-log10(num)));
 }
 
+static void print_table(FILE *output, int precision, double avg)
+{
+	char tmp[64];
+	int idx, indent = 0;
+
+	scnprintf(tmp, 64, " %17.*f", precision, avg);
+	while (tmp[indent] == ' ')
+		indent++;
+
+	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
+
+	for (idx = 0; idx < run_count; idx++) {
+		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
+
+		fprintf(output, " %17.*f (%+.*f)\n",
+			precision, run, precision, run - avg);
+	}
+
+	fprintf(output, "\n%*s# Final result:\n", indent, "");
+}
+
 static void print_footer(void)
 {
 	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
@@ -1791,6 +1817,9 @@ static void print_footer(void)
 		 */
 		int precision = get_precision(sd) + 2;
 
+		if (walltime_run_table)
+			print_table(output, precision, avg);
+
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
 
@@ -1970,6 +1999,8 @@ static const struct option stat_options[] = {
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
+	OPT_BOOLEAN(0, "table", &walltime_run_table,
+		    "display details about each run (only with -r option)"),
 	OPT_BOOLEAN('n', "null", &null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
@@ -2861,6 +2892,13 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (walltime_run_table && run_count <= 1) {
+		fprintf(stderr, "--table is only supported with -r\n");
+		parse_options_usage(stat_usage, stat_options, "r", 1);
+		parse_options_usage(NULL, stat_options, "table", 0);
+		goto out;
+	}
+
 	if (output_fd < 0) {
 		fprintf(stderr, "argument to --log-fd must be a > 0\n");
 		parse_options_usage(stat_usage, stat_options, "log-fd", 0);
@@ -2915,6 +2953,14 @@ int cmd_stat(int argc, const char **argv)
 		run_count = 1;
 	}
 
+	if (walltime_run_table) {
+		walltime_run = zalloc(run_count * sizeof(walltime_run[0]));
+		if (!walltime_run) {
+			pr_err("failed to setup -r option");
+			goto out;
+		}
+	}
+
 	if ((stat_config.aggr_mode == AGGR_THREAD) &&
 		!target__has_task(&target)) {
 		if (!target.system_wide || target.cpu_list) {
@@ -3030,7 +3076,7 @@ int cmd_stat(int argc, const char **argv)
 			fprintf(output, "[ perf stat: executing run #%d ... ]\n",
 				run_idx + 1);
 
-		status = run_perf_stat(argc, argv);
+		status = run_perf_stat(argc, argv, run_idx);
 		if (forever && status != -1) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
@@ -3078,6 +3124,8 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
+	free(walltime_run);
+
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8f56ba4fd258..36efb986f7fc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,8 +7,7 @@
 #include "xyarray.h"
 #include "rblist.h"
 
-struct stats
-{
+struct stats {
 	double n, mean, M2;
 	u64 max, min;
 };
-- 
2.14.3
