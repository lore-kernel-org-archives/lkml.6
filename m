Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C12151D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+oeG06z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7C12151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJKGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJKGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:17 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F2C2150D;
        Wed, 10 Oct 2018 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213235;
        bh=RiKlDg+Trhv3y1Z0tdc2lvJp3U7mr0W1raONZVeo9z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+oeG06zckh3UhTJUAu3ouXpMgb5y8MvhTk5zZ5apfgnTITvSemyS9r6pAcQqVUqF
         IMmu6UWANH33RkBjvvKHy1gA9IskxtVOE81eIBf/pi6R+RvSMLC2FgTyEnzehgMuDt
         hZH/Tb53AqNMrvysZ13Xz5bDMtkfcj5bEj5Nql3U=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 27/30] softirq: Swap softirq serving VS disable on preempt mask layout
Date:   Thu, 11 Oct 2018 01:12:14 +0200
Message-Id: <1539213137-13953-28-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current softirq_count() layout is designed as followed:

* Serving the softirq is done under SOFTIRQ_OFFSET. It makes the
  softirq_count() odd and since it can't nest, due to softirq serving
  not being re-entrant, it's fine to differenciate it from softirq
  disablement that use even values.

* Disable the softirq is done under SOFTIRQ_OFFSET * 2. This can nest,
  so increment of even values is fine to differenciate it from serving
  softirqs.

Now the design is going to change:

* Serving softirqs will need to be re-entrant to allow a vector to
  interrupt another.

* Disable softirqs can't nest anymore at the softirq_count() level.
  This is all driven by the vector disabled mask now.

In order to support this new layout, simply swap them. Serving softirqs
now use even value increments and disable softirqs now use odd value
toggle.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/bottom_half.h |  6 +++---
 include/linux/preempt.h     |  9 +++++----
 kernel/softirq.c            | 21 +++++++++++----------
 kernel/trace/ring_buffer.c  |  2 +-
 kernel/trace/trace.c        |  2 +-
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index f8a68c8..74c986a 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -49,7 +49,7 @@ static __always_inline unsigned int __local_bh_disable_ip(unsigned long ip, unsi
 
 static inline unsigned int local_bh_disable(unsigned int mask)
 {
-	return __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET, mask);
+	return __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_OFFSET, mask);
 }
 
 extern void local_bh_enable_no_softirq(unsigned int bh);
@@ -58,12 +58,12 @@ extern void __local_bh_enable_ip(unsigned long ip,
 
 static inline void local_bh_enable_ip(unsigned long ip, unsigned int bh)
 {
-	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET, bh);
+	__local_bh_enable_ip(ip, SOFTIRQ_OFFSET, bh);
 }
 
 static inline void local_bh_enable(unsigned int bh)
 {
-	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET, bh);
+	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_OFFSET, bh);
 }
 
 extern void local_bh_disable_all(void);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index cf3fc3c..c4d9672 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -51,7 +51,8 @@
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 #define NMI_OFFSET	(1UL << NMI_SHIFT)
 
-#define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
+#define SOFTIRQ_SERVING_OFFSET	(2 * SOFTIRQ_OFFSET)
+#define SOFTIRQ_SERVING_MASK (SOFTIRQ_MASK & ~SOFTIRQ_OFFSET)
 
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
@@ -101,10 +102,10 @@
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_serving_softirq()	(softirq_count() & ~SOFTIRQ_OFFSET)
 #define in_nmi()		(preempt_count() & NMI_MASK)
 #define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_SERVING_MASK)))
 
 /*
  * The preempt_count offset after preempt_disable();
@@ -133,7 +134,7 @@
  *
  * Work as expected.
  */
-#define SOFTIRQ_LOCK_OFFSET (SOFTIRQ_DISABLE_OFFSET + PREEMPT_LOCK_OFFSET)
+#define SOFTIRQ_LOCK_OFFSET (SOFTIRQ_OFFSET + PREEMPT_LOCK_OFFSET)
 
 /*
  * Are we running in atomic context?  WARNING: this macro cannot
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 84da16c..3efa59e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -163,13 +163,13 @@ void local_bh_enable_no_softirq(unsigned int bh)
 	if (bh != SOFTIRQ_ALL_MASK)
 		return;
 			
-	if (preempt_count() == SOFTIRQ_DISABLE_OFFSET)
+	if (preempt_count() == SOFTIRQ_OFFSET)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
-	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
+	if (softirq_count() == SOFTIRQ_OFFSET)
 		trace_softirqs_on(_RET_IP_);
 
-	__preempt_count_sub(SOFTIRQ_DISABLE_OFFSET);
+	__preempt_count_sub(SOFTIRQ_OFFSET);
 }
 EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
@@ -181,9 +181,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt, unsigned int bh)
 	local_irq_disable();
 #endif
 	softirq_enabled_set(bh);
+
 	if (bh != SOFTIRQ_ALL_MASK) {
 		cnt &= ~SOFTIRQ_MASK;
-	} else if (!(softirq_count() & SOFTIRQ_OFFSET)) {
+	} else if (!(softirq_count() & SOFTIRQ_SERVING_MASK)) {
 		/* Are softirqs going to be turned on now: */
 		trace_softirqs_on(ip);
 	}
@@ -235,15 +236,15 @@ static void local_bh_enter(unsigned long ip)
 	 * We must manually increment preempt_count here and manually
 	 * call the trace_preempt_off later.
 	 */
-	__preempt_count_add(SOFTIRQ_OFFSET);
+	__preempt_count_add(SOFTIRQ_SERVING_OFFSET);
 	/*
 	 * Were softirqs turned off above:
 	 */
-	if (softirq_count() == SOFTIRQ_OFFSET)
+	if (softirq_count() == SOFTIRQ_SERVING_OFFSET)
 		trace_softirqs_off(ip);
 	raw_local_irq_restore(flags);
 
-	if (preempt_count() == SOFTIRQ_OFFSET) {
+	if (preempt_count() == SOFTIRQ_SERVING_OFFSET) {
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = get_lock_parent_ip();
 #endif
@@ -255,13 +256,13 @@ static void local_bh_exit(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (preempt_count() == SOFTIRQ_OFFSET)
+	if (preempt_count() == SOFTIRQ_SERVING_OFFSET)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
-	if (softirq_count() == SOFTIRQ_OFFSET)
+	if (softirq_count() == SOFTIRQ_SERVING_OFFSET)
 		trace_softirqs_on(_RET_IP_);
 
-	__preempt_count_sub(SOFTIRQ_OFFSET);
+	__preempt_count_sub(SOFTIRQ_SERVING_OFFSET);
 }
 
 /*
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 65bd461..0fedc5c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2655,7 +2655,7 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 	unsigned long pc = preempt_count();
 	int bit;
 
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+	if (in_task())
 		bit = RB_CTX_NORMAL;
 	else
 		bit = pc & NMI_MASK ? RB_CTX_NMI :
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d7..af1abd6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2143,7 +2143,7 @@ tracing_generic_entry_update(struct trace_entry *entry, unsigned long flags,
 #endif
 		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
 		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
-		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
+		((pc & SOFTIRQ_SERVING_MASK) ? TRACE_FLAG_SOFTIRQ : 0) |
 		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
 		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
 }
-- 
2.7.4

