Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB8DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51F32146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51F32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeK3RLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:11:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:37819 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeK3RLl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 22:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="114083874"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 22:03:27 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 3/4] perf report: Display average IPC and IPC coverage per symbol
Date:   Fri, 30 Nov 2018 21:54:56 +0800
Message-Id: <1543586097-27632-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support displaying the average IPC and IPC coverage per symbol
in perf report TUI and stdio modes.

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

Jiri Olsa <jolsa@redhat.com> provides the patch to support the
stdio mode. I merge Jiri's code in this patch.

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

The columns "IPC" and "[IPC Coverage]" are automatically enabled
when the sort-key "symbol" is specified. If the perf.data doesn't
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
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 26 ++++++++++++++++---
 tools/perf/util/hist.h      |  1 +
 tools/perf/util/sort.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 4 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 257c9c1..4958095 100644
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
@@ -1284,6 +1286,24 @@ int cmd_report(int argc, const char **argv)
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
@@ -1311,7 +1331,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation()) {
+	if (ui__has_annotation() || report.symbol_ipc) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 3badd7f..664b5ed 100644
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
index f96c005..0477935 100644
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
index a97cf8e..130fe37 100644
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
-- 
2.7.4

