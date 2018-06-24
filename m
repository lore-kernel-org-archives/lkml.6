Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E10BC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B342924ECC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B342924ECC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeFXMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:06:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44876 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeFXMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:06:36 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX3ms-0004k9-BQ; Sun, 24 Jun 2018 14:06:34 +0200
Date:   Sun, 24 Jun 2018 14:06:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241357080.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A pile of perf updates:

  - Kernel related:

    - Remove an incorrect warning in uprobe_init_insn() when
      insn_get_length() fails. The error return code is handled at the
      call site.

    - Move the inline keyword to the right place in the perf ringbuffer
      code to address a W=1 build warning.

  - Tools related;

    perf stat:
    
    - Fix metric column header display alignment
    
    - Improve error messages for default attributes, providing better output
      for error in command line.

    - Add --interval-clear option, to provide a 'watch' like printing
    
    perf script:
    
    - Show hw-cache events too
    
    perf c2c:
    
    - Fix data dependency problem in layout of 'struct c2c_hist_entry'
    
    Core:
    
    - Do not blindly assume that 'struct perf_evsel' can be obtained via a
      straight forward container_of() as there are call sites which hand in
      a plain 'struct hist' which is not part of a container.

    - Fix error index in the PMU event parser, so that error messages can
      point to the problematic token.

Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (4):
      perf hists: Save the callchain_size in struct hist_entry
      perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
      perf hists browser gtk: Use hist_entry__has_callchains()
      perf hists: Reimplement hists__has_callchains()

Jiri Olsa (7):
      perf tools: Fix error index for pmu event parser
      perf stat: Add --interval-clear option
      perf stat: Use only color_fprintf call in print_metric_only
      perf stat: Fix metric column header display alignment
      perf stat: Allow to specify specific metric column len
      perf stat: Add event parsing error handling to add_default_attributes
      perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry

Mathieu Malaterre (1):
      perf/core: Move the inline keyword at the beginning of the function declaration

Oleg Nesterov (1):
      uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Seeteena Thoufeek (1):
      perf script: Show hw-cache events


 arch/x86/kernel/uprobes.c              |  2 +-
 kernel/events/ring_buffer.c            |  6 ++---
 tools/perf/Documentation/perf-stat.txt |  3 +++
 tools/perf/builtin-c2c.c               | 10 +++----
 tools/perf/builtin-script.c            | 12 +++++++++
 tools/perf/builtin-stat.c              | 48 ++++++++++++++++++++--------------
 tools/perf/ui/gtk/hists.c              |  2 +-
 tools/perf/util/hist.c                 | 12 ++++++---
 tools/perf/util/hist.h                 |  4 +--
 tools/perf/util/parse-events.y         |  5 ++++
 tools/perf/util/sort.h                 |  4 ++-
 11 files changed, 71 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 58d8d800875d..deb576b23b7c 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -293,7 +293,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
 	/* has the side-effect of processing the entire instruction */
 	insn_get_length(insn);
-	if (WARN_ON_ONCE(!insn_complete(insn)))
+	if (!insn_complete(insn))
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1d8ca9ea9979..d11f60cbe8ca 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -103,7 +103,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	preempt_enable();
 }
 
-static bool __always_inline
+static __always_inline bool
 ring_buffer_has_space(unsigned long head, unsigned long tail,
 		      unsigned long data_size, unsigned int size,
 		      bool backward)
@@ -114,7 +114,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 		return CIRC_SPACE(tail, head, data_size) >= size;
 }
 
-static int __always_inline
+static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
@@ -414,7 +414,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 }
 EXPORT_SYMBOL_GPL(perf_aux_output_begin);
 
-static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
+static __always_inline bool rb_need_aux_wakeup(struct ring_buffer *rb)
 {
 	if (rb->aux_overwrite)
 		return false;
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5dfe102fb5b5..b10a90b6a718 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -178,6 +178,9 @@ Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
 	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
 
+--interval-clear::
+Clear the screen before next interval.
+
 --timeout msecs::
 Stop the 'perf stat' session and print count deltas after N milliseconds (minimum: 10 ms).
 This option is not supported with the "-I" option.
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 307b3594525f..6a8738f7ead3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -56,16 +56,16 @@ struct c2c_hist_entry {
 
 	struct compute_stats	 cstats;
 
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
+
 	/*
 	 * must be at the end,
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
-
-	unsigned long		 paddr;
-	unsigned long		 paddr_cnt;
-	bool			 paddr_zero;
-	char			*nodestr;
 };
 
 static char const *coalesce_default = "pid,iaddr";
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b3bf35512d21..a31d7082188e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -180,6 +180,18 @@ static struct {
 				  PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE
 	},
 
+	[PERF_TYPE_HW_CACHE] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
 	[PERF_TYPE_RAW] = {
 		.user_set = false,
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 096ccb25c11f..22547a490e1f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/tool.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
+#include "util/top.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -144,6 +145,8 @@ static struct target target = {
 
 typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
+#define METRIC_ONLY_LEN 20
+
 static int			run_count			=  1;
 static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
@@ -173,6 +176,7 @@ static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
+static bool			interval_clear;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -180,6 +184,7 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
+static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -967,8 +972,6 @@ static void print_metric_csv(void *ctx,
 	fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
 }
 
-#define METRIC_ONLY_LEN 20
-
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -999,22 +1002,20 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	int n;
-	char buf[1024];
-	unsigned mlen = METRIC_ONLY_LEN;
+	char buf[1024], str[1024];
+	unsigned mlen = metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	if (color)
-		n = color_fprintf(out, color, fmt, val);
-	else
-		n = fprintf(out, fmt, val);
-	if (n > METRIC_ONLY_LEN)
-		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
-	fprintf(out, "%*s", mlen - n, "");
+
+	if (color)
+		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+
+	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	fprintf(out, "%*s ", mlen, str);
 }
 
 static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
@@ -1054,7 +1055,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%-*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
@@ -1704,9 +1705,12 @@ static void print_interval(char *prefix, struct timespec *ts)
 	FILE *output = stat_config.output;
 	static int num_print_interval;
 
+	if (interval_clear)
+		puts(CONSOLE_CLEAR);
+
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
 
-	if (num_print_interval == 0 && !csv_output) {
+	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
 		switch (stat_config.aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1719,7 +1723,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
 		case AGGR_NONE:
-			fprintf(output, "#           time CPU");
+			fprintf(output, "#           time CPU    ");
 			if (!metric_only)
 				fprintf(output, "                counts %*s events\n", unit_width, "unit");
 			break;
@@ -1738,7 +1742,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if (num_print_interval == 0 && metric_only)
+	if ((num_print_interval == 0 && metric_only) || interval_clear)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -2057,6 +2061,8 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
@@ -2436,14 +2442,13 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
+	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (null_run)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
-
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
@@ -2454,6 +2459,7 @@ static int add_default_attributes(void)
 					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
+			parse_events_print_error(&errinfo, transaction_attrs);
 			return -1;
 		}
 		return 0;
@@ -2479,10 +2485,11 @@ static int add_default_attributes(void)
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
 				metric_only = true;
-			err = parse_events(evsel_list, smi_cost_attrs, NULL);
+			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
 				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			return -1;
 		}
 		if (err) {
@@ -2517,12 +2524,13 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
-			err = parse_events(evsel_list, str, NULL);
+			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
 				free(str);
+				parse_events_print_error(&errinfo, str);
 				return -1;
 			}
 		} else {
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index b085f1b3e34d..4ab663ec3e5e 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -382,7 +382,7 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 			gtk_tree_store_set(store, &iter, col_idx++, s, -1);
 		}
 
-		if (hists__has_callchains(hists) &&
+		if (hist_entry__has_callchains(h) &&
 		    symbol_conf.use_callchain && hists__has(hists, sym)) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 52e8fda93a47..828cb9794c76 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -370,9 +370,11 @@ void hists__delete_entries(struct hists *hists)
 
 static int hist_entry__init(struct hist_entry *he,
 			    struct hist_entry *template,
-			    bool sample_self)
+			    bool sample_self,
+			    size_t callchain_size)
 {
 	*he = *template;
+	he->callchain_size = callchain_size;
 
 	if (symbol_conf.cumulate_callchain) {
 		he->stat_acc = malloc(sizeof(he->stat));
@@ -473,7 +475,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 
 	he = ops->new(callchain_size);
 	if (he) {
-		err = hist_entry__init(he, template, sample_self);
+		err = hist_entry__init(he, template, sample_self, callchain_size);
 		if (err) {
 			ops->free(he);
 			he = NULL;
@@ -619,9 +621,11 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
-	};
+	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
-	return hists__findnew_entry(hists, &entry, al, sample_self);
+	if (!hists->has_callchains && he && he->callchain_size != 0)
+		hists->has_callchains = true;
+	return he;
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 06607c434949..73049f7f0f60 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -85,6 +85,7 @@ struct hists {
 	struct events_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
+	bool			has_callchains;
 	int			socket_filter;
 	struct perf_hpp_list	*hpp_list;
 	struct list_head	hpp_formats;
@@ -222,8 +223,7 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 
 static __pure inline bool hists__has_callchains(struct hists *hists)
 {
-	const struct perf_evsel *evsel = hists_to_evsel(hists);
-	return evsel__has_callchain(evsel);
+	return hists->has_callchains;
 }
 
 int hists__init(void);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 155d2570274f..da8fe57691b8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -227,11 +227,16 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
 	struct list_head *list, *orig_terms, *terms;
 
 	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
+	if (error)
+		error->idx = @1.first_column;
+
 	ALLOC_LIST(list);
 	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 7cf2d5cc038e..8bf302cafcec 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -112,6 +112,8 @@ struct hist_entry {
 
 	char			level;
 	u8			filtered;
+
+	u16			callchain_size;
 	union {
 		/*
 		 * Since perf diff only supports the stdio output, TUI
@@ -153,7 +155,7 @@ struct hist_entry {
 
 static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 {
-	return hists__has_callchains(he->hists);
+	return he->callchain_size != 0;
 }
 
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
