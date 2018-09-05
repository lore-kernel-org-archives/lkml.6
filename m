Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBDAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F33020861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY7xT7mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F33020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeIFCiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeIFCiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB942083D;
        Wed,  5 Sep 2018 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185164;
        bh=25N4pgeHbET0RFZc5MyyCHZe+bwDu+ZRHpoxVzTwOuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iY7xT7mEolQvGeLlkXoQoInPa5Y378judqeb3Q/ccfM+T1EKN6suyG0bYhA1KCLdQ
         7WkG403vOCeuRn/x2jdVECTd3abpmboa6pgQjbeiTrz90prr0wN6vLC+4tR3LAEXLJ
         4UwQamjKVGc+QbchLdLfjd8/ao9gBXIp4wYOu720=
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
Subject: [PATCH 27/77] perf stat: Move 'initial_delay' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:03:50 -0300
Message-Id: <20180905220440.20256-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'initial_delay' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Add 'struct perf_stat_config' argument to create_perf_stat_counter() and
use its 'initial_delay' member instead of the static one.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 16 ++++++++--------
 tools/perf/util/stat.h    | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d389ed623715..719abdd3b7de 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,7 +164,6 @@ static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
-static unsigned int		initial_delay			= 0;
 static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
 static bool			metric_only			= false;
@@ -236,7 +235,8 @@ static void perf_stat__reset_stats(void)
 		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
-static int create_perf_stat_counter(struct perf_evsel *evsel)
+static int create_perf_stat_counter(struct perf_evsel *evsel,
+				    struct perf_stat_config *config)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	struct perf_evsel *leader = evsel->leader;
@@ -286,7 +286,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 		 * In case of initial_delay we enable tracee
 		 * events manually.
 		 */
-		if (target__none(&target) && !initial_delay)
+		if (target__none(&target) && !config->initial_delay)
 			attr->enable_on_exec = 1;
 	}
 
@@ -428,15 +428,15 @@ static void process_interval(void)
 
 static void enable_counters(void)
 {
-	if (initial_delay)
-		usleep(initial_delay * USEC_PER_MSEC);
+	if (stat_config.initial_delay)
+		usleep(stat_config.initial_delay * USEC_PER_MSEC);
 
 	/*
 	 * We need to enable counters only if:
 	 * - we don't have tracee (attaching to task or cpu)
 	 * - we have initial delay configured
 	 */
-	if (!target__none(&target) || initial_delay)
+	if (!target__none(&target) || stat_config.initial_delay)
 		perf_evlist__enable(evsel_list);
 }
 
@@ -609,7 +609,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	evlist__for_each_entry(evsel_list, counter) {
 try_again:
-		if (create_perf_stat_counter(counter) < 0) {
+		if (create_perf_stat_counter(counter, &stat_config) < 0) {
 
 			/* Weak group failed. Reset the group. */
 			if ((errno == EINVAL || errno == EBADF) &&
@@ -2027,7 +2027,7 @@ static const struct option stat_options[] = {
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
 		     "aggregate counts per thread", AGGR_THREAD),
-	OPT_UINTEGER('D', "delay", &initial_delay,
+	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
 		     "ms to wait before starting measurement after program start"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 36efb986f7fc..91e6609fce6e 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include "xyarray.h"
 #include "rblist.h"
+#include "perf.h"
 
 struct stats {
 	double n, mean, M2;
@@ -85,14 +86,15 @@ struct runtime_stat {
 };
 
 struct perf_stat_config {
-	enum aggr_mode	aggr_mode;
-	bool		scale;
-	FILE		*output;
-	unsigned int	interval;
-	unsigned int	timeout;
-	int		times;
-	struct runtime_stat *stats;
-	int		stats_num;
+	enum aggr_mode		 aggr_mode;
+	bool			 scale;
+	FILE			*output;
+	unsigned int		 interval;
+	unsigned int		 timeout;
+	unsigned int		 initial_delay;
+	int			 times;
+	struct runtime_stat	*stats;
+	int			 stats_num;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4

