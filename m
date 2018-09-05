Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB2FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DD32083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzY1Tw87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DD32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIFCjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E783720867;
        Wed,  5 Sep 2018 22:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185240;
        bh=X0mFrSv378Itl94i53kJsc68tBIXrOJUJlbMsrOfTxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzY1Tw87YNNLAs7UpQh3QH+6pY2cKKk6xqQr/Gg2cCUB5A4oEXuOKhBmoFp0tcbVd
         FwNV/PO43fHgLB/3MeCUKdrEVzRMlrAtSLG7RzwDMIgmbySfF70OTLFOWcDI71YqXo
         SUw5fgfKOys4SaLqzRBXLIxb3Pcco8iy/8H5RpkY=
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
Subject: [PATCH 54/77] perf stat: Pass 'struct perf_stat_config' to first_shadow_cpu()
Date:   Wed,  5 Sep 2018 19:04:17 -0300
Message-Id: <20180905220440.20256-55-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass a 'struct perf_stat_config' arg to first_shadow_cpu(), so that the
function does not depend on the 'perf stat' command object local
'stat_config' variable and can then be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-30-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

