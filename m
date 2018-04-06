Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFPIJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:08:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeDFPIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:08:06 -0400
Date: Fri, 6 Apr 2018 16:08:19 +0100
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180406150819.GB10528@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <a4649773-9dac-c496-2796-713981ead426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4649773-9dac-c496-2796-713981ead426@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:16:16PM -0400, Waiman Long wrote:
> On 04/05/2018 12:58 PM, Will Deacon wrote:
> >  	/*
> > -	 * we're pending, wait for the owner to go away.
> > -	 *
> > -	 * *,1,1 -> *,1,0
> > -	 *
> > -	 * this wait loop must be a load-acquire such that we match the
> > -	 * store-release that clears the locked bit and create lock
> > -	 * sequentiality; this is because not all clear_pending_set_locked()
> > -	 * implementations imply full barriers.
> > -	 */
> > -	smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
> > -
> > -	/*
> > -	 * take ownership and clear the pending bit.
> > -	 *
> > -	 * *,1,0 -> *,0,1
> > +	 * If pending was clear but there are waiters in the queue, then
> > +	 * we need to undo our setting of pending before we queue ourselves.
> >  	 */
> > -	clear_pending_set_locked(lock);
> > -	return;
> > +	if (!(val & _Q_PENDING_MASK))
> > +		atomic_andnot(_Q_PENDING_VAL, &lock->val);
> Can we add a clear_pending() helper that will just clear the byte if
> _Q_PENDING_BITS == 8? That will eliminate one atomic instruction from
> the failure path.

Good idea!

Will
