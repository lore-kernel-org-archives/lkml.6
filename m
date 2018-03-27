Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeC0IJN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:09:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:5084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeC0IJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:09:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="38433061"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf stat: avoid 10ms limit for printing event counts
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <8f27e33e-355a-e6f3-30d9-c0fc3ff46c4d@linux.intel.com>
Date: Tue, 27 Mar 2018 11:09:06 +0300
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

This change avoids that limitation and makes perf stat -I possible 
on frequencies up to 1KHz and, to some extent, makes perf stat -I 
to be on-par with perf record sampling profiling.

When running perf stat -I for monitoring e.g. PCIe uncore counters and 
at the same time profiling some I/O workload by perf record e.g. for 
cpu-cycles and context switches, it is then possible to build and 
observe good-enough consolidated CPU/OS/IO(Uncore) performance picture 
for that workload.

The warning on possible runtime overhead is still preserved, however 
it is only visible when specifying -v option.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f5c454855908..316607edd238 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1943,7 +1943,7 @@ static const struct option stat_options[] = {
 	OPT_STRING(0, "post", &post_cmd, "command",
 			"command to run after to the measured command"),
 	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
-		    "print counts at regular interval in ms (>= 10)"),
+		    "print counts at regular interval in ms."),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
@@ -2924,14 +2924,9 @@ int cmd_stat(int argc, const char **argv)
 	}
 
 	if (interval && interval < 100) {
-		if (interval < 10) {
-			pr_err("print interval must be >= 10ms\n");
-			parse_options_usage(stat_usage, stat_options, "I", 1);
-			goto out;
-		} else
-			pr_warning("print interval < 100ms. "
-				   "The overhead percentage could be high in some cases. "
-				   "Please proceed with caution.\n");
+		pr_warning("print interval < 100ms. "
+			   "The overhead percentage could be high in some cases. "
+			   "Please proceed with caution.\n");
 	}
 
 	if (stat_config.times && interval)
