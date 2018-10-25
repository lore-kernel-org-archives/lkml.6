Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5FEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4B2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA2+WGna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB4B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeJYTol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeJYTol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:41 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063D520856;
        Thu, 25 Oct 2018 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465942;
        bh=9aybkfOp3dC+JFO+YjSNz+X8no3Uk580hcOFN6nJtMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tA2+WGnaSA0ukC0YwnEwAMU4I3HLaq989TNDf5S4CBAMcSxV3gyg3uOFo3D6x+HUb
         +955YKllf05cfmZZAxXwk8l8XM/KS+GbRLzvB1w/PnxR832K3ElxDlxeEniocME9oV
         YH1opRANJA9KxX4rYplSYjow6/W6FipGvqCnJ+fo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/37] tools script: Add --call-trace and --call-ret-trace
Date:   Thu, 25 Oct 2018 08:10:29 -0300
Message-Id: <20181025111031.3440-36-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add short cut options to print PT call trace and call-ret-trace, for
calls and call and returns. Roughly corresponds to ftrace function
tracer and function graph tracer.

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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180920180540.14039-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  7 +++++++
 tools/perf/builtin-script.c              | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 00c655ab4968..805baabd238e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -390,6 +390,13 @@ include::itrace.txt[]
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
 
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
index 6099c722a679..566e1450898a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3122,6 +3122,26 @@ static int parse_xed(const struct option *opt __maybe_unused,
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
@@ -3213,6 +3233,10 @@ int cmd_script(int argc, const char **argv)
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
+	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls from from itrace", parse_call_trace),
+	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls and returns from itrace", parse_callret_trace),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
-- 
2.14.4

