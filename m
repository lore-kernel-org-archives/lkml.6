Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11592C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE19A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeH2VQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:17560 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeH2VQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="252927512"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 83DDC301BA0; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for instruction decoding
Date:   Wed, 29 Aug 2018 10:18:27 -0700
Message-Id: <20180829171834.6590-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a --insn-trace short hand option for decoding and disassembling
instruction streams for intel_pt. This automatically pipes the
output into the xed disassembler to generate disassembled instructions.
This just makes this use model much nicer to use

Before

% perf record -e intel_pt// ...
% perf script --itrace=i0ns --ns -F +insn,-event,-period | xed -F insn: -A -64
   swapper     0 [000] 117276.429606186:  ffffffff81010486 pt_config ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
   swapper     0 [000] 117276.429606186:  ffffffff8101048b pt_config ([kernel.kallsyms])          add $0x10, %rsp
   swapper     0 [000] 117276.429606186:  ffffffff8101048f pt_config ([kernel.kallsyms])          popq  %rbx
   swapper     0 [000] 117276.429606186:  ffffffff81010490 pt_config ([kernel.kallsyms])          popq  %rbp
   swapper     0 [000] 117276.429606186:  ffffffff81010491 pt_config ([kernel.kallsyms])          popq  %r12
   swapper     0 [000] 117276.429606186:  ffffffff81010493 pt_config ([kernel.kallsyms])          popq  %r13
   swapper     0 [000] 117276.429606186:  ffffffff81010495 pt_config ([kernel.kallsyms])          popq  %r14
   swapper     0 [000] 117276.429606186:  ffffffff81010497 pt_config ([kernel.kallsyms])          popq  %r15
   swapper     0 [000] 117276.429606186:  ffffffff81010499 pt_config ([kernel.kallsyms])          retq
   swapper     0 [000] 117276.429606186:  ffffffff8101063e pt_event_add ([kernel.kallsyms])               cmpl  $0x1, 0x1b0(%rbx)
   swapper     0 [000] 117276.429606186:  ffffffff81010645 pt_event_add ([kernel.kallsyms])               mov $0xffffffea, %eax
   swapper     0 [000] 117276.429606186:  ffffffff8101064a pt_event_add ([kernel.kallsyms])               mov $0x0, %edx
   swapper     0 [000] 117276.429606186:  ffffffff8101064f pt_event_add ([kernel.kallsyms])               popq  %rbx
   swapper     0 [000] 117276.429606186:  ffffffff81010650 pt_event_add ([kernel.kallsyms])               cmovnz %edx, %eax
   swapper     0 [000] 117276.429606186:  ffffffff81010653 pt_event_add ([kernel.kallsyms])               jmp 0xffffffff81010635
   swapper     0 [000] 117276.429606186:  ffffffff81010635 pt_event_add ([kernel.kallsyms])               retq
   swapper     0 [000] 117276.429606186:  ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])            test %eax, %eax

Now

% perf record -e intel_pt// ...
% perf script --insn-trace
... same output ...

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  4 ++++
 tools/perf/builtin-script.c              | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index afdafe2110a1..04a57e0fb3a6 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -383,6 +383,10 @@ include::itrace.txt[]
 	will be printed. Each entry has function name and file/line. Enabled by
 	default, disable with --no-inline.
 
+--insn-trace::
+	Show instruction stream for intel_pt traces. Requires installing the
+	xed disassembler.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 910e0f1f2876..66daa7df68c5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -44,6 +44,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <subcmd/pager.h>
 
 #include "sane_ctype.h"
 
@@ -3072,6 +3073,17 @@ static int perf_script__process_auxtrace_info(struct perf_tool *tool,
 #define perf_script__process_auxtrace_info 0
 #endif
 
+static int parse_insn_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "+insn,-event,-period", 0);
+	itrace_parse_synth_opts(opt, "i0ns", 0);
+	nanosecs = true;
+	force_pager("xed -F insn: -A -64 | less");
+	return 0;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -3156,6 +3168,8 @@ int cmd_script(int argc, const char **argv)
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
+	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode instructions from itrace", parse_insn_trace),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
-- 
2.17.1

