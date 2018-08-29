Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F852205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F852205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeH2VQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:7005 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbeH2VQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68826419"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id ABEF6301BA0; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 09/10] tools, perf, script: Add --call-trace and --call-ret-trace
Date:   Wed, 29 Aug 2018 10:18:33 -0700
Message-Id: <20180829171834.6590-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add short cut options to print PT call trace and call-ret-trace,
for calls and call and returns. Roughly corresponds to ftrace
function tracer and function graph tracer.

Just makes these common use cases nicer to use.

% perf record -a -e intel_pt// sleep 1
% perf script --call-trace
	    perf   900 [000] 194167.205652203: ([kernel.kallsyms])          perf_pmu_enable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          event_filter_match
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage

% perf script --call-ret-trace
	    perf   900 [000] 194167.205652203:   tr strt     ([unknown])        pt_config
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_config
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_event_add
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            perf_pmu_enable
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_void
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_sched_in.isra.107
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_int
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            group_sched_in
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            event_filter_match
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_filter_match
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            group_sched_in
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])                perf_pmu_nop_txn
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                event_sched_in.isra.107
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                    perf_event_set_state.part.71

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  7 +++++++
 tools/perf/builtin-script.c              | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 04a57e0fb3a6..29eb3c3eb93e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -387,6 +387,13 @@ include::itrace.txt[]
 	Show instruction stream for intel_pt traces. Requires installing the
 	xed disassembler.
 
+--call-trace::
+	Show call stream for intel_pt traces. The CPUs are interleaved, but
+	can be filtered with -C.
+
+--call-ret-trace::
+	Show call and return stream for intel_pt traces.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 938969b911cc..2effcb7003b7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3098,6 +3098,26 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+static int parse_call_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
+	itrace_parse_synth_opts(opt, "c", 0);
+	nanosecs = true;
+	return 0;
+}
+
+static int parse_callret_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
+	itrace_parse_synth_opts(opt, "cr", 0);
+	nanosecs = true;
+	return 0;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -3187,6 +3207,10 @@ int cmd_script(int argc, const char **argv)
 		   "only consider these symbols"),
 	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode instructions from itrace", parse_insn_trace),
+	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls from from itrace", parse_call_trace),
+	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls and returns from itrace", parse_callret_trace),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
-- 
2.17.1

