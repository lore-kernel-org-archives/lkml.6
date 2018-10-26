Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981FCECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523652082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523652082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJZQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:22:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:22:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7kgUJ141471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:46:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7kgIm141467;
        Fri, 26 Oct 2018 00:46:42 -0700
Date:   Fri, 26 Oct 2018 00:46:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-d1b1552e15d41297abcaf3812378e3391d44fa6b@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        leo.yan@linaro.org, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, hpa@zytor.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          leo.yan@linaro.org, kim.phillips@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <20180920180540.14039-4-andi@firstfloor.org>
References: <20180920180540.14039-4-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools script: Add --call-trace and
 --call-ret-trace
Git-Commit-ID: d1b1552e15d41297abcaf3812378e3391d44fa6b
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

Commit-ID:  d1b1552e15d41297abcaf3812378e3391d44fa6b
Gitweb:     https://git.kernel.org/tip/d1b1552e15d41297abcaf3812378e3391d44fa6b
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 20 Sep 2018 11:05:38 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 24 Oct 2018 15:29:55 -0300

tools script: Add --call-trace and --call-ret-trace

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
