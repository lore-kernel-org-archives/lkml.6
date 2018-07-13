Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31845ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD969208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BOcc46aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD969208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGMWM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:12:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46584 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbeGMWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:12:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so12725938pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wp8jgzRVo95lOrvP374xJJk2Pkg5gkU2Uvo1XXW0ub0=;
        b=BOcc46aPnLdqIvCkeiGts6n9vMeC+hLyfk+MxAP/12XqiNVmhFD7dw9rnSPcWZ4Rp0
         Qgx1ihjd8dxhlS2i7JhSV+kktfEr4q8wgIWqOOeE43NK657rEe7AQfVMeD/bhOBqTqrK
         EKwclp2IBmokLtfpX155hz+70X6r4LabWbsqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wp8jgzRVo95lOrvP374xJJk2Pkg5gkU2Uvo1XXW0ub0=;
        b=d+MoTytAlPtQ/AWzpzwEPCBxdWMGfWJsdhlKybSUyuQTeEOodeRk92+LpZVdxGIszi
         NL1S2JlXvnFLIfZ1rrNhAJ9sKxfPbBkJo2I8njXf9g1xHnkWy4aoMjz6X9obc1e7RZo3
         8xJIJ9z2TlU7mGgtriovZX9Xi3o4M3Z5WAIlIPZdoVjCfT+aaXS0H7uYKA7kMD0fbvYJ
         iHBqKFdm5VBQe+9Tlv7LuJO1k9Fp4KSee/XZjev5MZy80RB1Q901UGUdkOw9znvadHBx
         4yKDgy/floM8673J7CCd6BXyU0wDsFwk2Lnfq5vL6waxw/f3G9geE5/vMtuedih0erqz
         +V6w==
X-Gm-Message-State: AOUpUlG61lpUgAzgNRMyWCqrJAfPqWWL0ByarSi45TLsl+b7zTbswMPm
        VYUqrODfv0Jo4YDWDhY19Hz1BySdmVY=
X-Google-Smtp-Source: AAOMgpfaHuPEgiG2bozJeA+BsvHvWFe4pQ4ZSwR62SSB2iy8tx62qmPxdRH4lz5Rv/BQnG0SnkKAVQ==
X-Received: by 2002:a17:902:8607:: with SMTP id f7-v6mr8043610plo.138.1531518956870;
        Fri, 13 Jul 2018 14:55:56 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm35232990pgo.49.2018.07.13.14.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 14:55:56 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use SRCU
Date:   Fri, 13 Jul 2018 14:55:46 -0700
Message-Id: <20180713215547.255620-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180713215547.255620-1-joel@joelfernandes.org>
References: <20180713215547.255620-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In recent tests with IRQ on/off tracepoints, a large performance
overhead ~10% is noticed when running hackbench. This is root caused to
calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
tracepoint code. Following a long discussion on the list [1] about this,
we concluded that srcu is a better alternative for use during rcu idle.
Although it does involve extra barriers, its lighter than the sched-rcu
version which has to do additional RCU calls to notify RCU idle about
entry into RCU sections.

In this patch, we change the underlying implementation of the
trace_*_rcuidle API to use SRCU. This has shown to improve performance
alot for the high frequency irq enable/disable tracepoints.

Test: Tested idle and preempt/irq tracepoints.

Here are some performance numbers:

With a run of the following 30 times on a single core x86 Qemu instance
with 1GB memory:
hackbench -g 4 -f 2 -l 3000

Completion times in seconds. CONFIG_PROVE_LOCKING=y.

No patches (without this series)
Mean: 3.048
Median: 3.025
Std Dev: 0.064

With Lockdep using irq tracepoints with RCU implementation:
Mean: 3.451   (-11.66 %)
Median: 3.447 (-12.22%)
Std Dev: 0.049

With Lockdep using irq tracepoints with SRCU implementation (this series):
Mean: 3.020   (I would consider the improvement against the "without
	       this series" case as just noise).
Median: 3.013
Std Dev: 0.033

[1] https://patchwork.kernel.org/patch/10344297/

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cleaned-up-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 45 +++++++++++++++++++++++++++++++-------
 kernel/tracepoint.c        | 16 +++++++++++++-
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 19a690b559ca..97e1d365a817 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -15,6 +15,7 @@
  */
 
 #include <linux/smp.h>
+#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -33,6 +34,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
  */
+#ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_srcu(&tracepoint_srcu);
 	synchronize_sched();
 }
+#else
+static inline void tracepoint_synchronize_unregister(void)
+{ }
+#endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 extern int syscall_regfunc(void);
@@ -129,18 +138,34 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
+#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
+		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
-		if (rcucheck)						\
-			rcu_irq_enter_irqson();				\
-		rcu_read_lock_sched_notrace();				\
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+									\
+		/* srcu can't be used from NMI */			\
+		if (rcuidle && in_nmi())				\
+			WARN_ON_ONCE(1);				\
+									\
+		/* keep srcu and sched-rcu usage consistent */		\
+		preempt_disable_notrace();				\
+									\
+		/*							\
+		 * For rcuidle callers, use srcu since sched-rcu	\
+		 * doesn't work from the idle path.			\
+		 */							\
+		if (rcuidle)						\
+			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+		else							\
+			rcu_read_lock_sched_notrace();			\
+									\
+		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
+									\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -148,9 +173,13 @@ extern void syscall_unregfunc(void);
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
-		rcu_read_unlock_sched_notrace();			\
-		if (rcucheck)						\
-			rcu_irq_exit_irqson();				\
+									\
+		if (rcuidle)						\
+			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+		else							\
+			rcu_read_unlock_sched_notrace();		\
+									\
+		preempt_enable_notrace();				\
 	} while (0)
 
 #ifndef MODULE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6dc6356c3327..955148d91b74 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -31,6 +31,9 @@
 extern struct tracepoint * const __start___tracepoints_ptrs[];
 extern struct tracepoint * const __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -67,16 +70,27 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
+		/*
+		 * Tracepoint probes are protected by both sched RCU and SRCU,
+		 * by calling the SRCU callback in the sched RCU callback we
+		 * cover both cases. So let us chain the SRCU and sched RCU
+		 * callbacks to wait for both grace periods.
+		 */
 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
-- 
2.18.0.203.gfac676dfb9-goog

