Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDLOFv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:05:51 -0400
Received: from foss.arm.com ([217.140.101.70]:33674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbeDLOFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:05:50 -0400
Date: Thu, 12 Apr 2018 15:06:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
Message-ID: <20180412140605.GB21296@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
 <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 03:53:16PM -0400, Waiman Long wrote:
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 396701e8c62d..a8fc402b3f3a 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -162,6 +162,17 @@ struct __qspinlock {
> >  
> >  #if _Q_PENDING_BITS == 8
> >  /**
> > + * clear_pending - clear the pending bit.
> > + * @lock: Pointer to queued spinlock structure
> > + *
> > + * *,1,* -> *,0,*
> > + */
> > +static __always_inline void clear_pending(struct qspinlock *lock)
> > +{
> > +	WRITE_ONCE(lock->pending, 0);
> > +}
> > +
> > +/**
> >   * clear_pending_set_locked - take ownership and clear the pending bit.
> >   * @lock: Pointer to queued spinlock structure
> >   *
> > @@ -201,6 +212,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> >  #else /* _Q_PENDING_BITS == 8 */
> >  
> >  /**
> > + * clear_pending - clear the pending bit.
> > + * @lock: Pointer to queued spinlock structure
> > + *
> > + * *,1,* -> *,0,*
> > + */
> > +static __always_inline void clear_pending(struct qspinlock *lock)
> > +{
> > +	atomic_andnot(_Q_PENDING_VAL, &lock->val);
> > +}
> > +
> > +/**
> >   * clear_pending_set_locked - take ownership and clear the pending bit.
> >   * @lock: Pointer to queued spinlock structure
> >   *
> 
> BTW, there is a similar clear_pending() function in
> qspinlock_paravirt.c. I think you need to remove that with this patch.

Thanks, I'll do that. I did build and bisect this series... for arm64, which
is completely useless as it doesn't get compiled until the final patch which
I haven't posted here.

Will
