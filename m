Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE14ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuuyUax+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE0720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeGTFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:42:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41017 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeGTFmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:42:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so5745904pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 21:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FkmFZS8JYFsvDt0doVB5nhA6QI9nPzYl0tDTZCr9Ptw=;
        b=CuuyUax+ZrEa6b1tV2NpkQQuK74Z/PFABjyXhgiBcEszOs/Sn5GKDtt22ueW6eLfrq
         JHzbk+UQPiDqGpWj6fIZ693NZzg8zsvRMjcihWuGsbusKEjl0DCk+SSTjeaU82JF+VvZ
         EBQI4cjESxtqR0exJtXcxhCzbz66Ke/pxvpbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FkmFZS8JYFsvDt0doVB5nhA6QI9nPzYl0tDTZCr9Ptw=;
        b=i1vSO9H4MaHaxBLoCGyOL2Gqr8y3S2D2rmyEujISnapc9BEF/bAfqWjyqSDGQoQIqy
         vWyXOmO2fyE830lwtwep9gJJhggZP+v/DghoaJq/xzgBmq7RWOgaBniylXZ9IJe4CcXG
         ZOxfzdlBlXf/DjuWVo1Df8ZQYzFJV45dc1l95VmkNqJuA6zovHmCgvAdXXKNt4pjUvEb
         bhG0RFrlG7G9Acwp9we/aIGf/o5EfTTUk2oXBQES7aXq0PHiaaASt8cLpc/qzXConORa
         KqzJ03bj/at8PAgB4p5C0XsQvKWhGu1IFZWBIyhpot77XS7KB099FU19amruTxu0JIJn
         gjKQ==
X-Gm-Message-State: AOUpUlHk4oeiWYhwouD0inIgu2fJXxMHSENYxhV8bHFi84jWOiKAPmGK
        dniZtG38fiLiU/BAKJ0ItNNozAxcC7Q=
X-Google-Smtp-Source: AAOMgpeIMvkBBRP9H2lUDBHNI3ldDEXqksFL39zuL732WY2FGqjBeWBtJ1RQmmsWtFfrv5ZX8I/NlA==
X-Received: by 2002:a62:5ec3:: with SMTP id s186-v6mr620538pfb.129.1532062545425;
        Thu, 19 Jul 2018 21:55:45 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id r11-v6sm913760pgn.62.2018.07.19.21.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 21:55:44 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:25:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH] sched/fair: remove #ifdefs from scale_rt_capacity
Message-ID: <20180720045543.jx76p67sntophjne@vireshk-i7>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-18, 14:00, Vincent Guittot wrote:
> Reuse cpu_util_irq() that has been defined for schedutil and set irq util
> to 0 when !CONFIG_IRQ_TIME_ACCOUNTING
> 
> But the compiler is not able to optimize the sequence (at least with
> aarch64 GCC 7.2.1)
> 	free *= (max - irq);
> 	free /= max;
> when irq is fixed to 0
> 
> Add a new inline function scale_irq_capacity() that will scale utilization
> when irq is accounted. Reuse this funciton in schedutil which applies
> similar formula.
> 
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c |  3 +--
>  kernel/sched/fair.c              | 13 +++----------
>  kernel/sched/sched.h             | 20 ++++++++++++++++++--
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 97dcd44..3fffad3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -247,8 +247,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  	 *   U' = irq + ------- * U
>  	 *                max
>  	 */
> -	util *= (max - irq);
> -	util /= max;
> +	util = scale_irq_capacity(util, irq, max);
>  	util += irq;
>  
>  	/*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d5f7d52..14c3fdd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7551,16 +7551,12 @@ static unsigned long scale_rt_capacity(int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
>  	unsigned long used, free;
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
>  	unsigned long irq;
> -#endif
>  
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -	irq = READ_ONCE(rq->avg_irq.util_avg);
> +	irq = cpu_util_irq(rq);
>  
>  	if (unlikely(irq >= max))
>  		return 1;
> -#endif
>  
>  	used = READ_ONCE(rq->avg_rt.util_avg);
>  	used += READ_ONCE(rq->avg_dl.util_avg);
> @@ -7569,11 +7565,8 @@ static unsigned long scale_rt_capacity(int cpu)
>  		return 1;
>  
>  	free = max - used;
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -	free *= (max - irq);
> -	free /= max;
> -#endif
> -	return free;
> +
> +	return scale_irq_capacity(free, irq, max);
>  }
>  
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ebb4b3c..b80c3fd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2210,17 +2210,33 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>  	return READ_ONCE(rq->avg_rt.util_avg);
>  }
> +#endif
>  
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#if defined(SMP) \
> + && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))
>  static inline unsigned long cpu_util_irq(struct rq *rq)
>  {
>  	return rq->avg_irq.util_avg;
>  }
> +
> +static inline
> +unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
> +{
> +	util *= (max - irq);

() can be dropped here. 

Other than that: 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
