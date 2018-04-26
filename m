Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756304AbeDZOfV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:35:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754727AbeDZOfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:35:19 -0400
Subject: Re: [PATCH V2 1/2] sched/fair: Rearrange select_task_rq_fair() to
 optimize it
To: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f2904cf7-c41f-e064-d374-9a5bee0ca967@arm.com>
Date: Thu, 26 Apr 2018 15:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LGTM. Tiny inline comment but TBH might not be worth it.

FWIW: Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

On 26/04/18 11:30, Viresh Kumar wrote:
> Rearrange select_task_rq_fair() a bit to avoid executing some
> conditional statements in few specific code-paths. That gets rid of the
> goto as well.
> 
> This shouldn't result in any functional changes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Rohit Jain <rohit.k.jain@oracle.com>
> 
> ---
> V1->V2:
> - Optimize a bit more and get rid of affine_sd variable (Valentin)
> - Add unlikely while checking for non-NULL sd and add fast/slow path
>   comments (Joel)
> - Add tested-by from Rohit.
> 
>  kernel/sched/fair.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 54dc31e7ab9b..84fc74ddbd4b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6613,7 +6613,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
> -	struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
> +	struct sched_domain *tmp, *sd = NULL;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
>  	int want_affine = 0;
> @@ -6636,7 +6636,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		 */
>  		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
>  		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
> -			affine_sd = tmp;
> +			if (cpu != prev_cpu)
> +				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);

This cpu != prev_cpu check could be folded into wake_affine() to make this
look a little neater, but we might want to keep things as is to avoid a
function call (it's only ever called once so it might get inlined, but AFAIK
that's not guaranteed).

> +
> +			sd = NULL; /* Prefer wake_affine over balance flags */
>  			break;
>  		}
>  
> @@ -6646,33 +6649,25 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  			break;
>  	}
>  
> -	if (affine_sd) {
> -		sd = NULL; /* Prefer wake_affine over balance flags */
> -		if (cpu == prev_cpu)
> -			goto pick_cpu;
> -
> -		new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
> -	}
> +	if (unlikely(sd)) {
> +		/* Slow path */
>  
> -	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
>  		/*
>  		 * We're going to need the task's util for capacity_spare_wake
>  		 * in find_idlest_group. Sync it up to prev_cpu's
>  		 * last_update_time.
>  		 */
> -		sync_entity_load_avg(&p->se);
> -	}
> -
> -	if (!sd) {
> -pick_cpu:
> -		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> -			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +		if (!(sd_flag & SD_BALANCE_FORK))
> +			sync_entity_load_avg(&p->se);
>  
> -			if (want_affine)
> -				current->recent_used_cpu = cpu;
> -		}
> -	} else {
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> +	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> +		/* Fast path */
> +
> +		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +
> +		if (want_affine)
> +			current->recent_used_cpu = cpu;
>  	}
>  	rcu_read_unlock();
>  
> 
