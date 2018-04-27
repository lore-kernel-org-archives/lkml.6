Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757954AbeD0KQA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:16:00 -0400
Received: from foss.arm.com ([217.140.101.70]:37996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757811AbeD0KP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:15:59 -0400
Date: Fri, 27 Apr 2018 11:16:19 +0100
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
Message-ID: <20180427101619.GB21705@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <1adce90b-7627-ed71-fd34-bb33388790d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1adce90b-7627-ed71-fd34-bb33388790d5@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Thu, Apr 26, 2018 at 04:16:30PM -0400, Waiman Long wrote:
> On 04/26/2018 06:34 AM, Will Deacon wrote:
> > diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> > index 2711940429f5..2dbad2f25480 100644
> > --- a/kernel/locking/qspinlock_paravirt.h
> > +++ b/kernel/locking/qspinlock_paravirt.h
> > @@ -118,11 +118,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
> >  	WRITE_ONCE(lock->pending, 1);
> >  }
> >  
> > -static __always_inline void clear_pending(struct qspinlock *lock)
> > -{
> > -	WRITE_ONCE(lock->pending, 0);
> > -}
> > -
> >  /*
> >   * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
> >   * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
> 
> There is another clear_pending() function after the "#else /*
> _Q_PENDING_BITS == 8 */" line that need to be removed as well.

Bugger, sorry I missed that one. Is the >= 16K CPUs case supported elsewhere
in Linux? The x86 Kconfig appears to clamp NR_CPUS to 8192 iiuc.

Anyway, additional patch below. Ingo -- please can you apply this on top?

Thanks,

Will

--->8

>From ef6aa51e47047fe1a57dfdbe2f45caf63fa95be4 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 27 Apr 2018 10:40:13 +0100
Subject: [PATCH] locking/qspinlock: Remove duplicate clear_pending function
 from PV code

The native clear_pending function is identical to the PV version, so the
latter can simply be removed. This fixes the build for systems with >=
16K CPUs using the PV lock implementation.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock_paravirt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 25730b2ac022..5a0cf5f9008c 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -130,11 +130,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
-
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
 	int val = atomic_read(&lock->val);
-- 
2.1.4
