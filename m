Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113CDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00012075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00012075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeIFR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:57:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbeIFR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:57:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DLchZ305846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:21:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DLcAW305843;
        Thu, 6 Sep 2018 06:21:38 -0700
Date:   Thu, 6 Sep 2018 06:21:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-728c0ee0a896fcb0957b496afdb78bf195397645@git.kernel.org>
Cc:     andi@firstfloor.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        acme@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          dsahern@gmail.com, acme@redhat.com, peterz@infradead.org,
          andi@firstfloor.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20180830063252.23729-3-jolsa@kernel.org>
References: <20180830063252.23729-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'initial_delay' to 'struct
 perf_stat_config'
Git-Commit-ID: 728c0ee0a896fcb0957b496afdb78bf195397645
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

Commit-ID:  728c0ee0a896fcb0957b496afdb78bf195397645
Gitweb:     https://git.kernel.org/tip/728c0ee0a896fcb0957b496afdb78bf195397645
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf stat: Move 'initial_delay' to 'struct perf_stat_config'

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
