Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C727BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A3C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A3C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeG3Qe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:34:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731797AbeG3Qe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:34:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UExL4A060396
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:59:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kj3pwuh0r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:59:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 30 Jul 2018 10:59:32 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 10:59:31 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UExU4q9044554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 14:59:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD770B205F;
        Mon, 30 Jul 2018 10:59:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E206B2067;
        Mon, 30 Jul 2018 10:59:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jul 2018 10:59:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 20F6416C17E6; Mon, 30 Jul 2018 07:59:33 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:59:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC tip/core/rcu] Avoid resched_cpu() when rescheduling
 the current CPU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180727154931.GA12106@linux.vnet.ibm.com>
 <20180730092513.GD2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730092513.GD2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073014-0060-0000-0000-00000294CE81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009457; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068112; UDB=6.00549045; IPR=6.00846205;
 MB=3.00022406; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 14:59:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073014-0061-0000-0000-000045FBE63E
Message-Id: <20180730145933.GX24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:25:13AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 27, 2018 at 08:49:31AM -0700, Paul E. McKenney wrote:
> > Hello, Peter,
> > 
> > It occurred to me that it is wasteful to let resched_cpu() acquire
> > ->pi_lock when doing something like resched_cpu(smp_processor_id()),
> 
> rq->lock

Good catch, will fix.  And thank you for looking this over!

> > and that it would be better to instead use set_tsk_need_resched(current)
> > and set_preempt_need_resched().
> > 
> > But is doing so really worthwhile?  For that matter, are there some
> > constraints on the use of those two functions that I am failing to
> > allow for in the patch below?
> 
> 
> >     The resched_cpu() interface is quite handy, but it does acquire the
> >     specified CPU's runqueue lock, which does not come for free.  This
> >     commit therefore substitutes the following when directing resched_cpu()
> >     at the current CPU:
> >     
> >             set_tsk_need_resched(current);
> >             set_preempt_need_resched();
> 
> That is only a valid substitute for resched_cpu(smp_processor_id()).

Understood.

> But also note how this can cause more context switches over
> resched_curr() for not checking if TIF_NEED_RESCHED wasn't already set.
> 
> Something that might be more in line with
> resched_curr(smp_processor_id()) would be:
> 
> 	preempt_disable();
> 	if (!test_tsk_need_resched(current)) {
> 		set_tsk_need_resched(current);
> 		set_preempt_need_resched();
> 	}
> 	preempt_enable();
> 
> Where the preempt_enable() could of course instantly trigger the
> reschedule if it was the outer most one.

Ah.  So should I use resched_curr() from rcu_check_callbacks(), which
is invoked from the scheduling-clock interrupt?  Right now I have calls
to set_tsk_need_resched() and set_preempt_need_resched().

> > @@ -2674,10 +2675,12 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
> 
> > -		resched_cpu(rdp->cpu); /* Provoke future context switch. */
> 
> > +		set_tsk_need_resched(current);
> > +		set_preempt_need_resched();
> 
> That's not obviously correct. rdp->cpu had better be smp_processor_id().

At the beginning of the function, we have:

	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);

And this is in a softirq handler, so we are OK.

> > @@ -672,7 +672,8 @@ static void sync_rcu_exp_handler(void *unused)
> >  			rcu_report_exp_rdp(rdp);
> >  		} else {
> >  			rdp->deferred_qs = true;
> > -			resched_cpu(rdp->cpu);
> > +			set_tsk_need_resched(t);
> > +			set_preempt_need_resched();
> 
> That only works if @t == current.

At the beginning of the function, we have:

	struct task_struct *t = current;

So we should be OK.

> >  		}
> >  		return;
> >  	}
> 
> > -	else
> > -		resched_cpu(rdp->cpu);
> > +	} else {
> > +		set_tsk_need_resched(t);
> > +		set_preempt_need_resched();
> 
> Similar...

Same function, so we should be good here as well.

> >  }
> 
> > @@ -791,8 +791,10 @@ static void rcu_flavor_check_callbacks(int user)
> >  	if (t->rcu_read_lock_nesting > 0 ||
> >  	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> >  		/* No QS, force context switch if deferred. */
> > -		if (rcu_preempt_need_deferred_qs(t))
> > -			resched_cpu(smp_processor_id());
> > +		if (rcu_preempt_need_deferred_qs(t)) {
> > +			set_tsk_need_resched(t);
> > +			set_preempt_need_resched();
> > +		}
> 
> And another dodgy one..

And the beginning of this function also has:

	struct task_struct *t = current;

So good there as well.

Should I be instead using resched_curr() on some or all of these?

kernel/rcu/tiny.c rcu_check_callbacks():

	Interrupts disabled (scheduling clock interrupt), so no
	point in preempt_disable().  It would make sense to check
	test_tsk_need_resched().  This is handling the case where someone
	disabled something over rcu_read_unlock(), but got preempted
	within (or had an overly long) RCU read-side critical section.
	This used to result in deadlock, but now just messes up real-time
	response.

kernel/rcu/tree.c print_cpu_stall():

	Interrupts disabled, so no point in preempt_disable().
	It might make sense to check test_tsk_need_resched(), but
	on the other hand at this point this CPU has gone for
	tens of seconds without a quiescent state.  Wouldn't hurt
	to check, though.

kernel/rcu/tree.c rcu_check_callbacks():

	Interrupts disabled (scheduling clock interrupt), so no
	point in preempt_disable().  It would make sense to check
	test_tsk_need_resched().  This is handling the case where someone
	disabled something over rcu_read_unlock(), but got preempted
	within (or had an overly long) RCU read-side critical section.
	This used to result in deadlock, but now just messes up real-time
	response.

kernel/rcu/tree.c rcu_process_callbacks():

	Softirqs disabled (softirq handler), so no point
	in preempt_disable().  It might make sense to check
	test_tsk_need_resched().  This is handling the case where someone
	disabled something over rcu_read_unlock(), but got preempted
	within (or had an overly long) RCU read-side critical section.
	This used to result in deadlock, but now just messes up real-time
	response.

kernel/rcu/tree_exp.h sync_rcu_exp_handler():
kernel/rcu/tree_exp.h sync_sched_exp_handler():

	Interrupts disabled (IPI handler), so no point in
	preempt_disable().  It might make sense to check
	test_tsk_need_resched().  This is the expedited
	grace-period case.  (The first is PREEMPT, the second
	!PREEMPT.)

kernel/rcu/tree_plugin.h rcu_flavor_check_callbacks():

	Interrupts disabled (scheduling clock interrupt), so no
	point in preempt_disable().  It would make sense to check
	test_tsk_need_resched().  This is handling the case where someone
	disabled something over rcu_read_unlock(), but got preempted
	within (or had an overly long) RCU read-side critical section.
	This used to result in deadlock, but now just messes up real-time
	response.

So it looks safe for me to invoke resched_curr() in all cases.  I don't
believe that the extra nested preempt_disable() will be a performance
problem.  Anything that I am missing here?

							Thanx, Paul

