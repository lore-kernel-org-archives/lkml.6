Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27292206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfBXPhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:37:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:4459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfBXPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2019 07:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="120396840"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CCDD43010AD; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 11/11] perf tools report: Implement browsing of individual samples
Date:   Sun, 24 Feb 2019 07:37:22 -0800
Message-Id: <20190224153722.27020-12-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Now report can show whole time periods with perf script,
but the user still has to find individual samples of interest
manually.

It would be expensive and complicated to search for the
right samples in the whole perf file. Typically users
only need to look at a small number of samples for useful
analysis.

Also the full scripts tend to show samples of all CPUs and all
threads mixed up, which can be very confusing on larger systems.

Add a new --samples option to save a small random number of samples
per hist entry

Use a reservoir sample technique to select a representatve
number of samples.

Then allow browsing the samples using perf script
as part of the hist entry context menu. This automatically
adds the right filters, so only the thread or cpu of the sample
is displayed. Then we use less' search functionality
to directly jump the to the time stamp of the selected
sample.

It uses different menus for assembler and source display.
Assembler needs xed installed and source needs debuginfo.

Currently it only supports as many samples as fit on
the screen due to some limitations in the slang ui code.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  4 ++
 tools/perf/builtin-report.c              |  2 +
 tools/perf/ui/browsers/Build             |  1 +
 tools/perf/ui/browsers/hists.c           | 47 +++++++++++++++
 tools/perf/ui/browsers/res_sample.c      | 74 ++++++++++++++++++++++++
 tools/perf/ui/browsers/scripts.c         |  2 +-
 tools/perf/util/hist.c                   | 36 ++++++++++++
 tools/perf/util/hist.h                   | 19 ++++++
 tools/perf/util/sort.h                   |  8 +++
 tools/perf/util/symbol.c                 |  1 +
 tools/perf/util/symbol_conf.h            |  1 +
 11 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/ui/browsers/res_sample.c

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 546d87221ad8..f441baa794ce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -461,6 +461,10 @@ include::itrace.txt[]
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
+--samples=N::
+	Save N individual samples for each histogram entry to show context in perf
+	report tui browser.
+
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 600e168f3b99..9ad9dfa431d1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1154,6 +1154,8 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
+	OPT_INTEGER(0, "samples", &symbol_conf.res_sample,
+		    "Number of samples to save per histogram entry for individual browsing"),
 	OPT_CALLBACK(0, "percent-limit", &report, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index 8fee56b46502..fdf86f7981ca 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -3,6 +3,7 @@ perf-y += hists.o
 perf-y += map.o
 perf-y += scripts.o
 perf-y += header.o
+perf-y += res_sample.o
 
 CFLAGS_annotate.o += -DENABLE_SLFUTURE_CONST
 CFLAGS_hists.o    += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 9db8daa20044..6b27ff1494a8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2344,6 +2344,7 @@ struct popup_action {
 	struct map_symbol 	ms;
 	int			socket;
 	struct perf_evsel	*evsel;
+	enum rstype		rstype;
 
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
@@ -2571,6 +2572,19 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 	return 0;
 }
 
+static int
+do_res_sample_script(struct hist_browser *browser __maybe_unused,
+		     struct popup_action *act)
+{
+	struct hist_entry *he;
+	int num_res;
+
+	he = hist_browser__selected_entry(browser);
+	num_res = min(he->num_res, symbol_conf.res_sample);
+	res_sample_browse(he->res_samples, num_res, act->evsel, act->rstype);
+	return 0;
+}
+
 static int
 add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
@@ -2629,6 +2643,27 @@ add_script_opt(struct hist_browser *browser,
 	return n;
 }
 
+static int
+add_res_sample_opt(struct hist_browser *browser __maybe_unused,
+		   struct popup_action *act, char **optstr,
+		   struct res_sample *res_sample,
+		   struct perf_evsel *evsel,
+		   enum rstype type)
+{
+	if (!res_sample)
+		return 0;
+
+	if (asprintf(optstr, "Show context for individual samples %s",
+		type == A_ASM ? "with assembler" :
+		type == A_SOURCE ? "with source" : "") < 0)
+		return 0;
+
+	act->fn = do_res_sample_script;
+	act->evsel = evsel;
+	act->rstype = type;
+	return 1;
+}
+
 static int
 do_switch_data(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act __maybe_unused)
@@ -3115,6 +3150,18 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 		}
 		nr_options += add_script_opt(browser, &actions[nr_options],
 					     &options[nr_options], NULL, NULL, evsel);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_NORMAL);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_ASM);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_SOURCE);
 		nr_options += add_switch_opt(browser, &actions[nr_options],
 					     &options[nr_options]);
 skip_scripting:
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
new file mode 100644
index 000000000000..5b4807c29c2c
--- /dev/null
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Display a menu with individual samples to browse with perf script */
+#include "util.h"
+#include "hist.h"
+#include "evsel.h"
+#include "hists.h"
+#include "sort.h"
+#include "time-utils.h"
+
+/* In ns. Could make configurable. */
+#define CONTEXT_LEN 100000000
+
+int res_sample_browse(struct res_sample *res_samples, int num_res,
+		      struct perf_evsel *evsel, enum rstype rstype)
+{
+	char **names;
+	int i, n;
+	int choice;
+	char *cmd;
+	char pbuf[256], tidbuf[32], cpubuf[32];
+	const char *perf = perf_exe(pbuf, sizeof pbuf);
+	char trange[128], tsample[64];
+	struct res_sample *r;
+	char extra_format[256];
+
+	/* For now since ui__popup_menu doesn't like lists that don't fit */
+	num_res = max(min(SLtt_Screen_Rows - 4, num_res), 0);
+
+	names = calloc(num_res, sizeof(char *));
+	if (!names)
+		return -1;
+	for (i = 0; i < num_res; i++) {
+		char tbuf[64];
+
+		timestamp__scnprintf_nsec(res_samples[i].time, tbuf, sizeof tbuf);
+		if (asprintf(&names[i], "%s: CPU %d tid %d", tbuf,
+			     res_samples[i].cpu, res_samples[i].tid) < 0)
+			return -1;
+	}
+	choice = ui__popup_menu(num_res, names);
+	for (i = 0; i < num_res; i++)
+		free(names[i]);
+	free(names);
+
+	if (choice < 0 || choice >= num_res)
+		return -1;
+	r = &res_samples[choice];
+
+	n = timestamp__scnprintf_nsec(r->time - CONTEXT_LEN, trange, sizeof trange);
+	trange[n++] = ',';
+	timestamp__scnprintf_nsec(r->time + CONTEXT_LEN, trange + n, sizeof trange - n);
+
+	timestamp__scnprintf_nsec(r->time, tsample, sizeof tsample);
+
+	attr_to_script(extra_format, &evsel->attr);
+
+	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s | less +/%s",
+		     perf,
+		     input_name ? "-i " : "",
+		     input_name ? input_name : "",
+		     trange,
+		     r->cpu ? "--cpu " : "",
+		     r->cpu ? (sprintf(cpubuf, "%d", r->cpu), cpubuf) : "",
+		     r->tid ? "--tid " : "",
+		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
+		     extra_format,
+		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
+		     tsample) < 0)
+		return -1;
+	run_script(cmd);
+	free(cmd);
+	return 0;
+}
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 8633ad323fe9..3f018aefe118 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -128,7 +128,7 @@ static int list_scripts(char *script_name, bool *custom,
 	return ret;
 }
 
-static void run_script(char *cmd)
+void run_script(char *cmd)
 {
 	pr_debug("Running %s\n", cmd);
 	SLang_reset_tty();
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7bf4d85a3021..4af7caa87907 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -594,6 +594,40 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	return he;
 }
 
+static unsigned random_max(unsigned high)
+{
+	unsigned thresh = -high % high;
+	for (;;) {
+		unsigned r = random();
+		if (r >= thresh)
+			return r % high;
+	}
+}
+
+static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
+{
+	struct res_sample *r;
+	int j;
+
+	if (!he->res_samples) {
+		he->res_samples = calloc(sizeof(struct res_sample),
+					symbol_conf.res_sample);
+		if (!he->res_samples)
+			return;
+	}
+	if (he->num_res < symbol_conf.res_sample) {
+		j = he->num_res++;
+	} else {
+		j = random_max(++he->num_res + 1);
+		if (he->num_res > symbol_conf.res_sample)
+			return;
+	}
+	r = &he->res_samples[j];
+	r->time = sample->time;
+	r->cpu = sample->cpu;
+	r->tid = sample->tid;
+}
+
 static struct hist_entry*
 __hists__add_entry(struct hists *hists,
 		   struct addr_location *al,
@@ -641,6 +675,8 @@ __hists__add_entry(struct hists *hists,
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
 		hists->has_callchains = true;
+	if (he && symbol_conf.res_sample)
+		hists__res_sample(he, sample);
 	return he;
 }
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 51309f887cb1..2d4766508f31 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -433,6 +433,13 @@ struct hist_browser_timer {
 };
 
 struct annotation_options;
+struct res_sample;
+
+enum rstype {
+	A_NORMAL,
+	A_ASM,
+	A_SOURCE
+};
 
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
@@ -454,6 +461,10 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct annotation_options *annotation_options);
 
 int script_browse(const char *script_opt, struct perf_evsel *evsel);
+
+void run_script(char *cmd);
+int res_sample_browse(struct res_sample *res_samples, int num_res,
+		      struct perf_evsel *evsel, enum rstype rstype);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
@@ -488,6 +499,14 @@ static inline int script_browse(const char *script_opt __maybe_unused,
 	return 0;
 }
 
+static inline int res_sample_browse(struct res_sample *res_samples __maybe_unused,
+				    int num_res __maybe_unused,
+				    struct perf_evsel *evsel __maybe_unused,
+				    enum rstype rstype __maybe_unused)
+{
+	return 0;
+}
+
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index fc323f10f474..70c33add1443 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -47,6 +47,12 @@ extern struct sort_entry sort_srcline;
 extern enum sort_type sort__first_dimension;
 extern const char default_mem_sort_order[];
 
+struct res_sample {
+	u64 time;
+	int cpu;
+	int tid;
+};
+
 struct he_stat {
 	u64			period;
 	u64			period_sys;
@@ -140,6 +146,8 @@ struct hist_entry {
 	struct mem_info		*mem_info;
 	void			*raw_data;
 	u32			raw_size;
+	int			num_res;
+	struct res_sample	*res_samples;
 	void			*trace_output;
 	struct perf_hpp_list	*hpp_list;
 	struct hist_entry	*parent_he;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 758bf5f74e6e..112c3492decf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,6 +48,7 @@ struct symbol_conf symbol_conf = {
 	.symfs			= "",
 	.event_group		= true,
 	.inline_name		= true,
+	.res_sample		= 0,
 };
 
 static enum dso_binary_type binary_type_symtab[] = {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index fffea68c1203..8d21f8fb9cfb 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -66,6 +66,7 @@ struct symbol_conf {
 	struct intlist	*pid_list,
 			*tid_list;
 	const char	*symfs;
+	int		res_sample;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.17.2

