Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955AF20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298486;
	bh=/u58DKUfUNaLnmRsiqMSgQoS1DZvMnlwSFo7yOfp48k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHUA6hGnkPZ9uppwhilllRtP8folL5q1tQF5rP0FRXvfRIyGJAtUPcVWwIyCTswlL
	 dv1ev3kg5wqxHw1AL7e6/5vjXOBkTuTjpe9J27X47YTr/ehcXXHk617gC8zla0daX1
	 JdxRvp8RnfxK5OEqTL1KrWixrhySwCDNN1MlGVGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbeLTJep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732675AbeLTJ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DD320656;
        Thu, 20 Dec 2018 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298154;
        bh=/u58DKUfUNaLnmRsiqMSgQoS1DZvMnlwSFo7yOfp48k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bH5+Qi16zyI/p80qB3R/H8aRvgzlQoXPzBdqBjylIVncv+BFETXSZ0hGDh3X2rQqq
         zSKI+tWBbeOWK3L/bKrXbI0HC9Gi/F+vvtOZroydHR+EZ3YUzF/Biq65yxjMppmYv4
         xEgZKgVIz7xCjUiBTnfwgP/djx+ki5Ad+4ima0KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/67] locking/qspinlock, x86: Provide liveness guarantee
Date:   Thu, 20 Dec 2018 10:18:14 +0100
Message-Id: <20181220085903.660728348@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.

On x86 we cannot do fetch_or() with a single instruction and thus end up
using a cmpxchg loop, this reduces determinism. Replace the fetch_or()
with a composite operation: tas-pending + load.

Using two instructions of course opens a window we previously did not
have. Consider the scenario:

	CPU0		CPU1		CPU2

 1)	lock
	  trylock -> (0,0,1)

 2)			lock
			  trylock /* fail */

 3)	unlock -> (0,0,0)

 4)					lock
					  trylock -> (0,0,1)

 5)			  tas-pending -> (0,1,1)
			  load-val <- (0,1,0) from 3

 6)			  clear-pending-set-locked -> (0,0,1)

			  FAIL: _2_ owners

where 5) is our new composite operation. When we consider each part of
the qspinlock state as a separate variable (as we can when
_Q_PENDING_BITS == 8) then the above is entirely possible, because
tas-pending will only RmW the pending byte, so the later load is able
to observe prior tail and lock state (but not earlier than its own
trylock, which operates on the whole word, due to coherence).

To avoid this we need 2 things:

 - the load must come after the tas-pending (obviously, otherwise it
   can trivially observe prior state).

 - the tas-pending must be a full word RmW instruction, it cannot be an XCHGB for
   example, such that we cannot observe other state prior to setting
   pending.

On x86 we can realize this by using "LOCK BTS m32, r32" for
tas-pending followed by a regular load.

Note that observing later state is not a problem:

 - if we fail to observe a later unlock, we'll simply spin-wait for
   that store to become visible.

 - if we observe a later xchg_tail(), there is no difference from that
   xchg_tail() having taken place before the tas-pending.

Suggested-by: Will Deacon <will.deacon@arm.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: andrea.parri@amarulasolutions.com
Cc: longman@redhat.com
Fixes: 59fb586b4a07 ("locking/qspinlock: Remove unbounded cmpxchg() loop from locking slowpath")
Link: https://lkml.kernel.org/r/20181003130957.183726335@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bigeasy: GEN_BINARY_RMWcc macro redo]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 21 +++++++++++++++++++++
 kernel/locking/qspinlock.c       | 17 ++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 3e70bed8a978..055c60a05756 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -6,9 +6,30 @@
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
+#include <asm/rmwcc.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
+#define queued_fetch_set_pending_acquire queued_fetch_set_pending_acquire
+
+static __always_inline bool __queued_RMW_btsl(struct qspinlock *lock)
+{
+	GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter,
+			 "I", _Q_PENDING_OFFSET, "%0", c);
+}
+
+static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
+{
+	u32 val = 0;
+
+	if (__queued_RMW_btsl(lock))
+		val |= _Q_PENDING_VAL;
+
+	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
+
+	return val;
+}
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ec343276f975..edd75e0c7d96 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -231,6 +231,20 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 }
 #endif /* _Q_PENDING_BITS == 8 */
 
+/**
+ * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
+ * @lock : Pointer to queued spinlock structure
+ * Return: The previous lock value
+ *
+ * *,*,* -> *,1,*
+ */
+#ifndef queued_fetch_set_pending_acquire
+static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
+{
+	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+}
+#endif
+
 /**
  * set_locked - Set the lock bit and own the lock
  * @lock: Pointer to queued spinlock structure
@@ -329,7 +343,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * 0,0,0 -> 0,0,1 ; trylock
 	 * 0,0,1 -> 0,1,1 ; pending
 	 */
-	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	val = queued_fetch_set_pending_acquire(lock);
+
 	/*
 	 * If we observe any contention; undo and queue.
 	 */
-- 
2.19.1



