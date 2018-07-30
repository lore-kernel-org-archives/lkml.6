Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NTRLfOmP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IH4k0fMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860D520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeG3VMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:12:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbeG3VMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:12:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D19A60AD8; Mon, 30 Jul 2018 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532979330;
        bh=mJs5q2Fj4RHo3x6kswTiv0uLxtZOBmhO6bZW2VGyhhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NTRLfOmPxSko1tkhkPuP5QTdNFBjbT9n+jUOOaH7O68w+pGB8scbErZssW4EWfFhx
         Dl5XiC7gNg9K55iQxt5UyeNbcRYLF0Qu8Dj4ifpluxzHNqKvoEiRSE3HbAoPW1SqtS
         /TLejg3xTFGftNyCBv1oPT+vGyh8A+dGpy5nVY18=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CB85D60264;
        Mon, 30 Jul 2018 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532979327;
        bh=mJs5q2Fj4RHo3x6kswTiv0uLxtZOBmhO6bZW2VGyhhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IH4k0fMC0Dmm3KvSaI+0CehpwvTpTXQ+/1vPByEQIf8wtt1ghEZnxYXK7XXb83/0e
         8HanArZeHDGVEFTREUprlvZmzOJ4n90L98fQqa5ojtujAB6Du7PvHqujNxQ1JZ39Z+
         2QHs6vZv/inydS8V6fWd5tYJCWE7SgehRzl3Vxuo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 12:35:27 -0700
From:   skannan@codeaurora.org
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
In-Reply-To: <20180724122521.22109-11-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
Message-ID: <331552975e858911db66bc78c2c8e720@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 05:25, Quentin Perret wrote:
> Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
> to decide which frequency to request. Energy Aware Scheduling (EAS)
> needs to be able to predict those requests to assess the energy impact
> of scheduling decisions. However, the PELT signals aggregation is only
> done in schedutil for now, hence making it hard to synchronize it with
> EAS.
> 
> To address this issue, introduce schedutil_freq_util() to perform the
> aforementioned aggregation and make it available to other parts of the
> scheduler. Since frequency selection and energy estimation still need
> to deal with RT and DL signals slightly differently, 
> schedutil_freq_util()
> is called with a different 'type' parameter in those two contexts, and
> returns an aggregated utilization signal accordingly.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 86 +++++++++++++++++++++-----------
>  kernel/sched/sched.h             | 14 ++++++
>  2 files changed, 72 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c 
> b/kernel/sched/cpufreq_schedutil.c
> index 810193c8e4cd..af86050edcf5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -198,15 +198,15 @@ static unsigned int get_next_freq(struct
> sugov_policy *sg_policy,
>   * based on the task model parameters and gives the minimal 
> utilization
>   * required to meet deadlines.
>   */
> -static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> +unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> +				  enum schedutil_type type)
>  {
> -	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	struct rq *rq = cpu_rq(cpu);
>  	unsigned long util, irq, max;
> 
> -	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> -	sg_cpu->bw_dl = cpu_bw_dl(rq);
> +	max = arch_scale_cpu_capacity(NULL, cpu);
> 
> -	if (rt_rq_is_runnable(&rq->rt))
> +	if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
>  		return max;
> 
>  	/*
> @@ -224,20 +224,33 @@ static unsigned long sugov_get_util(struct
> sugov_cpu *sg_cpu)
>  	 * utilization (PELT windows are synchronized) we can directly add 
> them
>  	 * to obtain the CPU's actual utilization.
>  	 */
> -	util = cpu_util_cfs(rq);
> +	util = util_cfs;
>  	util += cpu_util_rt(rq);
> 
> -	/*
> -	 * We do not make cpu_util_dl() a permanent part of this sum because 
> we
> -	 * want to use cpu_bw_dl() later on, but we need to check if the
> -	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
> -	 * f_max when there is no idle time.
> -	 *
> -	 * NOTE: numerical errors or stop class might cause us to not quite 
> hit
> -	 * saturation when we should -- something for later.
> -	 */
> -	if ((util + cpu_util_dl(rq)) >= max)
> -		return max;
> +	if (type == frequency_util) {
> +		/*
> +		 * For frequency selection we do not make cpu_util_dl() a
> +		 * permanent part of this sum because we want to use
> +		 * cpu_bw_dl() later on, but we need to check if the
> +		 * CFS+RT+DL sum is saturated (ie. no idle time) such
> +		 * that we select f_max when there is no idle time.
> +		 *
> +		 * NOTE: numerical errors or stop class might cause us
> +		 * to not quite hit saturation when we should --
> +		 * something for later.
> +		 */
> +
> +		if ((util + cpu_util_dl(rq)) >= max)
> +			return max;
> +	} else {
> +		/*
> +		 * OTOH, for energy computation we need the estimated
> +		 * running time, so include util_dl and ignore dl_bw.
> +		 */
> +		util += cpu_util_dl(rq);
> +		if (util >= max)
> +			return max;
> +	}

If it's going to be a different aggregation from what's done for 
frequency guidance, I don't see the point of having this inside 
schedutil. Why not keep it inside the scheduler files? Also, it seems 
weird to use a governor's code when it might not actually be in use. 
What if someone is using ondemand, conservative, performance, etc?

> 
>  	/*
>  	 * There is still idle time; further improve the number by using the
> @@ -252,17 +265,34 @@ static unsigned long sugov_get_util(struct
> sugov_cpu *sg_cpu)
>  	util /= max;
>  	util += irq;
> 
> -	/*
> -	 * Bandwidth required by DEADLINE must always be granted while, for
> -	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a 
> mechanism
> -	 * to gracefully reduce the frequency when no tasks show up for 
> longer
> -	 * periods of time.
> -	 *
> -	 * Ideally we would like to set bw_dl as min/guaranteed freq and util 
> +
> -	 * bw_dl as requested freq. However, cpufreq is not yet ready for 
> such
> -	 * an interface. So, we only do the latter for now.
> -	 */
> -	return min(max, util + sg_cpu->bw_dl);
> +	if (type == frequency_util) {
> +		/*
> +		 * Bandwidth required by DEADLINE must always be granted
> +		 * while, for FAIR and RT, we use blocked utilization of
> +		 * IDLE CPUs as a mechanism to gracefully reduce the
> +		 * frequency when no tasks show up for longer periods of
> +		 * time.
> +		 *
> +		 * Ideally we would like to set bw_dl as min/guaranteed
> +		 * freq and util + bw_dl as requested freq. However,
> +		 * cpufreq is not yet ready for such an interface. So,
> +		 * we only do the latter for now.
> +		 */
> +		util += cpu_bw_dl(rq);
> +	}

Instead of all this indentation, can't you just return early without 
doing the code inside the if?

> +
> +	return min(max, util);
> +}
> +
> +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> +{
> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util = cpu_util_cfs(rq);
> +
> +	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> +	sg_cpu->bw_dl = cpu_bw_dl(rq);
> +
> +	return schedutil_freq_util(sg_cpu->cpu, util, frequency_util);
>  }
> 
>  /**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6d08ccd1e7a4..51e7f113ee23 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2185,7 +2185,15 @@ static inline void cpufreq_update_util(struct
> rq *rq, unsigned int flags) {}
>  # define arch_scale_freq_invariant()	false
>  #endif
> 
> +enum schedutil_type {
> +	frequency_util,
> +	energy_util,
> +};

Please don't use lower case for enums. It's extremely confusing.

Thanks,
Saravana
