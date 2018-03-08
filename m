Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeCHVUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:20:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50328 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCHVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:19:58 -0500
X-Google-Smtp-Source: AG47ELuZxurkP6m7fbEr8uIvWox7OnCmOodMkssmUGiKKN+GMQ/7NFfIo2vVvWVtWXQzLuEU2ddEwg==
Date: Thu, 8 Mar 2018 22:19:50 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: Simplifying our RCU models
Message-ID: <20180308211950.GA3202@andrea>
References: <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307155444.GA10367@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 07:54:44AM -0800, Paul E. McKenney wrote:
> On Tue, Mar 06, 2018 at 12:39:06PM -0800, Paul E. McKenney wrote:
> > On Tue, Mar 06, 2018 at 09:47:38AM +0100, Ingo Molnar wrote:
> > > 
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > > > But if we look at the bigger API picture:
> > > > > >
> > > > > >                           !PREEMPT_RCU  PREEMPT_RCU=y
> > > > > >   rcu_read_lock():        atomic        preemptible
> > > > > >   rcu_read_lock_sched():  atomic        atomic
> > > > > >   srcu_read_lock():       preemptible   preemptible
> > > > > >
> > > > > > Then we could maintain full read side API flexibility by making PREEMPT_RCU=y the 
> > > > > > only model, merging it with SRCU and using these main read side APIs:
> > > > > >
> > > > > >   rcu_read_lock_preempt_disable():	atomic
> > > > > >   rcu_read_lock():			preemptible
> > > > 
> > > > One issue with merging SRCU into rcu_read_lock() is the general blocking within 
> > > > SRCU readers.  Once merged in, these guys block everyone.  We should focus 
> > > > initially on the non-SRCU variants.
> > > > 
> > > > On the other hand, Linus's suggestion of merging rcu_read_lock_sched()
> > > > into rcu_read_lock() just might be feasible.  If that really does pan
> > > > out, we end up with the following:
> > > > 
> > > >				!PREEMPT	PREEMPT=y
> > > >	rcu_read_lock():	atomic		preemptible
> > > >	srcu_read_lock():	preemptible	preemptible
> > > > 
> > > > In this model, rcu_read_lock_sched() maps to preempt_disable() and (as
> > > > you say above) rcu_read_lock_bh() maps to local_bh_disable().  The way
> > > > this works is that in PREEMPT=y kernels, synchronize_rcu() waits not
> > > > only for RCU read-side critical sections, but also for regions of code
> > > > with preemption disabled.  The main caveat seems to be that there be an
> > > > assumed point of preemptibility between each interrupt and each softirq
> > > > handler, which should be OK.
> > > > 
> > > > There will be some adjustments required for lockdep-RCU, but that should
> > > > be reasonably straightforward.
> > > > 
> > > > Seem reasonable?
> > > 
> > > Yes, that approach sounds very reasonable to me: it is similar to what we do on 
> > > the locking side as well, where we have 'atomic' variants (spinlocks/rwlocks) and 
> > > 'sleeping' variants (mutexes, rwsems, etc.).
> > > 
> > > ( This means there will be more automatic coupling between BH and preempt critical
> > >   sections and RCU models not captured via explicit RCU-namespace APIs, but that
> > >   should be OK I think. )
> > 
> > Thus far, I have been unable to prove that it cannot work, which is about
> > as good as it gets at this stage.  So here is hoping!  ;-)
> > 
> > I will look at your later corrected message, but will gratefully accept
> > your offer of help with the naming transition.
> 
> Ah, and any thoughts on how best to get feedback from the various people
> who would need to reprogram their fingers?  Or is everyone already on
> board with changing these various names?

Experienced should get there in a week (gcc help); newbies would (have to)
rely on either on _properly updated_ documentation or weeks/months of code
paging; scripts do the renaming.  What am I missing?

  Andrea


> 
> 							Thanx, Paul
> 
