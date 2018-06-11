Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19A9BC16ABE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF812208B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z79EyEDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF812208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFKRsr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbeFKRso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:48:44 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5DF208B0;
        Mon, 11 Jun 2018 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739324;
        bh=iw1rhLyjbmQRgAtZr4gynrtCkLtwLwo0aA5+yl6N5cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z79EyEDZsp0I+ugoi2I0xpeVwC/u4DEYeZ9jBqsESFLIbhvINVUxlMBQqabRocfT3
         LNRwC5TLR9uKHUlg3HNitan2dZ/5yACOZNvPbWU8NpeTQq1LDuqfJgnxm7A/EnfPH6
         drl704RbjHOpWWpxNTW1BWoGHnMOWyTaaX9qaAUY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/12] perf stat: Add --interval-clear option
Date:   Mon, 11 Jun 2018 14:48:04 -0300
Message-Id: <20180611174810.14815-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding --interval-clear option to clear the screen before next interval.

Committer testing:

  # perf stat -I 1000 --interval-clear

And, as expected, it behaves almost like:

  # watch -n 0 perf stat -a sleep 1

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 096ccb25c11f..f1532e3ac7d7 100644
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
@@ -1704,9 +1706,12 @@ static void print_interval(char *prefix, struct timespec *ts)
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
@@ -1738,7 +1743,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if (num_print_interval == 0 && metric_only)
+	if ((num_print_interval == 0 && metric_only) || interval_clear)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -2057,6 +2062,8 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
-- 
2.14.3

