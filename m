Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968887AbeE3JkH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:40:07 -0400
Received: from foss.arm.com ([217.140.101.70]:53092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965196AbeE3JkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:40:06 -0400
Date: Wed, 30 May 2018 10:40:01 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180530094001.GH30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May 15:12, Vincent Guittot wrote:
> Add both cfs and rt utilization when selecting an OPP for cfs tasks as rt
> can preempt and steal cfs's running time.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 28592b6..a84b5a5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -56,6 +56,7 @@ struct sugov_cpu {
>  	/* The fields below are only needed when sharing a policy: */
>  	unsigned long		util_cfs;
>  	unsigned long		util_dl;
> +	unsigned long		util_rt;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -178,14 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
>  	sg_cpu->util_cfs = cpu_util_cfs(rq);
>  	sg_cpu->util_dl  = cpu_util_dl(rq);
> +	sg_cpu->util_rt  = cpu_util_rt(rq);
>  }
>  
>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util;
>  
> -	if (rq->rt.rt_nr_running)
> -		return sg_cpu->max;
> +	if (rq->rt.rt_nr_running) {
> +		util = sg_cpu->max;

Why not just adding the following lines while keeping the return in
for the rq->rt.rt_nr_running case?

> +	} else {
> +		util = sg_cpu->util_dl;
> +		util += sg_cpu->util_cfs;
> +		util += sg_cpu->util_rt;
> +	}
>  
>  	/*
>  	 * Utilization required by DEADLINE must always be granted while, for
> @@ -197,7 +205,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
> -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> +	return min(sg_cpu->max, util);

... for the rq->rt.rt_nr_running case we don't really need to min
clamp util = sg_cpu->max with itself...

>  }
>  
>  static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> -- 
> 2.7.4
> 

-- 
#include <best/regards.h>

Patrick Bellasi
