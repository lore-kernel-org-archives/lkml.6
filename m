Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C919320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0EicGcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C919320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeG3Ly4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbeG3Ly4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:54:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CE020881;
        Mon, 30 Jul 2018 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532946037;
        bh=R7W4LNx6muxvweyoqwGUlvxNPEdzuo8LMHidFGyZGXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0EicGccbl50qoIN0R1JdzSH13VWmfP8/rcFShJqpeVoBBUtBFs6jU9/Lr1k/VEpp
         3flcQGZWmC1ZMUt6dVgzHq/sQqg00mPUdIfLYkZVieQV26Z6EDE3JIT/spxwi7378K
         w3Bu+c02yZ68SQUtFSadVs94DkJVL8m6cl3R2B/U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] tracing: kprobes: Prohibit probing on notrace function
Date:   Mon, 30 Jul 2018 19:20:14 +0900
Message-Id: <153294601436.32740.10557881188933661239.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153294598465.32740.17737878083872427008.stgit@devbox>
References: <153294598465.32740.17737878083872427008.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit kprobe-events probing on notrace function.
Since probing on the notrace function can cause recursive
event call. In most case those are just skipped, but
in some case it falls into infinit recursive call.

This protection can be disabled by the kconfig
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly
recommended to keep it "n" for normal kernel.
Note that this is only available if "kprobes on ftrace"
has been implemented on target arch and
CONFIG_KPROBES_ON_FTRACE=y.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2
   - Add CONFIG_KPROBE_EVENTS_ON_NOTRACE kconfig for knocking down
     the protection.
  Changes in v3
   - Fix to check raw-address (no symbol) probe point correctly.
  Changes in v4
   - No notrace check if CONFIG_FUNCTION_TRACER=n. In that case
     notrace is ignored.
  Changes in v5
   - Change dependency on CONFIG_KPROBES_ON_FTRACE as same as
     original v1 patch does.
---
 kernel/trace/Kconfig        |   20 ++++++++++++++++++
 kernel/trace/trace_kprobe.c |   47 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..88b39f91b1e3 100644
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
index b37b92e7dbd4..10fdf1605e01 100644
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
@@ -487,6 +494,22 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
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
@@ -495,6 +518,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
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
 

