Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C659CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45F2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D45F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeIFSIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:08:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41067 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:08:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DWR6p308815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:32:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DWQrw308812;
        Thu, 6 Sep 2018 06:32:26 -0700
Date:   Thu, 6 Sep 2018 06:32:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0ce5aa0266604c77ee64882b70c980e843629177@git.kernel.org>
Cc:     peterz@infradead.org, andi@firstfloor.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          andi@firstfloor.org, peterz@infradead.org, acme@redhat.com,
          hpa@zytor.com, dsahern@gmail.com, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180830063252.23729-23-jolsa@kernel.org>
References: <20180830063252.23729-23-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'metric_only' to 'struct
 perf_stat_config'
Git-Commit-ID: 0ce5aa0266604c77ee64882b70c980e843629177
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

Commit-ID:  0ce5aa0266604c77ee64882b70c980e843629177
Gitweb:     https://git.kernel.org/tip/0ce5aa0266604c77ee64882b70c980e843629177
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:31 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Move 'metric_only' to 'struct perf_stat_config'

Move the static 'metric_only' variable to 'struct perf_stat_config', so
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
