Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC39620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH3Kde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeH3Kdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0215D401EF02;
        Thu, 30 Aug 2018 06:32:58 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92F79A9F09;
        Thu, 30 Aug 2018 06:32:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 02/43] perf stat: Move initial_delay into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:11 +0200
Message-Id: <20180830063252.23729-3-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 06:32:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 06:32:58 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static initial_delay into struct perf_stat_config,
so it can be passed around and used outside stat command.

Adding struct perf_stat_config argument into
create_perf_stat_counter function and using its
initial_delay instead of static one.

Link: http://lkml.kernel.org/n/tip-p2k4aymp7lxzqr7jyjcs6z80@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

