Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B914C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE7214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTuC0ivr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDE7214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIZRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:42:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ScREfY/m01Q+rj6NtM6gIoilNFE1Urq+Q7uEIAMBxAk=; b=NTuC0ivr77kTejixPvmzpUi+6x
        sOUmWbxHYwb68WhSVDFdJij44YzANCImsYHxb+O5cqhJ/4E6r/YYus1arb2TSDise3TzSOSDT3N3g
        egtIXUZkunO8I4c6Qp2cArcQ3WrryDYbuar1j08Ifv8l+QYGjXG2p9DnorAY+3spDJzISi7zOnAjS
        xn3nqdEl94xeCVyEknhNnVcz+Nrh6gO5FjqE49UkXw1iwIREwsKmGVvcxDwq+EMv+4Z2KsaqEFCgP
        cUEWXSKM08VhKBjocY0BtxH51sT+cL0/j7vHGjJDbxaPF3WHaRdsdXrkrgmjlk6HlBIBRNJDb5dTr
        le+COeOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g580X-00055f-KY; Wed, 26 Sep 2018 11:29:49 +0000
Received: by worktop (Postfix, from userid 0)
        id C29486E0846; Wed, 26 Sep 2018 13:29:27 +0200 (CEST)
Message-Id: <20180926111307.513429499@infradead.org>
User-Agent: quilt/0.61-1
Date:   Wed, 26 Sep 2018 13:01:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
References: <20180926110117.405325143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-qspinlock-opt-5.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 we cannot do fetch_or with a single instruction and end up
using a cmpxchg loop, this reduces determinism. Replace the fetch_or
with a very tricky composite xchg8 + load.

The basic idea is that we use xchg8 to test-and-set the pending bit
(when it is a byte) and then a load to fetch the whole word. Using
two instructions of course opens a window we previously did not have.
In particular the ordering between pending and tail is of interrest,
because that is where the split happens.

The claim is that if we order them, it all works out just fine. There
are two specific cases where the pending,tail state changes:

 - when the 3rd lock(er) comes in and finds pending set, it'll queue
   and set tail; since we set tail while pending is set, the ordering
   is split is not important (and not fundamentally different form
   fetch_or). [*]

 - when the last queued lock holder acquires the lock (uncontended),
   we clear the tail and set the lock byte. By first setting the
   pending bit this cmpxchg will fail and the later load must then
   see the remaining tail.

Another interesting scenario is where there are only 2 threads:

	lock := (0,0,0)

	CPU 0			CPU 1

	lock()			lock()
	  trylock(-> 0,0,1)       trylock() /* fail */
	    return;               xchg_relaxed(pending, 1) (-> 0,1,1)
				  mb()
				  val = smp_load_acquire(*lock);

Where, without the mb() the load would've been allowed to return 0 for
the locked byte.

[*] there is a fun scenario where the 3rd locker observes the pending
bit, but before it sets the tail, the 1st lock (owner) unlocks and the
2nd locker acquires the lock, leaving us with a temporary 0,0,1 state.
But this is not different between fetch_or or this new method.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/qspinlock.h |    2 +
 kernel/locking/qspinlock.c       |   56 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -9,6 +9,8 @@
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
+#define _Q_NO_FETCH_OR
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -232,6 +232,60 @@ static __always_inline u32 xchg_tail(str
 #endif /* _Q_PENDING_BITS == 8 */
 
 /**
+ * set_pending_fetch_acquire - fetch the whole lock value and set pending and locked
+ * @lock : Pointer to queued spinlock structure
+ * Return: The previous lock value
+ *
+ * *,*,* -> *,1,*
+ */
+static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
+{
+#if defined(_Q_NO_FETCH_OR) && _Q_PENDING_BITS == 8
+	u32 val;
+
+	/*
+	 * For the !LL/SC archs that do not have a native atomic_fetch_or
+	 * but do have a native xchg (x86) we can do trickery and avoid the
+	 * cmpxchg-loop based fetch-or to improve determinism.
+	 *
+	 * We first xchg the pending byte to set PENDING, and then issue a load
+	 * for the rest of the word and mask out the pending byte to compute a
+	 * 'full' value.
+	 */
+	val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;
+	/*
+	 * Ensures the tail load happens after the xchg().
+	 *
+	 *	   lock  unlock    (a)
+	 *   xchg ---------------.
+	 *    (b)  lock  unlock  +----- fetch_or
+	 *   load ---------------'
+	 *	   lock  unlock    (c)
+	 *
+	 * For both lock and unlock, (a) and (c) are the same as fetch_or(),
+	 * since either are fully before or after. The only new case is (b),
+	 * where a concurrent lock or unlock can interleave with the composite
+	 * operation.
+	 *
+	 * In either case, it is the queueing case that is of interrest, otherwise
+	 * the whole operation is covered by the xchg() and the tail will be 0.
+	 *
+	 * For lock-(b); we only care if we set the PENDING bit or not. If we lost
+	 * the PENDING race, we queue. Otherwise we'd observe the tail anyway.
+	 *
+	 * For unlock-(b); since we'll have set PENDING, the uncontended claim
+	 * will fail and we'll observe a !0 tail.
+	 */
+	smp_mb__after_atomic();
+	val |= atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK;
+
+	return val;
+#else
+	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+#endif
+}
+
+/**
  * set_locked - Set the lock bit and own the lock
  * @lock: Pointer to queued spinlock structure
  *
@@ -328,7 +382,7 @@ void queued_spin_lock_slowpath(struct qs
 	 *
 	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
 	 */
-	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	val = set_pending_fetch_acquire(lock);
 
 	/*
 	 * If we observe contention, there was a concurrent lock.


