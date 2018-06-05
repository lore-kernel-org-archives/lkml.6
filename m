Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFEMNS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:13:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751787AbeFEMNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:13:16 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf stat: Display user and system time
Date: Tue,  5 Jun 2018 14:13:13 +0200
Message-Id: <20180605121313.31337-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the support to read rusage data once the
workload is finished and display the system/user
time values:

  $ perf stat --null ./perf bench sched pipe
  ...

   Performance counter stats for './perf bench sched pipe':

       5.342599256 seconds time elapsed

       2.544434000 seconds user
       4.549691000 seconds sys

It works only in non -r mode and only for workload target.

So as of now, for workload targets, we display 3 types of
timings. The time we meassure in perf stat from enable to
disable+period:

       5.342599256 seconds time elapsed

The time spent in user and system lands, displayed only
for workload session/target:

       2.544434000 seconds user
       4.549691000 seconds sys

Those times are the very same displayed by 'time' tool.
They are returned by wait4 call via the getrusage struct
interface.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Link: http://lkml.kernel.org/n/tip-t8k6d3gs8sz8zqnz3aslk5ro@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++----------
 tools/perf/builtin-stat.c              | 28 +++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3a822f308e6d..5dfe102fb5b5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -310,20 +310,38 @@ Users who wants to get the actual value can apply --no-metric-only.
 EXAMPLES
 --------
 
-$ perf stat -- make -j
+$ perf stat -- make
 
- Performance counter stats for 'make -j':
+   Performance counter stats for 'make':
 
-    8117.370256  task clock ticks     #      11.281 CPU utilization factor
-            678  context switches     #       0.000 M/sec
-            133  CPU migrations       #       0.000 M/sec
-         235724  pagefaults           #       0.029 M/sec
-    24821162526  CPU cycles           #    3057.784 M/sec
-    18687303457  instructions         #    2302.138 M/sec
-      172158895  cache references     #      21.209 M/sec
-       27075259  cache misses         #       3.335 M/sec
+        83723.452481      task-clock:u (msec)       #    1.004 CPUs utilized
+                   0      context-switches:u        #    0.000 K/sec
+                   0      cpu-migrations:u          #    0.000 K/sec
+           3,228,188      page-faults:u             #    0.039 M/sec
+     229,570,665,834      cycles:u                  #    2.742 GHz
+     313,163,853,778      instructions:u            #    1.36  insn per cycle
+      69,704,684,856      branches:u                #  832.559 M/sec
+       2,078,861,393      branch-misses:u           #    2.98% of all branches
 
- Wall-clock time elapsed:   719.554352 msecs
+        83.409183620 seconds time elapsed
+
+        74.684747000 seconds user
+         8.739217000 seconds sys
+
+TIMINGS
+-------
+As displayed in the example above we can display 3 types of timings.
+We always display the time the counters were enabled/alive:
+
+        83.409183620 seconds time elapsed
+
+For workload sessions we also display time the workloads spent in
+user/system lands:
+
+        74.684747000 seconds user
+         8.739217000 seconds sys
+
+Those times are the very same as displayed by the 'time' tool.
 
 CSV FORMAT
 ----------
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a4f662a462c6..100b3c795501 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -80,6 +80,9 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
@@ -175,6 +178,8 @@ static int			output_fd;
 static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
+static bool			ru_display			= false;
+static struct rusage		ru_data;
 
 struct perf_stat {
 	bool			 record;
@@ -726,7 +731,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		waitpid(child_pid, &status, 0);
+		wait4(child_pid, &status, 0, &ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
@@ -1804,6 +1809,11 @@ static void print_table(FILE *output, int precision, double avg)
 	fprintf(output, "\n%*s# Final result:\n", indent, "");
 }
 
+static double timeval2double(struct timeval *t)
+{
+	return t->tv_sec + (double) t->tv_usec/USEC_PER_SEC;
+}
+
 static void print_footer(void)
 {
 	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
@@ -1815,6 +1825,15 @@ static void print_footer(void)
 
 	if (run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
+
+		if (ru_display) {
+			double utime = timeval2double(&ru_data.ru_utime);
+			double stime = timeval2double(&ru_data.ru_stime);
+
+			fprintf(output, "\n\n");
+			fprintf(output, " %17.9f seconds user\n", utime);
+			fprintf(output, " %17.9f seconds sys\n", stime);
+		}
 	} else {
 		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
 		/*
@@ -2950,6 +2969,13 @@ int cmd_stat(int argc, const char **argv)
 
 	setup_system_wide(argc);
 
+	/*
+	 * Display user/system times only for single
+	 * run and when there's specified tracee.
+	 */
+	if ((run_count == 1) && target__none(&target))
+		ru_display = true;
+
 	if (run_count < 0) {
 		pr_err("Run count must be a positive number\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
-- 
2.13.6
