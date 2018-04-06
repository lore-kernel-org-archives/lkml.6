Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeDFP1d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:27:33 -0400
Received: from foss.arm.com ([217.140.101.70]:38848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbeDFP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:27:31 -0400
Date: Fri, 6 Apr 2018 16:27:45 +0100
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
Message-ID: <20180406152744.GE10528@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180405172808.GG4082@hirez.programming.kicks-ass.net>
 <20180406113436.GC27619@arm.com>
 <20180406130512.GA6631@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406130512.GA6631@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Fri, Apr 06, 2018 at 03:05:12PM +0200, Andrea Parri wrote:
> On Fri, Apr 06, 2018 at 12:34:36PM +0100, Will Deacon wrote:
> > I could say something like:
> > 
> >   "Pairs with dependency ordering from both xchg_tail and explicit
> >    dereferences of node->next"
> > 
> > but it's a bit cryptic :(
> 
> Agreed. ;)  It might be helpful to instead include a snippet to highlight
> the interested memory accesses/dependencies; IIUC,
> 
> /*
>  * Pairs with dependency ordering from both xchg_tail and explicit/?
>  * dereferences of node->next:
>  *
>  *   CPU0
>  *
>  *   /* get node0, encode node0 in tail */
>  *   pv_init_node(node0);
>  *     ((struct pv_node *)node0)->cpu   = smp_processor_id();
>  *     ((struct pv_node *)node0)->state = vcpu_running;

I'd probably ignore the PV case here and just focus on the native init
of count/locked/next.

>  *   smp_wmb();
>  *   old = xchg_tail(lock, tail);
>  *
>  *   CPU1:
>  *
>  *   /* get node1, encode tail from node1 */
>  *   old = xchg_tail(lock, tail);   // = tail corresponding to node0
>  *                                  // head an addr. dependency
>  *   /* decode old in prev */
>  *   pv_wait_node(node1, prev);

Similarly here -- the dependency is through decode_tail.

>  *     READ ((struct pv_node *)prev)->cpu   // addr. dependent read
>  *     READ ((struct pv_node *)prev)->state // addr. dependend read
>  *
>  * [More details for the case "following our own ->next pointer" you
>  *  mentioned dabove.]
>  */
> 
> CPU1 would also have:
> 
>    WRITE_ONCE(prev->next, node1); // addr. dependent write
> 
> but I'm not sure how this pairs: does this belong to the the second
> case above? can you elaborate on that?

This is dependent on the result of decode_tail, so it's still the first
case. The second case is when we queued into an empty tail but somebody
later queued behind us, so we don't find them until we're claiming the
lock:

  if (!next)
  	next = smp_cond_load_relaxed(&node->next, (VAL));

  arch_mcs_spin_unlock_contended(&next->locked);

here, this is all straightforward address dependencies rather than the
arithmetic in decode_tail.

Will
