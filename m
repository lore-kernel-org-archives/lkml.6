Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0421920896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGpM8GHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934286AbeGFGAj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:00:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33897 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeGFGAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:00:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id e10-v6so7475510pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUisbJdyqZkgCYHI3hxYhe0jqzXFOo04U2Y73MFgdtY=;
        b=kGpM8GHdd+FDoz5cBgTwk1Fl4TSvL4N8ju/UixYd1eKXo5Logiz9kxVRl4SjByXoVu
         rK9FUJ5wr+quzQTsYrY9lvt9d59hi1IewdWuBUVaA4KXb1lCpELGSdqptxCzNmi6OTtd
         jEnGVx7ULAdBlqM2wvMhbkNvRo1QDQrYP8V/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUisbJdyqZkgCYHI3hxYhe0jqzXFOo04U2Y73MFgdtY=;
        b=unyip+wifNFmI3Poij3GefOEltbbQoQx/RsPf0jUyG63Gwc74uihnKGrsb6DsB9lGu
         mZNOQNccDm8J5noPLhL/vCSU8lBQKmonOnfSjWG+hRfhsIXbxdAnRTltYpSxAXANp4Cl
         +0mAegBdbWq7kzIYAbyKge9wVoLuss7jyF/kWhpaocmYR4uzCCWz0t51NacSFf4SW2KR
         VFmfc9FeJRADlOYNo2uDChUbtWTEzjvQmZ5je/o5ewXMHuLOZcUiG/0RBtTeGQT3FEe2
         78FIkrWhjyR5FgTFn2i6pd+n1pYaRCwXRiCgZ7Pbl4w3jX36ddVQ3i7MEd5gGPlAJe6C
         jfAg==
X-Gm-Message-State: APt69E2/bfOYJcIzkmezXoFoWc0T/8q3wkzgnoT8nxo6kA3lOLu7jHr+
        d2kvVBUqbkZdIP5gOJ+PdnbHhA==
X-Google-Smtp-Source: AAOMgpcuPrJeDvF3BMNa2CoFA5xHj4oiy9A1xnRZ913SwR4DVrl5602PXzzMAZLowx4/Srx4+bAizA==
X-Received: by 2002:a63:530b:: with SMTP id h11-v6mr2135335pgb.139.1530856835910;
        Thu, 05 Jul 2018 23:00:35 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id k15-v6sm12245385pfi.37.2018.07.05.23.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:00:35 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:30:33 +0530
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
Subject: Re: [PATCH 07/11] cpufreq/schedutil: take into account interrupt
Message-ID: <20180706060033.rcgzfs6pouqssiqh@vireshk-i7>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-18, 17:45, Vincent Guittot wrote:
> The time spent under interrupt can be significant but it is not reflected
> in the utilization of CPU when deciding to choose an OPP. Now that we have
> access to this metric, schedutil can take it into account when selecting
> the OPP for a CPU.
> rqs utilization don't see the time spend under interrupt context and report
> their value in the normal context time window. We need to compensate this when
> adding interrupt utilization
> 
> The CPU utilization is :
>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> 
> A test with iperf on hikey (octo arm64) gives:
> iperf -c server_address -r -t 5
> 
> w/o patch		w/ patch
> Tx 276 Mbits/sec        304 Mbits/sec +10%
> Rx 299 Mbits/sec        328 Mbits/sec +09%
> 
> 8 iterations
> stdev is lower than 1%
> Only WFI idle state is enable (shallowest diel state)
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++++++++----
>  kernel/sched/sched.h             | 13 +++++++++++++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index edfbfc1..b77bfef 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -58,6 +58,7 @@ struct sugov_cpu {
>  	unsigned long		util_dl;
>  	unsigned long		bw_dl;
>  	unsigned long		util_rt;
> +	unsigned long		util_irq;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -190,21 +191,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  	sg_cpu->util_dl  = cpu_util_dl(rq);
>  	sg_cpu->bw_dl    = cpu_bw_dl(rq);
>  	sg_cpu->util_rt  = cpu_util_rt(rq);
> +	sg_cpu->util_irq = cpu_util_irq(rq);
>  }
>  
>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> -	unsigned long util;
> +	unsigned long util, max = sg_cpu->max;
>  
>  	if (rq->rt.rt_nr_running)
>  		return sg_cpu->max;
>  
> +	if (unlikely(sg_cpu->util_irq >= max))
> +		return max;
> +
> +	/* Sum rq utilization */
>  	util = sg_cpu->util_cfs;
>  	util += sg_cpu->util_rt;
>  
> -	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> -		return sg_cpu->max;
> +	/*
> +	 * Interrupt time is not seen by rqs utilization nso we can compare

                                                         nso ?

> +	 * them with the CPU capacity
> +	 */
> +	if ((util + sg_cpu->util_dl) >= max)
> +		return max;
>  
>  	/*
>  	 * As there is still idle time on the CPU, we need to compute the
> @@ -220,10 +230,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
>  
> +	/* Weight rqs utilization to normal context window */
> +	util *= (max - sg_cpu->util_irq);
> +	util /= max;
> +
> +	/* Add interrupt utilization */
> +	util += sg_cpu->util_irq;
> +
>  	/* Add DL bandwidth requirement */
>  	util += sg_cpu->bw_dl;
>  
> -	return min(sg_cpu->max, util);
> +	return min(max, util);
>  }
>  
>  /**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 377be2b..9438e68 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2221,4 +2221,17 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>  	return rq->avg_rt.util_avg;
>  }
> +
> +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +static inline unsigned long cpu_util_irq(struct rq *rq)
> +{
> +	return rq->avg_irq.util_avg;
> +}
> +#else
> +static inline unsigned long cpu_util_irq(struct rq *rq)
> +{
> +	return 0;
> +}
> +
> +#endif
>  #endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
