Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeEUJxE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:53:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41518 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeEUJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:52:59 -0400
X-Google-Smtp-Source: AB8JxZro0X/0XTlUPw3ic7a4JDFVTllPqiY6xE/a1NY1l2RlLSm5Krvk1UHi2Hn/G8dJwtOVNAuVYA==
Date: Mon, 21 May 2018 15:22:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 2/2] cpufreq: schedutil: Cleanup and document iowait
 boost
Message-ID: <20180521095255.h62pdcf34bh344wu@vireshk-i7>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
 <20180521085120.7902-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521085120.7902-3-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18, 09:51, Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> +static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> +			       unsigned int flags)
> +{
> +	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> +
> +	/* Reset boost if the CPU appears to have been idle enough */
> +	if (sg_cpu->iowait_boost &&
> +	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
> +		return;
> +
> +	/* Boost only tasks waking up after IO */
> +	if (!set_iowait_boost)
> +		return;
> +
> +	/* Ensure boost doubles only one time at each request */
> +	if (sg_cpu->iowait_boost_pending)
> +		return;
> +	sg_cpu->iowait_boost_pending = true;
> +
> +	/* Double the boost at each request */
> +	if (sg_cpu->iowait_boost) {
> +		sg_cpu->iowait_boost <<= 1;
> +		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> +			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +		return;

Maybe add "else" part of the if block and drop the "return" statement
here ?

>  	}
> +
> +	/* First wakeup after IO: start with minimum boost */
> +	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
>  }


> +static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +			       unsigned long *util, unsigned long *max)
>  {
>  	unsigned int boost_util, boost_max;
>  
> +	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
>  		return;
>  
> +	/* Reset boost if the CPU appears to have been idle enough */
> +	if (sugov_iowait_reset(sg_cpu, time, false))
> +		return;
> +
> +	/*
> +	 * An IO waiting task has just woken up:
> +	 * allow to further double the boost value
> +	 */
>  	if (sg_cpu->iowait_boost_pending) {
>  		sg_cpu->iowait_boost_pending = false;
>  	} else {
> +		/*
> +		 * Otherwise: reduce the boost value and disable it when we
> +		 * reach the minimum.
> +		 */
>  		sg_cpu->iowait_boost >>= 1;
>  		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
>  			sg_cpu->iowait_boost = 0;
> @@ -247,9 +322,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
>  		}
>  	}
>  
> +	/*
> +	 * Apply the current boost value: a CPU is boosted only if its current
> +	 * utilization is smaller then the current IO boost level.
> +	 */
>  	boost_util = sg_cpu->iowait_boost;
>  	boost_max = sg_cpu->iowait_boost_max;
> -

Maybe keep this blank line as is ?

>  	if (*util * boost_max < *max * boost_util) {
>  		*util = boost_util;
>  		*max = boost_max;

Otherwise looks good.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
