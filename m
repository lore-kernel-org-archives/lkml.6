Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDIOx5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:53:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbeDIOxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:53:55 -0400
Date: Mon, 9 Apr 2018 15:54:09 +0100
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180409145409.GA9661@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105835.GC23134@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 11:58:35AM +0100, Will Deacon wrote:
> On Fri, Apr 06, 2018 at 04:50:19PM -0400, Waiman Long wrote:
> > The pending bit was added to the qspinlock design to counter performance
> > degradation compared with ticket lock for workloads with light
> > spinlock contention. I run my spinlock stress test on a Intel Skylake
> > server running the vanilla 4.16 kernel vs a patched kernel with this
> > patchset. The locking rates with different number of locking threads
> > were as follows:
> > 
> >   # of threads  4.16 kernel     patched 4.16 kernel
> >   ------------  -----------     -------------------
> >         1       7,417 kop/s         7,408 kop/s
> >         2       5,755 kop/s         4,486 kop/s
> >         3       4,214 kop/s         4,169 kop/s
> >         4       4,396 kop/s         4,383 kop/s
> >        
> > The 2 contending threads case is the one that exercise the pending bit
> > code path the most. So it is obvious that this is the one that is most
> > impacted by this patchset. The differences in the other cases are mostly
> > noise or maybe just a little bit on the 3 contending threads case.
> 
> That is bizarre. A few questions:
> 
>   1. Is this with my patches as posted, or also with your WRITE_ONCE change?
>   2. Could you try to bisect my series to see which patch is responsible
>      for this degradation, please?
>   3. Could you point me at your stress test, so I can try to reproduce these
>      numbers on arm64 systems, please?
> 
> > I am not against this patch, but we certainly need to find out a way to
> > bring the performance number up closer to what it is before applying
> > the patch.
> 
> We certainly need to *understand* where the drop is coming from, because
> the two-threaded case is still just a CAS on x86 with and without this
> patch series. Generally, there's a throughput cost when ensuring fairness
> and forward-progress otherwise we'd all be using test-and-set.

Whilst I think we still need to address my questions above, I've had a
crack at the diff below. Please can you give it a spin? It sticks a trylock
on the slowpath before setting pending and replaces the CAS-based set
with an xchg (which I *think* is safe, but will need to ponder it some
more).

Thanks,

Will

--->8

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 19261af9f61e..71eb5e3a3d91 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -139,6 +139,20 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
+/**
+ * set_pending_fetch_acquire - set the pending bit and return the old lock
+ *                             value with acquire semantics.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,*,* -> *,1,*
+ */
+static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
+{
+	u32 val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;
+	val |= (atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK);
+	return val;
+}
+
 /*
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
  * @lock : Pointer to queued spinlock structure
@@ -184,6 +198,18 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 }
 
 /**
+ * set_pending_fetch_acquire - set the pending bit and return the old lock
+ *                             value with acquire semantics.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,*,* -> *,1,*
+ */
+static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
+{
+	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+}
+
+/**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
  * @lock : Pointer to queued spinlock structure
  * @tail : The new queue tail code word
@@ -289,18 +315,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * If we observe any contention; queue.
+	 * If we observe queueing, then queue ourselves.
 	 */
-	if (val & ~_Q_LOCKED_MASK)
+	if (val & _Q_TAIL_MASK)
 		goto queue;
 
 	/*
+	 * We didn't see any queueing, so have one more try at snatching
+	 * the lock in case it became available whilst we were taking the
+	 * slow path.
+	 */
+	if (queued_spin_trylock(lock))
+		return;
+
+	/*
 	 * trylock || pending
 	 *
 	 * 0,0,0 -> 0,0,1 ; trylock
 	 * 0,0,1 -> 0,1,1 ; pending
 	 */
-	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	val = set_pending_fetch_acquire(lock);
 	if (!(val & ~_Q_LOCKED_MASK)) {
 		/*
 		 * we're pending, wait for the owner to go away.
