Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359F2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCKK0O22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0359F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeIFCja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF0620857;
        Wed,  5 Sep 2018 22:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185237;
        bh=VIqtUgiBUVvXRmVpjFvp36MHI/D6vgj9CYKLQjQedjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCKK0O22pdCNPrQM+Hj09JBb2N/YCcKrpH4cbN4vvjVz2Rx42YxYTSVciAgxJGXV+
         2p/8dFgDbuhbC2dhAmBz4/VqbQu0FPW8PgPkGVHRCNQFpOI5PWjCDb5Z1zw9i/hvpx
         419MxKqmj80t129vVZx+sQonvY3rLYv0gcY5bpK4=
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
Subject: [PATCH 53/77] perf stat: Move 'metric_only_len' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:16 -0300
Message-Id: <20180905220440.20256-54-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'metric_only_len' variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-29-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 +++++-----
 tools/perf/util/stat.h    |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1276596840c9..e96cef526ef0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -176,7 +176,6 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
-static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -200,6 +199,7 @@ static struct perf_stat_config stat_config = {
 	.scale		= true,
 	.unit_width	= 4, /* strlen("unit") */
 	.run_count	= 1,
+	.metric_only_len = METRIC_ONLY_LEN,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -854,14 +854,14 @@ static const char *fixunit(char *buf, struct perf_evsel *evsel,
 	return unit;
 }
 
-static void print_metric_only(struct perf_stat_config *config __maybe_unused,
+static void print_metric_only(struct perf_stat_config *config,
 			      void *ctx, const char *color, const char *fmt,
 			      const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = metric_only_len;
+	unsigned mlen = config->metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
@@ -902,7 +902,7 @@ static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 {
 }
 
-static void print_metric_header(struct perf_stat_config *config __maybe_unused,
+static void print_metric_header(struct perf_stat_config *config,
 				void *ctx, const char *color __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
@@ -916,7 +916,7 @@ static void print_metric_header(struct perf_stat_config *config __maybe_unused,
 	if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
-		fprintf(os->fh, "%*s ", metric_only_len, unit);
+		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
 static int first_shadow_cpu(struct perf_evsel *evsel, int id)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 351a36f5f5b0..e70e6d93ee1b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -99,6 +99,7 @@ struct perf_stat_config {
 	unsigned int		 timeout;
 	unsigned int		 initial_delay;
 	unsigned int		 unit_width;
+	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
 	struct runtime_stat	*stats;
-- 
2.14.4

