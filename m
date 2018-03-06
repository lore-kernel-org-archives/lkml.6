Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeCFIro (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:47:44 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55683 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:47:43 -0500
X-Google-Smtp-Source: AG47ELsyde+uat9+jdrWAMsMIjiXPuRzdR+dpur4Zxf4kL03a/g61P8IK5VDmc1V3Z2BxShCZupD8g==
Date: Tue, 6 Mar 2018 09:47:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: Simplifying our RCU models
Message-ID: <20180306084738.tcs4ggbby77phlbh@gmail.com>
References: <CAG48ez17vOL0oEWqoqdHCjqfGVX+aPhHBrtgCfn35z6jZ=8-Xg@mail.gmail.com>
 <CA+55aFzQPQw2UqQ2EEGN1Xe7=qDs-2VTvHVi7SSqGNwqNRg0cQ@mail.gmail.com>
 <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305161446.GQ3918@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > > But if we look at the bigger API picture:
> > >
> > >                           !PREEMPT_RCU  PREEMPT_RCU=y
> > >   rcu_read_lock():        atomic        preemptible
> > >   rcu_read_lock_sched():  atomic        atomic
> > >   srcu_read_lock():       preemptible   preemptible
> > >
> > > Then we could maintain full read side API flexibility by making PREEMPT_RCU=y the 
> > > only model, merging it with SRCU and using these main read side APIs:
> > >
> > >   rcu_read_lock_preempt_disable():	atomic
> > >   rcu_read_lock():			preemptible
> 
> One issue with merging SRCU into rcu_read_lock() is the general blocking within 
> SRCU readers.  Once merged in, these guys block everyone.  We should focus 
> initially on the non-SRCU variants.
> 
> On the other hand, Linus's suggestion of merging rcu_read_lock_sched()
> into rcu_read_lock() just might be feasible.  If that really does pan
> out, we end up with the following:
> 
>				!PREEMPT	PREEMPT=y
>	rcu_read_lock():	atomic		preemptible
>	srcu_read_lock():	preemptible	preemptible
> 
> In this model, rcu_read_lock_sched() maps to preempt_disable() and (as
> you say above) rcu_read_lock_bh() maps to local_bh_disable().  The way
> this works is that in PREEMPT=y kernels, synchronize_rcu() waits not
> only for RCU read-side critical sections, but also for regions of code
> with preemption disabled.  The main caveat seems to be that there be an
> assumed point of preemptibility between each interrupt and each softirq
> handler, which should be OK.
> 
> There will be some adjustments required for lockdep-RCU, but that should
> be reasonably straightforward.
> 
> Seem reasonable?

Yes, that approach sounds very reasonable to me: it is similar to what we do on 
the locking side as well, where we have 'atomic' variants (spinlocks/rwlocks) and 
'sleeping' variants (mutexes, rwsems, etc.).

( This means there will be more automatic coupling between BH and preempt critical
  sections and RCU models not captured via explicit RCU-namespace APIs, but that
  should be OK I think. )

A couple of small side notes:

 - Could we please also clean up the namespace of the synchronization APIs and 
   change them all to an rcu_ prefix, like all the other RCU APIs are? Right now 
   have a mixture like rcu_read_lock() but synchronize_rcu(), while I'd reall love 
   to be able to do:

	git grep '\<rcu_' ...

   ... to see RCU API usage within a particular kernel area. This would also clean
   up some of the internal inconsistencies like having 'struct rcu_synchronize'.

 - If we are cleaning up the write side APIs, could we move over to a _wait 
   nomenclature, i.e. rcu_wait*()?

   I.e. the new RCU namespace would be something like:

     rcu_read_lock                => rcu_read_lock        # unchanged
     rcu_read_unlock              => rcu_read_unlock      # unchanged

     call_rcu                     => rcu_call_rcu
     call_rcu_bh                  => rcu_call_bh
     call_rcu_sched               => rcu_call_sched

     synchronize_rcu              => rcu_wait_
     synchronize_rcu_bh           => rcu_wait_bh
     synchronize_rcu_bh_expedited => rcu_wait_expedited_bh
     synchronize_rcu_expedited    => rcu_wait_expedited
     synchronize_rcu_mult         => rcu_wait_mult
     synchronize_rcu_sched        => rcu_wait_sched
     synchronize_rcu_tasks        => rcu_wait_tasks

     srcu_read_lock               => srcu_read_lock       # unchanged
     srcu_read_unlock             => srcu_read_unlock     # unchanged

     synchronize_srcu             => srcu_wait
     synchronize_srcu_expedited   => srcu_wait_expedited

   Note that due to the prefix approach we gain various new patterns:

       git grep rcu_wait          # matches both rcu and srcu
       git grep rcu_wait          # matches all RCU waiting variants
       git grep wait_expedited    # matches all expedited variants

   ... which all increase the organization of the namespace.

 - While we are at it, the two RCU-state API variants, while rarely used, are
   named in a pretty obscure, disconnected fashion as well. A much better naming 
   would be:

     get_state_synchronize_rcu    => rcu_get_state
     cond_synchronize_rcu         => rcu_wait_state

   ... or so. This would also move them into the new, unified rcu_ prefix 
   namespace.

Note how consistent and hierarchical the new RCU API namespace is:

	<subsystem-prefix>_<verb>[_<qualifier[s]>]

If you agree with the overall concept of this I'd be glad to help out with 
scripting & testing the RCU namespace transition safely in an unintrusive fashion 
once you've done the model unification work, with compatibility defines to not 
create conflicts, churn and pain, etc.

Thanks,

	Ingo
