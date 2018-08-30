Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2972082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2972082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeH3KeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeH3KeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CA8F87A70;
        Thu, 30 Aug 2018 06:33:31 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCC47A9F09;
        Thu, 30 Aug 2018 06:33:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 22/43] perf stat: Move metric_only into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:31 +0200
Message-Id: <20180830063252.23729-23-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static metric_only into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-tevvpgyi3o7ok34nx0oi05gu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 29 ++++++++++++++++-------------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 89297ab77d21..397cb4f28d7f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -163,7 +163,6 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
-static bool			metric_only			= false;
 static bool			force_metric_only		= false;
 static bool			no_merge			= false;
 static bool			walltime_run_table		= false;
@@ -1013,7 +1012,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	print_metric_t pm = print_metric_std;
 	new_line_t nl;
 
-	if (metric_only) {
+	if (config->metric_only) {
 		nl = new_line_metric;
 		if (config->csv_output)
 			pm = print_metric_only_csv;
@@ -1022,7 +1021,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	} else
 		nl = new_line_std;
 
-	if (config->csv_output && !metric_only) {
+	if (config->csv_output && !config->metric_only) {
 		static int aggr_fields[] = {
 			[AGGR_GLOBAL] = 0,
 			[AGGR_THREAD] = 1,
@@ -1039,7 +1038,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			os.nfields++;
 	}
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
-		if (metric_only) {
+		if (config->metric_only) {
 			pm(config, &os, NULL, "", "", 0);
 			return;
 		}
@@ -1077,7 +1076,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		return;
 	}
 
-	if (!metric_only)
+	if (!config->metric_only)
 		abs_printout(config, id, nr, counter, uval);
 
 	out.print_metric = pm;
@@ -1085,7 +1084,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	out.ctx = &os;
 	out.force_header = false;
 
-	if (config->csv_output && !metric_only) {
+	if (config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -1093,7 +1092,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(counter, id),
 				&out, &metric_events, st);
-	if (!config->csv_output && !metric_only) {
+	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -1225,6 +1224,7 @@ static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
 static void print_aggr(struct perf_stat_config *config,
 		       char *prefix)
 {
+	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	struct perf_evsel *counter;
 	int s, id, nr;
@@ -1388,6 +1388,7 @@ static void counter_aggr_cb(struct perf_evsel *counter, void *data,
 static void print_counter_aggr(struct perf_stat_config *config,
 			       struct perf_evsel *counter, char *prefix)
 {
+	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	double uval;
 	struct caggr_data cd = { .avg = 0.0 };
@@ -1540,6 +1541,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 static void print_interval(struct perf_stat_config *config,
 			   char *prefix, struct timespec *ts)
 {
+	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	static int num_print_interval;
 
@@ -1716,6 +1718,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
+	bool metric_only = config->metric_only;
 	int interval = config->interval;
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
@@ -1843,7 +1846,7 @@ static int enable_metric_only(const struct option *opt __maybe_unused,
 			      const char *s __maybe_unused, int unset)
 {
 	force_metric_only = true;
-	metric_only = !unset;
+	stat_config.metric_only = !unset;
 	return 0;
 }
 
@@ -1922,7 +1925,7 @@ static const struct option stat_options[] = {
 		     "aggregate counts per thread", AGGR_THREAD),
 	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
 		     "ms to wait before starting measurement after program start"),
-	OPT_CALLBACK_NOOPT(0, "metric-only", &metric_only, NULL,
+	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure topdown level 1 statistics"),
@@ -2345,7 +2348,7 @@ static int add_default_attributes(void)
 		if (pmu_have_event("msr", "aperf") &&
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
-				metric_only = true;
+				stat_config.metric_only = true;
 			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
@@ -2376,7 +2379,7 @@ static int add_default_attributes(void)
 		}
 
 		if (!force_metric_only)
-			metric_only = true;
+			stat_config.metric_only = true;
 		if (topdown_filter_events(topdown_attrs, &str,
 				arch_topdown_check_group(&warn)) < 0) {
 			pr_err("Out of memory\n");
@@ -2776,12 +2779,12 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (metric_only && stat_config.aggr_mode == AGGR_THREAD) {
+	if (stat_config.metric_only && stat_config.aggr_mode == AGGR_THREAD) {
 		fprintf(stderr, "--metric-only is not supported with --per-thread\n");
 		goto out;
 	}
 
-	if (metric_only && run_count > 1) {
+	if (stat_config.metric_only && run_count > 1) {
 		fprintf(stderr, "--metric-only is not supported with -r\n");
 		goto out;
 	}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 470ab37601be..da838182b99c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -93,6 +93,7 @@ struct perf_stat_config {
 	bool			 identifier;
 	bool			 csv_output;
 	bool			 interval_clear;
+	bool			 metric_only;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

