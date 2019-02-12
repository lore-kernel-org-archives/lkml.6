Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4B222A0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991717;
	bh=8gboCObjbpTEkDVseyi43LJ6tcAp1y+2M+vE4jwfyKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZo6bqRGarMsKRbq4PBotCTUr1JLLN5dnl69eZPJC087s9wmzo+kB/NqfKXRiF6w5
	 SDONQ8l7DURsoxztNG/ABNYIqG50lyZdgwB2VX1yN5x9EVlnGHjl1e1AOT3iLinjw+
	 hb8cDlWfv+IKYN4nNo587FFeJLbGNqn7BK+RZCVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfBLRPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfBLRPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:13 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF6821906;
        Tue, 12 Feb 2019 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991712;
        bh=8gboCObjbpTEkDVseyi43LJ6tcAp1y+2M+vE4jwfyKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cj5807BeqaTosswgLItGwIE9VvN93srVzvwmT0SipsAakQKo3ei6aCT6JnEw/e+nX
         dAjtjKeQgxB+0mDzPE25Y4zcEFhFaX1coFXjuQG3yjX8Te1bmP3Flloea+7SxESbds
         YOhoGdakxHDQdcHCmBT5w7mWswpWsrXSDaIz1Oyc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 13/32] softirq: Pass softirq vector number to lockdep on vector execution
Date:   Tue, 12 Feb 2019 18:14:04 +0100
Message-Id: <20190212171423.8308-14-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the softirq vector number to lockdep on callback execution so that
we know which one is involved while holding a lock. We will then be able
to pick up the proper LOCK_USED_IN_*_SOFTIRQ index to perform the
finegrained verifications.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/irqflags.h | 12 ++++++------
 kernel/softirq.c         |  8 ++++----
 lib/locking-selftest.c   |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..623030a74866 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -43,13 +43,13 @@ do {						\
 do {						\
 	current->hardirq_context--;		\
 } while (0)
-# define lockdep_softirq_enter()		\
+# define lockdep_softirq_enter(__VEC)		\
 do {						\
-	current->softirq_context++;		\
+	current->softirq_context |= BIT(__VEC);	\
 } while (0)
-# define lockdep_softirq_exit()			\
+# define lockdep_softirq_exit(__VEC)		\
 do {						\
-	current->softirq_context--;		\
+	current->softirq_context &= ~BIT(__VEC);\
 } while (0)
 #else
 # define trace_hardirqs_on()		do { } while (0)
@@ -60,8 +60,8 @@ do {						\
 # define trace_softirqs_enabled(p)	0
 # define trace_hardirq_enter()		do { } while (0)
 # define trace_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define lockdep_softirq_enter(vec)	do { } while (0)
+# define lockdep_softirq_exit(vec)	do { } while (0)
 #endif
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c..2dcaef813acb 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -229,18 +229,15 @@ static inline bool lockdep_softirq_start(void)
 		trace_hardirq_exit();
 	}
 
-	lockdep_softirq_enter();
-
 	return in_hardirq;
 }
 
 static inline void lockdep_softirq_end(bool in_hardirq)
 {
-	lockdep_softirq_exit();
-
 	if (in_hardirq)
 		trace_hardirq_enter();
 }
+
 #else
 static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
@@ -288,9 +285,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
+		lockdep_softirq_enter(vec_nr);
 		trace_softirq_entry(vec_nr);
 		h->action(h);
 		trace_softirq_exit(vec_nr);
+		lockdep_softirq_exit(vec_nr);
+
 		if (unlikely(prev_count != preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
 			       vec_nr, softirq_to_name[vec_nr], h->action,
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..2bd782d7f2e5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -197,11 +197,11 @@ static void init_shared_classes(void)
 #define SOFTIRQ_ENTER()				\
 		local_bh_disable();		\
 		local_irq_disable();		\
-		lockdep_softirq_enter();	\
+		lockdep_softirq_enter(0);	\
 		WARN_ON(!in_softirq());
 
 #define SOFTIRQ_EXIT()				\
-		lockdep_softirq_exit();		\
+		lockdep_softirq_exit(0);	\
 		local_irq_enable();		\
 		local_bh_enable();
 
-- 
2.17.1

