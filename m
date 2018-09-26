Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CBB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2a/gSdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CBB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeIZN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:58:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43342 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeIZN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ABdYxSK4kaXbb7a54CdIXymQvP565TfjDPjQI1IwTNQ=; b=S2a/gSdIV8pJWb/HwivngMndo
        +T1KgoOG1he+8g7jTJMbyV2O0BaQcn1k895SGXhDRNYqO3nAGiFyAmgYQS1GyAfaT5AqcV/Sb65dZ
        HIvIvyFan7r9wifa/0wzQoiLnT39wtDRk8zwMHwLyYic2dpmJg0H6fAFp6DSrWluqYocsIyDJXY1J
        +oaEhKAhm2/CRWXXjO4CpcSH/Ek82f1UssrI+xoUcyNjg8rHvFcjW4KTgRjDwpJ0jOLxm0/oH8mW9
        6pM7+j1nPNzgESRy0IXWeQ3byDbjlmLPSNCS/zg6K2MGX0q5G58M+Bq/pSzdxZ+pdMjd6QlxwJY4h
        wZVltGfmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g54WQ-0006IV-GI; Wed, 26 Sep 2018 07:46:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 449FD20289D15; Wed, 26 Sep 2018 09:46:09 +0200 (CEST)
Date:   Wed, 26 Sep 2018 09:46:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     PierceGriffiths <pierceagriffiths@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler: conditional statement cleanup
Message-ID: <20180926074609.GA1654@hirez.programming.kicks-ass.net>
References: <20180921202205.11769-1-pierceagriffiths@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921202205.11769-1-pierceagriffiths@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:22:03PM -0500, PierceGriffiths wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc9897f62..443a1f235cfd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -617,12 +617,8 @@ bool sched_can_stop_tick(struct rq *rq)
>  	 * If there are more than one RR tasks, we need the tick to effect the
>  	 * actual RR behaviour.
>  	 */
> -	if (rq->rt.rr_nr_running) {
> -		if (rq->rt.rr_nr_running == 1)
> -			return true;
> -		else
> -			return false;
> -	}
> +	if (rq->rt.rr_nr_running)
> +		return rq->rt.rr_nr_running == 1;
>  
>  	/*
>  	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no

> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index daaadf939ccb..152c133e8247 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -29,20 +29,16 @@
>  #include "sched.h"
>  
>  /* Convert between a 140 based task->prio, and our 102 based cpupri */
> -static int convert_prio(int prio)
> +static int convert_prio(const int prio)
>  {
> -	int cpupri;
> -
>  	if (prio == CPUPRI_INVALID)
> -		cpupri = CPUPRI_INVALID;
> +		return CPUPRI_INVALID;
>  	else if (prio == MAX_PRIO)
> -		cpupri = CPUPRI_IDLE;
> +		return CPUPRI_IDLE;
>  	else if (prio >= MAX_RT_PRIO)
> -		cpupri = CPUPRI_NORMAL;
> +		return CPUPRI_NORMAL;
>  	else
> -		cpupri = MAX_RT_PRIO - prio + 1;
> -
> -	return cpupri;
> +		return MAX_RT_PRIO - prio + 1;

Code improves if you leave out the last else.

>  }
>  
>  /**

> @@ -222,7 +216,7 @@ int cpupri_init(struct cpupri *cp)
>  	return 0;
>  
>  cleanup:
> -	for (i--; i >= 0; i--)
> +	while (--i >= 0)
>  		free_cpumask_var(cp->pri_to_cpu[i].mask);
>  	return -ENOMEM;
>  }

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a8cf8f..acf1b94669ad 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -142,10 +142,12 @@ void free_rt_sched_group(struct task_group *tg)
>  		destroy_rt_bandwidth(&tg->rt_bandwidth);
>  
>  	for_each_possible_cpu(i) {
> -		if (tg->rt_rq)
> -			kfree(tg->rt_rq[i]);
> -		if (tg->rt_se)
> -			kfree(tg->rt_se[i]);
> +		/* Don't need to check if tg->rt_rq[i]
> +		 * or tg->rt_se[i] are NULL, since kfree(NULL)
> +		 * simply performs no operation
> +		 */

Don't bother with the comment tho (but if you do, know this is the wrong
comment style).

> +		kfree(tg->rt_rq[i]);
> +		kfree(tg->rt_se[i]);
>  	}
>  
>  	kfree(tg->rt_rq);

> @@ -1393,7 +1389,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  
>  	/* For anything but wake ups, just return the task_cpu */
>  	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> -		goto out;
> +		return cpu;
>  
>  	rq = cpu_rq(cpu);
>  
> @@ -1437,7 +1433,6 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	}
>  	rcu_read_unlock();
>  
> -out:
>  	return cpu;
>  }
>  

These changes are OK with minor edits, the rest just makes the code
harder to read.
