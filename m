Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbeDWJJW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:09:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754545AbeDWJIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:37 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 7/9] perf stat: Add --table option to display time of each run
Date: Mon, 23 Apr 2018 11:08:21 +0200
Message-Id: <20180423090823.32309-8-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --table option to display time for each
run (-r option), like:

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
Link: http://lkml.kernel.org/n/tip-tmd7cqla3pzc0a0bdf13qfdu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 56 +++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/stat.h    |  3 +--
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6b4f3d359cb3..345687b0eb10 100644
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
@@ -172,6 +173,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
+static u64			*walltime_run;
 
 struct perf_stat {
 	bool			 record;
@@ -568,7 +570,7 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
-static int __run_perf_stat(int argc, const char **argv)
+static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
 	int times = stat_config.times;
@@ -751,6 +753,9 @@ static int __run_perf_stat(int argc, const char **argv)
 
 	t1 = rdclock();
 
+	if (walltime_run_table)
+		walltime_run[run_idx] = t1 - t0;
+
 	update_stats(&walltime_nsecs_stats, t1 - t0);
 
 	/*
@@ -765,7 +770,7 @@ static int __run_perf_stat(int argc, const char **argv)
 	return WEXITSTATUS(status);
 }
 
-static int run_perf_stat(int argc, const char **argv)
+static int run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int ret;
 
@@ -778,7 +783,7 @@ static int run_perf_stat(int argc, const char **argv)
 	if (sync_run)
 		sync();
 
-	ret = __run_perf_stat(argc, argv);
+	ret = __run_perf_stat(argc, argv, run_idx);
 	if (ret)
 		return ret;
 
@@ -1741,6 +1746,27 @@ static int get_precision(double num)
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
@@ -1760,6 +1786,9 @@ static void print_footer(void)
 		 */
 		int precision = get_precision(sd) + 2;
 
+		if (walltime_run_table)
+			print_table(output, precision, avg);
+
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
 
@@ -1934,6 +1963,8 @@ static const struct option stat_options[] = {
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
+	OPT_BOOLEAN(0, "table", &walltime_run_table,
+		    "display details about each run (only with -r option)"),
 	OPT_BOOLEAN('n', "null", &null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
@@ -2825,6 +2856,13 @@ int cmd_stat(int argc, const char **argv)
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
@@ -2879,6 +2917,14 @@ int cmd_stat(int argc, const char **argv)
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
@@ -2994,7 +3040,7 @@ int cmd_stat(int argc, const char **argv)
 			fprintf(output, "[ perf stat: executing run #%d ... ]\n",
 				run_idx + 1);
 
-		status = run_perf_stat(argc, argv);
+		status = run_perf_stat(argc, argv, run_idx);
 		if (forever && status != -1) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
@@ -3042,6 +3088,8 @@ int cmd_stat(int argc, const char **argv)
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
2.13.6
