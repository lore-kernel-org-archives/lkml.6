Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F51C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFE216F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0PR8k4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCFE216F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeGFOxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:53:37 -0400
Received: from casper.infradead.org ([85.118.1.10]:34458 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbeGFOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kODEG89nXkc44PLGEC2/P3HC6HjzRC6SHfOe2aQ92QA=; b=d0PR8k4bLa1pLvndTC0UmLlPy2
        TeQPp0ACYhPjQrbErySLwhfX10VxNsrw+YWeB7L9/YPWh7F5C2YVkHvvgcMHB7q9H0T7Vr/aLLVV5
        4CME27oT4amMOcSeyZWRGfeFV+oZLHXzxXlYPtXWfuGaX48BRC4kA7sTkvufkXqnA9EV8Fse+kQXJ
        ctj3toDp3fV6Cgq4YbysA0IhgojtdjPUP6l977KnVSlp6VqyYskrMzjZ59Cus4msMTMGK5PKusqNh
        47PTQ2pAfzJf1RoWWm//niOwB9gLhHSJF6KvDtdOacOu2FMYNY8TGx1Oxs98glfo5qg5dpRZGGEnx
        3Y9Y0EAg==;
Received: from i7.infradead.org ([90.155.92.213])
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbS70-0006mE-Md; Fri, 06 Jul 2018 14:53:30 +0000
Message-ID: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
Subject: [RFC] Make need_resched() return true when rcu_urgent_qs requested
From:   David Woodhouse <dwmw2@infradead.org>
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 06 Jul 2018 15:53:30 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 4.15 without CONFIG_PREEMPT we observed expand_fdtable() taking
about 10 seconds for synchronize_sched() to complete, when most of the
other threads were running KVM guests.

In vcpu_run() there's a loop with the fairly common construct:

  if (need_resched()) {
      … local unlocks …
      cond_resched();
      … local locks …
  }

But because need_resched() wasn't true (until half the RCU warning time
was completed and rcu_implicit_dynticks_qs() calls resched_cpu()), that
never happens and cond_resched() is never called. In cond_resched()
there is an unconditional call to rcu_all_qs() which would DTRT.

Now, there's a simple way to fix it for the specific case of KVM — we
can find a place we can just call rcu_all_qs(), something like this:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 00520711..a304693 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7214,6 +7214,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	smp_mb__after_srcu_read_unlock();
 
+	/* Force quiescent state (if requested) before entering guest mode */
+	rcu_all_qs();
+
 	/*
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.


But I wonder if we should attempt to fix the general case by making
need_resched() return true when an RCU quiescent state is needed. To do
that without having an out-of-line function call in kernel/rcu/tree.c
would look something like the patch below. Paul, did you say you had
other ideas about how to export/inline it?

Alternatively — or perhaps additionally — shouldn't CPUs which are
currently in guest mode be counted as quiescent anyway? Or is that
something we'll only ever want to do in full NOHZ mode?

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b3dbf95..2f8a3bd 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -126,6 +126,7 @@ static inline bool rcu_is_watching(void) { return true; }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
+static inline bool rcu_urgent_qs_requested(void) { return false; }
 
 /* RCUtree hotplug events */
 #define rcutree_prepare_cpu      NULL
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 37d6fd3..d20b987 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -30,6 +30,36 @@
 #ifndef __LINUX_RCUTREE_H
 #define __LINUX_RCUTREE_H
 
+/*
+ * Dynticks per-CPU state.
+ */
+struct rcu_dynticks {
+	long long dynticks_nesting; /* Track irq/process nesting level. */
+				    /* Process level is worth LLONG_MAX/2. */
+	int dynticks_nmi_nesting;   /* Track NMI nesting level. */
+	atomic_t dynticks;	    /* Even value for idle, else odd. */
+	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
+	unsigned long rcu_qs_ctr;   /* Light universal quiescent state ctr. */
+	bool rcu_urgent_qs;	    /* GP old need light quiescent state. */
+#ifdef CONFIG_RCU_FAST_NO_HZ
+	bool all_lazy;		    /* Are all CPU's CBs lazy? */
+	unsigned long nonlazy_posted;
+				    /* # times non-lazy CBs posted to CPU. */
+	unsigned long nonlazy_posted_snap;
+				    /* idle-period nonlazy_posted snapshot. */
+	unsigned long last_accelerate;
+				    /* Last jiffy CBs were accelerated. */
+	unsigned long last_advance_all;
+				    /* Last jiffy CBs were all advanced. */
+	int tick_nohz_enabled_snap; /* Previously seen value from sysfs. */
+#endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
+};
+DECLARE_PER_CPU(struct rcu_dynticks, rcu_dynticks);
+static __always_inline bool rcu_urgent_qs_requested(void)
+{
+	return unlikely(raw_cpu_read(rcu_dynticks.rcu_urgent_qs));
+}
+
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(u64 basem, u64 *nextevt);
 void rcu_cpu_stall_reset(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4d4e60..89f5814 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1616,7 +1616,8 @@ static inline int spin_needbreak(spinlock_t *lock)
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(tif_need_resched()) ||
+		rcu_urgent_qs_requested();
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f9c0ca2..cf1c66c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -264,10 +264,11 @@ void rcu_bh_qs(void)
 #define rcu_eqs_special_exit() do { } while (0)
 #endif
 
-static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
+DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
 	.dynticks_nesting = DYNTICK_TASK_EXIT_IDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
+EXPORT_SYMBOL(rcu_dynticks); /* for need_resched() */
 
 /*
  * There's a few places, currently just in the tracing infrastructure,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 46a5d19..462b25b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -34,31 +34,6 @@
 
 #include "rcu_segcblist.h"
 
-/*
- * Dynticks per-CPU state.
- */
-struct rcu_dynticks {
-	long long dynticks_nesting; /* Track irq/process nesting level. */
-				    /* Process level is worth LLONG_MAX/2. */
-	int dynticks_nmi_nesting;   /* Track NMI nesting level. */
-	atomic_t dynticks;	    /* Even value for idle, else odd. */
-	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
-	unsigned long rcu_qs_ctr;   /* Light universal quiescent state ctr. */
-	bool rcu_urgent_qs;	    /* GP old need light quiescent state. */
-#ifdef CONFIG_RCU_FAST_NO_HZ
-	bool all_lazy;		    /* Are all CPU's CBs lazy? */
-	unsigned long nonlazy_posted;
-				    /* # times non-lazy CBs posted to CPU. */
-	unsigned long nonlazy_posted_snap;
-				    /* idle-period nonlazy_posted snapshot. */
-	unsigned long last_accelerate;
-				    /* Last jiffy CBs were accelerated. */
-	unsigned long last_advance_all;
-				    /* Last jiffy CBs were all advanced. */
-	int tick_nohz_enabled_snap; /* Previously seen value from sysfs. */
-#endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-};
-
 /* RCU's kthread states for tracing. */
 #define RCU_KTHREAD_STOPPED  0
 #define RCU_KTHREAD_RUNNING  1

-- 
dwmw2
