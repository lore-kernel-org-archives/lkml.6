Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DB720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeH3Kfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:35:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728062AbeH3KeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44D7326352;
        Thu, 30 Aug 2018 06:33:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5D13A9F09;
        Thu, 30 Aug 2018 06:33:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 28/43] perf stat: Move metric_only_len into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:37 +0200
Message-Id: <20180830063252.23729-29-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static metric_only_len into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-brq3qbbb9262ks5f6w8zjm24@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

