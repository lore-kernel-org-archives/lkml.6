Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCDC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F420658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3F420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeH3KeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbeH3KeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E4CD7A7EF;
        Thu, 30 Aug 2018 06:33:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF5BFA9F09;
        Thu, 30 Aug 2018 06:33:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 31/43] perf stat: Add walltime_nsecs_stats pointer into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:40 +0200
Message-Id: <20180830063252.23729-32-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding walltime_nsecs_stats pointer into struct perf_stat_config,
so it can be passed around and used outside stat command.

It's initialized to point to stat's walltime_nsecs_stats value.

Link: http://lkml.kernel.org/n/tip-oxi6iqsmux5m4hmk8k1rwch4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 15 ++++++++-------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2711d8f6e4b8..381549a989b4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -195,11 +195,12 @@ static struct perf_stat		perf_stat;
 static volatile int done = 0;
 
 static struct perf_stat_config stat_config = {
-	.aggr_mode	= AGGR_GLOBAL,
-	.scale		= true,
-	.unit_width	= 4, /* strlen("unit") */
-	.run_count	= 1,
-	.metric_only_len = METRIC_ONLY_LEN,
+	.aggr_mode		= AGGR_GLOBAL,
+	.scale			= true,
+	.unit_width		= 4, /* strlen("unit") */
+	.run_count		= 1,
+	.metric_only_len	= METRIC_ONLY_LEN,
+	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -1671,7 +1672,7 @@ static double timeval2double(struct timeval *t)
 
 static void print_footer(struct perf_stat_config *config)
 {
-	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
 	int n;
 
@@ -1690,7 +1691,7 @@ static void print_footer(struct perf_stat_config *config)
 			fprintf(output, " %17.9f seconds sys\n", ru_stime);
 		}
 	} else {
-		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+		double sd = stddev_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 		/*
 		 * Display at most 2 more significant
 		 * digits than the stddev inaccuracy.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index e70e6d93ee1b..35550e3efd81 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -105,6 +105,7 @@ struct perf_stat_config {
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
+	struct stats		*walltime_nsecs_stats;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

