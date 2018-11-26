Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC95C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE9020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeKZMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:42:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:50688 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZMmJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:42:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 17:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,280,1539673200"; 
   d="scan'208";a="103034568"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2018 17:49:34 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/2] perf report: Display average IPC and IPC coverage per symbol
Date:   Mon, 26 Nov 2018 17:40:54 +0800
Message-Id: <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
References: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support displaying the average IPC and IPC coverage for symbol
in perf report TUI browser. We create a new sort-key 'ipc' for
that.

For example,

$ perf record -g -b ...
$ perf report -s symbol,ipc or
  perf report -s ipc

Overhead  Symbol                           IPC   [IPC Coverage]
  39.60%  [.] __random                     2.30  [ 54.8%]
  18.02%  [.] main                         0.43  [ 54.3%]
  14.21%  [.] compute_flag                 2.29  [100.0%]
  14.16%  [.] rand                         0.36  [100.0%]
   7.06%  [.] __random_r                   2.57  [ 70.5%]
   6.85%  [.] rand@plt                     0.00  [  0.0%]

Note that, stdio mode doesn't support this feature.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/builtin-report.c              | 11 ++++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 43 ++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 tools/perf/util/symbol.h                 |  1 +
 6 files changed, 58 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 474a494..e7b8974 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -122,6 +122,7 @@ OPTIONS
 	- in_tx: branch in TSX transaction
 	- abort: TSX transaction abort.
 	- cycles: Cycles in basic block
+	- ipc: average ipc (instruction per cycle) of function
 
 	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
 	and symbol_to, see '--branch-stack'.
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 257c9c1..9b75e11 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -954,6 +954,7 @@ int cmd_report(int argc, const char **argv)
 	bool has_br_stack = false;
 	int branch_mode = -1;
 	bool branch_call_mode = false;
+	bool symbol_ipc = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
 					     CALLCHAIN_REPORT_HELP
@@ -1284,6 +1285,13 @@ int cmd_report(int argc, const char **argv)
 	else
 		use_browser = 0;
 
+	if ((sort__mode == SORT_MODE__BRANCH) && sort_order &&
+		strstr(sort_order, "ipc")) {
+		if (!strstr(sort_order, "symbol"))
+			sort_order = "symbol,ipc";
+		symbol_ipc = true;
+	}
+
 	if (setup_sorting(session->evlist) < 0) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
@@ -1331,6 +1339,9 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.sort_by_name = true;
 		}
 		annotation_config__init();
+	} else if (symbol_ipc) {
+		pr_err("Only TUI mode supports sort-key ipc\n");
+		goto error;
 	}
 
 	if (symbol__init(&session->header.env) < 0)
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
index f96c005..94f62c8 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "strlist.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
+#include "annotate.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -422,6 +423,47 @@ struct sort_entry sort_srcline_to = {
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
+	if (!sym->annotated &&
+	    symbol__annotate2(sym, map, evsel, &annotation__default_options,
+			      NULL) < 0) {
+		return 0;
+	}
+
+	sym->annotated = true;
+	notes = symbol__annotation(sym);
+
+	if (notes->hit_cycles)
+		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+
+	if (notes->total_insn)
+		coverage = notes->cover_insn * 100.0 /
+			((double)notes->total_insn);
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
 /* --sort srcfile */
 
 static char no_srcfile[1];
@@ -1591,6 +1633,7 @@ static struct sort_dimension bstack_sort_dimensions[] = {
 	DIM(SORT_CYCLES, "cycles", sort_cycles),
 	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
 	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
+	DIM(SORT_SYM_IPC, "ipc", sort_sym_ipc),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a97cf8e..de70736 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -242,6 +242,7 @@ enum sort_type {
 	SORT_CYCLES,
 	SORT_SRCLINE_FROM,
 	SORT_SRCLINE_TO,
+	SORT_SYM_IPC,
 
 	/* memory mode specific sort keys */
 	__SORT_MEMORY_MODE,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d026d21..94a567f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -63,6 +63,7 @@ struct symbol {
 	u8		ignore:1;
 	u8		inlined:1;
 	u8		arch_sym;
+	bool		annotated;
 	char		name[0];
 };
 
-- 
2.7.4

