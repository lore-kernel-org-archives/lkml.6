Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DABC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6925A25BB2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6925A25BB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeFYOqv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:46:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934351AbeFYOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:46:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PEiugO025490
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:46:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jty8r8jtu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:46:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 10:46:48 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 10:46:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PEkjHZ49086618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 14:46:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61288B205F;
        Mon, 25 Jun 2018 10:46:40 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3046EB2064;
        Mon, 25 Jun 2018 10:46:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 10:46:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D8E616C5C70; Mon, 25 Jun 2018 07:48:49 -0700 (PDT)
Date:   Mon, 25 Jun 2018 07:48:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
 <20180622062351.GC17010@X58A-UD3R>
 <20180623174954.GA3584@linux.vnet.ibm.com>
 <20180625100708.3cb50ced@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625100708.3cb50ced@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062514-0040-0000-0000-00000444E3A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009253; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052141; UDB=6.00539352; IPR=6.00830066;
 MB=3.00021849; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 14:46:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062514-0041-0000-0000-0000084AF903
Message-Id: <20180625144849.GN3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:07:08AM -0400, Steven Rostedt wrote:
> On Sat, 23 Jun 2018 10:49:54 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > commit 5e5ea52645b197fb7ae2f59f7927079b91e91aa0
> > Author: Byungchul Park <byungchul.park@lge.com>
> > Date:   Fri Jun 22 15:12:06 2018 +0900
> > 
> >     rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
> >     
> >     When entering or exiting irq or NMI handlers, the current code uses
> >     ->dynticks_nmi_nesting to detect if it is in the outermost handler,  
> >     that is, the one interrupting or returning to an RCU-idle context (the
> >     idle loop or nohz_full usermode execution).  When entering the outermost
> >     handler via an interrupt (as opposed to NMI), it is necessary to invoke
> >     rcu_dynticks_task_exit() just before the CPU is marked non-idle from an
> >     RCU perspective and to invoke rcu_cleanup_after_idle() just after the
> >     CPU is marked non-idle.  Similarly, when exiting the outermost handler
> >     via an interrupt, it is necessary to invoke rcu_prepare_for_idle() just
> >     before marking the CPU idle and to invoke rcu_dynticks_task_enter()
> >     just after marking the CPU idle.
> >     
> >     The decision to execute these four functions is currently taken in
> >     rcu_irq_enter() and rcu_irq_exit() as follows:
> >     
> >        rcu_irq_enter()
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >           rcu_nmi_enter()
> >              /* A conditional branch with ->dynticks */
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >     
> >        rcu_irq_exit()
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >           rcu_nmi_exit()
> >              /* A conditional branch with ->dynticks_nmi_nesting */
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >     
> >        rcu_nmi_enter()
> >           /* A conditional branch with ->dynticks */
> >     
> >        rcu_nmi_exit()
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >     
> >     This works, but the conditional branches in rcu_irq_enter() and
> >     rcu_irq_exit() are redundant with those in rcu_nmi_enter() and
> >     rcu_nmi_exit(), respectively.  Redundant branches are not something
> >     we want in the to/from-idle fastpaths, so this commit refactors
> >     rcu_{nmi,irq}_{enter,exit}() so they use a common inlined function passed
> >     a constant argument as follows:
> >     
> >        rcu_irq_enter() inlining rcu_nmi_enter_common(irq=true)
> >           /* A conditional branch with ->dynticks */
> >     
> >        rcu_irq_exit() inlining rcu_nmi_exit_common(irq=true)
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >     
> >        rcu_nmi_enter() inlining rcu_nmi_enter_common(irq=false)
> >           /* A conditional branch with ->dynticks */
> >     
> >        rcu_nmi_exit() inlining rcu_nmi_exit_common(irq=false)
> >           /* A conditional branch with ->dynticks_nmi_nesting */
> >     
> >     The combination of the constant function argument and the inlining allows
> >     the compiler to discard the conditionals that previously controlled
> >     execution of rcu_dynticks_task_exit(), rcu_cleanup_after_idle(),
> >     rcu_prepare_for_idle(), and rcu_dynticks_task_enter().  This reduces both
> >     the to-idle and from-idle path lengths by two conditional branches each,
> >     and improves readability as well.
> 
> Nice write up. Makes a lot of sense.

On behalf of both Byungchul and myself, glad you like it!

> >     Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8788ddbc0d13..4ed74f10c852 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -773,17 +773,17 @@ void rcu_user_enter(void)
> >  #endif /* CONFIG_NO_HZ_FULL */
> >  
> >  /**
> > - * rcu_nmi_exit - inform RCU of exit from NMI context
> > + * rcu_nmi_exit_common - inform RCU of exit from NMI context
> >   *
> >   * If we are returning from the outermost NMI handler that interrupted an
> >   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
> >   * to let the RCU grace-period handling know that the CPU is back to
> >   * being RCU-idle.
> >   *
> > - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > + * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -void rcu_nmi_exit(void)
> > +static __always_inline void rcu_nmi_exit_common(bool irq)
> >  {
> >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> >  
> > @@ -809,7 +809,22 @@ void rcu_nmi_exit(void)
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> >  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
> >  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> > +
> > +	if (irq)
> > +		rcu_prepare_for_idle();
> > +
> >  	rcu_dynticks_eqs_enter();
> > +
> > +	if (irq)
> > +		rcu_dynticks_task_enter();
> > +}
> > +
> > +/**
> > + * rcu_nmi_exit - inform RCU of exit from NMI context
> > + */
> > +void rcu_nmi_exit(void)
> > +{
> > +	rcu_nmi_exit_common(false);
> >  }
> >  
> >  /**
> > @@ -833,14 +848,8 @@ void rcu_nmi_exit(void)
> >   */
> >  void rcu_irq_exit(void)
> >  {
> > -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > -
> >  	lockdep_assert_irqs_disabled();
> > -	if (rdtp->dynticks_nmi_nesting == 1)
> > -		rcu_prepare_for_idle();
> > -	rcu_nmi_exit();
> > -	if (rdtp->dynticks_nmi_nesting == 0)
> > -		rcu_dynticks_task_enter();
> > +	rcu_nmi_exit_common(true);
> >  }
> >  
> >  /*
> > @@ -923,7 +932,7 @@ void rcu_user_exit(void)
> >  #endif /* CONFIG_NO_HZ_FULL */
> >  
> >  /**
> > - * rcu_nmi_enter - inform RCU of entry to NMI context
> > + * rcu_nmi_enter_common - inform RCU of entry to NMI context
> >   *
> >   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
> >   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> > @@ -931,10 +940,10 @@ void rcu_user_exit(void)
> >   * long as the nesting level does not overflow an int.  (You will probably
> >   * run out of stack space first.)
> >   *
> > - * If you add or remove a call to rcu_nmi_enter(), be sure to test
> > + * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -void rcu_nmi_enter(void)
> > +static __always_inline void rcu_nmi_enter_common(bool irq)
> >  {
> >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> >  	long incby = 2;
> > @@ -951,7 +960,15 @@ void rcu_nmi_enter(void)
> >  	 * period (observation due to Andy Lutomirski).
> >  	 */
> >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > +
> > +		if (irq)
> > +			rcu_dynticks_task_exit();
> > +
> >  		rcu_dynticks_eqs_exit();
> > +
> > +		if (irq)
> > +			rcu_cleanup_after_idle();
> > +
> >  		incby = 1;
> >  	}
> >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> 
> 
> There is a slight change here, although I don't think it is an issue,
> but I want to bring it up just in case.
> 
> The old way had:
> 
> 	rcu_dynticks_task_exit();
> 	rcu_dynticks_eqs_exit();
> 	trace_rcu_dyntick();
> 	rcu_cleanup_after_idle();
> 
> The new way has:
> 
> 	rcu_dynticks_task_exit();
> 	rcu_dynticks_eqs_exit();
> 	rcu_cleanup_after_idle();
> 	trace_rcu_dyntick();
> 
> As that tracepoint will use RCU, will this cause any side effects?
> 
> My thought is that the new way is actually more correct, as I'm not
> sure we wanted RCU usage before the rcu_cleanup_after_idle().

I believe that this is OK because is is the position of the call to
rcu_dynticks_eqs_exit() that really matters.  Before this call, RCU
is not yet watching, and after this call it is watching.  Reversing
the calls to rcu_cleanup_after_idle() and trace_rcu_dyntick() has them
both being invoked while RCU is watching.

All that rcu_cleanup_after_idle() does is to account for the time that
passed while the CPU was idle, for example, advancing callbacks to allow
for how ever many RCU grace periods completed during that idle period.

Or am I missing something subtle.

(At the very least, you would be quite right to ask that this be added
to the commit log!)

							Thanx, Paul

> -- Steve
> 
> 
> > @@ -962,6 +979,14 @@ void rcu_nmi_enter(void)
> >  	barrier();
> >  }
> >  
> > +/**
> > + * rcu_nmi_enter - inform RCU of entry to NMI context
> > + */
> > +void rcu_nmi_enter(void)
> > +{
> > +	rcu_nmi_enter_common(false);
> > +}
> > +
> >  /**
> >   * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
> >   *
> > @@ -986,14 +1011,8 @@ void rcu_nmi_enter(void)
> >   */
> >  void rcu_irq_enter(void)
> >  {
> > -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > -
> >  	lockdep_assert_irqs_disabled();
> > -	if (rdtp->dynticks_nmi_nesting == 0)
> > -		rcu_dynticks_task_exit();
> > -	rcu_nmi_enter();
> > -	if (rdtp->dynticks_nmi_nesting == 1)
> > -		rcu_cleanup_after_idle();
> > +	rcu_nmi_enter_common(true);
> >  }
> >  
> >  /*
> 

