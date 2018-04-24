Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756614AbeDXKaF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:30:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41487 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756533AbeDXKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:30:04 -0400
X-Google-Smtp-Source: AIpwx48VDipwKUs3nUZlEQmxxCRjODZ4vy5UMEQQ8+zt4z5JatxYnThLQTpKqbZscJhXXXAmqT7LDA==
Date: Tue, 24 Apr 2018 16:00:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180424103000.74sbxgztf7h7xppb@vireshk-i7>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-18, 11:02, Valentin Schneider wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cacee15..ad09b67 100644
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
> @@ -6636,8 +6636,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		 */
>  		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
>  		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
> +			if (cpu != prev_cpu)
> +				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
> +
>  			sd = NULL; /* Prefer wake_affine over balance flags */
> -			affine_sd = tmp;
>  			break;
>  		}
>  
> @@ -6657,16 +6659,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  			sync_entity_load_avg(&p->se);
>  
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> -	} else {
> -		if (affine_sd && cpu != prev_cpu)
> -			new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
> +	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> +		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>  
> -		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> -			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> -
> -			if (want_affine)
> -				current->recent_used_cpu = cpu;
> -		}
> +		if (want_affine)
> +			current->recent_used_cpu = cpu;
>  	}
>  	rcu_read_unlock();

LGTM.

I will merge it as part of the current patch, but maybe wait for a few
days before sending V2.

-- 
viresh
