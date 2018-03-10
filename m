Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCJQFo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:05:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932368AbeCJQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:05:43 -0500
Date: Sat, 10 Mar 2018 08:06:14 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <CA+55aFzQPQw2UqQ2EEGN1Xe7=qDs-2VTvHVi7SSqGNwqNRg0cQ@mail.gmail.com>
 <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <CAJhGHyD_N_duuZgPdidpsR9zVsAFzQi0oVwhd=qTiXa-hYiasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyD_N_duuZgPdidpsR9zVsAFzQi0oVwhd=qTiXa-hYiasg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18031016-0040-0000-0000-0000040561A2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008647; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01001063; UDB=6.00509249; IPR=6.00780393;
 MB=3.00019958; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-10 16:05:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031016-0041-0000-0000-000008066992
Message-Id: <20180310160614.GG3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803100194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 05:48:55PM +0800, Lai Jiangshan wrote:
> On Tue, Mar 6, 2018 at 12:14 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Mon, Mar 05, 2018 at 08:33:20AM -0600, Eric W. Biederman wrote:
> >>
> >> Moving this discussion to a public list as discussing how to reduce the
> >> number of rcu variants does not make sense in private.  We should have
> >> an archive of such discussions.
> >>
> >> Ingo Molnar <mingo@kernel.org> writes:
> >>
> >> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> >> >
> >> >> > So if people really want that low-cost RCU, and some people really
> >> >> > need the sleepable version, the only one that can _possibly_ be dumped
> >> >> > is the preempt one.
> >> >> >
> >> >> > But I may - again - be confused and/or missing something.
> >> >>
> >> >> I am going to do something very stupid and say that I was instead thinking in
> >> >> terms of getting rid of RCU-bh, thus reminding you of its existence.  ;-)
> >> >>
> >> >> The reason for believing that it is possible to get rid of RCU-bh is the work
> >> >> that has gone into improving the forward progress of RCU grace periods under
> >> >> heavy load and in corner-case workloads.
> >> >>
> >> >
> >> > [...]
> >> >
> >> >> The other reason for RCU-sched is it has the side effect of waiting
> >> >> for all in-flight hardware interrupt handlers, NMI handlers, and
> >> >> preempt-disable regions of code to complete, and last I checked, this side
> >> >> effect is relied on.  In contrast, RCU-preeempt is only guaranteed to wait
> >> >> on regions of code protected by rcu_read_lock() and rcu_read_unlock().
> >> >
> >> > Instead of only trying to fix the documentation (which is never a bad idea but it
> >> > is fighting the symptom in this case), I think the first step should be to
> >> > simplify the RCU read side APIs of RCU from 4 APIs:
> >> >
> >> >     rcu_read_lock()
> >> >     srcu_read_lock()
> >> >     rcu_read_lock_sched()
> >> >     rcu_read_lock_bh()
> >> >
> >> > ... which have ~8 further sub-model variations depending on CONFIG_PREEMPT,
> >> > CONFIG_PREEMPT_RCU - which is really a crazy design!
> >
> > If it is possible to set CONFIG_PREEMPT_RCU differently than CONFIG_PREEMPT,
> > then that is a bug that I need to fix.
> >
> >> > I think we could reduce this to just two APIs with no Kconfig dependencies:
> >> >
> >> >     rcu_read_lock()
> >> >     rcu_read_lock_preempt_disable()
> >> >
> >> > Which would be much, much simpler.
> >
> > No argument on the simpler part, at least from an API perspective.
> >
> >> > This is how we could do it I think:
> >> >
> >> > 1)
> >> >
> >> > Getting rid of the _bh() variant should be reasonably simple and involve a
> >> > treewide replacement of:
> >> >
> >> >     rcu_read_lock_bh()   -> local_bh_disable()
> >> >     rcu_read_unlock_bh() -> local_bh_enable()
> >> >
> >> > Correct?
> >
> > Assuming that I have done enough forward-progress work on grace periods, yes.
> >
> >> > 2)
> >> >
> >> > Further reducing the variants is harder, due to this main asymmetry:
> >> >
> >> >                           !PREEMPT_RCU  PREEMPT_RCU=y
> >> >   rcu_read_lock_sched():  atomic        atomic
> >> >   rcu_read_lock():        atomic        preemptible
> >> >
> >> > ('atomic' here is meant in the scheduler, non-preemptible sense.)
> >> >
> >> > But if we look at the bigger API picture:
> >> >
> >> >                           !PREEMPT_RCU  PREEMPT_RCU=y
> >> >   rcu_read_lock():        atomic        preemptiblep
> >> >   rcu_read_lock_sched():  atomic        atomic
> >> >   srcu_read_lock():       preemptible   preemptible
> >> >
> >> > Then we could maintain full read side API flexibility by making PREEMPT_RCU=y the
> >> > only model, merging it with SRCU and using these main read side APIs:
> >> >
> >> >   rcu_read_lock_preempt_disable((): atomic
> >> >   rcu_read_lock()                   preemptible
> >
> > One issue with merging SRCU into rcu_read_lock() is the general blocking
> > within SRCU readers.  Once merged in, these guys block everyone.  We should
> > focus initially on the non-SRCU variants.
> >
> > On the other hand, Linus's suggestion of merging rcu_read_lock_sched()
> > into rcu_read_lock() just might be feasible.  If that really does pan
> > out, we end up with the following:
> >
> >                                 !PREEMPT        PREEMPT=y
> >         rcu_read_lock():        atomic          preemptible
> >         srcu_read_lock():       preemptible     preemptible
> >
> > In this model, rcu_read_lock_sched() maps to preempt_disable() and (as
> > you say above) rcu_read_lock_bh() maps to local_bh_disable().  The way
> > this works is that in PREEMPT=y kernels, synchronize_rcu() waits not
> > only for RCU read-side critical sections, but also for regions of code
> > with preemption disabled.  The main caveat seems to be that there be an
> > assumed point of preemptibility between each interrupt and each softirq
> > handler, which should be OK.
> >
> > There will be some adjustments required for lockdep-RCU, but that should
> > be reasonably straightforward.
> >
> > Seem reasonable?
> 
> It's good. I hope there is only one global(non-srcu) rcu variant.

Well, there will still be both SRCU and RCU-tasks, but reducing by
two should at least help.

> It does have the trade-off, the grace period will be extended a little
> in some cases,
> so will the call_rcu()/synchronze_rcu(). But it simplifies the coding a lot.

True, and the extended grace periods did bother me at first.  But then
I realized that it was no worse than RCU-sched, so it should be OK.

And thank you for looking this over!

							Thanx, Paul

> >> > It's a _really_ simple and straightforward RCU model, with very obvious semantics
> >> > all around:
> >> >
> >> > - Note how the 'atomic' (non-preempt) variant uses the well-known
> >> >   preempt_disable() name as a postfix to signal its main property. (It's also a
> >> >   bit of a mouthful, which should discourage over-use.)
> >
> > My thought is to eliminate the atomic variant entirely.  If you want
> > to disable preemption, interrupts, or whatever, you simply do so.
> > It might turn out that there are documentation benefits to having a
> > separate rcu_read_lock_preempt_disable() that maps to preempt_disable()
> > with lockdep semantics, and if so, that can be provided trivially.
> >
> >> > - The read side APIs are really as straightforward as possible: there's no SRCU
> >> >   distinction on the read side, no _bh() distinction and no _sched() distinction.
> >> >   (On -rt all of these would turn into preemptible sections,
> >> >   obviously.)
> >
> > Agreed, and both models accomplish that.
> >
> >> And it looses the one advantage of srcu_read_lock.  That you don't have
> >> to wait for the entire world.  If you actually allow sleeping that is an
> >> important distinction to have.  Or are you proposing that we add the
> >> equivalent of init_srcu_struct to all of the rcu users?
> >
> > I am instead proposing folding rcu_read_lock_bh() and rcu_read_lock_sched()
> > into rcu_read_lock(), and leaving srcu_read_lock() separate.
> >
> >> That rcu_read_lock would need to take an argument about which rcu region
> >> we are talking about.
> >
> > From what I can see, it would be far better to leave SRCU separate.  As you
> > say, it really does have very different semantics.
> >
> >> > rcu_read_lock_preempt_disable() would essentially be all the current
> >> > rcu_read_lock_sched() users (where the _sched() postfix was a confusing misnomer
> >> > anyway).
> >
> > I agree that rcu_read_lock_preempt_disable() is a better name.
> > We might not need it at all, though.  There are only about 20 uses of
> > rcu_read_lock_sched() in v4.15.  ;-)
> >
> >> > Wrt. merging SRCU and RCU: this can be done by making PREEMPT_RCU=y the one and
> >> > only main RCU model and converting all SRCU users to main RCU. This is relatively
> >> > straightforward to perform, as there are only ~170 SRCU critical sections, versus
> >> > the 3000+ main RCU critical sections ...
> >>
> >> It really sounds like you are talking about adding a requirement that
> >> everyone update their rcu_read_lock() calls with information about which
> >> region you are talking about.  That seems like quite a bit of work.
> >
> > Agreed, merging RCU, RCU-bh, and RCU-sched seems much more straightforward
> > to me from the viewpoint of both usage and implementation.
> >
> >> Doing something implicit when PREEMPT_RCU=y and converting
> >> "rcu_read_lock()" to "srcu_read_lock(&kernel_srcu_region)" only in that
> >> case I can see.
> >>
> >> Except in very specific circustances I don't think I ever want to run a
> >> kernel with PREEMPT_RCU the default.  All of that real time stuff trades
> >> off predictability with performance.  Having lost enough performance to
> >> spectre and meltdown I don't think it makes sense for us all to start
> >> runing predictable^H^H^H^H^H^H^H^H^H^H^H time kernels now.
> >
> > Yes, in PREEMPT=n kernels RCU would act exactly as it does today.
> >
> >> > AFAICS this should be a possible read side design that keeps correctness, without
> >> > considering grace period length patterns, i.e. without considering GC latency and
> >> > scalability aspects.
> >> >
> >> > Before we get into ways to solve the latency and scalability aspects of such a
> >> > simplified RCU model, do you agree with this analysis so far, or have I missed
> >> > something important wrt. correctness?
> >>
> >> RCU region specification.  If we routinely allow preemption of rcu
> >> critical sections for any length of time I can't imagine we will want to
> >> wait for every possible preempted rcu critical section.
> >>
> >> Of course I could see the merge working the other way.  Adding the
> >> debugging we need to find rcu critical secions that are held to long and
> >> shrinking them so we don't need PREEMPT_RCU at all.
> >
> > Again, from what I can see, merging rcu_read_lock(), rcu_read_lock_sched(),
> > and rcu_read_lock_bh() together should get us to a much better place.
> >
> > Make sense, or am I missing something?
> >
> >                                                         Thanx, Paul
> >
> 
