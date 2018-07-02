Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A4C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F71E24AEF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F71E24AEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGBDJ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:09:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752972AbeGBDJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:09:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62393mK103016
        for <linux-kernel@vger.kernel.org>; Sun, 1 Jul 2018 23:09:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jxqcq33fg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 23:09:28 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 1 Jul 2018 23:09:26 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 1 Jul 2018 23:09:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6239LMX1769886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 03:09:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E8DBB205F;
        Sun,  1 Jul 2018 23:09:07 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED607B2064;
        Sun,  1 Jul 2018 23:09:06 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  1 Jul 2018 23:09:06 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 944DE16CA314; Sun,  1 Jul 2018 20:11:32 -0700 (PDT)
Date:   Sun, 1 Jul 2018 20:11:32 -0700
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
 <20180701183828.GB111992@joelaf.mtv.corp.google.com>
 <20180701222749.GD3593@linux.vnet.ibm.com>
 <20180702003553.GA95395@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702003553.GA95395@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070203-0040-0000-0000-0000044812F0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009292; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055269; UDB=6.00541228; IPR=6.00833191;
 MB=3.00021956; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 03:09:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070203-0041-0000-0000-0000084E2E3A
Message-Id: <20180702031132.GI3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 05:35:53PM -0700, Joel Fernandes wrote:
> On Sun, Jul 01, 2018 at 03:27:49PM -0700, Paul E. McKenney wrote:
> [...]
> > > > +/*
> > > > + * Report a deferred quiescent state if needed and safe to do so.
> > > > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > > > + * not being in an RCU read-side critical section.  The caller must
> > > > + * evaluate safety in terms of interrupt, softirq, and preemption
> > > > + * disabling.
> > > > + */
> > > > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	if (!rcu_preempt_need_deferred_qs(t))
> > > > +		return;
> > > > +	local_irq_save(flags);
> > > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Handle special cases during rcu_read_unlock(), such as needing to
> > > > + * notify RCU core processing or task having blocked during the RCU
> > > > + * read-side critical section.
> > > > + */
> > > > +static void rcu_read_unlock_special(struct task_struct *t)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> > > > +	bool irqs_were_disabled;
> > > > +
> > > > +	/* NMI handlers cannot block and cannot safely manipulate state. */
> > > > +	if (in_nmi())
> > > > +		return;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	irqs_were_disabled = irqs_disabled_flags(flags);
> > > > +	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > > +	    t->rcu_read_unlock_special.b.blocked) {
> > > > +		/* Need to defer quiescent state until everything is enabled. */
> > > > +		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > +		local_irq_restore(flags);
> > > > +		return;
> > > > +	}
> > > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Dump detailed information for all tasks blocking the current RCU
> > > >   * grace period on the specified rcu_node structure.
> > > > @@ -737,10 +784,20 @@ static void rcu_preempt_check_callbacks(void)
> > > >  	struct rcu_state *rsp = &rcu_preempt_state;
> > > >  	struct task_struct *t = current;
> > > >  
> > > > -	if (t->rcu_read_lock_nesting == 0) {
> > > > -		rcu_preempt_qs();
> > > > +	if (t->rcu_read_lock_nesting > 0 ||
> > > > +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> > > > +		/* No QS, force context switch if deferred. */
> > > > +		if (rcu_preempt_need_deferred_qs(t))
> > > > +			resched_cpu(smp_processor_id());
> > > 
> > > 
> > > Hi Paul,
> > > 
> > > I had a similar idea of checking the preempt_count() sometime back but didn't
> > > believe this path can be called with preempt enabled (for some reason ;-)).
> > > Now that I've convinced myself that's possible, what do you think about
> > > taking advantage of the opportunity to report a RCU-sched qs like below from
> > > rcu_check_callbacks ?
> > > 
> > > Did some basic testing, can roll into a patch later if you're Ok with it.
> > 
> > The problem here is that the code patch above cannot be called
> > with CONFIG_PREEMPT_COUNT=n, but the code below can.  And if
> > CONFIG_PREEMPT_COUNT=n, the return value from preempt_count() can be
> > misleading.
> > 
> > Or am I missing something here?
> 
> That is true! so then I could also test if PREEMPT_RCU is enabled like you're
> doing in the other path.
> 
> thanks!
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fb440baf8ac6..03a460921dca 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2683,6 +2683,12 @@ void rcu_check_callbacks(int user)
>  		rcu_note_voluntary_context_switch(current);
> 
>  	} else if (!in_softirq()) {
> +		/*
> +		 * Report RCU-sched qs if not in an RCU-sched read-side
> +		 * critical section.
> +		 */
> +		if (IS_ENABLED(PREEMPT_RCU) && !(preempt_count() & PREEMPT_MASK))

For more precision, s/PREEMPT_RCU/CONFIG_PREEMPT_COUNT/

Hmmm...  I recently queued a patch that redefines the RCU-bh update-side
API in terms of the consolidated RCU implementation, so this "else"
clause no longer exists.  One approach would be to fold this condition
(with the addition of SOFTIRQ_MASK) into the previous "if" condition,
but that would call rcu_note_voluntary_context_switch() at bad times.
So maybe this becomes a new "else if" clause.

Another complication is an upcoming step that redefines the RCU-sched
update-side API in terms of the consolidated RCU implementation, which
will likely restructure this "if" statement yet again.

So I will try to fold this idea in (with attribution).  If I don't get
it in place in a week or two, please remind me.  Of course, one good way
to remind me is to supply a patch against whatever this turns into.  ;-)

							Thanx, Paul

> +			rcu_sched_qs();
> 
>  		/*
>  		 * Get here if this CPU did not take its interrupt from
> 

