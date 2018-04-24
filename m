Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbeDXKCa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:02:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756681AbeDXKC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:02:28 -0400
From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
To: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
Message-ID: <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
Date: Tue, 24 Apr 2018 11:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/04/18 11:38, Viresh Kumar wrote:
> Rearrange select_task_rq_fair() a bit to avoid executing some
> conditional statements in few specific code-paths. That gets rid of the
> goto as well.
> 

I'd argue making things easier to read is a non-negligible part as well.

> This shouldn't result in any functional changes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/fair.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 54dc31e7ab9b..cacee15076a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6636,6 +6636,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		 */
>  		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
>  		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
> +			sd = NULL; /* Prefer wake_affine over balance flags */
>  			affine_sd = tmp;
>  			break;
>  		}
> @@ -6646,33 +6647,26 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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
> -
> -	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
> +	if (sd) {
>  		/*
>  		 * We're going to need the task's util for capacity_spare_wake
>  		 * in find_idlest_group. Sync it up to prev_cpu's
>  		 * last_update_time.
>  		 */
> -		sync_entity_load_avg(&p->se);
> -	}
> +		if (!(sd_flag & SD_BALANCE_FORK))
> +			sync_entity_load_avg(&p->se);
> +
> +		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> +	} else {
> +		if (affine_sd && cpu != prev_cpu)
> +			new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
>  
> -	if (!sd) {
> -pick_cpu:
>  		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>  			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>  
>  			if (want_affine)
>  				current->recent_used_cpu = cpu;
>  		}
> -	} else {
> -		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	}
>  	rcu_read_unlock();
>  
> 

I stared at it for a bit and don't see anything wrong. I was just thinking
that the original flow made it a bit clearer to follow the 'wake_affine' path.

What about this ? It re-bumps up the number of conditionals and adds an indent
level in the domain loop (that could be prevented by hiding the 
cpu != prev_cpu check in wake_affine()), which isn't great, but you get to
squash some more if's.

---------------------->8-------------------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cacee15..ad09b67 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6613,7 +6613,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
 {
-	struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
+	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
@@ -6636,8 +6636,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		 */
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
+			if (cpu != prev_cpu)
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+
 			sd = NULL; /* Prefer wake_affine over balance flags */
-			affine_sd = tmp;
 			break;
 		}
 
@@ -6657,16 +6659,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			sync_entity_load_avg(&p->se);
 
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else {
-		if (affine_sd && cpu != prev_cpu)
-			new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
+	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
-		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
-			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-			if (want_affine)
-				current->recent_used_cpu = cpu;
-		}
+		if (want_affine)
+			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
