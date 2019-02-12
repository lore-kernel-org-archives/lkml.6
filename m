Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E9C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D1D218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991694;
	bh=aad0bpcT6EwnNBwB6REovMO/9Y8vdp0bNoNds8FCyvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/XnY+9xLgDybFqk1aBbyyvduK87uXLW1ZqVtcKBua0YAZ6f8Zp6GwF1MtlU9NsXz
	 K9tesLmoMIJndgBQuA6kG1aLIU6lSDZ2dhaHJE3slm49mOx1BR8JGj5mez3nShWkGG
	 EHMLaPADjyJdZPN0A6Qx7PKiZUaxXklqq3SQ00x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfBLROw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbfBLROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:50 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF0C217D9;
        Tue, 12 Feb 2019 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991689;
        bh=aad0bpcT6EwnNBwB6REovMO/9Y8vdp0bNoNds8FCyvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B94VF5pRYRAwz8di2ge2/L+VA8XQbFz19ASoxLAAtZpajNgGed0PAQZdKbtSZa1CH
         pOoI0DdlDTVo6WvBS65r6li4EY5DRVQ7uvl2eC39bN7RTB0YLiHUUL9OUxrndh9SQv
         uvz4fr/wVFwtabfh1UyFJJ95fJsausj6dBi+79yM=
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
Subject: [PATCH 06/32] locking/lockdep: Prepare check_usage_*() to handle plain masks
Date:   Tue, 12 Feb 2019 18:13:57 +0100
Message-Id: <20190212171423.8308-7-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_lock_irq() is going to deal with lock usages that gather multiple
softirq vectors at once. Therefore the validation through
check_usage_backwards() and check_usage_forwards() will need to handle
expanded usage masks.

So enhance those functions to that purpose.

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
 kernel/locking/lockdep.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6b625b70598a..bb66327e5cc3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2660,9 +2660,12 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     u64 usage_mask, const char *irqclass)
+		     u64 usage_mask, bool read)
 {
 	int ret;
+	u64 intersec;
+	int intersec_bit;
+	const char *irqclass;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
@@ -2674,8 +2677,14 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
+	intersec = usage_mask & target_entry->class->usage_mask;
+	intersec_bit = __ffs64(intersec);
+	if (read)
+		intersec_bit += LOCK_USAGE_READ_MASK;
+	irqclass = state_name(intersec_bit);
+
 	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 1, irqclass);
+				       this, 1, irqclass);
 }
 
 /*
@@ -2684,9 +2693,12 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      u64 usage_mask, const char *irqclass)
+		      u64 usage_mask, bool read)
 {
 	int ret;
+	u64 intersec;
+	int intersec_bit;
+	const char *irqclass;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
@@ -2698,6 +2710,12 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
+	intersec = usage_mask & target_entry->class->usage_mask;
+	intersec_bit = __ffs64(intersec);
+	if (read)
+		intersec_bit += LOCK_USAGE_READ_MASK;
+	irqclass = state_name(intersec_bit);
+
 	return print_irq_inversion_bug(curr, &root, target_entry,
 					this, 0, irqclass);
 }
@@ -2751,7 +2769,7 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     u64 usage_mask, const char *name);
+			     u64 usage_mask, bool read);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -2787,7 +2805,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-	    !usage(curr, this, lock_usage_mask(&excl_usage), state_name(new_usage->bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, lock_usage_mask(&excl_usage), false))
 		return 0;
 
 	/*
@@ -2801,7 +2819,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 
 		if (STRICT_READ_CHECKS &&
 		    !usage(curr, this, lock_usage_mask(&excl_usage),
-			   state_name(new_usage->bit + LOCK_USAGE_READ_MASK)))
+			       true))
 			return 0;
 	}
 
-- 
2.17.1

