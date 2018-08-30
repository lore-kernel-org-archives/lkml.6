Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A61C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3299720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3299720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeH3Kd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbeH3Kd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D965E401EF02;
        Thu, 30 Aug 2018 06:33:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76955B27A3;
        Thu, 30 Aug 2018 06:33:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 17/43] perf stat: Add stat_config argument to perf_evlist__print_counters
Date:   Thu, 30 Aug 2018 08:32:26 +0200
Message-Id: <20180830063252.23729-18-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 06:33:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 06:33:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding stat_config argument perf_evlist__print_counters,
so the function could be moved out of stat command to
generic object in following patches.

Link: http://lkml.kernel.org/n/tip-spaw3m5jf1o6ycv39j57va1e@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ffbb6594eb6..f340641fe63a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1694,10 +1694,11 @@ static void print_footer(void)
 
 static void
 perf_evlist__print_counters(struct perf_evlist *evlist,
+			    struct perf_stat_config *config,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
-	int interval = stat_config.interval;
+	int interval = config->interval;
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
@@ -1713,11 +1714,11 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_metric_headers(prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (stat_config.aggr_mode == AGGR_GLOBAL && prefix)
-			fprintf(stat_config.output, "%s", prefix);
+		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+			fprintf(config->output, "%s", prefix);
 	}
 
-	switch (stat_config.aggr_mode) {
+	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
 		print_aggr(prefix);
@@ -1736,7 +1737,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_counter_aggr(counter, prefix);
 		}
 		if (metric_only)
-			fputc('\n', stat_config.output);
+			fputc('\n', config->output);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
@@ -1757,7 +1758,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	if (!interval && !csv_output)
 		print_footer();
 
-	fflush(stat_config.output);
+	fflush(config->output);
 }
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
@@ -1766,7 +1767,8 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
 
-	perf_evlist__print_counters(evsel_list, ts, argc, argv);
+	perf_evlist__print_counters(evsel_list, &stat_config,
+				    ts, argc, argv);
 }
 
 static volatile int signr = -1;
-- 
2.17.1

