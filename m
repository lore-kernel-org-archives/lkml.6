Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C8FC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ADA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991681;
	bh=KRcc9pXyWb4b66HO/m+2usC8fXwyvTRyeLW7zNQ47PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+W35qAvyOV3Vzw2YJfhQW4kbwNPsU3xkOm4rIBF6P8h45R9NTqn0rPA3K3rxFQBk
	 1aNXyXo/jYnQpgnSuWiqKZwklNIJvUUtkLZbgeQYB9E5AhCsEbF4L4Y4asVHi7lFet
	 uRrvdcj73TX3/a0IZiBim0UQJFEz3XUCCixI5QWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfBLROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfBLROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:38 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CE9217FA;
        Tue, 12 Feb 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991676;
        bh=KRcc9pXyWb4b66HO/m+2usC8fXwyvTRyeLW7zNQ47PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoCxMitIc3boT9eMHV56Dred9dd82lqp1Bjmt+1U8ue6Ki/C5MUsBPoTNEmRl0mYc
         3wvRAvyOnuUfS55Gd1eQ4f0az5FmUe/vBmH2l89sI+ZB9D/0ax9TyMvqXhzcfK/SFy
         ppZElVbKtWbAu8MiAIzknYTfjFnqbRyFsxb8wST4=
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
Subject: [PATCH 02/32] locking/lockdep: Introduce struct lock_usage
Date:   Tue, 12 Feb 2019 18:13:53 +0100
Message-Id: <20190212171423.8308-3-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support softirq per-vector locking validation, we could
simply iterate over all enabled vectors and perform separate validation
for all of them on every lock event. We can expect that to introduce a
severe performance penalty though.

Therefore, we instead plan to validate the LOCK_USED_IN_*_SOFTIRQ and
LOCK_ENABLED_*_SOFTIRQ events with grouping the involved softirq vector
bits. It implies that we'll rather validate expanded usage mask than
usage bit in the end.

Before the usage mask to be expanded though, we need to play with the
usage bit that defines the nature of the event relevant to a group of
vectors.

Introduce struct lock_usage to implement that. This is made of the
classical lock usage bit that defines the nature of a lock usage
along which we carry the vectors to which that usage applies.

Once high level functions are done dealing with the nature of the lock
usage, lower level functions dealing with validation can expand the
struct lock_usage to a usage mask through lock_usage_mask().

For now, vector is always 0 until we get the proper vector finegrained
informations on softirq usage events.

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
 kernel/locking/lockdep.c           | 121 +++++++++++++++++------------
 kernel/locking/lockdep_internals.h |   6 ++
 2 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6127cef4f8fb..1bb955d22eae 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2466,6 +2466,11 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	return 0;
 }
 
+static u64 lock_usage_mask(struct lock_usage *usage)
+{
+	return BIT(usage->bit);
+}
+
 /*
  * Print out an error if an invalid bit is set:
  */
@@ -2479,7 +2484,7 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 }
 
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
+		     struct lock_usage *new_usage);
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
@@ -2648,11 +2653,14 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+	      struct lock_usage *new_usage)
 {
-	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & LOCK_USAGE_READ_MASK;
-	int dir = new_bit & LOCK_USAGE_DIR_MASK;
+	struct lock_usage excl_usage = {
+		.bit = exclusive_bit(new_usage->bit),
+		.vector = new_usage->vector
+	};
+	int read = new_usage->bit & LOCK_USAGE_READ_MASK;
+	int dir = new_usage->bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * mark USED_IN has to look forwards -- to ensure no dependency
@@ -2668,7 +2676,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
-	if (!valid_state(curr, this, new_bit, excl_bit))
+	if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
 		return 0;
 
 	/*
@@ -2676,23 +2684,24 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-	    !usage(curr, this, BIT(excl_bit), state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, lock_usage_mask(&excl_usage), state_name(new_usage->bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
 	 * Check for read in write conflicts
 	 */
 	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
+		excl_usage.bit += LOCK_USAGE_READ_MASK;
+		if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-		    !usage(curr, this, BIT(excl_bit + LOCK_USAGE_READ_MASK),
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+		    !usage(curr, this, lock_usage_mask(&excl_usage),
+			   state_name(new_usage->bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
-	if (state_verbose(new_bit, hlock_class(this)))
+	if (state_verbose(new_usage->bit, hlock_class(this)))
 		return 2;
 
 	return 1;
@@ -2702,24 +2711,24 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
  * Mark all held locks with a usage bit:
  */
 static int
-mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
+mark_held_locks(struct task_struct *curr, struct lock_usage *base_usage)
 {
 	struct held_lock *hlock;
 	int i;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
-		enum lock_usage_bit hlock_bit = base_bit;
+		struct lock_usage hlock_usage = *base_usage;
 		hlock = curr->held_locks + i;
 
 		if (hlock->read)
-			hlock_bit += LOCK_USAGE_READ_MASK;
+			hlock_usage.bit += LOCK_USAGE_READ_MASK;
 
-		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
+		BUG_ON(hlock_usage.bit >= LOCK_USAGE_STATES);
 
 		if (!hlock->check)
 			continue;
 
-		if (!mark_lock(curr, hlock, hlock_bit))
+		if (!mark_lock(curr, hlock, &hlock_usage))
 			return 0;
 	}
 
@@ -2732,6 +2741,7 @@ mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 static void __trace_hardirqs_on_caller(unsigned long ip)
 {
 	struct task_struct *curr = current;
+	struct lock_usage usage = { .bit = LOCK_ENABLED_HARDIRQ };
 
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
@@ -2740,16 +2750,18 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
 	 */
-	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
+	if (!mark_held_locks(curr, &usage))
 		return;
 	/*
 	 * If we have softirqs enabled, then set the usage
 	 * bit for all held locks. (disabled hardirqs prevented
 	 * this bit from being set before)
 	 */
-	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
+	if (curr->softirqs_enabled) {
+		usage.bit = LOCK_ENABLED_SOFTIRQ;
+		if (!mark_held_locks(curr, &usage))
 			return;
+	}
 
 	curr->hardirq_enable_ip = ip;
 	curr->hardirq_enable_event = ++curr->irq_events;
@@ -2832,6 +2844,9 @@ void lockdep_hardirqs_off(unsigned long ip)
 void trace_softirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
+	struct lock_usage usage = {
+		.bit = LOCK_ENABLED_SOFTIRQ,
+	};
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -2862,7 +2877,7 @@ void trace_softirqs_on(unsigned long ip)
 	 * enabled too:
 	 */
 	if (curr->hardirqs_enabled)
-		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
+		mark_held_locks(curr, &usage);
 	current->lockdep_recursion = 0;
 }
 
@@ -2900,46 +2915,55 @@ void trace_softirqs_off(unsigned long ip)
 
 static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 {
+	struct lock_usage usage = { .vector = 0 };
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_HARDIRQ_READ))
+			if (curr->hardirq_context) {
+				usage.bit = LOCK_USED_IN_HARDIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_SOFTIRQ_READ))
+			}
+			if (curr->softirq_context) {
+				usage.bit = LOCK_USED_IN_SOFTIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		} else {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
+			if (curr->hardirq_context) {
+				usage.bit = LOCK_USED_IN_HARDIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
+			}
+			if (curr->softirq_context) {
+				usage.bit = LOCK_USED_IN_SOFTIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		}
 	}
 	if (!hlock->hardirqs_off) {
 		if (hlock->read) {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ_READ))
+			usage.bit = LOCK_ENABLED_HARDIRQ_READ;
+			if (!mark_lock(curr, hlock, &usage))
 				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ_READ))
+			if (curr->softirqs_enabled) {
+				usage.bit = LOCK_ENABLED_SOFTIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		} else {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ))
+			usage.bit = LOCK_ENABLED_HARDIRQ;
+			if (!mark_lock(curr, hlock, &usage))
 				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ))
+			if (curr->softirqs_enabled) {
+				usage.bit = LOCK_ENABLED_SOFTIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		}
 	}
 
@@ -2978,7 +3002,7 @@ static int separate_irq_context(struct task_struct *curr,
 
 static inline
 int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+		  struct lock_usage *new_usage)
 {
 	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
 	return 1;
@@ -3007,9 +3031,9 @@ static inline int separate_irq_context(struct task_struct *curr,
  * Mark a lock with a usage bit, and validate the state transition:
  */
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-			     enum lock_usage_bit new_bit)
+		     struct lock_usage *new_usage)
 {
-	unsigned int new_mask = 1 << new_bit, ret = 1;
+	u64 new_mask = lock_usage_mask(new_usage), ret = 1;
 
 	/*
 	 * If already set then do not dirty the cacheline,
@@ -3030,10 +3054,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	hlock_class(this)->usage_mask |= new_mask;
 
-	if (!save_trace(hlock_class(this)->usage_traces + new_bit))
+	if (!save_trace(hlock_class(this)->usage_traces + new_usage->bit))
 		return 0;
 
-	switch (new_bit) {
+	switch (new_usage->bit) {
 #define LOCKDEP_STATE(__STATE)			\
 	case LOCK_USED_IN_##__STATE:		\
 	case LOCK_USED_IN_##__STATE##_READ:	\
@@ -3041,7 +3065,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	case LOCK_ENABLED_##__STATE##_READ:
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
-		ret = mark_lock_irq(curr, this, new_bit);
+		ret = mark_lock_irq(curr, this, new_usage);
 		if (!ret)
 			return 0;
 		break;
@@ -3061,7 +3085,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
+		printk("\nmarked lock as {%s}:\n", usage_str[new_usage->bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
@@ -3185,6 +3209,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	struct task_struct *curr = current;
 	struct lock_class *class = NULL;
+	struct lock_usage usage = { .bit = LOCK_USED };
 	struct held_lock *hlock;
 	unsigned int depth;
 	int chain_head = 0;
@@ -3278,7 +3303,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		return 0;
 
 	/* mark it as used: */
-	if (!mark_lock(curr, hlock, LOCK_USED))
+	if (!mark_lock(curr, hlock, &usage))
 		return 0;
 
 	/*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2ebb9d0ea91c..e714c823f594 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -26,6 +26,12 @@ enum lock_usage_bit {
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
 
+struct lock_usage {
+	enum lock_usage_bit bit;
+	unsigned long vector; /* Softirq vector */
+};
+
+
 /*
  * Usage-state bitmasks:
  */
-- 
2.17.1

