Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeE3QqJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:46:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753816AbeE3QqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:46:05 -0400
Date: Wed, 30 May 2018 17:46:01 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Friday 25 May 2018 at 15:12:24 (+0200), Vincent Guittot wrote:
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

So I understand why we want to got to max freq when a RT task is running,
but I think there are use cases where we might want to be more conservative
and use the util_avg of the RT rq instead. The first use case is
battery-powered devices where going to max isn't really affordable from
an energy standpoint. Android, for example, has been using a RT
utilization signal to select OPPs for quite a while now, because going
to max blindly is _very_ expensive.

And the second use-case is thermal pressure. On some modern CPUs, going to
max freq can lead to stringent thermal capping very quickly, at the
point where your CPUs might not have enough capacity to serve your tasks
properly. And that can ultimately hurt the very RT tasks you originally
tried to run fast. In these systems, in the long term, you'd be better off
not asking for more than what you really need ...

So what about having a sched_feature to select between going to max and
using the RT util_avg ? Obviously the default should keep the current
behaviour.

Thanks,
Quentin
