Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8082B20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN8tMmlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8082B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIFCjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeIFCi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C572083E;
        Wed,  5 Sep 2018 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185206;
        bh=Gf3njt0F7lqMy3MeqMoc1V28N714E44FkKbWlHPnvMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hN8tMmlkALKax0yx9qJFJv3+NSKMTh+XsrXsF56nqbRu589IqhO2O6j7xQqm98KzQ
         Y+2ShTOBg1t1CKAwuls0o9fUezleQNN+Eo0I6I5QEcNQJNZB5R4TA4rmClFlleosr/
         734vbp/D/17E+087zrg1MJGI4+1uE6hbJ4tpjx/w=
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
Subject: [PATCH 42/77] perf stat: Add 'struct perf_stat_config' argument to perf_evlist__print_counters()
Date:   Wed,  5 Sep 2018 19:04:05 -0300
Message-Id: <20180905220440.20256-43-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a 'struct perf_stat_config' argument to perf_evlist__print_counters(),
so that it can be moved out of the 'perf stat' command to generic object
in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

