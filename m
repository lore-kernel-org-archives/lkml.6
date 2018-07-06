Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC0C20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0p3VDNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC0C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeGFGGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:06:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35711 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbeGFGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:05:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so2367064plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i7l6eCqlUl815/8V+wlp6kY3FgqxWUflhBhIxG+N50U=;
        b=B0p3VDNkOKOsKKOMLwp8uOR/4vVt13Uu+FpR2aUAuh2YIWoHW9RkWq6Ix7B01ag2MJ
         yi3NQGNgq7ITuysgUFny/BFm0rEt7scYa00Jh8Os3oKHUafcggONZ01LXHbUkO3T5HXL
         RI4Tp/Gjcg3HV3VHnEis/aIEpI0SNDxDC8Noo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7l6eCqlUl815/8V+wlp6kY3FgqxWUflhBhIxG+N50U=;
        b=t8RJlEN/hgx6hog31azJK6ygFxmgT58ZZkSfYTjmtz7lK+boVdAXtM3E4LVWkxzylu
         uFrQoSIJQVppl3ZevvGoYpd0sqPkwYRWI6MnCv9Pih8NZDHwUPU0D+0Lno9wYXF7Naa8
         1dYsu0KyQbvZ0ovvIM6Y8LENn3Vd2LUjL4SE7ic8H7NG8TU5Xtamo0+zJeYKfLgrflIq
         GP2VfExKeLCkNo3bx47Z+NOXHtcSkMGReMCTnnU7baBdrAsF1HJywAOXBC43adr/brB0
         nT+/v8ZaKLf0DlDPJYuGqscy1Kv+wBncMePXUHIzdquGBB/o4jClzapzEbKSm3gQMyt0
         Gn0Q==
X-Gm-Message-State: APt69E3WBWCtI6GBf3NtjKdFIaqGF5v7pz5/Z4dHNh/xDCQgyD2fqYoI
        Sdv8laHfNc/GwK1nLyHjBHfW3A==
X-Google-Smtp-Source: AAOMgpcq6qlve4Pd8UxdAHUs3Pei4zSZve3kqNvHYXb6emKfflRYRLqS1dTFcERoa5lGV/sJ3H4GXw==
X-Received: by 2002:a17:902:6193:: with SMTP id u19-v6mr8954759plj.133.1530857125353;
        Thu, 05 Jul 2018 23:05:25 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id y81-v6sm19149606pfd.178.2018.07.05.23.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:05:24 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:35:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com
Subject: Re: [PATCH v7 00/11] track CPU utilization
Message-ID: <20180706060522.537imgcw4b62crph@vireshk-i7>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <20180705123617.GM2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705123617.GM2458@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 14:36, Peter Zijlstra wrote:
> Subject: sched/cpufreq: Clarify sugov_get_util()
> 
> Add a few comments (hopefully) clarifying some of the magic in
> sugov_get_util().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  cpufreq_schedutil.c |   69 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -177,6 +177,26 @@ static unsigned int get_next_freq(struct
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> +/*
> + * This function computes an effective utilization for the given CPU, to be
> + * used for frequency selection given the linear relation: f = u * f_max.
> + *
> + * The scheduler tracks the following metrics:
> + *
> + *   cpu_util_{cfs,rt,dl,irq}()
> + *   cpu_bw_dl()
> + *
> + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> + * synchronized windows and are thus directly comparable.
> + *
> + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> + * which excludes things like IRQ and steal-time. These latter are then accrued in
> + * the irq utilization.
> + *
> + * The DL bandwidth number otoh is not a measured meric but a value computed

                                                     metric

> + * based on the task model parameters and gives the minimal u required to meet

                                                               u ?

> + * deadlines.
> + */
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> @@ -188,26 +208,50 @@ static unsigned long sugov_get_util(stru
>  	if (rt_rq_is_runnable(&rq->rt))
>  		return max;
>  
> +	/*
> +	 * Early check to see if IRQ/steal time saturates the CPU, can be
> +	 * because of inaccuracies in how we track these -- see
> +	 * update_irq_load_avg().
> +	 */
>  	irq = cpu_util_irq(rq);
> -
>  	if (unlikely(irq >= max))
>  		return max;
>  
> -	/* Sum rq utilization */
> +	/*
> +	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
> +	 * CFS tasks and we use the same metric to track the effective
> +	 * utilization (PELT windows are synchronized) we can directly add them
> +	 * to obtain the CPU's actual utilization.
> +	 */
>  	util = cpu_util_cfs(rq);
>  	util += cpu_util_rt(rq);
>  
>  	/*
> -	 * Interrupt time is not seen by rqs utilization nso we can compare
> -	 * them with the CPU capacity
> +	 * We do not make cpu_util_dl() a permanent part of this sum because we
> +	 * want to use cpu_bw_dl() later on, but we need to check if the
> +	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
> +	 * f_max when there is no idle time.
> +	 *
> +	 * NOTE: numerical errors or stop class might cause us to not quite hit
> +	 * saturation when we should -- something for later.
>  	 */
>  	if ((util + cpu_util_dl(rq)) >= max)
>  		return max;
>  
>  	/*
> -	 * As there is still idle time on the CPU, we need to compute the
> -	 * utilization level of the CPU.
> +	 * There is still idle time; further improve the number by using the
> +	 * irq metric. Because IRQ/steal time is hidden from the task clock we
> +	 * need to scale the task numbers:
>  	 *
> +	 *              1 - irq
> +	 *   U' = irq + ------- * U
> +	 *                max
> +	 */
> +	util *= (max - irq);
> +	util /= max;
> +	util += irq;
> +
> +	/*
>  	 * Bandwidth required by DEADLINE must always be granted while, for
>  	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
>  	 * to gracefully reduce the frequency when no tasks show up for longer
> @@ -217,18 +261,7 @@ static unsigned long sugov_get_util(stru
>  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
> -
> -	/* Weight rqs utilization to normal context window */
> -	util *= (max - irq);
> -	util /= max;
> -
> -	/* Add interrupt utilization */
> -	util += irq;
> -
> -	/* Add DL bandwidth requirement */
> -	util += sg_cpu->bw_dl;
> -
> -	return min(max, util);
> +	return min(max, util + sg_cpu->bw_dl);
>  }
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
