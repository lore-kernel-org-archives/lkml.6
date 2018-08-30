Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A99020838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A99020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeH3WN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeH3WN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:13:58 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CAEC2082A;
        Thu, 30 Aug 2018 18:10:33 +0000 (UTC)
Date:   Thu, 30 Aug 2018 14:10:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH tip/core/rcu 01/19] rcu: Refactor
 rcu_{nmi,irq}_{enter,exit}()
Message-ID: <20180830141032.76efd12c@gandalf.local.home>
In-Reply-To: <20180829222047.319-1-paulmck@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
        <20180829222047.319-1-paulmck@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 15:20:29 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> This commit also changes order of execution from this:
> 
> 	rcu_dynticks_task_exit();
> 	rcu_dynticks_eqs_exit();
> 	trace_rcu_dyntick();
> 	rcu_cleanup_after_idle();
> 
> To this:
> 
> 	rcu_dynticks_task_exit();
> 	rcu_dynticks_eqs_exit();
> 	rcu_cleanup_after_idle();
> 	trace_rcu_dyntick();
> 
> In other words, the calls to trace_rcu_dyntick() and trace_rcu_dyntick()

How is trace_rcu_dyntick() and trace_rcu_dyntick reversed ? ;-)

> are reversed.  This has no functional effect because the real
> concern is whether a given call is before or after the call to
> rcu_dynticks_eqs_exit(), and this patch does not change that.  Before the
> call to rcu_dynticks_eqs_exit(), RCU is not yet watching the current
> CPU and after that call RCU is watching.
> 
> A similar switch in calling order happens on the idle-entry path, with
> similar lack of effect for the same reasons.
> 
> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  kernel/rcu/tree.c | 61 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0b760c1369f7..0adf77923e8b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -771,17 +771,18 @@ void rcu_user_enter(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_exit - inform RCU of exit from NMI context
> + * rcu_nmi_exit_common - inform RCU of exit from NMI context
> + * @irq: Is this call from rcu_irq_exit?
>   *
>   * If we are returning from the outermost NMI handler that interrupted an
>   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
>   * to let the RCU grace-period handling know that the CPU is back to
>   * being RCU-idle.
>   *
> - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> + * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.

As this is a static function, this description doesn't make sense. You
need to move the description down to the new rcu_nmi_exit() below.

Other than that...

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>   */
> -void rcu_nmi_exit(void)
> +static __always_inline void rcu_nmi_exit_common(bool irq)
>  {
>  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>  
> @@ -807,7 +808,22 @@ void rcu_nmi_exit(void)
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
> @@ -831,14 +847,8 @@ void rcu_nmi_exit(void)
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
> @@ -921,7 +931,8 @@ void rcu_user_exit(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_enter - inform RCU of entry to NMI context
> + * rcu_nmi_enter_common - inform RCU of entry to NMI context
> + * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
>   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> @@ -929,10 +940,10 @@ void rcu_user_exit(void)
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
> @@ -949,7 +960,15 @@ void rcu_nmi_enter(void)
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
> @@ -960,6 +979,14 @@ void rcu_nmi_enter(void)
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
> @@ -984,14 +1011,8 @@ void rcu_nmi_enter(void)
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

