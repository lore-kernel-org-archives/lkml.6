Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5DC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8E2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lB6fy/2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B8E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeJBU6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:58:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJBU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hu9KM8+Hm4MPVH0ByL/aYe4538y+cyL/wRqqfqsYuTY=; b=lB6fy/2ZvYp9fH3031gX/9ub3
        vVorovHZ20aN4YImBT0JelKPHggksKTyTfCqMq4p6O+gd5lBhzFaXyHA5Sy+PRPCly+/fPZ4D6OGl
        PV4plinEXhyDA32bI3opfFZ8kvwZH4/tBtHGsO7zPVFPz1gVcQYl6hEL0xoVNWCHXGnBKsqBBTsTY
        ZPqctDgYEZNKO/cypFC9Xa1MG78QgmVhU2mOVnZBplCbYchcTGiKj3EsS0UaiNjEm1LeGKsK9++vk
        cd72LxqvblUA9d7omG+lS/G9jIRYnIhkdzGkZza+hfH5n5Rcv+0QMZSG8hITQucCqh0zCqNxi1XXa
        +dHJ8BpZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7LRS-00040D-90; Tue, 02 Oct 2018 14:14:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2A00202549F7; Tue,  2 Oct 2018 16:14:24 +0200 (CEST)
Date:   Tue, 2 Oct 2018 16:14:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181002141424.GG26858@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
 <20181001200028.GO3439@hirez.programming.kicks-ass.net>
 <20181002131952.GD16422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002131952.GD16422@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:19:53PM +0100, Will Deacon wrote:
> On Mon, Oct 01, 2018 at 10:00:28PM +0200, Peter Zijlstra wrote:

> > Let me draw a picture of that..
> > 
> > 
> >   CPU0		CPU1		CPU2		CPU3
> > 
> > 0)						lock
> > 						  trylock -> (0,0,1)
> > 1)lock
> >     trylock /* fail */
> > 
> > 2)		lock
> > 		  trylock /* fail */
> > 		  tas-pending -> (0,1,1)
> > 		  wait-locked
> > 
> > 3)				lock
> > 				  trylock /* fail */
> > 				  tas-pending /* fail */
> > 
> > 4)						unlock -> (0,1,0)
> > 		  clr_pnd_set_lck -> (0,0,1)
> > 		  unlock -> (0,0,0)
> > 
> > 5)  tas-pending -> (0,1,0)
> >     read-val -> (0,1,0)
> > 6)  clr_pnd_set_lck -> (0,0,1)
> > 7)				  xchg_tail -> (n,0,1)
> > 				  load_acquire <- (n,0,0) (from-4)
> > 8)				  cmpxchg /* fail */
> > 				  set_locked()
> > 
> > > Is there something I'm missing that means this can't happen? I suppose
> > > cacheline granularity ends up giving serialisation between (4) and (7),
> > > but I'd *much* prefer not to rely on that because it feels horribly
> > > fragile.
> > 
> > Well, on x86 atomics are fully ordered, so the xchg_tail() does in
> > fact have smp_mb() in and that should order it sufficient for that not
> > to happen I think.
> 
> Hmm, does that actually help, though? I still think you're relying on the
> cache-coherence protocol to serialise the xchg() on pending before the
> xchg_tail(), which I think is fragile because they don't actually overlap.

Maybe, I suspect TSO makes it work, but see the below alternative.

---
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -6,9 +6,29 @@
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
+#include <asm/rmwcc.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
+static __always_inline bool __test_and_set_pending(struct qspinlock *lock)
+{
+	GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
+			 lock->val.counter, "Ir", _Q_PENDING_OFFSET, "%0", c);
+}
+
+#define queued_set_pending_fetch_acquire queued_set_pending_fetch_acquire
+static inline u32 queued_set_pending_fetch_acquire(struct qspinlock *lock)
+{
+	u32 val = 0;
+
+	if (__test_and_set_pending(lock))
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
+ * queued_set_pending_fetch_acquire - fetch the whole lock value and set pending
+ * @lock : Pointer to queued spinlock structure
+ * Return: The previous lock value
+ *
+ * *,*,* -> *,1,*
+ */
+#ifndef queued_set_pending_fetch_acquire
+static __always_inline u32 queued_set_pending_fetch_acquire(struct qspinlock *lock)
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
+	val = queued_set_pending_fetch_acquire(lock);
 
 	/*
 	 * If we observe contention, there is a concurrent locker.
