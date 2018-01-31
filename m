Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeAaOLu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:11:50 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40087 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeAaOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:11:49 -0500
X-Google-Smtp-Source: AH8x226lgO+G2it6iwfCmBCnESYFtR7eB35T8VpRr/tOyaRlRCc3fhRmVpcdekzbhaEkX3lQCAKY5w==
Date: Wed, 31 Jan 2018 15:11:40 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking/qspinlock: Ensure node is initialised before
 updating prev->next
Message-ID: <20180131141140.GA9450@andrea>
References: <1517401246-2750-1-git-send-email-will.deacon@arm.com>
 <20180131123859.GQ2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131123859.GQ2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 01:38:59PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 12:20:46PM +0000, Will Deacon wrote:
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 294294c71ba4..1ebbc366a31d 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -408,16 +408,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  	 */
> >  	if (old & _Q_TAIL_MASK) {
> >  		prev = decode_tail(old);
> > +
> >  		/*
> > -		 * The above xchg_tail() is also a load of @lock which generates,
> > -		 * through decode_tail(), a pointer.
> > -		 *
> > -		 * The address dependency matches the RELEASE of xchg_tail()
> > -		 * such that the access to @prev must happen after.
> > +		 * We must ensure that the stores to @node are observed before
> > +		 * the write to prev->next. The address dependency on xchg_tail
> > +		 * is not sufficient to ensure this because the read component
> > +		 * of xchg_tail is unordered with respect to the initialisation
> > +		 * of node.
> >  		 */
> > -		smp_read_barrier_depends();
> 
> Right, except you're patching old code here, please try again on a tree
> that includes commit:
> 
>   548095dea63f ("locking: Remove smp_read_barrier_depends() from queued_spin_lock_slowpath()")

BTW, which loads was/is the smp_read_barrier_depends() supposed to order? ;)

I was somehow guessing that this barrier was/is there to "order" the load
from xchg_tail() with the address-dependent loads from pv_wait_node(); is
this true? (Does Will's patch really remove the reliance on the barrier?)

  Andrea


> 
> > -
> > -		WRITE_ONCE(prev->next, node);
> > +		smp_store_release(prev->next, node);
> >  
> >  		pv_wait_node(node, prev);
> >  		arch_mcs_spin_lock_contended(&node->locked);
> > -- 
> > 2.1.4
> > 
