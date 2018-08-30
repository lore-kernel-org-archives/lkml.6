Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B346C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21752082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21752082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeH3KeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeH3KeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 512F687927;
        Thu, 30 Aug 2018 06:33:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3F4DB27A3;
        Thu, 30 Aug 2018 06:33:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 19/43] perf stat: Pass stat_config argument to global print functions
Date:   Thu, 30 Aug 2018 08:32:28 +0200
Message-Id: <20180830063252.23729-20-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding stat_config argument global print functions, so those
functions could be used out of the stat command code.

Link: http://lkml.kernel.org/n/tip-p1yrm9p91j87rx77eqzf5cfk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c   |   8 +-
 tools/perf/builtin-stat.c     |  74 +++++++++--------
 tools/perf/util/stat-shadow.c | 147 ++++++++++++++++++----------------
 tools/perf/util/stat.h        |   8 +-
 4 files changed, 131 insertions(+), 106 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ba481d73f910..6176bae177c2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1544,7 +1544,8 @@ struct metric_ctx {
 	FILE 			*fp;
 };
 
-static void script_print_metric(void *ctx, const char *color,
+static void script_print_metric(struct perf_stat_config *config __maybe_unused,
+				void *ctx, const char *color,
 			        const char *fmt,
 			        const char *unit, double val)
 {
@@ -1562,7 +1563,8 @@ static void script_print_metric(void *ctx, const char *color,
 	fprintf(mctx->fp, " %s\n", unit);
 }
 
-static void script_new_line(void *ctx)
+static void script_new_line(struct perf_stat_config *config __maybe_unused,
+			    void *ctx)
 {
 	struct metric_ctx *mctx = ctx;
 
@@ -1608,7 +1610,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	evsel_script(evsel)->val = val;
 	if (evsel_script(evsel->leader)->gnum == evsel->leader->nr_members) {
 		for_each_group_member (ev2, evsel->leader) {
-			perf_stat__print_shadow_stats(ev2,
+			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
 						      sample->cpu,
 						      &ctx,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f56da22abccc..7a3361308e61 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -697,11 +697,12 @@ static void print_noise(struct perf_stat_config *config,
 	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
 }
 
-static void aggr_printout(struct perf_evsel *evsel, int id, int nr)
+static void aggr_printout(struct perf_stat_config *config,
+			  struct perf_evsel *evsel, int id, int nr)
 {
-	switch (stat_config.aggr_mode) {
+	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(stat_config.output, "S%d-C%*d%s%*d%s",
+		fprintf(config->output, "S%d-C%*d%s%*d%s",
 			cpu_map__id_to_socket(id),
 			csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id),
@@ -711,7 +712,7 @@ static void aggr_printout(struct perf_evsel *evsel, int id, int nr)
 			csv_sep);
 		break;
 	case AGGR_SOCKET:
-		fprintf(stat_config.output, "S%*d%s%*d%s",
+		fprintf(config->output, "S%*d%s%*d%s",
 			csv_output ? 0 : -5,
 			id,
 			csv_sep,
@@ -720,12 +721,12 @@ static void aggr_printout(struct perf_evsel *evsel, int id, int nr)
 			csv_sep);
 			break;
 	case AGGR_NONE:
-		fprintf(stat_config.output, "CPU%*d%s",
+		fprintf(config->output, "CPU%*d%s",
 			csv_output ? 0 : -4,
 			perf_evsel__cpus(evsel)->map[id], csv_sep);
 		break;
 	case AGGR_THREAD:
-		fprintf(stat_config.output, "%*s-%*d%s",
+		fprintf(config->output, "%*s-%*d%s",
 			csv_output ? 0 : 16,
 			thread_map__comm(evsel->threads, id),
 			csv_output ? 0 : -8,
@@ -750,24 +751,27 @@ struct outstate {
 
 #define METRIC_LEN  35
 
-static void new_line_std(void *ctx)
+static void new_line_std(struct perf_stat_config *config __maybe_unused,
+			 void *ctx)
 {
 	struct outstate *os = ctx;
 
 	os->newline = true;
 }
 
-static void do_new_line_std(struct outstate *os)
+static void do_new_line_std(struct perf_stat_config *config,
+			    struct outstate *os)
 {
 	fputc('\n', os->fh);
 	fputs(os->prefix, os->fh);
-	aggr_printout(os->evsel, os->id, os->nr);
-	if (stat_config.aggr_mode == AGGR_NONE)
+	aggr_printout(config, os->evsel, os->id, os->nr);
+	if (config->aggr_mode == AGGR_NONE)
 		fprintf(os->fh, "        ");
 	fprintf(os->fh, "                                                 ");
 }
 
-static void print_metric_std(void *ctx, const char *color, const char *fmt,
+static void print_metric_std(struct perf_stat_config *config,
+			     void *ctx, const char *color, const char *fmt,
 			     const char *unit, double val)
 {
 	struct outstate *os = ctx;
@@ -783,7 +787,7 @@ static void print_metric_std(void *ctx, const char *color, const char *fmt,
 	}
 
 	if (newline)
-		do_new_line_std(os);
+		do_new_line_std(config, os);
 
 	n = fprintf(out, " # ");
 	if (color)
@@ -793,7 +797,7 @@ static void print_metric_std(void *ctx, const char *color, const char *fmt,
 	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
 }
 
-static void new_line_csv(void *ctx)
+static void new_line_csv(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
 	int i;
@@ -801,12 +805,13 @@ static void new_line_csv(void *ctx)
 	fputc('\n', os->fh);
 	if (os->prefix)
 		fprintf(os->fh, "%s%s", os->prefix, csv_sep);
-	aggr_printout(os->evsel, os->id, os->nr);
+	aggr_printout(config, os->evsel, os->id, os->nr);
 	for (i = 0; i < os->nfields; i++)
 		fputs(csv_sep, os->fh);
 }
 
-static void print_metric_csv(void *ctx,
+static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
+			     void *ctx,
 			     const char *color __maybe_unused,
 			     const char *fmt, const char *unit, double val)
 {
@@ -853,7 +858,8 @@ static const char *fixunit(char *buf, struct perf_evsel *evsel,
 	return unit;
 }
 
-static void print_metric_only(void *ctx, const char *color, const char *fmt,
+static void print_metric_only(struct perf_stat_config *config __maybe_unused,
+			      void *ctx, const char *color, const char *fmt,
 			      const char *unit, double val)
 {
 	struct outstate *os = ctx;
@@ -874,7 +880,8 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	fprintf(out, "%*s ", mlen, str);
 }
 
-static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
+static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
+				  void *ctx, const char *color __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -894,11 +901,13 @@ static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
 	fprintf(out, "%s%s", vals, csv_sep);
 }
 
-static void new_line_metric(void *ctx __maybe_unused)
+static void new_line_metric(struct perf_stat_config *config __maybe_unused,
+			    void *ctx __maybe_unused)
 {
 }
 
-static void print_metric_header(void *ctx, const char *color __maybe_unused,
+static void print_metric_header(struct perf_stat_config *config __maybe_unused,
+				void *ctx, const char *color __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
 {
@@ -936,9 +945,10 @@ static int first_shadow_cpu(struct perf_evsel *evsel, int id)
 	return 0;
 }
 
-static void abs_printout(int id, int nr, struct perf_evsel *evsel, double avg)
+static void abs_printout(struct perf_stat_config *config,
+			 int id, int nr, struct perf_evsel *evsel, double avg)
 {
-	FILE *output = stat_config.output;
+	FILE *output = config->output;
 	double sc =  evsel->scale;
 	const char *fmt;
 
@@ -951,7 +961,7 @@ static void abs_printout(int id, int nr, struct perf_evsel *evsel, double avg)
 			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
 	}
 
-	aggr_printout(evsel, id, nr);
+	aggr_printout(config, evsel, id, nr);
 
 	fprintf(output, fmt, avg, csv_sep);
 
@@ -1004,7 +1014,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		.evsel = counter,
 	};
 	print_metric_t pm = print_metric_std;
-	void (*nl)(void *);
+	new_line_t nl;
 
 	if (metric_only) {
 		nl = new_line_metric;
@@ -1033,10 +1043,10 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (metric_only) {
-			pm(&os, NULL, "", "", 0);
+			pm(config, &os, NULL, "", "", 0);
 			return;
 		}
-		aggr_printout(counter, id, nr);
+		aggr_printout(config, counter, id, nr);
 
 		fprintf(config->output, "%*s%s",
 			csv_output ? 0 : 18,
@@ -1062,16 +1072,16 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 				csv_sep, counter->cgrp->name);
 
 		if (!csv_output)
-			pm(&os, NULL, NULL, "", 0);
+			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 		if (csv_output)
-			pm(&os, NULL, NULL, "", 0);
+			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
 
 	if (!metric_only)
-		abs_printout(id, nr, counter, uval);
+		abs_printout(config, id, nr, counter, uval);
 
 	out.print_metric = pm;
 	out.new_line = nl;
@@ -1083,7 +1093,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		print_running(config, run, ena);
 	}
 
-	perf_stat__print_shadow_stats(counter, uval,
+	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(counter, id),
 				&out, &metric_events, st);
 	if (!csv_output && !metric_only) {
@@ -1255,7 +1265,7 @@ static void print_aggr(struct perf_stat_config *config,
 			val = ad.val;
 			if (first && metric_only) {
 				first = false;
-				aggr_printout(counter, id, nr);
+				aggr_printout(config, counter, id, nr);
 			}
 			if (prefix && !metric_only)
 				fprintf(output, "%s", prefix);
@@ -1459,7 +1469,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			if (is_duration_time(counter))
 				continue;
 			if (first) {
-				aggr_printout(counter, cpu, 0);
+				aggr_printout(config, counter, cpu, 0);
 				first = false;
 			}
 			val = perf_counts(counter->counts, cpu, 0)->val;
@@ -1521,7 +1531,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 		out.new_line = new_line_metric;
 		out.force_header = true;
 		os.evsel = counter;
-		perf_stat__print_shadow_stats(counter, 0,
+		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
 					      &metric_events,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 99990f5f2512..8ad32763cfff 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -410,7 +410,8 @@ static double runtime_stat_n(struct runtime_stat *st,
 	return v->stats.n;
 }
 
-static void print_stalled_cycles_frontend(int cpu,
+static void print_stalled_cycles_frontend(struct perf_stat_config *config,
+					  int cpu,
 					  struct perf_evsel *evsel, double avg,
 					  struct perf_stat_output_ctx *out,
 					  struct runtime_stat *st)
@@ -427,13 +428,14 @@ static void print_stalled_cycles_frontend(int cpu,
 	color = get_ratio_color(GRC_STALLED_CYCLES_FE, ratio);
 
 	if (ratio)
-		out->print_metric(out->ctx, color, "%7.2f%%", "frontend cycles idle",
+		out->print_metric(config, out->ctx, color, "%7.2f%%", "frontend cycles idle",
 				  ratio);
 	else
-		out->print_metric(out->ctx, NULL, NULL, "frontend cycles idle", 0);
+		out->print_metric(config, out->ctx, NULL, NULL, "frontend cycles idle", 0);
 }
 
-static void print_stalled_cycles_backend(int cpu,
+static void print_stalled_cycles_backend(struct perf_stat_config *config,
+					 int cpu,
 					 struct perf_evsel *evsel, double avg,
 					 struct perf_stat_output_ctx *out,
 					 struct runtime_stat *st)
@@ -449,10 +451,11 @@ static void print_stalled_cycles_backend(int cpu,
 
 	color = get_ratio_color(GRC_STALLED_CYCLES_BE, ratio);
 
-	out->print_metric(out->ctx, color, "%7.2f%%", "backend cycles idle", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "backend cycles idle", ratio);
 }
 
-static void print_branch_misses(int cpu,
+static void print_branch_misses(struct perf_stat_config *config,
+				int cpu,
 				struct perf_evsel *evsel,
 				double avg,
 				struct perf_stat_output_ctx *out,
@@ -469,10 +472,11 @@ static void print_branch_misses(int cpu,
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
 
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all branches", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all branches", ratio);
 }
 
-static void print_l1_dcache_misses(int cpu,
+static void print_l1_dcache_misses(struct perf_stat_config *config,
+				   int cpu,
 				   struct perf_evsel *evsel,
 				   double avg,
 				   struct perf_stat_output_ctx *out,
@@ -490,10 +494,11 @@ static void print_l1_dcache_misses(int cpu,
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
 
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
 }
 
-static void print_l1_icache_misses(int cpu,
+static void print_l1_icache_misses(struct perf_stat_config *config,
+				   int cpu,
 				   struct perf_evsel *evsel,
 				   double avg,
 				   struct perf_stat_output_ctx *out,
@@ -510,10 +515,11 @@ static void print_l1_icache_misses(int cpu,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
 }
 
-static void print_dtlb_cache_misses(int cpu,
+static void print_dtlb_cache_misses(struct perf_stat_config *config,
+				    int cpu,
 				    struct perf_evsel *evsel,
 				    double avg,
 				    struct perf_stat_output_ctx *out,
@@ -529,10 +535,11 @@ static void print_dtlb_cache_misses(int cpu,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
 }
 
-static void print_itlb_cache_misses(int cpu,
+static void print_itlb_cache_misses(struct perf_stat_config *config,
+				    int cpu,
 				    struct perf_evsel *evsel,
 				    double avg,
 				    struct perf_stat_output_ctx *out,
@@ -548,10 +555,11 @@ static void print_itlb_cache_misses(int cpu,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
 }
 
-static void print_ll_cache_misses(int cpu,
+static void print_ll_cache_misses(struct perf_stat_config *config,
+				  int cpu,
 				  struct perf_evsel *evsel,
 				  double avg,
 				  struct perf_stat_output_ctx *out,
@@ -567,7 +575,7 @@ static void print_ll_cache_misses(int cpu,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
 }
 
 /*
@@ -674,7 +682,8 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 	return sanitize_val(1.0 - sum);
 }
 
-static void print_smi_cost(int cpu, struct perf_evsel *evsel,
+static void print_smi_cost(struct perf_stat_config *config,
+			   int cpu, struct perf_evsel *evsel,
 			   struct perf_stat_output_ctx *out,
 			   struct runtime_stat *st)
 {
@@ -694,11 +703,12 @@ static void print_smi_cost(int cpu, struct perf_evsel *evsel,
 
 	if (cost > 10)
 		color = PERF_COLOR_RED;
-	out->print_metric(out->ctx, color, "%8.1f%%", "SMI cycles%", cost);
-	out->print_metric(out->ctx, NULL, "%4.0f", "SMI#", smi_num);
+	out->print_metric(config, out->ctx, color, "%8.1f%%", "SMI cycles%", cost);
+	out->print_metric(config, out->ctx, NULL, "%4.0f", "SMI#", smi_num);
 }
 
-static void generic_metric(const char *metric_expr,
+static void generic_metric(struct perf_stat_config *config,
+			   const char *metric_expr,
 			   struct perf_evsel **metric_events,
 			   char *name,
 			   const char *metric_name,
@@ -737,20 +747,21 @@ static void generic_metric(const char *metric_expr,
 		const char *p = metric_expr;
 
 		if (expr__parse(&ratio, &pctx, &p) == 0)
-			print_metric(ctxp, NULL, "%8.1f",
+			print_metric(config, ctxp, NULL, "%8.1f",
 				metric_name ?
 				metric_name :
 				out->force_header ?  name : "",
 				ratio);
 		else
-			print_metric(ctxp, NULL, NULL,
+			print_metric(config, ctxp, NULL, NULL,
 				     out->force_header ?
 				     (metric_name ? metric_name : name) : "", 0);
 	} else
-		print_metric(ctxp, NULL, NULL, "", 0);
+		print_metric(config, ctxp, NULL, NULL, "", 0);
 }
 
-void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
+void perf_stat__print_shadow_stats(struct perf_stat_config *config,
+				   struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
@@ -769,10 +780,10 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 
 		if (total) {
 			ratio = avg / total;
-			print_metric(ctxp, NULL, "%7.2f ",
+			print_metric(config, ctxp, NULL, "%7.2f ",
 					"insn per cycle", ratio);
 		} else {
-			print_metric(ctxp, NULL, NULL, "insn per cycle", 0);
+			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
 		}
 
 		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT,
@@ -783,20 +794,20 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 						    ctx, cpu));
 
 		if (total && avg) {
-			out->new_line(ctxp);
+			out->new_line(config, ctxp);
 			ratio = total / avg;
-			print_metric(ctxp, NULL, "%7.2f ",
+			print_metric(config, ctxp, NULL, "%7.2f ",
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(ctxp, NULL, NULL,
+			print_metric(config, ctxp, NULL, NULL,
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
 		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
-			print_branch_misses(cpu, evsel, avg, out, st);
+			print_branch_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all branches", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
 		evsel->attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1D |
@@ -804,9 +815,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
 		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
-			print_l1_dcache_misses(cpu, evsel, avg, out, st);
+			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all L1-dcache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
 	} else if (
 		evsel->attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
@@ -814,9 +825,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
 		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
-			print_l1_icache_misses(cpu, evsel, avg, out, st);
+			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all L1-icache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
 	} else if (
 		evsel->attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
@@ -824,9 +835,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
 		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
-			print_dtlb_cache_misses(cpu, evsel, avg, out, st);
+			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all dTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
 	} else if (
 		evsel->attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
@@ -834,9 +845,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
 		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
-			print_itlb_cache_misses(cpu, evsel, avg, out, st);
+			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all iTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
 	} else if (
 		evsel->attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
@@ -844,9 +855,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
 		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
-			print_ll_cache_misses(cpu, evsel, avg, out, st);
+			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(ctxp, NULL, NULL, "of all LL-cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
 
@@ -854,32 +865,32 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			ratio = avg * 100 / total;
 
 		if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu) != 0)
-			print_metric(ctxp, NULL, "%8.3f %%",
+			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
-			print_metric(ctxp, NULL, NULL, "of all cache refs", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(cpu, evsel, avg, out, st);
+		print_stalled_cycles_frontend(config, cpu, evsel, avg, out, st);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(cpu, evsel, avg, out, st);
+		print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
 
 		if (total) {
 			ratio = avg / total;
-			print_metric(ctxp, NULL, "%8.3f", "GHz", ratio);
+			print_metric(config, ctxp, NULL, "%8.3f", "GHz", ratio);
 		} else {
-			print_metric(ctxp, NULL, NULL, "Ghz", 0);
+			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
 		}
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 		if (total)
-			print_metric(ctxp, NULL,
+			print_metric(config, ctxp, NULL,
 					"%7.2f%%", "transactional cycles",
 					100.0 * (avg / total));
 		else
-			print_metric(ctxp, NULL, NULL, "transactional cycles",
+			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
 				     0);
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
@@ -888,10 +899,10 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		if (total2 < avg)
 			total2 = avg;
 		if (total)
-			print_metric(ctxp, NULL, "%7.2f%%", "aborted cycles",
+			print_metric(config, ctxp, NULL, "%7.2f%%", "aborted cycles",
 				100.0 * ((total2-avg) / total));
 		else
-			print_metric(ctxp, NULL, NULL, "aborted cycles", 0);
+			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
 	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
 		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
 					 ctx, cpu);
@@ -900,10 +911,10 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			ratio = total / avg;
 
 		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu) != 0)
-			print_metric(ctxp, NULL, "%8.0f",
+			print_metric(config, ctxp, NULL, "%8.0f",
 				     "cycles / transaction", ratio);
 		else
-			print_metric(ctxp, NULL, NULL, "cycles / transaction",
+			print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
 				      0);
 	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
 		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
@@ -912,33 +923,33 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		if (avg)
 			ratio = total / avg;
 
-		print_metric(ctxp, NULL, "%8.0f", "cycles / elision", ratio);
+		print_metric(config, ctxp, NULL, "%8.0f", "cycles / elision", ratio);
 	} else if (perf_evsel__is_clock(evsel)) {
 		if ((ratio = avg_stats(&walltime_nsecs_stats)) != 0)
-			print_metric(ctxp, NULL, "%8.3f", "CPUs utilized",
+			print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
 				     avg / (ratio * evsel->scale));
 		else
-			print_metric(ctxp, NULL, NULL, "CPUs utilized", 0);
+			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
 		double fe_bound = td_fe_bound(ctx, cpu, st);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
-		print_metric(ctxp, color, "%8.1f%%", "frontend bound",
+		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
 		double retiring = td_retiring(ctx, cpu, st);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
-		print_metric(ctxp, color, "%8.1f%%", "retiring",
+		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
 		double bad_spec = td_bad_spec(ctx, cpu, st);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
-		print_metric(ctxp, color, "%8.1f%%", "bad speculation",
+		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
 		double be_bound = td_be_bound(ctx, cpu, st);
@@ -955,12 +966,12 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
 		if (td_total_slots(ctx, cpu, st) > 0)
-			print_metric(ctxp, color, "%8.1f%%", name,
+			print_metric(config, ctxp, color, "%8.1f%%", name,
 					be_bound * 100.);
 		else
-			print_metric(ctxp, NULL, NULL, name, 0);
+			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
-		generic_metric(evsel->metric_expr, evsel->metric_events, evsel->name,
+		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
 				evsel->metric_name, avg, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
 		char unit = 'M';
@@ -975,9 +986,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			unit = 'K';
 		}
 		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-		print_metric(ctxp, NULL, "%8.3f", unit_buf, ratio);
+		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
-		print_smi_cost(cpu, evsel, out, st);
+		print_smi_cost(config, cpu, evsel, out, st);
 	} else {
 		num = 0;
 	}
@@ -987,12 +998,12 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 
 		list_for_each_entry (mexp, &me->head, nd) {
 			if (num++ > 0)
-				out->new_line(ctxp);
-			generic_metric(mexp->metric_expr, mexp->metric_events,
+				out->new_line(config, ctxp);
+			generic_metric(config, mexp->metric_expr, mexp->metric_events,
 					evsel->name, mexp->metric_name,
 					avg, cpu, out, st);
 		}
 	}
 	if (num == 0)
-		print_metric(ctxp, NULL, NULL, NULL, 0);
+		print_metric(config, ctxp, NULL, NULL, NULL, 0);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index da6a706daecc..dffcf2110706 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -135,9 +135,10 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
-typedef void (*print_metric_t)(void *ctx, const char *color, const char *unit,
+typedef void (*print_metric_t)(struct perf_stat_config *config,
+			       void *ctx, const char *color, const char *unit,
 			       const char *fmt, double val);
-typedef void (*new_line_t )(void *ctx);
+typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
 void runtime_stat__init(struct runtime_stat *st);
 void runtime_stat__exit(struct runtime_stat *st);
@@ -153,7 +154,8 @@ struct perf_stat_output_ctx {
 	bool force_header;
 };
 
-void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
+void perf_stat__print_shadow_stats(struct perf_stat_config *config,
+				   struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
-- 
2.17.1

