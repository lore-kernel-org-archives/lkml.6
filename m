Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE37C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F1320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F1320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIACLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:11:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:23562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbeIACLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:11:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 15:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,313,1531810800"; 
   d="scan'208";a="77128130"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Aug 2018 15:02:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 15100301BFA; Fri, 31 Aug 2018 15:02:10 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 10/10] tools, perf, script: Implement --graph-function
Date:   Fri, 31 Aug 2018 15:02:06 -0700
Message-Id: <20180831220206.28351-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831220206.28351-1-andi@firstfloor.org>
References: <20180831220206.28351-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a ftrace style --graph-function argument to perf script that allows
to print itrace function calls only below a given function. This
makes it easier to find the code of interest in a large trace.

% perf record -e intel_pt//k -a sleep 1
% perf script --graph-function group_sched_in --call-trace
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])          group_sched_in
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              __x86_indirect_thunk_rax
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              event_sched_in.isra.107
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_event_set_state.part.71
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_time
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_pmu_disable
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_log_itrace_start
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_userpage
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          calc_timer_values
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_cpu
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          arch_perf_update_userpage
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              __fentry__
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              using_native_sched_clock
         swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_stable

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  4 +
 tools/perf/builtin-script.c              | 97 +++++++++++++++++++-----
 tools/perf/util/symbol.h                 |  3 +-
 tools/perf/util/thread.h                 |  2 +
 4 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 29eb3c3eb93e..59fed1adca7f 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -394,6 +394,10 @@ include::itrace.txt[]
 --call-ret-trace::
 	Show call and return stream for intel_pt traces.
 
+--graph-function::
+	For itrace only show specified functions and their callees for
+	itrace. Multiple functions can be separated by comma.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f5f90ed79eae..0040ae1125ea 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1105,6 +1105,35 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
 	return printed;
 }
 
+static const char *resolve_branch_sym(struct perf_sample *sample,
+				      struct perf_evsel *evsel,
+				      struct thread *thread,
+				      struct addr_location *al,
+				      u64 *ip)
+{
+	struct addr_location addr_al;
+	struct perf_event_attr *attr = &evsel->attr;
+	const char *name = NULL;
+
+	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
+		if (sample_addr_correlates_sym(attr)) {
+			thread__resolve(thread, &addr_al, sample);
+			if (addr_al.sym)
+				name = addr_al.sym->name;
+			else
+				*ip = sample->addr;
+		} else {
+			*ip = sample->addr;
+		}
+	} else if (sample->flags & (PERF_IP_FLAG_RETURN | PERF_IP_FLAG_TRACE_END)) {
+		if (al->sym)
+			name = al->sym->name;
+		else
+			*ip = sample->ip;
+	}
+	return name;
+}
+
 static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 					   struct perf_evsel *evsel,
 					   struct thread *thread,
@@ -1112,7 +1141,6 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	size_t depth = thread_stack__depth(thread);
-	struct addr_location addr_al;
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
@@ -1126,22 +1154,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (thread->ts && sample->flags & PERF_IP_FLAG_RETURN)
 		depth += 1;
 
-	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
-		if (sample_addr_correlates_sym(attr)) {
-			thread__resolve(thread, &addr_al, sample);
-			if (addr_al.sym)
-				name = addr_al.sym->name;
-			else
-				ip = sample->addr;
-		} else {
-			ip = sample->addr;
-		}
-	} else if (sample->flags & (PERF_IP_FLAG_RETURN | PERF_IP_FLAG_TRACE_END)) {
-		if (al->sym)
-			name = al->sym->name;
-		else
-			ip = sample->ip;
-	}
+	name = resolve_branch_sym(sample, evsel, thread, al, &ip);
 
 	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
 		dlen += fprintf(fp, "(");
@@ -1225,6 +1238,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		} else
 			printed += fprintf(fp, "\n");
 
+		printed += fprintf(fp, "IP: ");
 		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
 	}
 
@@ -1627,6 +1641,47 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	}
 }
 
+static bool show_event(struct perf_sample *sample,
+		       struct perf_evsel *evsel,
+		       struct thread *thread,
+		       struct addr_location *al)
+{
+	int depth = thread_stack__depth(thread);
+
+	if (!symbol_conf.graph_function)
+		return true;
+
+	if (thread->filter) {
+		if (depth <= thread->filter_entry_depth) {
+			thread->filter = false;
+			return false;
+		}
+		return true;
+	} else {
+		const char *s = symbol_conf.graph_function;
+		u64 ip;
+		const char *name = resolve_branch_sym(sample, evsel, thread, al,
+				&ip);
+		unsigned nlen;
+
+		if (!name)
+			return false;
+		nlen = strlen(name);
+		while (*s) {
+			unsigned len = strcspn(s, ",");
+			if (nlen == len && !strncmp(name, s, len)) {
+				thread->filter = true;
+				thread->filter_entry_depth = depth;
+				return true;
+			}
+			s += len;
+			if (*s == ',')
+				s++;
+		}
+		return false;
+	}
+}
+
 static void process_event(struct perf_script *script,
 			  struct perf_sample *sample, struct perf_evsel *evsel,
 			  struct addr_location *al,
@@ -1641,6 +1696,9 @@ static void process_event(struct perf_script *script,
 	if (output[type].fields == 0)
 		return;
 
+	if (!show_event(sample, evsel, thread, al))
+		return;
+
 	++es->samples;
 
 	perf_sample__fprintf_start(sample, thread, evsel,
@@ -3211,6 +3269,8 @@ int cmd_script(int argc, const char **argv)
 			"Decode calls from from itrace", parse_call_trace),
 	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode calls and returns from itrace", parse_callret_trace),
+	OPT_STRING(0, "graph-function", &symbol_conf.graph_function, "symbol[,symbol...]",
+			"Only print symbols and callees with --call-trace/--call-ret-trace"),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
@@ -3466,7 +3526,8 @@ int cmd_script(int argc, const char **argv)
 	script.session = session;
 	script__setup_sample_type(&script);
 
-	if (output[PERF_TYPE_HARDWARE].fields & PERF_OUTPUT_CALLINDENT)
+	if ((output[PERF_TYPE_HARDWARE].fields & PERF_OUTPUT_CALLINDENT) ||
+	    symbol_conf.graph_function)
 		itrace_synth_opts.thread_stack = true;
 
 	session->itrace_synth_opts = &itrace_synth_opts;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index f25fae4b5743..d726a8a7bb1b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -123,7 +123,8 @@ struct symbol_conf {
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-			*field_sep;
+			*field_sep,
+			*graph_function;
 	const char	*default_guest_vmlinux_name,
 			*default_guest_kallsyms,
 			*default_guest_modules;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..36c09a9904e6 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -42,6 +42,8 @@ struct thread {
 	void				*addr_space;
 	struct unwind_libunwind_ops	*unwind_libunwind_ops;
 #endif
+	bool			filter;
+	int			filter_entry_depth;
 };
 
 struct machine;
-- 
2.17.1

