Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D4LmOhddGFsRJQAAmS7hNA
	; Wed, 06 Jun 2018 22:17:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 674D360861; Wed,  6 Jun 2018 22:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DCE74607E4;
	Wed,  6 Jun 2018 22:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCE74607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeFFWRM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:17:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752404AbeFFWP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCE8D8A3CE;
        Wed,  6 Jun 2018 22:15:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 723172026DEF;
        Wed,  6 Jun 2018 22:15:25 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 03/10] perf stat: Add --interval-clear option
Date: Thu,  7 Jun 2018 00:15:06 +0200
Message-Id: <20180606221513.11302-4-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 06 Jun 2018 22:15:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 06 Jun 2018 22:15:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --interval-clear option to clear the screen
before next interval.

Link: http://lkml.kernel.org/n/tip-8zobiwghr6t9f9a4o886cmau@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  3 +++
 tools/perf/builtin-stat.c              | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5dfe102fb5b5..b10a90b6a718 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -178,6 +178,9 @@ Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
 	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
 
+--interval-clear::
+Clear the screen before next interval.
+
 --timeout msecs::
 Stop the 'perf stat' session and print count deltas after N milliseconds (minimum: 10 ms).
 This option is not supported with the "-I" option.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fce46252f89c..067d8b5b2c83 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/tool.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
+#include "util/top.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -173,6 +174,7 @@ static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
+static bool			interval_clear;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -1713,9 +1715,12 @@ static void print_interval(char *prefix, struct timespec *ts)
 	FILE *output = stat_config.output;
 	static int num_print_interval;
 
+	if (interval_clear)
+		puts(CONSOLE_CLEAR);
+
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
 
-	if (num_print_interval == 0 && !csv_output) {
+	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
 		switch (stat_config.aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1747,7 +1752,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if (num_print_interval == 0 && metric_only)
+	if ((num_print_interval == 0 && metric_only) || interval_clear)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -2066,6 +2071,8 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
-- 
2.13.6
