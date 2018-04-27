Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757776AbeD0Iar (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:30:47 -0400
Received: from foss.arm.com ([217.140.101.70]:35722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757755AbeD0Iap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:30:45 -0400
Subject: Re: [PATCH 2/2] sched/fair: Avoid calling sync_entity_load_avg()
 unnecessarily
To: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
 <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c1dba90d-d464-9286-94e3-e399f0b71281@arm.com>
Date: Fri, 27 Apr 2018 10:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 04/26/2018 12:30 PM, Viresh Kumar wrote:
> Call sync_entity_load_avg() directly from find_idlest_cpu() instead of
> select_task_rq_fair(), as that's where we need to use task's utilization
> value. And call sync_entity_load_avg() only after making sure sched
> domain spans over one of the allowed CPUs for the task.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The patch looks correct to me but we want to have the waking task synced 
against its previous rq also for EAS, i.e. for 
find_energy_efficient_cpu() which will sit next to find_idlest_cpu().

https://marc.info/?l=linux-kernel&m=152302907327168&w=2

The comment on top of the if condition would have to be changed though.

I would suggest we leave the call to sync_entity_load_avg() in the slow 
path of strf() so that we're not forced to call it in 
find_energy_efficient_cpu().

> ---
>   kernel/sched/fair.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84fc74ddbd4b..5b1b4f91f132 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6199,6 +6199,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>   	if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
>   		return prev_cpu;
>   
> +	/*
> +	 * We need task's util for capacity_spare_wake, sync it up to prev_cpu's
> +	 * last_update_time.
> +	 */
> +	if (!(sd_flag & SD_BALANCE_FORK))
> +		sync_entity_load_avg(&p->se);
> +
>   	while (sd) {
>   		struct sched_group *group;
>   		struct sched_domain *tmp;
> @@ -6651,15 +6658,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>   
>   	if (unlikely(sd)) {
>   		/* Slow path */
> -
> -		/*
> -		 * We're going to need the task's util for capacity_spare_wake
> -		 * in find_idlest_group. Sync it up to prev_cpu's
> -		 * last_update_time.
> -		 */
> -		if (!(sd_flag & SD_BALANCE_FORK))
> -			sync_entity_load_avg(&p->se);
> -
>   		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>   	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>   		/* Fast path */
> 
