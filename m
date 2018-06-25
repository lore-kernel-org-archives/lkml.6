Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1925B04
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D1925B04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeFYOHN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934074AbeFYOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:07:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7EA25B01;
        Mon, 25 Jun 2018 14:07:10 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:07:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Message-ID: <20180625100708.3cb50ced@gandalf.local.home>
In-Reply-To: <20180623174954.GA3584@linux.vnet.ibm.com>
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
        <20180622062351.GC17010@X58A-UD3R>
        <20180623174954.GA3584@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 10:49:54 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> commit 5e5ea52645b197fb7ae2f59f7927079b91e91aa0
> Author: Byungchul Park <byungchul.park@lge.com>
> Date:   Fri Jun 22 15:12:06 2018 +0900
> 
>     rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
>     
>     When entering or exiting irq or NMI handlers, the current code uses
>     ->dynticks_nmi_nesting to detect if it is in the outermost handler,  
>     that is, the one interrupting or returning to an RCU-idle context (the
>     idle loop or nohz_full usermode execution).  When entering the outermost
>     handler via an interrupt (as opposed to NMI), it is necessary to invoke
>     rcu_dynticks_task_exit() just before the CPU is marked non-idle from an
>     RCU perspective and to invoke rcu_cleanup_after_idle() just after the
>     CPU is marked non-idle.  Similarly, when exiting the outermost handler
>     via an interrupt, it is necessary to invoke rcu_prepare_for_idle() just
>     before marking the CPU idle and to invoke rcu_dynticks_task_enter()
>     just after marking the CPU idle.
>     
>     The decision to execute these four functions is currently taken in
>     rcu_irq_enter() and rcu_irq_exit() as follows:
>     
>        rcu_irq_enter()
>           /* A conditional branch with ->dynticks_nmi_nesting */
>           rcu_nmi_enter()
>              /* A conditional branch with ->dynticks */
>           /* A conditional branch with ->dynticks_nmi_nesting */
>     
>        rcu_irq_exit()
>           /* A conditional branch with ->dynticks_nmi_nesting */
>           rcu_nmi_exit()
>              /* A conditional branch with ->dynticks_nmi_nesting */
>           /* A conditional branch with ->dynticks_nmi_nesting */
>     
>        rcu_nmi_enter()
>           /* A conditional branch with ->dynticks */
>     
>        rcu_nmi_exit()
>           /* A conditional branch with ->dynticks_nmi_nesting */
>     
>     This works, but the conditional branches in rcu_irq_enter() and
>     rcu_irq_exit() are redundant with those in rcu_nmi_enter() and
>     rcu_nmi_exit(), respectively.  Redundant branches are not something
>     we want in the to/from-idle fastpaths, so this commit refactors
>     rcu_{nmi,irq}_{enter,exit}() so they use a common inlined function passed
>     a constant argument as follows:
>     
>        rcu_irq_enter() inlining rcu_nmi_enter_common(irq=true)
>           /* A conditional branch with ->dynticks */
>     
>        rcu_irq_exit() inlining rcu_nmi_exit_common(irq=true)
>           /* A conditional branch with ->dynticks_nmi_nesting */
>     
>        rcu_nmi_enter() inlining rcu_nmi_enter_common(irq=false)
>           /* A conditional branch with ->dynticks */
>     
>        rcu_nmi_exit() inlining rcu_nmi_exit_common(irq=false)
>           /* A conditional branch with ->dynticks_nmi_nesting */
>     
>     The combination of the constant function argument and the inlining allows
>     the compiler to discard the conditionals that previously controlled
>     execution of rcu_dynticks_task_exit(), rcu_cleanup_after_idle(),
>     rcu_prepare_for_idle(), and rcu_dynticks_task_enter().  This reduces both
>     the to-idle and from-idle path lengths by two conditional branches each,
>     and improves readability as well.

Nice write up. Makes a lot of sense.

>     
>     Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8788ddbc0d13..4ed74f10c852 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -773,17 +773,17 @@ void rcu_user_enter(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_exit - inform RCU of exit from NMI context
> + * rcu_nmi_exit_common - inform RCU of exit from NMI context
>   *
>   * If we are returning from the outermost NMI handler that interrupted an
>   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
>   * to let the RCU grace-period handling know that the CPU is back to
>   * being RCU-idle.
>   *
> - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> + * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_nmi_exit(void)
> +static __always_inline void rcu_nmi_exit_common(bool irq)
>  {
>  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>  
> @@ -809,7 +809,22 @@ void rcu_nmi_exit(void)
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
>  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> +
> +	if (irq)
> +		rcu_prepare_for_idle();
> +
>  	rcu_dynticks_eqs_enter();
> +
> +	if (irq)
> +		rcu_dynticks_task_enter();
> +}
> +
> +/**
> + * rcu_nmi_exit - inform RCU of exit from NMI context
> + */
> +void rcu_nmi_exit(void)
> +{
> +	rcu_nmi_exit_common(false);
>  }
>  
>  /**
> @@ -833,14 +848,8 @@ void rcu_nmi_exit(void)
>   */
>  void rcu_irq_exit(void)
>  {
> -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> -
>  	lockdep_assert_irqs_disabled();
> -	if (rdtp->dynticks_nmi_nesting == 1)
> -		rcu_prepare_for_idle();
> -	rcu_nmi_exit();
> -	if (rdtp->dynticks_nmi_nesting == 0)
> -		rcu_dynticks_task_enter();
> +	rcu_nmi_exit_common(true);
>  }
>  
>  /*
> @@ -923,7 +932,7 @@ void rcu_user_exit(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_enter - inform RCU of entry to NMI context
> + * rcu_nmi_enter_common - inform RCU of entry to NMI context
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
>   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> @@ -931,10 +940,10 @@ void rcu_user_exit(void)
>   * long as the nesting level does not overflow an int.  (You will probably
>   * run out of stack space first.)
>   *
> - * If you add or remove a call to rcu_nmi_enter(), be sure to test
> + * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_nmi_enter(void)
> +static __always_inline void rcu_nmi_enter_common(bool irq)
>  {
>  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>  	long incby = 2;
> @@ -951,7 +960,15 @@ void rcu_nmi_enter(void)
>  	 * period (observation due to Andy Lutomirski).
>  	 */
>  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> +
> +		if (irq)
> +			rcu_dynticks_task_exit();
> +
>  		rcu_dynticks_eqs_exit();
> +
> +		if (irq)
> +			rcu_cleanup_after_idle();
> +
>  		incby = 1;
>  	}
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),


There is a slight change here, although I don't think it is an issue,
but I want to bring it up just in case.

The old way had:

	rcu_dynticks_task_exit();
	rcu_dynticks_eqs_exit();
	trace_rcu_dyntick();
	rcu_cleanup_after_idle();

The new way has:

	rcu_dynticks_task_exit();
	rcu_dynticks_eqs_exit();
	rcu_cleanup_after_idle();
	trace_rcu_dyntick();

As that tracepoint will use RCU, will this cause any side effects?

My thought is that the new way is actually more correct, as I'm not
sure we wanted RCU usage before the rcu_cleanup_after_idle().

-- Steve


> @@ -962,6 +979,14 @@ void rcu_nmi_enter(void)
>  	barrier();
>  }
>  
> +/**
> + * rcu_nmi_enter - inform RCU of entry to NMI context
> + */
> +void rcu_nmi_enter(void)
> +{
> +	rcu_nmi_enter_common(false);
> +}
> +
>  /**
>   * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
>   *
> @@ -986,14 +1011,8 @@ void rcu_nmi_enter(void)
>   */
>  void rcu_irq_enter(void)
>  {
> -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> -
>  	lockdep_assert_irqs_disabled();
> -	if (rdtp->dynticks_nmi_nesting == 0)
> -		rcu_dynticks_task_exit();
> -	rcu_nmi_enter();
> -	if (rdtp->dynticks_nmi_nesting == 1)
> -		rcu_cleanup_after_idle();
> +	rcu_nmi_enter_common(true);
>  }
>  
>  /*

