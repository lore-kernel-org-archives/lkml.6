Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5481A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991677;
	bh=B+4Xs3900ZIfxAVOsoVcpsuM4zZ1FmkyNj31TryJhxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXjViu443T56DB51wvOfglMR2G5JJmRFGC2hqL0CXmLjCfbgPVJs/mGCbbRCeT3jW
	 +xiWNpHTW6ml2dvGbpYq9FAFKtSNCzhZReRCrGwQFIhhA14tsEP/y+ElpG+61mop/i
	 QBCNhBVunykbUxHBIf2Zcv/9OsnGqxg5gh96/5Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfBLROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfBLROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:34 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FFB20855;
        Tue, 12 Feb 2019 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991673;
        bh=B+4Xs3900ZIfxAVOsoVcpsuM4zZ1FmkyNj31TryJhxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOWniW6WPpwoZS/IKxzay0zkjFWpdK+jHSYE+u2Tg4PlcYtjdQuS/RtOkBSQ2kPvP
         63QHUkH5zxXpgYmN8rTn23LActkYLYhoxbk/58BZMe7HRBL0C1YqsHooF7nH89d35d
         nYXULQKAreYL+Csqh2QvCWRH+/rJmU+zXTe8cwk8=
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
Subject: [PATCH 01/32] locking/lockdep: Use expanded masks on find_usage_*() functions
Date:   Tue, 12 Feb 2019 18:13:52 +0100
Message-Id: <20190212171423.8308-2-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to perform softirq vector-finegrained locking validation we'll
need to be able to check multiple vector usages at once. Prepare the low
level usage mask check functions for that purpose.

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
 kernel/locking/lockdep.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 608f74ed8bb9..6127cef4f8fb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1335,9 +1335,9 @@ check_redundant(struct lock_list *root, struct lock_class *target,
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *bit)
+static inline int usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
+	return entry->class->usage_mask & *(u64 *)mask;
 }
 
 
@@ -1353,14 +1353,14 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  * Return <0 on error.
  */
 static int
-find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_forwards(struct lock_list *root, u64 usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1376,14 +1376,14 @@ find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
  * Return <0 on error.
  */
 static int
-find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_backwards(struct lock_list *root, u64 usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1588,7 +1588,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 	this.parent = NULL;
 
 	this.class = hlock_class(prev);
-	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
+	ret = find_usage_backwards(&this, BIT(bit_backwards), &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -1596,7 +1596,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
+	ret = find_usage_forwards(&that, BIT(bit_forwards), &target_entry1);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2553,7 +2553,7 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     u64 usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2561,7 +2561,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_forwards(&root, bit, &target_entry);
+	ret = find_usage_forwards(&root, usage_mask, &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2577,7 +2577,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      u64 usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2585,7 +2585,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_backwards(&root, bit, &target_entry);
+	ret = find_usage_backwards(&root, usage_mask, &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2644,7 +2644,7 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     enum lock_usage_bit bit, const char *name);
+			     u64 usage_mask, const char *name);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -2676,7 +2676,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, BIT(excl_bit), state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
@@ -2687,7 +2687,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+		    !usage(curr, this, BIT(excl_bit + LOCK_USAGE_READ_MASK),
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
-- 
2.17.1

