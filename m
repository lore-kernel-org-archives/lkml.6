Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE83C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0317222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991746;
	bh=7PxGbo3ThfFvVxxmdhESNQFl20XJ1rVOL8kAmHr7fyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgUYEWNnUU7hFM2tyKjc2vW+oGzi4k2VOIBlgyPXGfdeC5CcqZTnpjbrW3Iti3wdW
	 /EWm8u+US1mdrEsjD8DstjNA/s4urZMx1ZOV2mNoJqNuavtpAC1cHJNEKGjU6IZA6D
	 sYV5xmsYpmwXN9eQ98fgmpD75xsvjwmiB8BliJ3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfBLRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfBLRPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:43 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A50222AD;
        Tue, 12 Feb 2019 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991741;
        bh=7PxGbo3ThfFvVxxmdhESNQFl20XJ1rVOL8kAmHr7fyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nr7TdTLsx7nnKguo/712NX5WVCjyr8OVPtOsidi9uHW5LXFM9s0gqhwGSaTahGopi
         A/FAnXJ9qKdxxxOyD7cdebpq3RXWztNpkjdV3afLomWCVaoDSgJklLsNab4SXt0MUP
         7XRw6kqF5S5i96EKU3FFYcMZe53/0ASRoZmRtu9E=
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
Subject: [PATCH 22/32] softirq: Check enabled vectors before processing
Date:   Tue, 12 Feb 2019 18:14:13 +0100
Message-Id: <20190212171423.8308-23-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to process softirqs if none of those pending are
enabled. Check about that early to avoid unnecessary overhead.

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
 include/linux/interrupt.h |  5 +++++
 kernel/softirq.c          | 21 +++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 346fb1e8e55b..161babfc1a0d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -508,6 +508,11 @@ static inline void softirq_pending_set_mask(unsigned int pending)
 {
 	__this_cpu_or(local_softirq_data_ref, pending);
 }
+
+static inline int softirq_pending_enabled(void)
+{
+	return local_softirq_pending() & local_softirq_enabled();
+}
 #endif /* local_softirq_pending */
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d305b4c8d1a7..a2257a5aaa0b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -181,7 +181,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	preempt_count_sub(cnt - 1);
 
-	if (unlikely(!in_interrupt() && local_softirq_pending())) {
+	if (unlikely(!in_interrupt() && softirq_pending_enabled())) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
 		 * as we may be calling this deep in a task call stack already.
@@ -250,7 +250,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
-	__u32 pending;
+	__u32 pending, enabled;
 	int softirq_bit;
 
 	/*
@@ -260,7 +260,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
-	pending = local_softirq_pending();
+	enabled = local_softirq_enabled();
+	pending = local_softirq_pending() & enabled;
 	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
@@ -268,7 +269,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	softirq_pending_clear_mask(SOFTIRQ_ALL_MASK);
+	softirq_pending_clear_mask(pending);
 
 	local_irq_enable();
 
@@ -305,7 +306,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
+	pending = local_softirq_pending() & enabled;
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
@@ -331,7 +332,7 @@ asmlinkage __visible void do_softirq(void)
 
 	local_irq_save(flags);
 
-	pending = local_softirq_pending();
+	pending = softirq_pending_enabled();
 
 	if (pending && !ksoftirqd_running(pending))
 		do_softirq_own_stack();
@@ -360,7 +361,7 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running(local_softirq_pending()))
+	if (ksoftirqd_running(softirq_pending_enabled()))
 		return;
 
 	if (!force_irqthreads) {
@@ -409,7 +410,7 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
+	if (!in_interrupt() && softirq_pending_enabled())
 		invoke_softirq();
 
 	tick_irq_exit();
@@ -640,13 +641,13 @@ void __init softirq_init(void)
 
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return local_softirq_pending();
+	return softirq_pending_enabled();
 }
 
 static void run_ksoftirqd(unsigned int cpu)
 {
 	local_irq_disable();
-	if (local_softirq_pending()) {
+	if (softirq_pending_enabled()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
-- 
2.17.1

