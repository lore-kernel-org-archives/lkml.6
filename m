Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4604C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3542084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="jvTGMmRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfAUMf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:35:26 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:60711 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfAUMfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dIkj/kqQdZkDqKx9J8buPXOazvoj3yz2O1UOh6k7kxw=; b=jvTGMmRGP9LjAkNH8Q4+a6YjTI
        8+m9NjlxqYp/NRugAoKTHx7pEmZr4Mj3tU2lgIQb8VQoN9kWApHrnpYjoO7iS2FFqR4mWoEMEuFTr
        iicXMxmcliqaNqckP/G7PDQEV7feTXo9xNwHJVsvbPK30a1fVEJGUDw4s8nkqu6kWk9Wg5bvsXcPK
        bFAvdXeu19WJ6Coe5L/jNGzn0kkw+MBdbcyjcvUysnwbjOwYGfQra9zuOAVXEMVWxM/jlric9q8yh
        P1xY/FW38DpqL5wnm2+THCGoyzt2nXpl8h79EDbBOrmeS5axarpeguvMKUYlbxM6KGxvI/4nweihg
        cxr5TPmA==;
Received: from lakka.kapsi.fi ([2001:67c:1be8::1] ident=Debian-exim)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mcfrisk@kapsi.fi>)
        id 1glYnJ-0003qy-RI; Mon, 21 Jan 2019 14:35:13 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
        (envelope-from <mcfrisk@lakka.kapsi.fi>)
        id 1glYnJ-0004MZ-N5; Mon, 21 Jan 2019 14:35:13 +0200
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ftrace: Implement fs notification for preempt/irqsoff tracers
Date:   Mon, 21 Jan 2019 14:35:10 +0200
Message-Id: <1548074113-16599-2-git-send-email-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
References: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
X-SA-Exim-Connect-IP: 2001:67c:1be8::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the feature that the trace file, e.g.
/sys/kernel/debug/tracing/trace will receive notifications through
the fsnotify framework when a new trace is available.

This makes it possible to implement a user space program that can,
with equal probability, obtain traces of latencies that occur
immediately after each other in spite of the fact that the
preempt/irqsoff tracers operate in overwrite mode.

Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
---
 kernel/trace/Kconfig         | 10 ++++++++++
 kernel/trace/trace.c         | 31 +++++++++++++++++++++++++++++--
 kernel/trace/trace.h         |  5 +++++
 kernel/trace/trace_irqsoff.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fa8b1fe824f3..ca80cb08bd39 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -234,6 +234,16 @@ config PREEMPT_TRACER
 	  enabled. This option and the irqs-off timing option can be
 	  used together or separately.)
 
+	config PREEMPTIRQ_FSNOTIFY
+	bool "Generate fsnotify events for the latency tracers"
+	default n
+	depends on (IRQSOFF_TRACER || PREEMPT_TRACER) && FSNOTIFY
+	help
+	  This option will enable the generation of fsnotify events for the
+	  trace file. This makes it possible for userspace to be notified about
+	  modification of /sys/kernel/debug/tracing/trace through the inotify
+	  interface.
+
 config SCHED_TRACER
 	bool "Scheduling Latency Tracer"
 	select GENERIC_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..c7db01101ef2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -44,6 +44,8 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
+#include <linux/fsnotify.h>
+#include <linux/workqueue.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -7977,6 +7979,32 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 		return;
 }
 
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+
+static void trace_notify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      notify_work);
+	fsnotify(tr->d_trace->d_inode, FS_MODIFY, tr->d_trace->d_inode,
+		 FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static void trace_create_trace_file(struct trace_array *tr,
+				    struct dentry *d_tracer)
+{
+	/* For notify we need to init the work structure and save the pointer */
+	INIT_WORK(&tr->notify_work, trace_notify_workfn);
+	tr->d_trace = trace_create_file("trace", 0644, d_tracer, tr,
+					&tracing_fops);
+}
+
+#else /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
+#define trace_create_trace_file(tr, d_tracer) \
+	trace_create_file("trace", 0644, d_tracer, tr, &tracing_fops)
+
+#endif
+
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
@@ -7995,8 +8023,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_options", 0644, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", 0644, d_tracer,
-			  tr, &tracing_fops);
+	trace_create_trace_file(tr, d_tracer);
 
 	trace_create_file("trace_pipe", 0444, d_tracer,
 			  tr, &tracing_pipe_fops);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..a6769438a809 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/trace_seq.h>
 #include <linux/glob.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -257,6 +258,10 @@ struct trace_array {
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct dentry		*event_dir;
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+	struct dentry		*d_trace;
+	struct work_struct	notify_work;
+#endif
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d3294721f119..676413504566 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -81,6 +81,31 @@ static inline int irqsoff_display_graph(struct trace_array *tr, int set)
  */
 static __cacheline_aligned_in_smp	unsigned long max_sequence;
 
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+
+static struct workqueue_struct *notify_wq;
+
+static __init void trace_file_notify_init(void)
+{
+	notify_wq = alloc_workqueue("irqsoff_notify_wq",
+				    WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!notify_wq)
+		pr_err("Unable to allocate irqsoff_notify_wq");
+}
+
+static inline void trace_file_notify(struct trace_array *tr)
+{
+	if (likely(notify_wq))
+		queue_work(notify_wq, &tr->notify_work);
+}
+
+#else /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
+#define trace_file_notify_init() do {} while (0)
+#define trace_file_notify(tr) do {} while (0)
+
+#endif /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
 #ifdef CONFIG_FUNCTION_TRACER
 /*
  * Prologue for the preempt and irqs off function tracers.
@@ -322,6 +347,7 @@ check_critical_timing(struct trace_array *tr,
 	u64 T0, T1, delta;
 	unsigned long flags;
 	int pc;
+	bool notify = false;
 
 	T0 = data->preempt_timestamp;
 	T1 = ftrace_now(cpu);
@@ -352,6 +378,7 @@ check_critical_timing(struct trace_array *tr,
 	if (likely(!is_tracing_stopped())) {
 		tr->max_latency = delta;
 		update_max_tr_single(tr, current, cpu);
+		notify = true;
 	}
 
 	max_sequence++;
@@ -363,6 +390,13 @@ check_critical_timing(struct trace_array *tr,
 	data->critical_sequence = max_sequence;
 	data->preempt_timestamp = ftrace_now(cpu);
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+
+	/*
+	 * We are optimizing for a high threshold, meaning that this will
+	 * happen seldom
+	 */
+	if (unlikely(notify))
+		trace_file_notify(tr);
 }
 
 static inline void
@@ -740,6 +774,7 @@ static struct tracer preemptirqsoff_tracer __read_mostly =
 
 __init static int init_irqsoff_tracer(void)
 {
+	trace_file_notify_init();
 #ifdef CONFIG_IRQSOFF_TRACER
 	register_tracer(&irqsoff_tracer);
 #endif
-- 
2.17.1

