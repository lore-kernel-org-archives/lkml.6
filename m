Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36D20877
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du2I0XmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A36D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbeG1Dqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388894AbeG1Dqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:46:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D48E20862;
        Sat, 28 Jul 2018 02:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532744518;
        bh=y7CS4Ktwnvvre+Zcuu2C7Wytpat7rqYuY/jZtGUyJ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Du2I0XmUaXzlcBzkBHjjT4o6OBNXLCymq43BqiSngWzCHKBICqgjPMrJk/pA23lNj
         AxuVj6sLpc72wGM+V1FPlnFL9deWt+2A53pnL4LnPgDK+zsNLerCT4VQh/Eaf7uMo7
         j/rOmdCn3viT5c/BDbV0j74imb/02C49kpdsbL2U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing: kprobes: Prohibit probing on notrace function
Date:   Sat, 28 Jul 2018 11:21:35 +0900
Message-Id: <153274449521.14940.10594601173810551002.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153274446603.14940.16028811307915635132.stgit@devbox>
References: <153274446603.14940.16028811307915635132.stgit@devbox>
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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
  Changes in v2
   - Add CONFIG_KPROBE_EVENTS_ON_NOTRACE kconfig for knocking down
     the protection.
  Changes in v3
   - Fix to check raw-address (no symbol) probe point correctly.
---
 kernel/trace/Kconfig        |   18 +++++++++++++++++
 kernel/trace/trace_kprobe.c |   46 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..24d5a58467a3 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -456,6 +456,24 @@ config KPROBE_EVENTS
 	  This option is also required by perf-probe subcommand of perf tools.
 	  If you want to use perf tools, this option is strongly recommended.
 
+config KPROBE_EVENTS_ON_NOTRACE
+	bool "Do NOT protect notrace function from kprobe events"
+	depends on KPROBE_EVENTS
+	default n
+	help
+	  This is only for the developers who want to debug ftrace itself
+	  using kprobe events.
+
+	  Usually, ftrace related functions are protected from kprobe-events
+	  to prevent an infinit recursion or any unexpected execution path
+	  which leads to a kernel crash.
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
index 27ace4513c43..2bf75af92f16 100644
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
@@ -496,6 +503,21 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	return ret;
 }
 
+#ifdef CONFIG_KPROBE_EVENTS_ON_NOTRACE
+#define within_notrace_func(tk)	(false)
+#else
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
+#endif
+
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
@@ -504,6 +526,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
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
 

