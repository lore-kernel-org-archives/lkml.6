Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DE4C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766DD217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766DD217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeHKQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeHKQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE29721A88;
        Sat, 11 Aug 2018 13:50:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHX-0006EF-Vx; Sat, 11 Aug 2018 09:50:16 -0400
Message-Id: <20180811135015.887386256@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 27/34] tracing: irqsoff: Account for additional preempt_disable
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Recently we tried to make the preemptirqsoff tracer to use irqsoff
tracepoint probes. However this causes issues as reported by Masami:

[2.271078] Testing tracer preemptirqsoff: .. no entries found ..FAILED!
[2.381015] WARNING: CPU: 0 PID: 1 at /home/mhiramat/ksrc/linux/kernel/
trace/trace.c:1512 run_tracer_selftest+0xf3/0x154

This is due to the tracepoint code increasing the preempt nesting count
by calling an additional preempt_disable before calling into the
preemptoff tracer which messes up the preempt_count() check in
tracer_hardirqs_off.

To fix this, make the irqsoff tracer probes balance the additional outer
preempt_disable with a preempt_enable_notrace.

The other way to fix this is to just use SRCU for all tracepoints.
However we can't do that because we can't use NMIs from RCU context.

Link: http://lkml.kernel.org/r/20180806034049.67949-1-joel@joelfernandes.org

Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 770cd30cda40..ffbf1505d5bc 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
  */
 static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
 {
+	/*
+	 * Tracepoint probes are expected to be called with preempt disabled,
+	 * We don't care about being called with preempt disabled but we need
+	 * to know in the future if that changes so we can remove the next
+	 * preempt_enable.
+	 */
+	WARN_ON_ONCE(!preempt_count());
+
+	/* Tracepoint probes disable preemption atleast once, account for that */
+	preempt_enable_notrace();
+
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
+
+	preempt_disable_notrace();
 }
 
 static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
 {
+	/*
+	 * Tracepoint probes are expected to be called with preempt disabled,
+	 * We don't care about being called with preempt disabled but we need
+	 * to know in the future if that changes so we can remove the next
+	 * preempt_enable.
+	 */
+	WARN_ON_ONCE(!preempt_count());
+
+	/* Tracepoint probes disable preemption atleast once, account for that */
+	preempt_enable_notrace();
+
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
+
+	preempt_disable_notrace();
 }
 
 static int irqsoff_tracer_init(struct trace_array *tr)
-- 
2.18.0


