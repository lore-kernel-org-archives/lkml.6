Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64A2404E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jl3MccHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE64A2404E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeGFGEK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:04:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39071 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932603AbeGFGCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:02:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so7482474pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wmmV+PbNxa9ccj5txR9YHkMirkww93oK61c0K/Z7Cqw=;
        b=jl3MccHYpCiqIcPzMBUG5XFNM+bbjfJzXb35yhGCaPPkiptZPrd6SZlyeFZ18yzYcN
         pdVIvRq00jvNJRmlvdPKyYFZH4YZKz9zARjUfm07q1wv/SPcq1+zh6wyDTcSpMdE9Z4q
         /DKwCHPlBLB8KCz1IXq1MgFtG4DkXynk3Os6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmmV+PbNxa9ccj5txR9YHkMirkww93oK61c0K/Z7Cqw=;
        b=tdNZdLzQ2XztHj/QsumwyoR+Lyw+VIqQBeHucYDRa+T8o6BJx0rBRn0CFxZKgEqnVo
         ybBEGJn5NxDOld62y162JilPP8pPqONhrnxoajILTHwLO+6zjCjp+8ZujFE9gz8RXndw
         bpAXT91STv/dTBxmkJ6x0FUYPnLi8H6oyPVYdDYSyV8E7Ay4vzI9ABE3qnEYtO2X37os
         WyxHpEFfHBU8PA7Nt7EEJCAdZE0FA2q9nDc8Tgw61v2dOLqRv2SP+bDkMqx+23p+JTwS
         j1Hf+Y2UePJk8RVh6wCmhXbn9qcoDZmwCR2KOlUc0li9CJRcCHH/lkCzNh1pYpvVsyVg
         OlFQ==
X-Gm-Message-State: APt69E1gK28zwpTY/Pqq8I+/2IiaZ5mP874LElGLvDMPLBPbzad1iNrY
        huzVbUYlEOheNVuT2s4ZQAAuPA==
X-Google-Smtp-Source: AAOMgpcfz0ucVj6gw0YhZdPf2HGSH7uXewfNHgHURA6r9I8hhzlRYJ2yZPOlaGMFlRouoDkggpIFcA==
X-Received: by 2002:a63:a347:: with SMTP id v7-v6mr2068374pgn.182.1530856925122;
        Thu, 05 Jul 2018 23:02:05 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id u11-v6sm3029552pfd.125.2018.07.05.23.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:02:04 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:32:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 08/11] sched: schedutil: remove sugov_aggregate_util()
Message-ID: <20180706060202.2ig6hmdo3pnlpotc@vireshk-i7>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-9-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530200714-4504-9-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-18, 17:45, Vincent Guittot wrote:
> There is no reason why sugov_get_util() and sugov_aggregate_util()
> were in fact separate functions.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [rebased after adding irq tracking and fixed some compilation errors]
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 44 ++++++++++++++--------------------------
>  kernel/sched/sched.h             |  2 +-
>  2 files changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index b77bfef..d04f941 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -53,12 +53,7 @@ struct sugov_cpu {
>  	unsigned int		iowait_boost_max;
>  	u64			last_update;
>  
> -	/* The fields below are only needed when sharing a policy: */
> -	unsigned long		util_cfs;
> -	unsigned long		util_dl;
>  	unsigned long		bw_dl;
> -	unsigned long		util_rt;
> -	unsigned long		util_irq;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -182,38 +177,31 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util, irq, max;
>  
> -	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> -	sg_cpu->util_cfs = cpu_util_cfs(rq);
> -	sg_cpu->util_dl  = cpu_util_dl(rq);
> -	sg_cpu->bw_dl    = cpu_bw_dl(rq);
> -	sg_cpu->util_rt  = cpu_util_rt(rq);
> -	sg_cpu->util_irq = cpu_util_irq(rq);
> -}
> -
> -static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> -{
> -	struct rq *rq = cpu_rq(sg_cpu->cpu);
> -	unsigned long util, max = sg_cpu->max;
> +	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> +	sg_cpu->bw_dl = cpu_bw_dl(rq);
>  
>  	if (rq->rt.rt_nr_running)
> -		return sg_cpu->max;
> +		return max;
> +
> +	irq = cpu_util_irq(rq);
>  
> -	if (unlikely(sg_cpu->util_irq >= max))
> +	if (unlikely(irq >= max))
>  		return max;
>  
>  	/* Sum rq utilization */
> -	util = sg_cpu->util_cfs;
> -	util += sg_cpu->util_rt;
> +	util = cpu_util_cfs(rq);
> +	util += cpu_util_rt(rq);
>  
>  	/*
>  	 * Interrupt time is not seen by rqs utilization nso we can compare
>  	 * them with the CPU capacity
>  	 */
> -	if ((util + sg_cpu->util_dl) >= max)
> +	if ((util + cpu_util_dl(rq)) >= max)
>  		return max;
>  
>  	/*
> @@ -231,11 +219,11 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	 */
>  
>  	/* Weight rqs utilization to normal context window */
> -	util *= (max - sg_cpu->util_irq);
> +	util *= (max - irq);
>  	util /= max;
>  
>  	/* Add interrupt utilization */
> -	util += sg_cpu->util_irq;
> +	util += irq;
>  
>  	/* Add DL bandwidth requirement */
>  	util += sg_cpu->bw_dl;
> @@ -418,9 +406,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  
>  	busy = sugov_cpu_is_busy(sg_cpu);
>  
> -	sugov_get_util(sg_cpu);
> +	util = sugov_get_util(sg_cpu);
>  	max = sg_cpu->max;
> -	util = sugov_aggregate_util(sg_cpu);
>  	sugov_iowait_apply(sg_cpu, time, &util, &max);
>  	next_f = get_next_freq(sg_policy, util, max);
>  	/*
> @@ -459,9 +446,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>  		unsigned long j_util, j_max;
>  
> -		sugov_get_util(j_sg_cpu);
> +		j_util = sugov_get_util(j_sg_cpu);
>  		j_max = j_sg_cpu->max;
> -		j_util = sugov_aggregate_util(j_sg_cpu);
>  		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
>  
>  		if (j_util * max > j_max * util) {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9438e68..59a633d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2219,7 +2219,7 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
>  
>  static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
> -	return rq->avg_rt.util_avg;
> +	return READ_ONCE(rq->avg_rt.util_avg);
>  }
>  
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
