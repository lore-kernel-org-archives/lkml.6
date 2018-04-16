Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDPGmn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:42:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeDPGml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:42:41 -0400
Date: Sun, 15 Apr 2018 23:40:55 -0700
From: tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-9dc9a95f03a69ab926d9ff1986ab2087f34a5dce@git.kernel.org>
Cc: hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        alexey.budankov@linux.intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, peterz@infradead.org, ak@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        alexey.budankov@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, acme@redhat.com
In-Reply-To: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
References: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Enable 1ms interval for printing event
 counters values
Git-Commit-ID: 9dc9a95f03a69ab926d9ff1986ab2087f34a5dce
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

Commit-ID:  9dc9a95f03a69ab926d9ff1986ab2087f34a5dce
Gitweb:     https://git.kernel.org/tip/9dc9a95f03a69ab926d9ff1986ab2087f34a5dce
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 3 Apr 2018 21:18:33 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 09:29:31 -0300

perf stat: Enable 1ms interval for printing event counters values

Currently print count interval for performance counters values is
limited by 10ms so reading the values at frequencies higher than 100Hz
is restricted by the tool.

This change makes perf stat -I possible on frequencies up to 1KHz and,
to some extent, makes perf stat -I to be on-par with perf record
sampling profiling.

When running perf stat -I for monitoring e.g. PCIe uncore counters and
at the same time profiling some I/O workload by perf record e.g. for
cpu-cycles and context switches, it is then possible to observe
consolidated CPU/OS/IO(Uncore) performance picture for that workload.

Tool overhead warning printed when specifying -v option can be missed
due to screen scrolling in case you have output to the console
so message is moved into help available by running perf stat -h.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  2 +-
 tools/perf/builtin-stat.c              | 14 ++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index f15b306be183..e6c3b4e555c2 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -153,7 +153,7 @@ perf stat --repeat 10 --null --sync --pre 'make -s O=defconfig-build/clean' -- m
 
 -I msecs::
 --interval-print msecs::
-Print count deltas every N milliseconds (minimum: 10ms)
+Print count deltas every N milliseconds (minimum: 1ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f5c454855908..147a27e8c937 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1943,7 +1943,8 @@ static const struct option stat_options[] = {
 	OPT_STRING(0, "post", &post_cmd, "command",
 			"command to run after to the measured command"),
 	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
-		    "print counts at regular interval in ms (>= 10)"),
+		    "print counts at regular interval in ms "
+		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
@@ -2923,17 +2924,6 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (interval && interval < 100) {
-		if (interval < 10) {
-			pr_err("print interval must be >= 10ms\n");
-			parse_options_usage(stat_usage, stat_options, "I", 1);
-			goto out;
-		} else
-			pr_warning("print interval < 100ms. "
-				   "The overhead percentage could be high in some cases. "
-				   "Please proceed with caution.\n");
-	}
-
 	if (stat_config.times && interval)
 		interval_count = true;
 	else if (stat_config.times && !interval) {
