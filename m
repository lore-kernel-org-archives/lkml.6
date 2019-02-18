Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001DF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mAEAIpPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfBRRkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388666AbfBRRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ejaQpxqudKwNSLwKp0g0iUi61iCkjaTLEmALw7BJbB0=; b=mAEAIpPvtcqglMCfB+ISF8eKK6
        WRy7KUv3DNc7cVGIjfPGBHT6ruCz3y8fZ2OEBNXVGe46ktWhBMc7GOyqPs84PEcaOdZK6LTs7GP2c
        EOrsJ6LVyHO2ZHyvJ6chfmClpgtzERwCxOVnWqoUVmmbOtzDd9Ln6e0Sl3pTGHNW0fAb6XRszrZNS
        /+Tn4ipTnpqVsd1x54vpuqDdX5vVh2MzQTjfaxbuQHz+thnhKOp51muvMGnT4KnIzTxNitDg73o8G
        ylp76XUM++6NrSg1S2vH1159SjWqypff9SkzpZq+XHwSQM5PHsw76+SXshTLlHDM7R88ThbQhU2sO
        GQawmzkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0005zA-Pc; Mon, 18 Feb 2019 17:40:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3885F2848B87C; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.478900066@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 10/16] sched: Core-wide rq->lock
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the basic infrastructure to have a core wide rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt |    8 +++-
 kernel/sched/core.c    |   93 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |   31 ++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -57,4 +57,10 @@ config PREEMPT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+	bool
+
+config SCHED_CORE
+	bool
+	default y
+	depends on SCHED_SMT
+
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -60,6 +60,70 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * The static-key + stop-machine variable are needed such that:
+ *
+ *	spin_lock(rq_lockp(rq));
+ *	...
+ *	spin_unlock(rq_lockp(rq));
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+static int __sched_core_stopper(void *data)
+{
+	bool enabled = !!(unsigned long)data;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	return 0;
+}
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	stop_machine(__sched_core_stopper, (void *)true, NULL);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	stop_machine(__sched_core_stopper, (void *)false, NULL);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
@@ -5862,6 +5926,28 @@ static void sched_rq_cpu_starting(unsign
 
 int sched_cpu_starting(unsigned int cpu)
 {
+#ifdef CONFIG_SCHED_CORE
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+		if (rq->core && rq->core == rq)
+			core_rq = rq;
+	}
+
+	if (!core_rq)
+		core_rq = cpu_rq(cpu);
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+
+		WARN_ON_ONCE(rq->core && rq->core != core_rq);
+		rq->core = core_rq;
+	}
+#endif /* CONFIG_SCHED_CORE */
+
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6088,6 +6176,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -952,6 +952,12 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -979,11 +985,36 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
 	return &rq->__lock;
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 


