Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8637C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626B02586C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626B02586C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGAWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 18:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752504AbeGAWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 18:22:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w61MJNNc060627
        for <linux-kernel@vger.kernel.org>; Sun, 1 Jul 2018 18:22:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jxq0pd5q9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 18:22:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 1 Jul 2018 18:22:54 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 1 Jul 2018 18:22:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w61MMow11769780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Jul 2018 22:22:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20B96B205F;
        Sun,  1 Jul 2018 18:22:36 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92B5B2065;
        Sun,  1 Jul 2018 18:22:35 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  1 Jul 2018 18:22:35 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0B4E016CA30F; Sun,  1 Jul 2018 15:25:01 -0700 (PDT)
Date:   Sun, 1 Jul 2018 15:25:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 1/2] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180701174045.GA111992@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701174045.GA111992@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070122-0072-0000-0000-00000377E9F3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009291; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055173; UDB=6.00541171; IPR=6.00833095;
 MB=3.00021955; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-01 22:22:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070122-0073-0000-0000-0000488E3096
Message-Id: <20180701222501.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807010268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 10:40:45AM -0700, Joel Fernandes wrote:
> On Wed, Jun 27, 2018 at 01:49:14PM -0700, Paul E. McKenney wrote:
> > This commit defers reporting of RCU-preempt quiescent states at
> > rcu_read_unlock_special() time when any of interrupts, softirq, or
> > preemption are disabled.  These deferred quiescent states are reported
> > at a later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug
> > offline operation.  Of course, if another RCU read-side critical
> > section has started in the meantime, the reporting of the quiescent
> > state will be further deferred.
> > 
> > This also means that disabling preemption, interrupts, and/or
> > softirqs will act as an RCU-preempt read-side critical section.
> > This is enforced by checking preempt_count() as needed.
> > 
> > Some special cases must be handled on an ad-hoc basis, for example,
> > context switch is a quiescent state even though both the scheduler and
> > do_exit() disable preemption.  In these cases, additional calls to
> > rcu_preempt_deferred_qs() override the preemption disabling.  Similar
> > logic overrides disabled interrupts in rcu_preempt_check_callbacks()
> > because in this case the quiescent state happened just before the
> > corresponding scheduling-clock interrupt.
> > 
> > This change lifts a long-standing restriction that required that if
> > interrupts were disabled across a call to rcu_read_unlock() that the
> > matching rcu_read_lock() also be contained within that interrupts-disabled
> > region of code.  Because the reporting of the corresponding RCU-preempt
> > quiescent state is now deferred until after interrupts have been enabled,
> > it is no longer possible for this situation to result in deadlocks
> > involving the scheduler's runqueue and priority-inheritance locks.
> > This may allow some code simplification that might reduce interrupt
> > latency a bit.  Unfortunately, this would also defer deboosting a
> > low-priority task that had been subjected to RCU priority boosting,
> > so real-time-response considerations might well force this restriction
> > to remain in place.
> > 
> > Because RCU-preempt grace periods are now blocked not only by RCU
> > read-side critical sections, but also by disabling of interrupts,
> > preemption, and softirqs, it will be possible to eliminate RCU-bh and
> > RCU-sched in favor of RCU-preempt in CONFIG_PREEMPT=y kernels.  This may
> > require some additional plumbing to provide the network denial-of-service
> > guarantees that have been traditionally provided by RCU-bh.  Once these
> > are in place, CONFIG_PREEMPT=n kernels will be able to fold RCU-bh
> > into RCU-sched.  This would mean that all kernels would have but
> > one flavor of RCU, which would open the door to significant code
> > cleanup.
> > 
> > Moving to a single flavor of RCU would also have the beneficial effect
> > of reducing the NOCB kthreads by at least a factor of two.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [...]
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index c1b17f5b9361..ff5c70eae47d 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -371,6 +371,9 @@ static void rcu_preempt_note_context_switch(bool preempt)
> >  		 * behalf of preempted instance of __rcu_read_unlock().
> >  		 */
> >  		rcu_read_unlock_special(t);
> > +		rcu_preempt_deferred_qs(t);
> > +	} else {
> > +		rcu_preempt_deferred_qs(t);
> >  	}
> >  
> >  	/*
> > @@ -464,54 +467,51 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
> >  }
> >  
> >  /*
> > - * Handle special cases during rcu_read_unlock(), such as needing to
> > - * notify RCU core processing or task having blocked during the RCU
> > - * read-side critical section.
> > + * Report deferred quiescent states.  The deferral time can
> > + * be quite short, for example, in the case of the call from
> > + * rcu_read_unlock_special().
> >   */
> > -static void rcu_read_unlock_special(struct task_struct *t)
> > +static void
> > +rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >  {
> >  	bool empty_exp;
> >  	bool empty_norm;
> >  	bool empty_exp_now;
> > -	unsigned long flags;
> >  	struct list_head *np;
> >  	bool drop_boost_mutex = false;
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  	union rcu_special special;
> >  
> > -	/* NMI handlers cannot block and cannot safely manipulate state. */
> > -	if (in_nmi())
> > -		return;
> > -
> > -	local_irq_save(flags);
> > -
> >  	/*
> >  	 * If RCU core is waiting for this CPU to exit its critical section,
> >  	 * report the fact that it has exited.  Because irqs are disabled,
> >  	 * t->rcu_read_unlock_special cannot change.
> >  	 */
> >  	special = t->rcu_read_unlock_special;
> > +	rdp = this_cpu_ptr(rcu_state_p->rda);
> > +	if (!special.s && !rdp->deferred_qs) {
> > +		local_irq_restore(flags);
> > +		return;
> > +	}
> >  	if (special.b.need_qs) {
> >  		rcu_preempt_qs();
> >  		t->rcu_read_unlock_special.b.need_qs = false;
> > -		if (!t->rcu_read_unlock_special.s) {
> > +		if (!t->rcu_read_unlock_special.s && !rdp->deferred_qs) {
> >  			local_irq_restore(flags);
> >  			return;
> >  		}
> >  	}
> >  
> >  	/*
> > -	 * Respond to a request for an expedited grace period, but only if
> > -	 * we were not preempted, meaning that we were running on the same
> > -	 * CPU throughout.  If we were preempted, the exp_need_qs flag
> > -	 * would have been cleared at the time of the first preemption,
> > -	 * and the quiescent state would be reported when we were dequeued.
> > +	 * Respond to a request by an expedited grace period for a
> > +	 * quiescent state from this CPU.  Note that requests from
> > +	 * tasks are handled when removing the task from the
> > +	 * blocked-tasks list below.
> >  	 */
> > -	if (special.b.exp_need_qs) {
> > -		WARN_ON_ONCE(special.b.blocked);
> > +	if (special.b.exp_need_qs || rdp->deferred_qs) {
> >  		t->rcu_read_unlock_special.b.exp_need_qs = false;
> > -		rdp = this_cpu_ptr(rcu_state_p->rda);
> > +		rdp->deferred_qs = false;
> >  		rcu_report_exp_rdp(rcu_state_p, rdp, true);
> >  		if (!t->rcu_read_unlock_special.s) {
> >  			local_irq_restore(flags);
> > @@ -519,19 +519,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		}
> >  	}
> >  
> > -	/* Hardware IRQ handlers cannot block, complain if they get here. */
> > -	if (in_irq() || in_serving_softirq()) {
> > -		lockdep_rcu_suspicious(__FILE__, __LINE__,
> > -				       "rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
> > -		pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",
> > -			 t->rcu_read_unlock_special.s,
> > -			 t->rcu_read_unlock_special.b.blocked,
> > -			 t->rcu_read_unlock_special.b.exp_need_qs,
> > -			 t->rcu_read_unlock_special.b.need_qs);
> > -		local_irq_restore(flags);
> > -		return;
> > -	}
> > -
> >  	/* Clean up if blocked during RCU read-side critical section. */
> >  	if (special.b.blocked) {
> >  		t->rcu_read_unlock_special.b.blocked = false;
> > @@ -602,6 +589,66 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  	}
> >  }
> >  
> > +/*
> > + * Is a deferred quiescent-state pending, and are we also not in
> > + * an RCU read-side critical section?  It is the caller's responsibility
> > + * to ensure it is otherwise safe to report any deferred quiescent
> > + * states.  The reason for this is that it is safe to report a
> > + * quiescent state during context switch even though preemption
> > + * is disabled.  This function cannot be expected to understand these
> > + * nuances, so the caller must handle them.
> > + */
> > +static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > +{
> > +	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
> > +		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> > +	       !t->rcu_read_lock_nesting;
> > +}
> > +
> > +/*
> > + * Report a deferred quiescent state if needed and safe to do so.
> > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > + * not being in an RCU read-side critical section.  The caller must
> > + * evaluate safety in terms of interrupt, softirq, and preemption
> > + * disabling.
> > + */
> > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!rcu_preempt_need_deferred_qs(t))
> > +		return;
> > +	local_irq_save(flags);
> > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > +}
> > +
> > +/*
> > + * Handle special cases during rcu_read_unlock(), such as needing to
> > + * notify RCU core processing or task having blocked during the RCU
> > + * read-side critical section.
> > + */
> > +static void rcu_read_unlock_special(struct task_struct *t)
> > +{
> > +	unsigned long flags;
> > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> 
> Would it be better to just test for those bits just to be safe the higher
> order bits don't bleed in, such as PREEMPT_NEED_RESCHED, something like the
> following based on the 'dev' branch?

Good point!  My plan is to merge it into the original commit with
attribution.  Please let me know if you have objections.

							Thanx, Paul

> thanks,
> 
> - Joel
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dfeca11c9fe7..ca7cfdf422f1 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -626,7 +626,8 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
>  static void rcu_read_unlock_special(struct task_struct *t)
>  {
>  	unsigned long flags;
> -	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> +	bool preempt_bh_were_disabled = !!(preempt_count() &
> +					   (PREEMPT_MASK | SOFTIRQ_MASK));
>  	bool irqs_were_disabled;
> 
>  	/* NMI handlers cannot block and cannot safely manipulate state. */
> 

