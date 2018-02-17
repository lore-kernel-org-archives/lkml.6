Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeBQLeR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:34:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBQLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:34:13 -0500
Date: Sat, 17 Feb 2018 03:23:30 -0800
From: tip-bot for yuzhoujian <tipbot@zytor.com>
Message-ID: <tip-db06a269ecbb1d71d534fc5713624eeeee0b8f92@git.kernel.org>
Cc: yuzhoujian@didichuxing.com, linux-kernel@vger.kernel.org,
        kan.liang@intel.com, wangnan0@huawei.com, dsahern@gmail.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, acme@redhat.com, hpa@zytor.com,
        milian.wolff@kdab.com, adrian.hunter@intel.com, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, milian.wolff@kdab.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, yuzhoujian@didichuxing.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, kan.liang@intel.com,
        dsahern@gmail.com, mingo@kernel.org
In-Reply-To: <1517217923-8302-2-git-send-email-ufo19890607@gmail.com>
References: <1517217923-8302-2-git-send-email-ufo19890607@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add support to print counts for fixed
 times
Git-Commit-ID: db06a269ecbb1d71d534fc5713624eeeee0b8f92
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

Commit-ID:  db06a269ecbb1d71d534fc5713624eeeee0b8f92
Gitweb:     https://git.kernel.org/tip/db06a269ecbb1d71d534fc5713624eeeee0b8f92
Author:     yuzhoujian <yuzhoujian@didichuxing.com>
AuthorDate: Mon, 29 Jan 2018 10:25:22 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:24 -0300

perf stat: Add support to print counts for fixed times

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
index 823fce7..47a2164 100644
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
index 98bf9d3..7d1d761 100644
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
@@ -700,6 +702,8 @@ try_again:
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
 				process_interval();
+				if (interval_count && !(--times))
+					break;
 			}
 		}
 		waitpid(child_pid, &status, 0);
@@ -716,8 +720,11 @@ try_again:
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
index dbc6f71..540fbb3 100644
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
