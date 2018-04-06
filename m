Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeDFNFX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:05:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40684 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeDFNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:05:21 -0400
X-Google-Smtp-Source: AIpwx4+llzOVwJbgj3gmmUYwrAkUJ0cVa9TB20lSbF1C89xt9mDYu0t+CYzEFm8Bm/1uDyGcZMQUkw==
Date: Fri, 6 Apr 2018 15:05:12 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
Message-ID: <20180406130512.GA6631@andrea>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180405172808.GG4082@hirez.programming.kicks-ass.net>
 <20180406113436.GC27619@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406113436.GC27619@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Apr 06, 2018 at 12:34:36PM +0100, Will Deacon wrote:
> On Thu, Apr 05, 2018 at 07:28:08PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> > > @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  		goto release;
> > >  
> > >  	/*
> > > +	 * Ensure that the initialisation of @node is complete before we
> > > +	 * publish the updated tail and potentially link @node into the
> > > +	 * waitqueue.
> > > +	 */
> > > +	smp_wmb();
> > 
> > Maybe an explicit note to where the matching barrier lives..
> 
> Oh man, that's not a simple thing to write: there isn't a matching barrier!
> 
> Instead, we rely on dependency ordering for two cases:
> 
>   * We access a node by decoding the tail we get back from the xchg
> 
> - or -
> 
>   * We access a node by following our own ->next pointer
> 
> I could say something like:
> 
>   "Pairs with dependency ordering from both xchg_tail and explicit
>    dereferences of node->next"
> 
> but it's a bit cryptic :(

Agreed. ;)  It might be helpful to instead include a snippet to highlight
the interested memory accesses/dependencies; IIUC,

/*
 * Pairs with dependency ordering from both xchg_tail and explicit/?
 * dereferences of node->next:
 *
 *   CPU0
 *
 *   /* get node0, encode node0 in tail */
 *   pv_init_node(node0);
 *     ((struct pv_node *)node0)->cpu   = smp_processor_id();
 *     ((struct pv_node *)node0)->state = vcpu_running;

 *   smp_wmb();
 *   old = xchg_tail(lock, tail);
 *
 *   CPU1:
 *
 *   /* get node1, encode tail from node1 */
 *   old = xchg_tail(lock, tail);   // = tail corresponding to node0
 *                                  // head an addr. dependency
 *   /* decode old in prev */
 *   pv_wait_node(node1, prev);
 *     READ ((struct pv_node *)prev)->cpu   // addr. dependent read
 *     READ ((struct pv_node *)prev)->state // addr. dependend read
 *
 * [More details for the case "following our own ->next pointer" you
 *  mentioned dabove.]
 */

CPU1 would also have:

   WRITE_ONCE(prev->next, node1); // addr. dependent write

but I'm not sure how this pairs: does this belong to the the second
case above? can you elaborate on that?

  Andrea


> 
> Will
