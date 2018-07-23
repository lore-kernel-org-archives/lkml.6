Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41661ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58D320874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58D320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeGWVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbeGWVNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:13:34 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1C020854;
        Mon, 23 Jul 2018 20:10:43 +0000 (UTC)
Date:   Mon, 23 Jul 2018 16:10:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Consolidating RCU-bh, RCU-preempt, and RCU-sched
Message-ID: <20180723161041.5375b54f@gandalf.local.home>
In-Reply-To: <CAJhGHyCYxPNSM9fZgUHW7jFR0M3DFGn4HdQGfpRnzfnrL2yyYA@mail.gmail.com>
References: <20180713000249.GA16907@linux.vnet.ibm.com>
        <CAJhGHyCYxPNSM9fZgUHW7jFR0M3DFGn4HdQGfpRnzfnrL2yyYA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late reply, just came back from the Caribbean :-) :-) :-)

On Fri, 13 Jul 2018 11:47:18 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> On Fri, Jul 13, 2018 at 8:02 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > Hello!
> >
> > I now have a semi-reasonable prototype of changes consolidating the
> > RCU-bh, RCU-preempt, and RCU-sched update-side APIs in my -rcu tree.
> > There are likely still bugs to be fixed and probably other issues as well,
> > but a prototype does exist.

What's the rational for all this churn? Linus's complaining that there
are too many RCU variants?


> >
> > Assuming continued good rcutorture results and no objections, I am
> > thinking in terms of this timeline:
> >
> > o       Preparatory work and cleanups are slated for the v4.19 merge window.
> >
> > o       The actual consolidation and post-consolidation cleanup is slated
> >         for the merge window after v4.19 (v5.0?).  These cleanups include
> >         the replacements called out below within the RCU implementation
> >         itself (but excluding kernel/rcu/sync.c, see question below).
> >
> > o       Replacement of now-obsolete update APIs is slated for the second
> >         merge window after v4.19 (v5.1?).  The replacements are currently
> >         expected to be as follows:
> >
> >         synchronize_rcu_bh() -> synchronize_rcu()
> >         synchronize_rcu_bh_expedited() -> synchronize_rcu_expedited()
> >         call_rcu_bh() -> call_rcu()
> >         rcu_barrier_bh() -> rcu_barrier()
> >         synchronize_sched() -> synchronize_rcu()
> >         synchronize_sched_expedited() -> synchronize_rcu_expedited()
> >         call_rcu_sched() -> call_rcu()
> >         rcu_barrier_sched() -> rcu_barrier()
> >         get_state_synchronize_sched() -> get_state_synchronize_rcu()
> >         cond_synchronize_sched() -> cond_synchronize_rcu()
> >         synchronize_rcu_mult() -> synchronize_rcu()
> >
> >         I have done light testing of these replacements with good results.
> >
> > Any objections to this timeline?
> >
> > I also have some questions on the ultimate end point.  I have default
> > choices, which I will likely take if there is no discussion.
> >
> > o
> >         Currently, I am thinking in terms of keeping the per-flavor
> >         read-side functions.  For example, rcu_read_lock_bh() would
> >         continue to disable softirq, and would also continue to tell
> >         lockdep about the RCU-bh read-side critical section.  However,
> >         synchronize_rcu() will wait for all flavors of read-side critical
> >         sections, including those introduced by (say) preempt_disable(),
> >         so there will no longer be any possibility of mismatching (say)
> >         RCU-bh readers with RCU-sched updaters.
> >
> >         I could imagine other ways of handling this, including:
> >
> >         a.      Eliminate rcu_read_lock_bh() in favor of
> >                 local_bh_disable() and so on.  Rely on lockdep
> >                 instrumentation of these other functions to identify RCU
> >                 readers, introducing such instrumentation as needed.  I am
> >                 not a fan of this approach because of the large number of
> >                 places in the Linux kernel where interrupts, preemption,
> >                 and softirqs are enabled or disabled "behind the scenes".
> >
> >         b.      Eliminate rcu_read_lock_bh() in favor of rcu_read_lock(),
> >                 and required callers to also disable softirqs, preemption,
> >                 or whatever as needed.  I am not a fan of this approach
> >                 because it seems a lot less convenient to users of RCU-bh
> >                 and RCU-sched.
> >
> >         At the moment, I therefore favor keeping the RCU-bh and RCU-sched
> >         read-side APIs.  But are there better approaches?  
> 
> Hello, Paul
> 
> Since local_bh_disable() will be guaranteed to be protected by RCU
> and more general. I'm afraid it will be preferred over
> rcu_read_lock_bh() which will be gradually being phased out.
> 
> In other words, keeping the RCU-bh read-side APIs will be a slower
> version of the option A. So will the same approach for the RCU-sched.
> But it'll still be better than the hurrying option A, IMHO.

Now when all this gets done, is synchronize_rcu() going to just wait
for everything to pass? (scheduling, RCU readers, softirqs, etc) Is
there any worry about lengthening the time of synchronize_rcu?

-- Steve


> >
> > o       How should kernel/rcu/sync.c be handled?  Here are some
> >         possibilities:
> >
> >         a.      Leave the full gp_ops[] array and simply translate
> >                 the obsolete update-side functions to their RCU
> >                 equivalents.
> >
> >         b.      Leave the current gp_ops[] array, but only have
> >                 the RCU_SYNC entry.  The __INIT_HELD field would
> >                 be set to a function that was OK with being in an
> >                 RCU read-side critical section, an interrupt-disabled
> >                 section, etc.
> >
> >                 This allows for possible addition of SRCU functionality.
> >                 It is also a trivial change.  Note that the sole user
> >                 of sync.c uses RCU_SCHED_SYNC, and this would need to
> >                 be changed to RCU_SYNC.
> >
> >                 But is it likely that we will ever add SRCU?
> >
> >         c.      Eliminate that gp_ops[] array, hard-coding the function
> >                 pointers into their call sites.
> >
> >         I don't really have a preference.  Left to myself, I will be lazy
> >         and take option #a.  Are there better approaches?
> >
> > o       Currently, if a lock related to the scheduler's rq or pi locks is
> >         held across rcu_read_unlock(), that lock must be held across the
> >         entire read-side critical section in order to avoid deadlock.
> >         Now that the end of the RCU read-side critical section is
> >         deferred until sometime after interrupts are re-enabled, this
> >         requirement could be lifted.  However, because the end of the RCU
> >         read-side critical section is detected sometime after interrupts
> >         are re-enabled, this means that a low-priority RCU reader might
> >         remain priority-boosted longer than need be, which could be a
> >         problem when running real-time workloads.
> >
> >         My current thought is therefore to leave this constraint in
> >         place.  Thoughts?
> >
> > Anything else that I should be worried about?  ;-)
> >
> >                                                         Thanx, Paul
> >  

