Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDCSSj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:18:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:22640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752814AbeDCSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:18:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="43105562"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Subject: [PATCH v2] perf stat: enable 1ms interval for printing event counters
 values
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
Date: Tue, 3 Apr 2018 21:18:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
---

Changes in v2:
 - updated minimum value to 1ms at perf-stat.txt manual

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
