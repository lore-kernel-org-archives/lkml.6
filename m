Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeBPTjf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeBPTSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D394217CE
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
Subject: [PATCH 09/41] perf stat: Add support to print counts for fixed times
Date: Fri, 16 Feb 2018 16:17:14 -0300
Message-Id: <20180216191746.11095-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce a new option to print counts for fixed number of times and
update 'perf stat' documentation accordingly.

Show below is the output of the new option for perf stat.

  $ perf stat -I 1000 --interval-count 2 -e cycles -a
  #           time             counts unit events
           1.002827089         93,884,870      cycles
           2.004231506         56,573,446      cycles

We can just print the counts for several times with this newly
introduced option. The usage of it is a little like 'vmstat', and it
should be used together with "-I" option.

  $ vmstat -n 1 2
  procs ---------memory-------------- --swap- ----io-- -system-- ------cpu---
   r  b swpd   free   buff   cache    si   so  bi   bo  in   cs us sy id wa st
   0  0    0 78270544 547484 51732076  0   0   0   20    1    1  1  0 99  0 0
   0  0    0 78270512 547484 51732080  0   0   0   16  477 1555  0  0 100 0 0

Changes since v3:
- merge interval_count check and times check to one line.
- fix the wrong indent in stat.h
- use stat_config.times instead of 'times' in cmd_stat function.

Changes since v2:
- none.

Changes since v1:
- change the name of the new option "times-print" to "interval-count".
- keep the new option interval specifically.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1517217923-8302-2-git-send-email-ufo19890607@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 20 +++++++++++++++++++-
 tools/perf/util/stat.h                 |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 823fce7674bb..47a21645f60c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -146,6 +146,11 @@ Print count deltas every N milliseconds (minimum: 10ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
+--interval-count times::
+Print count deltas for fixed number of times.
+This option should be used together with "-I" option.
+	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
+
 --metric-only::
 Only print computed metrics. Print them in a single line.
 Don't show any raw values. Not supported with --per-thread.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..7d1d7613bf56 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -168,6 +168,7 @@ static struct timespec		ref_time;
 static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
+static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -571,6 +572,7 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
+	int times = stat_config.times;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct perf_evsel *counter;
@@ -700,6 +702,8 @@ static int __run_perf_stat(int argc, const char **argv)
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
 				process_interval();
+				if (interval_count && !(--times))
+					break;
 			}
 		}
 		waitpid(child_pid, &status, 0);
@@ -716,8 +720,11 @@ static int __run_perf_stat(int argc, const char **argv)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
-			if (interval)
+			if (interval) {
 				process_interval();
+				if (interval_count && !(--times))
+					break;
+			}
 		}
 	}
 
@@ -1891,6 +1898,8 @@ static const struct option stat_options[] = {
 			"command to run after to the measured command"),
 	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
 		    "print counts at regular interval in ms (>= 10)"),
+	OPT_INTEGER(0, "interval-count", &stat_config.times,
+		    "print counts for fixed number of times"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
@@ -2870,6 +2879,15 @@ int cmd_stat(int argc, const char **argv)
 				   "The overhead percentage could be high in some cases. "
 				   "Please proceed with caution.\n");
 	}
+	if (stat_config.times && interval)
+		interval_count = true;
+	else if (stat_config.times && !interval) {
+		pr_err("interval-count option should be used together with "
+				"interval-print.\n");
+		parse_options_usage(stat_usage, stat_options, "interval-count", 0);
+		parse_options_usage(stat_usage, stat_options, "I", 1);
+		goto out;
+	}
 
 	if (perf_evlist__alloc_stats(evsel_list, interval))
 		goto out;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index dbc6f7134f61..540fbb350e53 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,7 @@ struct perf_stat_config {
 	bool		scale;
 	FILE		*output;
 	unsigned int	interval;
+	int		times;
 	struct runtime_stat *stats;
 	int		stats_num;
 };
-- 
2.14.3
