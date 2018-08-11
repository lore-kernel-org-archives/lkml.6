Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBD217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFBD217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeHKQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7BFF21A2B;
        Sat, 11 Aug 2018 13:50:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHU-00065T-Qv; Sat, 11 Aug 2018 09:50:12 -0400
Message-Id: <20180811135012.738120829@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [for-next][PATCH 11/34] tracing: kprobes: Prohibit probing on notrace function
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Prohibit kprobe-events probing on notrace functions.  Since probing on a
notrace function can cause a recursive event call. In most cases those are just
skipped, but in some cases it falls into an infinite recursive call.

This protection can be disabled by the kconfig
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly recommended to keep it
"n" for normal kernel builds.  Note that this is only available if "kprobes on
ftrace" has been implemented on the target arch and CONFIG_KPROBES_ON_FTRACE=y.

Link: http://lkml.kernel.org/r/153294601436.32740.10557881188933661239.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
[ Slight grammar and spelling fixes ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig        | 20 ++++++++++++++++
 kernel/trace/trace_kprobe.c | 47 ++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e15fadbe5dfb..4d4eb15cc7fd 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -456,6 +456,26 @@ config KPROBE_EVENTS
 	  This option is also required by perf-probe subcommand of perf tools.
 	  If you want to use perf tools, this option is strongly recommended.
 
+config KPROBE_EVENTS_ON_NOTRACE
+	bool "Do NOT protect notrace function from kprobe events"
+	depends on KPROBE_EVENTS
+	depends on KPROBES_ON_FTRACE
+	default n
+	help
+	  This is only for the developers who want to debug ftrace itself
+	  using kprobe events.
+
+	  If kprobes can use ftrace instead of breakpoint, ftrace related
+	  functions are protected from kprobe-events to prevent an infinit
+	  recursion or any unexpected execution path which leads to a kernel
+	  crash.
+
+	  This option disables such protection and allows you to put kprobe
+	  events on ftrace functions for debugging ftrace by itself.
+	  Note that this might let you shoot yourself in the foot.
+
+	  If unsure, say N.
+
 config UPROBE_EVENTS
 	bool "Enable uprobes-based dynamic events"
 	depends on ARCH_SUPPORTS_UPROBES
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0534eb8b7640..25662a780fdf 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -87,6 +87,21 @@ static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 	return nhit;
 }
 
+static nokprobe_inline
+unsigned long trace_kprobe_address(struct trace_kprobe *tk)
+{
+	unsigned long addr;
+
+	if (tk->symbol) {
+		addr = (unsigned long)
+			kallsyms_lookup_name(trace_kprobe_symbol(tk));
+		addr += tk->rp.kp.offset;
+	} else {
+		addr = (unsigned long)tk->rp.kp.addr;
+	}
+	return addr;
+}
+
 bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
@@ -99,16 +114,8 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 bool trace_kprobe_error_injectable(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
-	unsigned long addr;
 
-	if (tk->symbol) {
-		addr = (unsigned long)
-			kallsyms_lookup_name(trace_kprobe_symbol(tk));
-		addr += tk->rp.kp.offset;
-	} else {
-		addr = (unsigned long)tk->rp.kp.addr;
-	}
-	return within_error_injection_list(addr);
+	return within_error_injection_list(trace_kprobe_address(tk));
 }
 
 static int register_kprobe_event(struct trace_kprobe *tk);
@@ -504,6 +511,22 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	return ret;
 }
 
+#if defined(CONFIG_KPROBES_ON_FTRACE) && \
+	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
+static bool within_notrace_func(struct trace_kprobe *tk)
+{
+	unsigned long offset, size, addr;
+
+	addr = trace_kprobe_address(tk);
+	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
+		return true;	/* Out of range. */
+
+	return !ftrace_location_range(addr - offset, addr - offset + size);
+}
+#else
+#define within_notrace_func(tk)	(false)
+#endif
+
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
@@ -512,6 +535,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
+	if (within_notrace_func(tk)) {
+		pr_warn("Could not probe notrace function %s\n",
+			trace_kprobe_symbol(tk));
+		return -EINVAL;
+	}
+
 	for (i = 0; i < tk->tp.nr_args; i++)
 		traceprobe_update_arg(&tk->tp.args[i]);
 
-- 
2.18.0


