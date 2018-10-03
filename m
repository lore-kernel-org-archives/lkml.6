Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C722C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263B2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbgXTWb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJCUBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:01:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HW8L3WnqFcq1O/SPv7+njaNGQ246YjHyZv3phOYg6mw=; b=jbgXTWb8Fp4FkM3Id4I/ZF6NBu
        wl1Te7H1KjHLBG85pAU8E7OdRPaYm8i5805A9H6puft7F0f8CeK+m+tSf29CIGwMMqKXJX7jeOudz
        bZgWpkVniyUYFYWznMfopnqLwA+tl5QFxSUVz2K7Q/ceiLXN7AxpuwCfFZfv3uUvq6FWj9QsCkST2
        GAfB15uZsCyOJGxZL8CGmdvTPSd9EQ/ubyWMDSL0rJg/7bQx8SckouFmPllxs4Rn/FnrtTvKGhTFC
        PY9bp81hVr4N7Xvi4ntUzZBgp9KjK9H6MynvLHZaa/UFWin+w8NlxVFQKz5b9zJjYWIp0DmMGEB6f
        00p/5rYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7gxu-0003As-JO; Wed, 03 Oct 2018 13:13:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 24F0B2025A349; Wed,  3 Oct 2018 15:13:15 +0200 (CEST)
Message-ID: <20181003130957.183726335@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Oct 2018 15:03:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/4] locking/qspinlock, x86: Provide liveness guarantee
References: <20181003130257.156322446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 we cannot do fetch_or with a single instruction and thus end up
using a cmpxchg loop, this reduces determinism. Replace the fetch_or
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

 - the tas-pending must be a full word RmW, it cannot be an xchg8 for
   example, such that we cannot observe other state prior to setting
   pending.

On x86 we can realize this by using "LOCK BTS m32, r32" for
tas-pending followed by a regular load.

Note that observing later state is not a problem:

 - if we fail to observe a later unlock, we'll simply spin-wait for
   that store to become visible.

 - if we observe a later xchg_tail, there is no difference from that
   xchg_tail having taken place before the tas-pending.

Cc: mingo@kernel.org
Cc: tglx@linutronix.de
Cc: longman@redhat.com
Cc: andrea.parri@amarulasolutions.com
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/qspinlock.h |   15 +++++++++++++++
 kernel/locking/qspinlock.c       |   16 +++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

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
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -232,6 +232,20 @@ static __always_inline u32 xchg_tail(str
 #endif /* _Q_PENDING_BITS == 8 */
 
 /**
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
+/**
  * set_locked - Set the lock bit and own the lock
  * @lock: Pointer to queued spinlock structure
  *
@@ -328,7 +342,7 @@ void queued_spin_lock_slowpath(struct qs
 	 *
 	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
 	 */
-	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	val = queued_fetch_set_pending_acquire(lock);
 
 	/*
 	 * If we observe contention, there is a concurrent locker.


