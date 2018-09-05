Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78478C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA120861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuDPJTn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAA120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeIFCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBD62083D;
        Wed,  5 Sep 2018 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185245;
        bh=lQo9ysQgUgAMdDiLSv0M/0ig8TxFwd4EHAgWakgbEHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuDPJTn8eL0qvCAS9tm5aCRaqVj0tm+f/uxAwsSdUYny6+hWbkJ5ytZZbY04qHRO7
         OLyUZTcxXZiaKsg+dZGgVOPHrPWbxz55+3MLTTfzbnT5W1GRFATaNxBcPwVsEP3Q9v
         nJFEeyZBlykhDMN+I3jLFVaCUWZZWoew05KeS7wE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 56/77] perf stat: Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:19 -0300
Message-Id: <20180905220440.20256-57-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config', so that
it can be passed around and used outside the 'perf stat' command.

It's initialized to point to stat's walltime_nsecs_stats value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

