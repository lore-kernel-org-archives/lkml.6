Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8AB20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8AB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbeGWV2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:28:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387982AbeGWV2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:28:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NKNTKo002750
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:25:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdhbju8mj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:25:11 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 16:25:10 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 16:25:07 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NKP75h4194674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 20:25:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4995DB206C;
        Mon, 23 Jul 2018 16:24:50 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 226D0B2068;
        Mon, 23 Jul 2018 16:24:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jul 2018 16:24:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 72E3016CA220; Mon, 23 Jul 2018 13:25:10 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:25:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Consolidating RCU-bh, RCU-preempt, and RCU-sched
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180713000249.GA16907@linux.vnet.ibm.com>
 <CAJhGHyCYxPNSM9fZgUHW7jFR0M3DFGn4HdQGfpRnzfnrL2yyYA@mail.gmail.com>
 <20180723161041.5375b54f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723161041.5375b54f@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072320-0068-0000-0000-0000031C5C72
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009419; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065113; UDB=6.00547104; IPR=6.00842970;
 MB=3.00022283; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-23 20:25:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072320-0069-0000-0000-000045227C8B
Message-Id: <20180723202510.GW12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:10:41PM -0400, Steven Rostedt wrote:
> 
> Sorry for the late reply, just came back from the Caribbean :-) :-) :-)

Welcome back, and I hope that the Caribbean trip was a good one!

> On Fri, 13 Jul 2018 11:47:18 +0800
> Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> 
> > On Fri, Jul 13, 2018 at 8:02 AM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > > Hello!
> > >
> > > I now have a semi-reasonable prototype of changes consolidating the
> > > RCU-bh, RCU-preempt, and RCU-sched update-side APIs in my -rcu tree.
> > > There are likely still bugs to be fixed and probably other issues as well,
> > > but a prototype does exist.
> 
> What's the rational for all this churn? Linus's complaining that there
> are too many RCU variants?

A CVE stemming from someone getting confused between the different flavors
of RCU.  The churn is large, as you say, but it does have the benefit of
making RCU a bit smaller.

Not necessarily simpler, but smaller.

> > > Assuming continued good rcutorture results and no objections, I am
> > > thinking in terms of this timeline:
> > >
> > > o       Preparatory work and cleanups are slated for the v4.19 merge window.
> > >
> > > o       The actual consolidation and post-consolidation cleanup is slated
> > >         for the merge window after v4.19 (v5.0?).  These cleanups include
> > >         the replacements called out below within the RCU implementation
> > >         itself (but excluding kernel/rcu/sync.c, see question below).
> > >
> > > o       Replacement of now-obsolete update APIs is slated for the second
> > >         merge window after v4.19 (v5.1?).  The replacements are currently
> > >         expected to be as follows:
> > >
> > >         synchronize_rcu_bh() -> synchronize_rcu()
> > >         synchronize_rcu_bh_expedited() -> synchronize_rcu_expedited()
> > >         call_rcu_bh() -> call_rcu()
> > >         rcu_barrier_bh() -> rcu_barrier()
> > >         synchronize_sched() -> synchronize_rcu()
> > >         synchronize_sched_expedited() -> synchronize_rcu_expedited()
> > >         call_rcu_sched() -> call_rcu()
> > >         rcu_barrier_sched() -> rcu_barrier()
> > >         get_state_synchronize_sched() -> get_state_synchronize_rcu()
> > >         cond_synchronize_sched() -> cond_synchronize_rcu()
> > >         synchronize_rcu_mult() -> synchronize_rcu()
> > >
> > >         I have done light testing of these replacements with good results.
> > >
> > > Any objections to this timeline?
> > >
> > > I also have some questions on the ultimate end point.  I have default
> > > choices, which I will likely take if there is no discussion.
> > >
> > > o
> > >         Currently, I am thinking in terms of keeping the per-flavor
> > >         read-side functions.  For example, rcu_read_lock_bh() would
> > >         continue to disable softirq, and would also continue to tell
> > >         lockdep about the RCU-bh read-side critical section.  However,
> > >         synchronize_rcu() will wait for all flavors of read-side critical
> > >         sections, including those introduced by (say) preempt_disable(),
> > >         so there will no longer be any possibility of mismatching (say)
> > >         RCU-bh readers with RCU-sched updaters.
> > >
> > >         I could imagine other ways of handling this, including:
> > >
> > >         a.      Eliminate rcu_read_lock_bh() in favor of
> > >                 local_bh_disable() and so on.  Rely on lockdep
> > >                 instrumentation of these other functions to identify RCU
> > >                 readers, introducing such instrumentation as needed.  I am
> > >                 not a fan of this approach because of the large number of
> > >                 places in the Linux kernel where interrupts, preemption,
> > >                 and softirqs are enabled or disabled "behind the scenes".
> > >
> > >         b.      Eliminate rcu_read_lock_bh() in favor of rcu_read_lock(),
> > >                 and required callers to also disable softirqs, preemption,
> > >                 or whatever as needed.  I am not a fan of this approach
> > >                 because it seems a lot less convenient to users of RCU-bh
> > >                 and RCU-sched.
> > >
> > >         At the moment, I therefore favor keeping the RCU-bh and RCU-sched
> > >         read-side APIs.  But are there better approaches?  
> > 
> > Hello, Paul
> > 
> > Since local_bh_disable() will be guaranteed to be protected by RCU
> > and more general. I'm afraid it will be preferred over
> > rcu_read_lock_bh() which will be gradually being phased out.
> > 
> > In other words, keeping the RCU-bh read-side APIs will be a slower
> > version of the option A. So will the same approach for the RCU-sched.
> > But it'll still be better than the hurrying option A, IMHO.
> 
> Now when all this gets done, is synchronize_rcu() going to just wait
> for everything to pass? (scheduling, RCU readers, softirqs, etc) Is
> there any worry about lengthening the time of synchronize_rcu?

Yes, when all is said and done, synchronize_rcu() will wait for everything
to get done.  I am not too worried about PREEMPT=y synchronize_rcu()'s
latency because the kernel usually doesn't spend that large a fraction
of its time disabled.  I am not worried at all about PREEMPT=n
synchronize_rcu()'s latency because it will if anything be slightly
faster due to being able to take advantage of some softirq transitions.

But one reason for feeding this in over three successive merge windows
is to get more time on it before it all goes in.

							Thanx, Paul

> -- Steve
> 
> 
> > >
> > > o       How should kernel/rcu/sync.c be handled?  Here are some
> > >         possibilities:
> > >
> > >         a.      Leave the full gp_ops[] array and simply translate
> > >                 the obsolete update-side functions to their RCU
> > >                 equivalents.
> > >
> > >         b.      Leave the current gp_ops[] array, but only have
> > >                 the RCU_SYNC entry.  The __INIT_HELD field would
> > >                 be set to a function that was OK with being in an
> > >                 RCU read-side critical section, an interrupt-disabled
> > >                 section, etc.
> > >
> > >                 This allows for possible addition of SRCU functionality.
> > >                 It is also a trivial change.  Note that the sole user
> > >                 of sync.c uses RCU_SCHED_SYNC, and this would need to
> > >                 be changed to RCU_SYNC.
> > >
> > >                 But is it likely that we will ever add SRCU?
> > >
> > >         c.      Eliminate that gp_ops[] array, hard-coding the function
> > >                 pointers into their call sites.
> > >
> > >         I don't really have a preference.  Left to myself, I will be lazy
> > >         and take option #a.  Are there better approaches?
> > >
> > > o       Currently, if a lock related to the scheduler's rq or pi locks is
> > >         held across rcu_read_unlock(), that lock must be held across the
> > >         entire read-side critical section in order to avoid deadlock.
> > >         Now that the end of the RCU read-side critical section is
> > >         deferred until sometime after interrupts are re-enabled, this
> > >         requirement could be lifted.  However, because the end of the RCU
> > >         read-side critical section is detected sometime after interrupts
> > >         are re-enabled, this means that a low-priority RCU reader might
> > >         remain priority-boosted longer than need be, which could be a
> > >         problem when running real-time workloads.
> > >
> > >         My current thought is therefore to leave this constraint in
> > >         place.  Thoughts?
> > >
> > > Anything else that I should be worried about?  ;-)
> > >
> > >                                                         Thanx, Paul
> > >  
> 

