Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeDKKp3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:45:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeDKKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:45:28 -0400
Date: Wed, 11 Apr 2018 12:45:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/7] sched/fair: Add group_misfit_task load-balance type
Message-ID: <20180411104520.GG4043@hirez.programming.kicks-ass.net>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
 <1521125224-15434-3-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521125224-15434-3-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:46:59PM +0000, Morten Rasmussen wrote:

> +static inline unsigned long task_util(struct task_struct *p);
> +static inline int task_fits_capacity(struct task_struct *p, long capacity)
> +{
> +	return capacity * 1024 > task_util(p) * capacity_margin;
> +}
> +
> +static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> +{
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +		return;
> +
> +	if (!p) {
> +		rq->misfit_task_load = 0;
> +		return;
> +	}
> +
> +	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
> +		rq->misfit_task_load = 0;
> +		return;
> +	}
> +
> +	rq->misfit_task_load = task_h_load(p);
> +}

So RT/IRQ pressure can also cause misfit..


> @@ -7972,6 +8005,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		 */
>  		if (!nr_running && idle_cpu(i))
>  			sgs->idle_cpus++;
> +
> +		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +		    !sgs->group_misfit_task_load && rq->misfit_task_load)
> +			sgs->group_misfit_task_load = rq->misfit_task_load;
>  	}

Should we not look for the biggest misfit instead of the first?

>  
>  	/* Adjust by relative CPU capacity of the group */
