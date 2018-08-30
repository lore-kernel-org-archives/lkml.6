Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC74C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448B320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeH3KeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbeH3KeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 982D47DAC9;
        Thu, 30 Aug 2018 06:33:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34138A9F09;
        Thu, 30 Aug 2018 06:33:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 27/43] perf stat: Move run_count into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:36 +0200
Message-Id: <20180830063252.23729-28-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:39 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static run_count into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-wmmgzikkzqx4k5mqz7xld903@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 39 ++++++++++++++++++++-------------------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 11741f3a8342..1276596840c9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -147,7 +147,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
 #define METRIC_ONLY_LEN 20
 
-static int			run_count			=  1;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -200,6 +199,7 @@ static struct perf_stat_config stat_config = {
 	.aggr_mode	= AGGR_GLOBAL,
 	.scale		= true,
 	.unit_width	= 4, /* strlen("unit") */
+	.run_count	= 1,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -686,7 +686,7 @@ static void print_noise(struct perf_stat_config *config,
 {
 	struct perf_stat_evsel *ps;
 
-	if (run_count == 1)
+	if (config->run_count == 1)
 		return;
 
 	ps = evsel->stats;
@@ -1620,8 +1620,8 @@ static void print_header(struct perf_stat_config *config,
 			fprintf(output, "thread id \'%s", _target->tid);
 
 		fprintf(output, "\'");
-		if (run_count > 1)
-			fprintf(output, " (%d runs)", run_count);
+		if (config->run_count > 1)
+			fprintf(output, " (%d runs)", config->run_count);
 		fprintf(output, ":\n\n");
 	}
 }
@@ -1634,7 +1634,8 @@ static int get_precision(double num)
 	return lround(ceil(-log10(num)));
 }
 
-static void print_table(FILE *output, int precision, double avg)
+static void print_table(struct perf_stat_config *config,
+			FILE *output, int precision, double avg)
 {
 	char tmp[64];
 	int idx, indent = 0;
@@ -1645,7 +1646,7 @@ static void print_table(FILE *output, int precision, double avg)
 
 	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
 
-	for (idx = 0; idx < run_count; idx++) {
+	for (idx = 0; idx < config->run_count; idx++) {
 		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
@@ -1675,7 +1676,7 @@ static void print_footer(struct perf_stat_config *config)
 	if (!null_run)
 		fprintf(output, "\n");
 
-	if (run_count == 1) {
+	if (config->run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
 
 		if (ru_display) {
@@ -1695,7 +1696,7 @@ static void print_footer(struct perf_stat_config *config)
 		int precision = get_precision(sd) + 2;
 
 		if (walltime_run_table)
-			print_table(output, precision, avg);
+			print_table(config, output, precision, avg);
 
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
@@ -1886,7 +1887,7 @@ static const struct option stat_options[] = {
 	OPT_BOOLEAN('c', "scale", &stat_config.scale, "scale/normalize counters"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
-	OPT_INTEGER('r', "repeat", &run_count,
+	OPT_INTEGER('r', "repeat", &stat_config.run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
@@ -2484,7 +2485,7 @@ static int __cmd_record(int argc, const char **argv)
 	if (output_name)
 		data->file.path = output_name;
 
-	if (run_count != 1 || forever) {
+	if (stat_config.run_count != 1 || forever) {
 		pr_err("Cannot use -r option with perf stat record.\n");
 		return -1;
 	}
@@ -2792,12 +2793,12 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (stat_config.metric_only && run_count > 1) {
+	if (stat_config.metric_only && stat_config.run_count > 1) {
 		fprintf(stderr, "--metric-only is not supported with -r\n");
 		goto out;
 	}
 
-	if (walltime_run_table && run_count <= 1) {
+	if (walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		parse_options_usage(NULL, stat_options, "table", 0);
@@ -2853,20 +2854,20 @@ int cmd_stat(int argc, const char **argv)
 	 * Display user/system times only for single
 	 * run and when there's specified tracee.
 	 */
-	if ((run_count == 1) && target__none(&target))
+	if ((stat_config.run_count == 1) && target__none(&target))
 		ru_display = true;
 
-	if (run_count < 0) {
+	if (stat_config.run_count < 0) {
 		pr_err("Run count must be a positive number\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		goto out;
-	} else if (run_count == 0) {
+	} else if (stat_config.run_count == 0) {
 		forever = true;
-		run_count = 1;
+		stat_config.run_count = 1;
 	}
 
 	if (walltime_run_table) {
-		walltime_run = zalloc(run_count * sizeof(walltime_run[0]));
+		walltime_run = zalloc(stat_config.run_count * sizeof(walltime_run[0]));
 		if (!walltime_run) {
 			pr_err("failed to setup -r option");
 			goto out;
@@ -2994,8 +2995,8 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGABRT, skip_signal);
 
 	status = 0;
-	for (run_idx = 0; forever || run_idx < run_count; run_idx++) {
-		if (run_count != 1 && verbose > 0)
+	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
+		if (stat_config.run_count != 1 && verbose > 0)
 			fprintf(output, "[ perf stat: executing run #%d ... ]\n",
 				run_idx + 1);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2dc66e0ba4b8..351a36f5f5b0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -100,6 +100,7 @@ struct perf_stat_config {
 	unsigned int		 initial_delay;
 	unsigned int		 unit_width;
 	int			 times;
+	int			 run_count;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.17.1

