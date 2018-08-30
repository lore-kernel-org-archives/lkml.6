Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3032082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3032082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeH3KeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbeH3KeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8692A7D84D;
        Thu, 30 Aug 2018 06:33:24 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22D1FA9F09;
        Thu, 30 Aug 2018 06:33:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 18/43] perf stat: Pass stat_config argument to local print functions
Date:   Thu, 30 Aug 2018 08:32:27 +0200
Message-Id: <20180830063252.23729-19-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding stat_config argument local print functions, so those
functions could be moved out of stat command to generic object
in following patches.

Link: http://lkml.kernel.org/n/tip-p1yrm9p91j87rx77eqzf5cfk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 149 ++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 69 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f340641fe63a..f56da22abccc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -660,30 +660,33 @@ static int run_perf_stat(int argc, const char **argv, int run_idx)
 	return ret;
 }
 
-static void print_running(u64 run, u64 ena)
+static void print_running(struct perf_stat_config *config,
+			  u64 run, u64 ena)
 {
 	if (csv_output) {
-		fprintf(stat_config.output, "%s%" PRIu64 "%s%.2f",
+		fprintf(config->output, "%s%" PRIu64 "%s%.2f",
 					csv_sep,
 					run,
 					csv_sep,
 					ena ? 100.0 * run / ena : 100.0);
 	} else if (run != ena) {
-		fprintf(stat_config.output, "  (%.2f%%)", 100.0 * run / ena);
+		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
 	}
 }
 
-static void print_noise_pct(double total, double avg)
+static void print_noise_pct(struct perf_stat_config *config,
+			    double total, double avg)
 {
 	double pct = rel_stddev_stats(total, avg);
 
 	if (csv_output)
-		fprintf(stat_config.output, "%s%.2f%%", csv_sep, pct);
+		fprintf(config->output, "%s%.2f%%", csv_sep, pct);
 	else if (pct)
-		fprintf(stat_config.output, "  ( +-%6.2f%% )", pct);
+		fprintf(config->output, "  ( +-%6.2f%% )", pct);
 }
 
-static void print_noise(struct perf_evsel *evsel, double avg)
+static void print_noise(struct perf_stat_config *config,
+			struct perf_evsel *evsel, double avg)
 {
 	struct perf_stat_evsel *ps;
 
@@ -691,7 +694,7 @@ static void print_noise(struct perf_evsel *evsel, double avg)
 		return;
 
 	ps = evsel->stats;
-	print_noise_pct(stddev_stats(&ps->res_stats[0]), avg);
+	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
 }
 
 static void aggr_printout(struct perf_evsel *evsel, int id, int nr)
@@ -987,13 +990,14 @@ static bool is_mixed_hw_group(struct perf_evsel *counter)
 	return false;
 }
 
-static void printout(int id, int nr, struct perf_evsel *counter, double uval,
+static void printout(struct perf_stat_config *config, int id, int nr,
+		     struct perf_evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st)
 {
 	struct perf_stat_output_ctx out;
 	struct outstate os = {
-		.fh = stat_config.output,
+		.fh = config->output,
 		.prefix = prefix ? prefix : "",
 		.id = id,
 		.nr = nr,
@@ -1023,7 +1027,7 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 		pm = print_metric_csv;
 		nl = new_line_csv;
 		os.nfields = 3;
-		os.nfields += aggr_fields[stat_config.aggr_mode];
+		os.nfields += aggr_fields[config->aggr_mode];
 		if (counter->cgrp)
 			os.nfields++;
 	}
@@ -1034,7 +1038,7 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 		}
 		aggr_printout(counter, id, nr);
 
-		fprintf(stat_config.output, "%*s%s",
+		fprintf(config->output, "%*s%s",
 			csv_output ? 0 : 18,
 			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
 			csv_sep);
@@ -1045,22 +1049,22 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 				print_mixed_hw_group_error = 1;
 		}
 
-		fprintf(stat_config.output, "%-*s%s",
+		fprintf(config->output, "%-*s%s",
 			csv_output ? 0 : unit_width,
 			counter->unit, csv_sep);
 
-		fprintf(stat_config.output, "%*s",
+		fprintf(config->output, "%*s",
 			csv_output ? 0 : -25,
 			perf_evsel__name(counter));
 
 		if (counter->cgrp)
-			fprintf(stat_config.output, "%s%s",
+			fprintf(config->output, "%s%s",
 				csv_sep, counter->cgrp->name);
 
 		if (!csv_output)
 			pm(&os, NULL, NULL, "", 0);
-		print_noise(counter, noise);
-		print_running(run, ena);
+		print_noise(config, counter, noise);
+		print_running(config, run, ena);
 		if (csv_output)
 			pm(&os, NULL, NULL, "", 0);
 		return;
@@ -1075,16 +1079,16 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 	out.force_header = false;
 
 	if (csv_output && !metric_only) {
-		print_noise(counter, noise);
-		print_running(run, ena);
+		print_noise(config, counter, noise);
+		print_running(config, run, ena);
 	}
 
 	perf_stat__print_shadow_stats(counter, uval,
 				first_shadow_cpu(counter, id),
 				&out, &metric_events, st);
 	if (!csv_output && !metric_only) {
-		print_noise(counter, noise);
-		print_running(run, ena);
+		print_noise(config, counter, noise);
+		print_running(config, run, ena);
 	}
 }
 
@@ -1211,9 +1215,10 @@ static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
 	}
 }
 
-static void print_aggr(char *prefix)
+static void print_aggr(struct perf_stat_config *config,
+		       char *prefix)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	struct perf_evsel *counter;
 	int s, id, nr;
 	double uval;
@@ -1256,8 +1261,8 @@ static void print_aggr(char *prefix)
 				fprintf(output, "%s", prefix);
 
 			uval = val * counter->scale;
-			printout(id, nr, counter, uval, prefix, run, ena, 1.0,
-				 &rt_stat);
+			printout(config, id, nr, counter, uval, prefix,
+				 run, ena, 1.0, &rt_stat);
 			if (!metric_only)
 				fputc('\n', output);
 		}
@@ -1320,9 +1325,10 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 	return buf;
 }
 
-static void print_aggr_thread(struct perf_evsel *counter, char *prefix)
+static void print_aggr_thread(struct perf_stat_config *config,
+			      struct perf_evsel *counter, char *prefix)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	int nthreads = thread_map__nr(counter->threads);
 	int ncpus = cpu_map__nr(counter->cpus);
 	int thread, sorted_threads, id;
@@ -1339,12 +1345,12 @@ static void print_aggr_thread(struct perf_evsel *counter, char *prefix)
 			fprintf(output, "%s", prefix);
 
 		id = buf[thread].id;
-		if (stat_config.stats)
-			printout(id, 0, buf[thread].counter, buf[thread].uval,
+		if (config->stats)
+			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
 				 prefix, buf[thread].run, buf[thread].ena, 1.0,
-				 &stat_config.stats[id]);
+				 &config->stats[id]);
 		else
-			printout(id, 0, buf[thread].counter, buf[thread].uval,
+			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
 				 prefix, buf[thread].run, buf[thread].ena, 1.0,
 				 &rt_stat);
 		fputc('\n', output);
@@ -1372,9 +1378,10 @@ static void counter_aggr_cb(struct perf_evsel *counter, void *data,
  * Print out the results of a single counter:
  * aggregated counts in system-wide mode
  */
-static void print_counter_aggr(struct perf_evsel *counter, char *prefix)
+static void print_counter_aggr(struct perf_stat_config *config,
+			       struct perf_evsel *counter, char *prefix)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	double uval;
 	struct caggr_data cd = { .avg = 0.0 };
 
@@ -1385,7 +1392,7 @@ static void print_counter_aggr(struct perf_evsel *counter, char *prefix)
 		fprintf(output, "%s", prefix);
 
 	uval = cd.avg * counter->scale;
-	printout(-1, 0, counter, uval, prefix, cd.avg_running, cd.avg_enabled,
+	printout(config, -1, 0, counter, uval, prefix, cd.avg_running, cd.avg_enabled,
 		 cd.avg, &rt_stat);
 	if (!metric_only)
 		fprintf(output, "\n");
@@ -1405,9 +1412,10 @@ static void counter_cb(struct perf_evsel *counter, void *data,
  * Print out the results of a single counter:
  * does not use aggregated count in system-wide
  */
-static void print_counter(struct perf_evsel *counter, char *prefix)
+static void print_counter(struct perf_stat_config *config,
+			  struct perf_evsel *counter, char *prefix)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
 	int cpu;
@@ -1425,14 +1433,15 @@ static void print_counter(struct perf_evsel *counter, char *prefix)
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		printout(cpu, 0, counter, uval, prefix, run, ena, 1.0,
+		printout(config, cpu, 0, counter, uval, prefix, run, ena, 1.0,
 			 &rt_stat);
 
 		fputc('\n', output);
 	}
 }
 
-static void print_no_aggr_metric(char *prefix)
+static void print_no_aggr_metric(struct perf_stat_config *config,
+				 char *prefix)
 {
 	int cpu;
 	int nrcpus = 0;
@@ -1445,7 +1454,7 @@ static void print_no_aggr_metric(char *prefix)
 		bool first = true;
 
 		if (prefix)
-			fputs(prefix, stat_config.output);
+			fputs(prefix, config->output);
 		evlist__for_each_entry(evsel_list, counter) {
 			if (is_duration_time(counter))
 				continue;
@@ -1458,10 +1467,10 @@ static void print_no_aggr_metric(char *prefix)
 			run = perf_counts(counter->counts, cpu, 0)->run;
 
 			uval = val * counter->scale;
-			printout(cpu, 0, counter, uval, prefix, run, ena, 1.0,
+			printout(config, cpu, 0, counter, uval, prefix, run, ena, 1.0,
 				 &rt_stat);
 		}
-		fputc('\n', stat_config.output);
+		fputc('\n', config->output);
 	}
 }
 
@@ -1481,25 +1490,25 @@ static const char *aggr_header_csv[] = {
 	[AGGR_GLOBAL] 	=	""
 };
 
-static void print_metric_headers(const char *prefix, bool no_indent)
+static void print_metric_headers(struct perf_stat_config *config,
+				 const char *prefix, bool no_indent)
 {
 	struct perf_stat_output_ctx out;
 	struct perf_evsel *counter;
 	struct outstate os = {
-		.fh = stat_config.output
+		.fh = config->output
 	};
 
 	if (prefix)
-		fprintf(stat_config.output, "%s", prefix);
+		fprintf(config->output, "%s", prefix);
 
 	if (!csv_output && !no_indent)
-		fprintf(stat_config.output, "%*s",
-			aggr_header_lens[stat_config.aggr_mode], "");
+		fprintf(config->output, "%*s",
+			aggr_header_lens[config->aggr_mode], "");
 	if (csv_output) {
-		if (stat_config.interval)
-			fputs("time,", stat_config.output);
-		fputs(aggr_header_csv[stat_config.aggr_mode],
-			stat_config.output);
+		if (config->interval)
+			fputs("time,", config->output);
+		fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
 
 	/* Print metrics headers only */
@@ -1518,12 +1527,13 @@ static void print_metric_headers(const char *prefix, bool no_indent)
 					      &metric_events,
 					      &rt_stat);
 	}
-	fputc('\n', stat_config.output);
+	fputc('\n', config->output);
 }
 
-static void print_interval(char *prefix, struct timespec *ts)
+static void print_interval(struct perf_stat_config *config,
+			   char *prefix, struct timespec *ts)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	static int num_print_interval;
 
 	if (interval_clear)
@@ -1532,7 +1542,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
 
 	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
-		switch (stat_config.aggr_mode) {
+		switch (config->aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
 			if (!metric_only)
@@ -1564,14 +1574,15 @@ static void print_interval(char *prefix, struct timespec *ts)
 	}
 
 	if ((num_print_interval == 0 || interval_clear) && metric_only)
-		print_metric_headers(" ", true);
+		print_metric_headers(config, " ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
 
-static void print_header(int argc, const char **argv)
+static void print_header(struct perf_stat_config *config,
+			 int argc, const char **argv)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	int i;
 
 	fflush(stdout);
@@ -1639,10 +1650,10 @@ static double timeval2double(struct timeval *t)
 	return t->tv_sec + (double) t->tv_usec/USEC_PER_SEC;
 }
 
-static void print_footer(void)
+static void print_footer(struct perf_stat_config *config)
 {
 	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	int n;
 
 	if (!null_run)
@@ -1673,7 +1684,7 @@ static void print_footer(void)
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
 
-		print_noise_pct(sd, avg);
+		print_noise_pct(config, sd, avg);
 	}
 	fprintf(output, "\n\n");
 
@@ -1703,15 +1714,15 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	char buf[64], *prefix = NULL;
 
 	if (interval)
-		print_interval(prefix = buf, ts);
+		print_interval(config, prefix = buf, ts);
 	else
-		print_header(argc, argv);
+		print_header(config, argc, argv);
 
 	if (metric_only) {
 		static int num_print_iv;
 
 		if (num_print_iv == 0 && !interval)
-			print_metric_headers(prefix, false);
+			print_metric_headers(config, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix)
@@ -1721,32 +1732,32 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
-		print_aggr(prefix);
+		print_aggr(config, prefix);
 		break;
 	case AGGR_THREAD:
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
-			print_aggr_thread(counter, prefix);
+			print_aggr_thread(config, counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
-			print_counter_aggr(counter, prefix);
+			print_counter_aggr(config, counter, prefix);
 		}
 		if (metric_only)
 			fputc('\n', config->output);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-			print_no_aggr_metric(prefix);
+			print_no_aggr_metric(config, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
 					continue;
-				print_counter(counter, prefix);
+				print_counter(config, counter, prefix);
 			}
 		}
 		break;
@@ -1756,7 +1767,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	}
 
 	if (!interval && !csv_output)
-		print_footer();
+		print_footer(config);
 
 	fflush(config->output);
 }
-- 
2.17.1

