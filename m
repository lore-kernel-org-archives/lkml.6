Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389E0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19B20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE19B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeH3KeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbeH3KeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7CC087927;
        Thu, 30 Aug 2018 06:33:42 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82369A9F09;
        Thu, 30 Aug 2018 06:33:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 29/43] perf stat: Pass stat_config to first_shadow_cpu
Date:   Thu, 30 Aug 2018 08:32:38 +0200
Message-Id: <20180830063252.23729-30-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing stat_config to first_shadow_cpu, so the function
does not depend on stat command object local stat_config
and can be moved out.

Link: http://lkml.kernel.org/n/tip-x9gryrm7evfb3uybq2pxcix6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e96cef526ef0..f5ac6545af34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -919,17 +919,18 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu(struct perf_evsel *evsel, int id)
+static int first_shadow_cpu(struct perf_stat_config *config,
+			    struct perf_evsel *evsel, int id)
 {
 	int i;
 
 	if (!aggr_get_id)
 		return 0;
 
-	if (stat_config.aggr_mode == AGGR_NONE)
+	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (stat_config.aggr_mode == AGGR_GLOBAL)
+	if (config->aggr_mode == AGGR_GLOBAL)
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
@@ -1090,7 +1091,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(counter, id),
+				first_shadow_cpu(config, counter, id),
 				&out, &metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -1098,7 +1099,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 }
 
-static void aggr_update_shadow(void)
+static void aggr_update_shadow(struct perf_stat_config *config)
 {
 	int cpu, s2, id, s;
 	u64 val;
@@ -1115,7 +1116,7 @@ static void aggr_update_shadow(void)
 				val += perf_counts(counter->counts, cpu, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(counter, id),
+					first_shadow_cpu(config, counter, id),
 					&rt_stat);
 		}
 	}
@@ -1237,7 +1238,7 @@ static void print_aggr(struct perf_stat_config *config,
 	if (!(aggr_map || aggr_get_id))
 		return;
 
-	aggr_update_shadow();
+	aggr_update_shadow(config);
 
 	/*
 	 * With metric_only everything is on a single line.
-- 
2.17.1

