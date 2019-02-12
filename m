Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30603C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA3D218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991688;
	bh=rqZyMR/FWUfvxRNgZP/umTvm1CrdBxsGGYeSY7Qztsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyBxufz5tvFBZXc678Sj4ZfD/Upm31+ft6F/j8L1t8sJNnQxlouHV6S6efdaSz2sP
	 OBvtSIAfFkidj5JVhKJQZOZeTAWpnC1ubS5PuHlvXDYW8QoszNNem5jzQ1jrB2VbWv
	 fO+IXxHNZXE+DtIqCkcMD7z5Z58ue/wvf/nU7s20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfBLROq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbfBLROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:44 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870DB21773;
        Tue, 12 Feb 2019 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991683;
        bh=rqZyMR/FWUfvxRNgZP/umTvm1CrdBxsGGYeSY7Qztsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u31KEn6McXKCq1b356JCcMlgX1ncihiI3gOk/w0lVJd32gPNsXXjxlQtfR0EaOSl
         DhASlFxqqTj8ekGbcwo5Vo5HZMuhzfBUJLitWXMgCcZCWAqNMqC4iVDyV4bvoehl6t
         T5gtPHeFKe6c4gY8JNy8hbL0QPtyciVU/VxFTXrk=
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
Subject: [PATCH 04/32] locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
Date:   Tue, 12 Feb 2019 18:13:55 +0100
Message-Id: <20190212171423.8308-5-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prev_add_irq() tests all incompatible scenarios one after the
other while adding a lock (@next) to a tree dependency (@prev):

	LOCK_USED_IN_HARDIRQ          vs         LOCK_ENABLED_HARDIRQ
	LOCK_USED_IN_HARDIRQ_READ     vs         LOCK_ENABLED_HARDIRQ
	LOCK_USED_IN_SOFTIRQ          vs         LOCK_ENABLED_SOFTIRQ
	LOCK_USED_IN_SOFTIRQ_READ     vs         LOCK_ENABLED_SOFTIRQ

Also for these four scenarios, we must at least iterate the @prev
backward dependency. Then if it matches the relevant LOCK_USED_* bit,
we must also iterate the @next forward dependency.

Therefore in the best case we iterate 4 times, in the worst case 8 times.

Now things are going to become much worse as we plan to add as much
LOCK_USED_IN_{$VEC}_SOFTIRQ[_READ] as we have softirq vectors, currently
10. So the expanded test would be at least 22 loops and at most 44. We
can't really afford that.

So we take a different approach to fix this:

1) Iterate through @prev backward dependencies and accumulate all the IRQ
   uses in a single mask.

2) Iterate through @next forward dependencies and try to find a lock
   whose usage is exclusive to the accumulated usages gathered in the
   previous step. If we find one (call it @lockA), we have found an
   incompatible use.

3) Iterate again through @prev backward dependency and find the lock
   whose usage matches @lockA in term of incompatibility. Call that
   lock @lockB.

4) Report the incompatible usages of @lockA and @lockB

If no incompatible use is found, the verification never goes beyond
step 2 which means at most two iterations.

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
 kernel/locking/lockdep.c | 204 ++++++++++++++++++++++++++-------------
 1 file changed, 137 insertions(+), 67 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a977aa5976b7..578dd57f70d3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1329,6 +1329,14 @@ check_redundant(struct lock_list *root, struct lock_class *target,
 }
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+static inline int usage_accumulate(struct lock_list *entry, void *mask)
+{
+	*(u64 *)mask |= entry->class->usage_mask;
+
+	return 0;
+}
+
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -1340,8 +1348,6 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 	return entry->class->usage_mask & *(u64 *)mask;
 }
 
-
-
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -1575,39 +1581,6 @@ print_bad_irq_dependency(struct task_struct *curr,
 	return 0;
 }
 
-static int
-check_usage(struct task_struct *curr, struct held_lock *prev,
-	    struct held_lock *next, enum lock_usage_bit bit_backwards,
-	    enum lock_usage_bit bit_forwards, const char *irqclass)
-{
-	int ret;
-	struct lock_list this, that;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list *uninitialized_var(target_entry1);
-
-	this.parent = NULL;
-
-	this.class = hlock_class(prev);
-	ret = find_usage_backwards(&this, BIT(bit_backwards), &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
-
-	that.parent = NULL;
-	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, BIT(bit_forwards), &target_entry1);
-	if (ret < 0)
-		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
-
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			bit_backwards, bit_forwards, irqclass);
-}
-
 static const char *state_names[] = {
 #define LOCKDEP_STATE(__STATE) \
 	__stringify(__STATE),
@@ -1638,45 +1611,143 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
+static u64 __invert_mask(u64 mask, bool read)
+{
+	u64 excl_mask = 0;
+	int bit = 0;
+
+	while (mask) {
+		long fs = __ffs64(mask) + 1;
+		int excl;
+
+		mask >>= fs;
+		bit += fs;
+		excl = exclusive_bit(bit - 1);
+		excl_mask |= lock_flag(excl);
+		if (read)
+			excl_mask |= lock_flag(excl | LOCK_USAGE_READ_MASK);
+	}
+
+	return excl_mask;
+}
+
+static u64 exclusive_mask(u64 mask)
+{
+	return __invert_mask(mask, false);
+}
+
+/*
+ * Retrieve the _possible_ original mask to which @mask is
+ * exclusive. Ie: this is the opposite of exclusive_mask().
+ * Note that 2 possible original bits can match an exclusive
+ * bit: one has LOCK_USAGE_READ_MASK set, the other has it
+ * cleared. So both are returned for each exclusive bit.
+ */
+static u64 original_mask(u64 mask)
+{
+	return __invert_mask(mask, true);
+}
+
+/*
+ * Find the first pair of bit match between an original
+ * usage mask and an exclusive usage mask.
+ */
+static int find_exclusive_match(u64 mask, u64 excl_mask,
+				enum lock_usage_bit *bit,
+				enum lock_usage_bit *excl_bit)
+{
+	int nr = 0;
+
+	while (mask) {
+		long fs = __ffs64(mask) + 1;
+		int excl;
+
+		mask >>= fs;
+		nr += fs;
+
+		excl = exclusive_bit(nr - 1);
+		if (excl_mask & lock_flag(excl)) {
+			*bit = nr - 1;
+			*excl_bit = excl;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Prove that the new dependency does not connect a hardirq-safe(-read)
+ * lock with a hardirq-unsafe lock - to achieve this we search
+ * the backwards-subgraph starting at <prev>, and the
+ * forwards-subgraph starting at <next>:
+ */
 static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
-			   struct held_lock *next, enum lock_usage_bit bit)
+			   struct held_lock *next)
 {
+	enum lock_usage_bit forward_bit = 0, backward_bit = 0;
+	struct lock_list *uninitialized_var(target_entry1);
+	struct lock_list *uninitialized_var(target_entry);
+	u64 usage_mask = 0, forward_mask, backward_mask;
+	struct lock_list this, that;
+	int ret;
+
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * Step 1: gather all hard/soft IRQs usages backward in an
+	 * accumulated usage mask.
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	this.parent = NULL;
+	this.class = hlock_class(prev);
+
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	if (ret < 0)
+		return print_bfs_bug(ret);
 
-	bit++; /* _READ */
+	usage_mask &= LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ;
+	if (!usage_mask)
+		return 1;
 
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe-read
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * Step 2: find exclusive uses forward that match the previous
+	 * backward accumulated mask.
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	forward_mask = exclusive_mask(usage_mask);
 
-	return 1;
-}
+	that.parent = NULL;
+	that.class = hlock_class(next);
 
-static int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
-{
-#define LOCKDEP_STATE(__STATE)						\
-	if (!check_irq_usage(curr, prev, next, LOCK_USED_IN_##__STATE))	\
-		return 0;
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
+	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
+	if (ret < 0)
+		return print_bfs_bug(ret);
+	if (ret == 1)
+		return ret;
+
+	/*
+	 * Step 3: we found a bad match! Now retrieve a lock from the backward
+	 * list whose usage mask matches the exclusive usage mask from the
+	 * lock found on the forward list.
+	 */
+	backward_mask = original_mask(target_entry1->class->usage_mask);
+
+	ret = find_usage_backwards(&this, backward_mask, &target_entry);
+	if (ret < 0)
+		return print_bfs_bug(ret);
+	if (ret == 1)
+		return print_bfs_bug(ret);
+
+	/*
+	 * Step 4: narrow down to a pair of incompatible usage bits
+	 * and report it.
+	 */
+	ret = find_exclusive_match(target_entry->class->usage_mask,
+				   target_entry1->class->usage_mask,
+				   &backward_bit, &forward_bit);
+	WARN_ON_ONCE(ret == -1);
 
-	return 1;
+	return print_bad_irq_dependency(curr, &this, &that,
+			target_entry, target_entry1,
+			prev, next,
+			backward_bit, forward_bit,
+			state_name(backward_bit));
 }
 
 static void inc_chains(void)
@@ -1693,9 +1764,8 @@ static void inc_chains(void)
 
 #else
 
-static inline int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
 {
 	return 1;
 }
@@ -1857,7 +1927,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
-	if (!check_prev_add_irq(curr, prev, next))
+	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
 	/*
-- 
2.17.1

