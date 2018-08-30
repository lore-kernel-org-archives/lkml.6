Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1FF20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1FF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeH3Kg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:36:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbeH3KeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F276A7D84D;
        Thu, 30 Aug 2018 06:33:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EFE9A9F09;
        Thu, 30 Aug 2018 06:33:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 20/43] perf stat: Move csv_* into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:29 +0200
Message-Id: <20180830063252.23729-21-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static csv_* fields into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-md7htmdsje3od38k86do4899@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 114 +++++++++++++++++++-------------------
 tools/perf/util/stat.h    |   2 +
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7a3361308e61..4c29e5065e02 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -157,8 +157,6 @@ static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static bool			big_num				=  true;
 static int			big_num_opt			=  -1;
-static const char		*csv_sep			= NULL;
-static bool			csv_output			= false;
 static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
@@ -663,11 +661,11 @@ static int run_perf_stat(int argc, const char **argv, int run_idx)
 static void print_running(struct perf_stat_config *config,
 			  u64 run, u64 ena)
 {
-	if (csv_output) {
+	if (config->csv_output) {
 		fprintf(config->output, "%s%" PRIu64 "%s%.2f",
-					csv_sep,
+					config->csv_sep,
 					run,
-					csv_sep,
+					config->csv_sep,
 					ena ? 100.0 * run / ena : 100.0);
 	} else if (run != ena) {
 		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
@@ -679,8 +677,8 @@ static void print_noise_pct(struct perf_stat_config *config,
 {
 	double pct = rel_stddev_stats(total, avg);
 
-	if (csv_output)
-		fprintf(config->output, "%s%.2f%%", csv_sep, pct);
+	if (config->csv_output)
+		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
 	else if (pct)
 		fprintf(config->output, "  ( +-%6.2f%% )", pct);
 }
@@ -704,34 +702,34 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_CORE:
 		fprintf(config->output, "S%d-C%*d%s%*d%s",
 			cpu_map__id_to_socket(id),
-			csv_output ? 0 : -8,
+			config->csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id),
-			csv_sep,
-			csv_output ? 0 : 4,
+			config->csv_sep,
+			config->csv_output ? 0 : 4,
 			nr,
-			csv_sep);
+			config->csv_sep);
 		break;
 	case AGGR_SOCKET:
 		fprintf(config->output, "S%*d%s%*d%s",
-			csv_output ? 0 : -5,
+			config->csv_output ? 0 : -5,
 			id,
-			csv_sep,
-			csv_output ? 0 : 4,
+			config->csv_sep,
+			config->csv_output ? 0 : 4,
 			nr,
-			csv_sep);
+			config->csv_sep);
 			break;
 	case AGGR_NONE:
 		fprintf(config->output, "CPU%*d%s",
-			csv_output ? 0 : -4,
-			perf_evsel__cpus(evsel)->map[id], csv_sep);
+			config->csv_output ? 0 : -4,
+			perf_evsel__cpus(evsel)->map[id], config->csv_sep);
 		break;
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
-			csv_output ? 0 : 16,
+			config->csv_output ? 0 : 16,
 			thread_map__comm(evsel->threads, id),
-			csv_output ? 0 : -8,
+			config->csv_output ? 0 : -8,
 			thread_map__pid(evsel->threads, id),
-			csv_sep);
+			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_UNSET:
@@ -804,10 +802,10 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 
 	fputc('\n', os->fh);
 	if (os->prefix)
-		fprintf(os->fh, "%s%s", os->prefix, csv_sep);
+		fprintf(os->fh, "%s%s", os->prefix, config->csv_sep);
 	aggr_printout(config, os->evsel, os->id, os->nr);
 	for (i = 0; i < os->nfields; i++)
-		fputs(csv_sep, os->fh);
+		fputs(config->csv_sep, os->fh);
 }
 
 static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
@@ -820,7 +818,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s", csv_sep, csv_sep);
+		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
@@ -830,7 +828,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	*ends = 0;
 	while (isspace(*unit))
 		unit++;
-	fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
+	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, unit);
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
@@ -898,7 +896,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	fprintf(out, "%s%s", vals, csv_sep);
+	fprintf(out, "%s%s", vals, config->csv_sep);
 }
 
 static void new_line_metric(struct perf_stat_config *config __maybe_unused,
@@ -917,8 +915,8 @@ static void print_metric_header(struct perf_stat_config *config __maybe_unused,
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	if (csv_output)
-		fprintf(os->fh, "%s%s", unit, csv_sep);
+	if (config->csv_output)
+		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
 		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
@@ -952,7 +950,7 @@ static void abs_printout(struct perf_stat_config *config,
 	double sc =  evsel->scale;
 	const char *fmt;
 
-	if (csv_output) {
+	if (config->csv_output) {
 		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
 	} else {
 		if (big_num)
@@ -963,17 +961,17 @@ static void abs_printout(struct perf_stat_config *config,
 
 	aggr_printout(config, evsel, id, nr);
 
-	fprintf(output, fmt, avg, csv_sep);
+	fprintf(output, fmt, avg, config->csv_sep);
 
 	if (evsel->unit)
 		fprintf(output, "%-*s%s",
-			csv_output ? 0 : unit_width,
-			evsel->unit, csv_sep);
+			config->csv_output ? 0 : unit_width,
+			evsel->unit, config->csv_sep);
 
-	fprintf(output, "%-*s", csv_output ? 0 : 25, perf_evsel__name(evsel));
+	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
 
 	if (evsel->cgrp)
-		fprintf(output, "%s%s", csv_sep, evsel->cgrp->name);
+		fprintf(output, "%s%s", config->csv_sep, evsel->cgrp->name);
 }
 
 static bool is_mixed_hw_group(struct perf_evsel *counter)
@@ -1018,14 +1016,14 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 
 	if (metric_only) {
 		nl = new_line_metric;
-		if (csv_output)
+		if (config->csv_output)
 			pm = print_metric_only_csv;
 		else
 			pm = print_metric_only;
 	} else
 		nl = new_line_std;
 
-	if (csv_output && !metric_only) {
+	if (config->csv_output && !metric_only) {
 		static int aggr_fields[] = {
 			[AGGR_GLOBAL] = 0,
 			[AGGR_THREAD] = 1,
@@ -1049,9 +1047,9 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		aggr_printout(config, counter, id, nr);
 
 		fprintf(config->output, "%*s%s",
-			csv_output ? 0 : 18,
+			config->csv_output ? 0 : 18,
 			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
-			csv_sep);
+			config->csv_sep);
 
 		if (counter->supported) {
 			print_free_counters_hint = 1;
@@ -1060,22 +1058,22 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		}
 
 		fprintf(config->output, "%-*s%s",
-			csv_output ? 0 : unit_width,
-			counter->unit, csv_sep);
+			config->csv_output ? 0 : unit_width,
+			counter->unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
-			csv_output ? 0 : -25,
+			config->csv_output ? 0 : -25,
 			perf_evsel__name(counter));
 
 		if (counter->cgrp)
 			fprintf(config->output, "%s%s",
-				csv_sep, counter->cgrp->name);
+				config->csv_sep, counter->cgrp->name);
 
-		if (!csv_output)
+		if (!config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
-		if (csv_output)
+		if (config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
@@ -1088,7 +1086,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	out.ctx = &os;
 	out.force_header = false;
 
-	if (csv_output && !metric_only) {
+	if (config->csv_output && !metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -1096,7 +1094,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(counter, id),
 				&out, &metric_events, st);
-	if (!csv_output && !metric_only) {
+	if (!config->csv_output && !metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -1512,10 +1510,10 @@ static void print_metric_headers(struct perf_stat_config *config,
 	if (prefix)
 		fprintf(config->output, "%s", prefix);
 
-	if (!csv_output && !no_indent)
+	if (!config->csv_output && !no_indent)
 		fprintf(config->output, "%*s",
 			aggr_header_lens[config->aggr_mode], "");
-	if (csv_output) {
+	if (config->csv_output) {
 		if (config->interval)
 			fputs("time,", config->output);
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
@@ -1549,9 +1547,9 @@ static void print_interval(struct perf_stat_config *config,
 	if (interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
+	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
-	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
+	if ((num_print_interval == 0 && !config->csv_output) || interval_clear) {
 		switch (config->aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1597,7 +1595,7 @@ static void print_header(struct perf_stat_config *config,
 
 	fflush(stdout);
 
-	if (!csv_output) {
+	if (!config->csv_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
 		if (target.system_wide)
@@ -1776,7 +1774,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	}
 
-	if (!interval && !csv_output)
+	if (!interval && !config->csv_output)
 		print_footer(config);
 
 	fflush(config->output);
@@ -1896,7 +1894,7 @@ static const struct option stat_options[] = {
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
 	OPT_BOOLEAN(0, "no-merge", &no_merge, "Do not merge identical named events"),
-	OPT_STRING('x', "field-separator", &csv_sep, "separator",
+	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
 		     "monitor event in cgroup name only", parse_cgroups),
@@ -2749,12 +2747,12 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__collect_metric_expr(evsel_list);
 	perf_stat__init_shadow_stats();
 
-	if (csv_sep) {
-		csv_output = true;
-		if (!strcmp(csv_sep, "\\t"))
-			csv_sep = "\t";
+	if (stat_config.csv_sep) {
+		stat_config.csv_output = true;
+		if (!strcmp(stat_config.csv_sep, "\\t"))
+			stat_config.csv_sep = "\t";
 	} else
-		csv_sep = DEFAULT_SEPARATOR;
+		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
 	if (argc && !strncmp(argv[0], "rec", 3)) {
 		argc = __cmd_record(argc, argv);
@@ -2827,7 +2825,7 @@ int cmd_stat(int argc, const char **argv)
 	/*
 	 * let the spreadsheet do the pretty-printing
 	 */
-	if (csv_output) {
+	if (stat_config.csv_output) {
 		/* User explicitly passed -B? */
 		if (big_num_opt == 1) {
 			fprintf(stderr, "-B option not supported with -x\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index dffcf2110706..18546d8b0279 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -91,6 +91,7 @@ struct perf_stat_config {
 	bool			 scale;
 	bool			 no_inherit;
 	bool			 identifier;
+	bool			 csv_output;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -98,6 +99,7 @@ struct perf_stat_config {
 	int			 times;
 	struct runtime_stat	*stats;
 	int			 stats_num;
+	const char		*csv_sep;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

