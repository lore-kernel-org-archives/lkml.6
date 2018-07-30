Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C413F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrWeWG/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeG3K7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeG3K7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zWypWX/Lmc9Sal0F1/QOdBjv6HrkRIilD9ad6tS5RO8=; b=CrWeWG/+YmsX5cM/5g1DIGqND
        EegIclVCLrWbcNxgAhSshO4qgtiNw18fYZXwxUVgmGjUg1pRZROeWW4Q9McfywW+JmCOEKTGwfZGA
        WcJJ82ztdwFP00Wttxm2zn8AXoNnM6u2W9oN9bdLYP3RIsS2LPffvt4ks55NmojapnU91ANNpYkfL
        sReAD5ruJ8YaPZbbI7HDlXtGSpTvxAjC7//diNzCeCE3RsSuQHBtzOGQNpTJqGfeLzPeRiZcs8YVf
        kfJ7ouJ/Z3PXhHBRTQ6G6xxu4h/dmE7JO6++A3dRM0Hf4RZ7xuLL9oDSqJLDX8HOSE2WSPQ7T46mt
        d6gQN/WRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4QV-0008TP-C4; Mon, 30 Jul 2018 09:25:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D027A20268325; Mon, 30 Jul 2018 11:25:13 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:25:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC tip/core/rcu] Avoid resched_cpu() when rescheduling
 the current CPU
Message-ID: <20180730092513.GD2494@hirez.programming.kicks-ass.net>
References: <20180727154931.GA12106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727154931.GA12106@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 08:49:31AM -0700, Paul E. McKenney wrote:
> Hello, Peter,
> 
> It occurred to me that it is wasteful to let resched_cpu() acquire
> ->pi_lock when doing something like resched_cpu(smp_processor_id()),

rq->lock

> and that it would be better to instead use set_tsk_need_resched(current)
> and set_preempt_need_resched().
> 
> But is doing so really worthwhile?  For that matter, are there some
> constraints on the use of those two functions that I am failing to
> allow for in the patch below?


>     The resched_cpu() interface is quite handy, but it does acquire the
>     specified CPU's runqueue lock, which does not come for free.  This
>     commit therefore substitutes the following when directing resched_cpu()
>     at the current CPU:
>     
>             set_tsk_need_resched(current);
>             set_preempt_need_resched();

That is only a valid substitute for resched_cpu(smp_processor_id()).

But also note how this can cause more context switches over
resched_curr() for not checking if TIF_NEED_RESCHED wasn't already set.

Something that might be more in line with
resched_curr(smp_processor_id()) would be:

	preempt_disable();
	if (!test_tsk_need_resched(current)) {
		set_tsk_need_resched(current);
		set_preempt_need_resched();
	}
	preempt_enable();

Where the preempt_enable() could of course instantly trigger the
reschedule if it was the outer most one.

> @@ -2674,10 +2675,12 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused

> -		resched_cpu(rdp->cpu); /* Provoke future context switch. */

> +		set_tsk_need_resched(current);
> +		set_preempt_need_resched();

That's not obviously correct. rdp->cpu had better be smp_processor_id().

> @@ -672,7 +672,8 @@ static void sync_rcu_exp_handler(void *unused)
>  			rcu_report_exp_rdp(rdp);
>  		} else {
>  			rdp->deferred_qs = true;
> -			resched_cpu(rdp->cpu);
> +			set_tsk_need_resched(t);
> +			set_preempt_need_resched();

That only works if @t == current.

>  		}
>  		return;
>  	}

> -	else
> -		resched_cpu(rdp->cpu);
> +	} else {
> +		set_tsk_need_resched(t);
> +		set_preempt_need_resched();

Similar...

>  }

> @@ -791,8 +791,10 @@ static void rcu_flavor_check_callbacks(int user)
>  	if (t->rcu_read_lock_nesting > 0 ||
>  	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
>  		/* No QS, force context switch if deferred. */
> -		if (rcu_preempt_need_deferred_qs(t))
> -			resched_cpu(smp_processor_id());
> +		if (rcu_preempt_need_deferred_qs(t)) {
> +			set_tsk_need_resched(t);
> +			set_preempt_need_resched();
> +		}

And another dodgy one..
