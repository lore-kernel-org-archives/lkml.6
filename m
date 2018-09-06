Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165E42064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165E42064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeIFSM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:12:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:12:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DaQeP309573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:36:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DaQgc309569;
        Thu, 6 Sep 2018 06:36:26 -0700
Date:   Thu, 6 Sep 2018 06:36:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ae2d7da554f0dda837b6639d247665f6df90e41f@git.kernel.org>
Cc:     hpa@zytor.com, dsahern@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, andi@firstfloor.org,
        peterz@infradead.org, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, mingo@kernel.org,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com, peterz@infradead.org,
          andi@firstfloor.org
In-Reply-To: <20180830063252.23729-30-jolsa@kernel.org>
References: <20180830063252.23729-30-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Pass 'struct perf_stat_config' to
 first_shadow_cpu()
Git-Commit-ID: ae2d7da554f0dda837b6639d247665f6df90e41f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ae2d7da554f0dda837b6639d247665f6df90e41f
Gitweb:     https://git.kernel.org/tip/ae2d7da554f0dda837b6639d247665f6df90e41f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:38 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Pass 'struct perf_stat_config' to first_shadow_cpu()

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
