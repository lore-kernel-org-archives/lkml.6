Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC02821773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988047;
	bh=MfvR07KhO4hUy5aezsun6TEaOoyAu2dzBjEtr8HajT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cecfvHrwyPTOHGB/5Ez0l/PjxcWgEm43JWkXsw5jicWKgI+tapiKMrGmhNoVI9KxO
	 VWAfbGtKnrvZYL3UlWoQPVhvmh4WyexVm7DaBGsCw6X59BTDSJjLDWyPPJxSQCxzeH
	 +fJr6wG+Wsrtkkwg0U5bLUVknzDKMTiNKrS1jy7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfBLQOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBLQOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:14:05 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B068C2080F;
        Tue, 12 Feb 2019 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988043;
        bh=MfvR07KhO4hUy5aezsun6TEaOoyAu2dzBjEtr8HajT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikjNMkD8KN5rG7OBovDc3E0nOBaC/UBCAZRo33MZ8yqOvzlJXO3G0mp+mHpkbNI5z
         8vG+yUhIX5NfOjVEyJd4x+n19/0C+SiA+dMHByUqJVPZhy3bq1BfmI/1LjbY1T40u3
         XPIGhW/4piswn0vfgASf+rmjYM1im06YA01dPz7s=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 06/10] kprobes: Prohibit probing on hardirq tracers
Date:   Wed, 13 Feb 2019 01:13:40 +0900
Message-Id: <154998802073.31052.17255044712514564153.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobes breakpoint handling involves hardirq tracer,
probing these functions cause breakpoint recursion problem.

Prohibit probing on those functions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c    |    9 +++++++--
 kernel/trace/trace_preemptirq.c |    5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d3294721f119..d42a473b8240 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include "trace.h"
 
@@ -365,7 +366,7 @@ check_critical_timing(struct trace_array *tr,
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
 }
 
-static inline void
+static nokprobe_inline void
 start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -401,7 +402,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 	atomic_dec(&data->disabled);
 }
 
-static inline void
+static nokprobe_inline void
 stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -443,6 +444,7 @@ void start_critical_timings(void)
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
+NOKPROBE_SYMBOL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
@@ -452,6 +454,7 @@ void stop_critical_timings(void)
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
+NOKPROBE_SYMBOL(stop_critical_timings);
 
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
@@ -611,6 +614,7 @@ void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 	if (!preempt_trace(pc) && irq_trace())
 		stop_critical_timing(a0, a1, pc);
 }
+NOKPROBE_SYMBOL(tracer_hardirqs_on);
 
 void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
@@ -619,6 +623,7 @@ void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 	if (!preempt_trace(pc) && irq_trace())
 		start_critical_timing(a0, a1, pc);
 }
+NOKPROBE_SYMBOL(tracer_hardirqs_off);
 
 static int irqsoff_tracer_init(struct trace_array *tr)
 {
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 71f553cceb3c..4d8e99fdbbbe 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include "trace.h"
 
 #define CREATE_TRACE_POINTS
@@ -30,6 +31,7 @@ void trace_hardirqs_on(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
+NOKPROBE_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
@@ -43,6 +45,7 @@ void trace_hardirqs_off(void)
 	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
+NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
@@ -56,6 +59,7 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
+NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
@@ -69,6 +73,7 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
+NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE

