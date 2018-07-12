Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE4EA4F8E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B2A2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WqbbG03o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B2A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeGLSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:05:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:55374 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:05:08 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2E68C233C24;
        Thu, 12 Jul 2018 13:54:31 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Mpc2fJkoIh-L; Thu, 12 Jul 2018 13:54:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B65A4233C20;
        Thu, 12 Jul 2018 13:54:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B65A4233C20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531418070;
        bh=lSkyXzmX73rWsDA9ApnhV/oFcy1ydzvCIdccfsa7h80=;
        h=From:To:Date:Message-Id;
        b=WqbbG03olHnwyo/HY5FVR2qIZnOHrjwhmuB9b0Dur4u+pbUrrMFs7jwMiFQPVLHgP
         +sCRXfwTlRwrYs4CD02+513J5t9h+m6ccuGv0CV5ctwlz/wn/tp9quuAtFy1SJ+3UI
         t0mC8euxjES7dFgWlOcRHef7o45mvpEkJ19wRoM07DGn0ZlDG+nStOKSAcaBByblIW
         GSrgYbXmWJESIaMcR3BzT+nSnGTcAvClD9DaMyD3x5CBiKoR/CDkLkdTzCSRJgfMWR
         wH1+wCWMsi4WK3RR/j1JheoWYTHTsnfpwlnm+eKCl+4pYqEKNSxovyTXxdZAs2ePPq
         Ya3juRKXkLDwQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pYV0p8iVz70W; Thu, 12 Jul 2018 13:54:30 -0400 (EDT)
Received: from raton.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id CD5B4233C18;
        Thu, 12 Jul 2018 13:54:29 -0400 (EDT)
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org
Cc:     mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace functions
Date:   Thu, 12 Jul 2018 13:54:12 -0400
Message-Id: <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
 <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Prohibit kprobe-events probing on notrace function.
Since probing on the notrace function can cause recursive
event call. In most case those are just skipped, but
in some case it falls into infinite recursive call.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
 kernel/trace/trace_kprobe.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index daa8157..952dc2a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -487,6 +487,23 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	return ret;
 }
 
+#ifdef CONFIG_KPROBES_ON_FTRACE
+static bool within_notrace_func(struct trace_kprobe *tk)
+{
+	unsigned long offset, size, addr;
+
+	addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));
+	addr += trace_kprobe_offset(tk);
+
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
@@ -495,6 +512,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
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
2.7.4

