Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85A020870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547260136;
	bh=PIWSRJem1EAE1MYY4OPom+YqR8dr2EsFg481ou2fjCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJB25fyoN1nyPzIsXoMhfibl8S1PP3Ia0RfOYvG/c+qtQtkHHX0hHfyC/gbnz0CEd
	 FioxpuDqvHSlcd3P3s96Z8zeO7KJ81/6decqj9Bu/hoyNKcRyNz3I2oc4N5vRfgDUy
	 ipPrQMXAU7Uo6mpWE6rKdU4uy+GFdRgSFiPFAujU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfALC2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALC2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:28:54 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A62E204FD;
        Sat, 12 Jan 2019 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547260133;
        bh=PIWSRJem1EAE1MYY4OPom+YqR8dr2EsFg481ou2fjCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC8a6M88sa+LRlcdppIV/RM2FJq3wZbvpouja49uv7k6QKILL31mdFuOEOITkqB+Z
         ltLssYZZEYWq1lO2FPcRjRAqVTupRNm6x4W8Ew7p9XHHCYNzh920CAwnGgm0yD4DZg
         Yr4zas1DCi+K64CRy4/NIbKIk4bQsajv2auzQElA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 6/9] kprobes: Prohibit probing on hardirq tracers
Date:   Sat, 12 Jan 2019 11:28:30 +0900
Message-Id: <154726011067.18060.14848714386408118073.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
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
index 98ea6d28df15..829709bfec3d 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include "trace.h"
 
@@ -368,7 +369,7 @@ check_critical_timing(struct trace_array *tr,
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
 }
 
-static inline void
+static nokprobe_inline void
 start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -404,7 +405,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 	atomic_dec(&data->disabled);
 }
 
-static inline void
+static nokprobe_inline void
 stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -446,6 +447,7 @@ void start_critical_timings(void)
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
+NOKPROBE_SYMBOL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
@@ -455,6 +457,7 @@ void stop_critical_timings(void)
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
+NOKPROBE_SYMBOL(stop_critical_timings);
 
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
@@ -615,6 +618,7 @@ void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 	if (!preempt_trace(pc) && irq_trace())
 		stop_critical_timing(a0, a1, pc);
 }
+NOKPROBE_SYMBOL(tracer_hardirqs_on);
 
 void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
@@ -623,6 +627,7 @@ void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
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

