Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B37C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C779620862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C779620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeICUoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:44:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:60079 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbeICUoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:44:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 09:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="70244082"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2018 09:22:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 718F5301B65; Mon,  3 Sep 2018 09:22:55 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 7/8] tools, perf, script: Add --call-trace and --call-ret-trace
Date:   Mon,  3 Sep 2018 09:22:48 -0700
Message-Id: <20180903162249.36304-8-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903162249.36304-1-andi@firstfloor.org>
References: <20180903162249.36304-1-andi@firstfloor.org>
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

v2: Print errors, power, ptwrite too
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
index 99f69561e1f8..87ec7cc798ea 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3094,6 +3094,26 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+static int parse_call_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
+	itrace_parse_synth_opts(opt, "cewp", 0);
+	nanosecs = true;
+	return 0;
+}
+
+static int parse_callret_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
+	itrace_parse_synth_opts(opt, "crewp", 0);
+	nanosecs = true;
+	return 0;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -3183,6 +3203,10 @@ int cmd_script(int argc, const char **argv)
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

