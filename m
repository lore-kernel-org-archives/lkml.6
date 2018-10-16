Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C588EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B6C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B6C2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJPX5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:57:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:57:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9GG64Oq4158990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Oct 2018 09:06:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9GG64Oo4158987;
        Tue, 16 Oct 2018 09:06:04 -0700
Date:   Tue, 16 Oct 2018 09:06:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-7aa54be2976550f17c11a1c3e3630002dea39303@git.kernel.org>
Cc:     will.deacon@arm.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          will.deacon@arm.com, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20181003130957.183726335@infradead.org>
References: <20181003130957.183726335@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock, x86: Provide liveness
 guarantee
Git-Commit-ID: 7aa54be2976550f17c11a1c3e3630002dea39303
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7aa54be2976550f17c11a1c3e3630002dea39303
Gitweb:     https://git.kernel.org/tip/7aa54be2976550f17c11a1c3e3630002dea39303
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 26 Sep 2018 13:01:20 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 17:33:54 +0200

locking/qspinlock, x86: Provide liveness guarantee

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
---
 arch/x86/include/asm/qspinlock.h | 15 +++++++++++++++
 kernel/locking/qspinlock.c       | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 3e70bed8a978..87623c6b13db 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -6,9 +6,24 @@
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
+#include <asm/rmwcc.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
+#define queued_fetch_set_pending_acquire queued_fetch_set_pending_acquire
+static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
+{
+	u32 val = 0;
+
+	if (GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
+			     "I", _Q_PENDING_OFFSET))
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
index 47cb99787e4d..341ca666bc60 100644
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
@@ -328,7 +342,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
 	 */
-	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	val = queued_fetch_set_pending_acquire(lock);
 
 	/*
 	 * If we observe contention, there is a concurrent locker.
