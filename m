Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA79DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D7B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLROA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:00:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeLROA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:00:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE04Ed2852305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:00:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE03Ei2852302;
        Tue, 18 Dec 2018 06:00:03 -0800
Date:   Tue, 18 Dec 2018 06:00:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-ec6ae74fe8f00c7df018628ada9d33190de72efa@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, kan.liang@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com, yao.jin@linux.intel.com
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          yao.jin@linux.intel.com, tglx@linutronix.de, jolsa@kernel.org,
          acme@redhat.com
In-Reply-To: <1543586097-27632-4-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-4-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Display average IPC and IPC coverage
 per symbol
Git-Commit-ID: ec6ae74fe8f00c7df018628ada9d33190de72efa
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

Commit-ID:  ec6ae74fe8f00c7df018628ada9d33190de72efa
Gitweb:     https://git.kernel.org/tip/ec6ae74fe8f00c7df018628ada9d33190de72efa
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Nov 2018 21:54:56 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:44 -0300

perf report: Display average IPC and IPC coverage per symbol

Support displaying the average IPC and IPC coverage per symbol in 'perf
report' --tui and --stdio modes.

For example,

 $ perf record -b ...
 $ perf report -s symbol

 Overhead  Symbol                           IPC   [IPC Coverage]
   39.60%  [.] __random                     2.30  [ 54.8%]
   18.02%  [.] main                         0.43  [ 54.3%]
   14.21%  [.] compute_flag                 2.29  [100.0%]
   14.16%  [.] rand                         0.36  [100.0%]
    7.06%  [.] __random_r                   2.57  [ 70.5%]
    6.85%  [.] rand@plt                     0.00  [  0.0%]

Jiri Olsa <jolsa@redhat.com> provided the patch to support the --stdio
mode. I merged Jiri's code in this patch.

  $ perf report -s symbol --stdio

    # Overhead  Symbol                       IPC   [IPC Coverage]
    # ........  ...........................  ....................
    #
      39.60%  [.] __random                   2.30  [ 54.8%]
      18.02%  [.] main                       0.43  [ 54.3%]
      14.21%  [.] compute_flag               2.29  [100.0%]
      14.16%  [.] rand                       0.36  [100.0%]
       7.06%  [.] __random_r                 2.57  [ 70.5%]
       6.85%  [.] rand@plt                   0.00  [  0.0%]
       0.02%  [k] run_timer_softirq          1.60  [ 57.2%]

The columns "IPC" and "[IPC Coverage]" are automatically enabled when
the sort-key "symbol" is specified. If the perf.data file doesn't
contain timed LBR information, columns are filled with "-".

For example,

  # Overhead  Symbol                       IPC   [IPC Coverage]
  # ........  ...........................  ....................
  #
      46.57%  [.] main                     -      -
      17.60%  [.] rand                     -      -
      15.84%  [.] __random_r               -      -
      11.90%  [.] __random                 -      -
       6.50%  [.] compute_flag             -      -
       1.59%  [.] rand@plt                 -      -
       0.00%  [.] _dl_relocate_object      -      -
       0.00%  [k] tlb_flush_mmu            -      -
       0.00%  [k] perf_event_mmap          -      -
       0.00%  [k] native_sched_clock       -      -
       0.00%  [k] intel_pmu_handle_irq_v4  -      -
       0.00%  [k] native_write_msr         -      -

 v3:
 ---
 Removed the sortkey 'ipc' from command-line. The columns "IPC"
 and "[IPC Coverage]" are automatically enabled when "symbol"
 is specified.

 v2:
 ---
 Merge in Jiri's patch to support stdio mode

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1543586097-27632-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 26 ++++++++++++++++---
 tools/perf/util/hist.h      |  1 +
 tools/perf/util/sort.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 4 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 257c9c18cb7e..4958095be4fc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -85,6 +85,7 @@ struct report {
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
+	bool			symbol_ipc;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -129,7 +130,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct mem_info *mi;
 	struct branch_info *bi;
 
-	if (!ui__has_annotation())
+	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
 	hist__account_cycles(sample->branch_stack, al, sample,
@@ -174,7 +175,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	if (!ui__has_annotation())
+	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
 	hist__account_cycles(sample->branch_stack, al, sample,
@@ -1133,6 +1134,7 @@ int cmd_report(int argc, const char **argv)
 		.mode  = PERF_DATA_MODE_READ,
 	};
 	int ret = hists__init();
+	char sort_tmp[128];
 
 	if (ret < 0)
 		return ret;
@@ -1284,6 +1286,24 @@ repeat:
 	else
 		use_browser = 0;
 
+	if (sort_order && strstr(sort_order, "ipc")) {
+		parse_options_usage(report_usage, options, "s", 1);
+		goto error;
+	}
+
+	if (sort_order && strstr(sort_order, "symbol")) {
+		if (sort__mode == SORT_MODE__BRANCH) {
+			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
+				 sort_order, "ipc_lbr");
+			report.symbol_ipc = true;
+		} else {
+			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
+				 sort_order, "ipc_null");
+		}
+
+		sort_order = sort_tmp;
+	}
+
 	if (setup_sorting(session->evlist) < 0) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
@@ -1311,7 +1331,7 @@ repeat:
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation()) {
+	if (ui__has_annotation() || report.symbol_ipc) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 3badd7f1e1b8..664b5eda8d51 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -62,6 +62,7 @@ enum hist_column {
 	HISTC_TRACE,
 	HISTC_SYM_SIZE,
 	HISTC_DSO_SIZE,
+	HISTC_SYMBOL_IPC,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f96c005b3c41..047793528919 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "strlist.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
+#include "annotate.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -422,6 +423,64 @@ struct sort_entry sort_srcline_to = {
 	.se_width_idx	= HISTC_SRCLINE_TO,
 };
 
+static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
+					size_t size, unsigned int width)
+{
+
+	struct symbol *sym = he->ms.sym;
+	struct map *map = he->ms.map;
+	struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	struct annotation *notes;
+	double ipc = 0.0, coverage = 0.0;
+	char tmp[64];
+
+	if (!sym)
+		return repsep_snprintf(bf, size, "%-*s", width, "-");
+
+	if (!sym->annotate2 && symbol__annotate2(sym, map, evsel,
+		&annotation__default_options, NULL) < 0) {
+		return 0;
+	}
+
+	notes = symbol__annotation(sym);
+
+	if (notes->hit_cycles)
+		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+
+	if (notes->total_insn) {
+		coverage = notes->cover_insn * 100.0 /
+			((double)notes->total_insn);
+	}
+
+	snprintf(tmp, sizeof(tmp), "%-5.2f [%5.1f%%]", ipc, coverage);
+	return repsep_snprintf(bf, size, "%-*s", width, tmp);
+}
+
+struct sort_entry sort_sym_ipc = {
+	.se_header	= "IPC   [IPC Coverage]",
+	.se_cmp		= sort__sym_cmp,
+	.se_snprintf	= hist_entry__sym_ipc_snprintf,
+	.se_width_idx	= HISTC_SYMBOL_IPC,
+};
+
+static int hist_entry__sym_ipc_null_snprintf(struct hist_entry *he
+					     __maybe_unused,
+					     char *bf, size_t size,
+					     unsigned int width)
+{
+	char tmp[64];
+
+	snprintf(tmp, sizeof(tmp), "%-5s %2s", "-", "-");
+	return repsep_snprintf(bf, size, "%-*s", width, tmp);
+}
+
+struct sort_entry sort_sym_ipc_null = {
+	.se_header	= "IPC   [IPC Coverage]",
+	.se_cmp		= sort__sym_cmp,
+	.se_snprintf	= hist_entry__sym_ipc_null_snprintf,
+	.se_width_idx	= HISTC_SYMBOL_IPC,
+};
+
 /* --sort srcfile */
 
 static char no_srcfile[1];
@@ -1574,6 +1633,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
+	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
 };
 
 #undef DIM
@@ -1591,6 +1651,7 @@ static struct sort_dimension bstack_sort_dimensions[] = {
 	DIM(SORT_CYCLES, "cycles", sort_cycles),
 	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
 	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
+	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a97cf8e6be86..130fe37fe2df 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -229,6 +229,7 @@ enum sort_type {
 	SORT_SYM_SIZE,
 	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
+	SORT_SYM_IPC_NULL,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
@@ -242,6 +243,7 @@ enum sort_type {
 	SORT_CYCLES,
 	SORT_SRCLINE_FROM,
 	SORT_SRCLINE_TO,
+	SORT_SYM_IPC,
 
 	/* memory mode specific sort keys */
 	__SORT_MEMORY_MODE,
