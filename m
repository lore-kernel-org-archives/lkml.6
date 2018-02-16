Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbeBPTSq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbeBPTSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E820217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/41] perf stat: Add support to print counts after a period of time
Date: Fri, 16 Feb 2018 16:17:15 -0300
Message-Id: <20180216191746.11095-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce a new option to print counts after N milliseconds and update
'perf stat' documentation accordingly.

Show below is the output of the new option for perf stat.

  $ perf stat --time 2000 -e cycles -a
  Performance counter stats for 'system wide':

        157,260,423      cycles

        2.003060766 seconds time elapsed

We can print the count deltas after N milliseconds with this new
introduced option. This option is not supported with "-I" option.

In addition, according to Kangliang's patch(19afd10410957), the
monitoring overhead for system-wide core event could be very high if the
interval-print parameter was below 100ms, and the limitation value is
10ms.

So the same warning will be displayed when the time is set between 10ms
to 100ms, and the minimal time is limited to 10ms. Users can make a
decision according to their spcific cases.

Committer notes:

This actually stops the workload after the specified time, then prints
the counts.

So I renamed the option to --timeout and updated the documentation to
state that it will not just print the counts after the specified time,
but will really stop the 'perf stat' session and print the counts.

The rename from 'time' to 'timeout' also fixes the build in systems
where 'time' is used by glibc and can't be used as a name of a variable,
such as centos:5 and centos:6.

Changes since v3:
- none.

Changes since v2:
- modify the time check in __run_perf_stat func to keep some consistency
  with the workload case.
- add the warning when the time is set between 10ms to 100ms.
- add the pr_err when the time is set below 10ms.

Changes since v1:
- none.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1517217923-8302-3-git-send-email-ufo19890607@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 33 +++++++++++++++++++++++++++++++--
 tools/perf/util/stat.h                 |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 47a21645f60c..2bbe79a50d3c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -151,6 +151,11 @@ Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
 	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
 
+--timeout msecs::
+Stop the 'perf stat' session and print count deltas after N milliseconds (minimum: 10 ms).
+This option is not supported with the "-I" option.
+	example: 'perf stat --time 2000 -e cycles -a'
+
 --metric-only::
 Only print computed metrics. Print them in a single line.
 Don't show any raw values. Not supported with --per-thread.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7d1d7613bf56..2d49eccf98f2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -573,6 +573,7 @@ static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
 	int times = stat_config.times;
+	int timeout = stat_config.timeout;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct perf_evsel *counter;
@@ -586,6 +587,9 @@ static int __run_perf_stat(int argc, const char **argv)
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
 		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
+	} else if (timeout) {
+		ts.tv_sec  = timeout / USEC_PER_MSEC;
+		ts.tv_nsec = (timeout % USEC_PER_MSEC) * NSEC_PER_MSEC;
 	} else {
 		ts.tv_sec  = 1;
 		ts.tv_nsec = 0;
@@ -698,9 +702,11 @@ static int __run_perf_stat(int argc, const char **argv)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval) {
+		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
+				if (timeout)
+					break;
 				process_interval();
 				if (interval_count && !(--times))
 					break;
@@ -720,6 +726,8 @@ static int __run_perf_stat(int argc, const char **argv)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (timeout)
+				break;
 			if (interval) {
 				process_interval();
 				if (interval_count && !(--times))
@@ -1900,6 +1908,8 @@ static const struct option stat_options[] = {
 		    "print counts at regular interval in ms (>= 10)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
+		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
@@ -2697,7 +2707,7 @@ int cmd_stat(int argc, const char **argv)
 	int status = -EINVAL, run_idx;
 	const char *mode;
 	FILE *output = stderr;
-	unsigned int interval;
+	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 
 	setlocale(LC_ALL, "");
@@ -2728,6 +2738,7 @@ int cmd_stat(int argc, const char **argv)
 		return __cmd_report(argc, argv);
 
 	interval = stat_config.interval;
+	timeout = stat_config.timeout;
 
 	/*
 	 * For record command the -o is already taken care of.
@@ -2879,6 +2890,7 @@ int cmd_stat(int argc, const char **argv)
 				   "The overhead percentage could be high in some cases. "
 				   "Please proceed with caution.\n");
 	}
+
 	if (stat_config.times && interval)
 		interval_count = true;
 	else if (stat_config.times && !interval) {
@@ -2889,6 +2901,23 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (timeout && timeout < 100) {
+		if (timeout < 10) {
+			pr_err("timeout must be >= 10ms.\n");
+			parse_options_usage(stat_usage, stat_options, "timeout", 0);
+			goto out;
+		} else
+			pr_warning("timeout < 100ms. "
+				   "The overhead percentage could be high in some cases. "
+				   "Please proceed with caution.\n");
+	}
+	if (timeout && interval) {
+		pr_err("timeout option is not supported with interval-print.\n");
+		parse_options_usage(stat_usage, stat_options, "timeout", 0);
+		parse_options_usage(stat_usage, stat_options, "I", 1);
+		goto out;
+	}
+
 	if (perf_evlist__alloc_stats(evsel_list, interval))
 		goto out;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 540fbb350e53..2f44e386a0e8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,7 @@ struct perf_stat_config {
 	bool		scale;
 	FILE		*output;
 	unsigned int	interval;
+	unsigned int	timeout;
 	int		times;
 	struct runtime_stat *stats;
 	int		stats_num;
-- 
2.14.3
