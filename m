Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbeLQQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:56:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLQQ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:56:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10EBA78;
        Mon, 17 Dec 2018 08:56:20 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C091A3F575;
        Mon, 17 Dec 2018 08:56:19 -0800 (PST)
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
Date:   Mon, 17 Dec 2018 16:56:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

About time I had a look at this one...

On 14/12/2018 16:01, Vincent Guittot wrote:
> In case of active balance, we increase the balance interval to cover
> pinned tasks cases not covered by all_pinned logic.

AFAIUI the balance increase is there to have plenty of time to
stop the task before going through another load_balance().

Seeing as there is a cpus_allowed check that leads to

    env.flags |= LBF_ALL_PINNED;
    goto out_one_pinned;

in the active balancing part of load_balance(), the condition you're
changing should never be hit when we have pinned tasks. So you may want
to rephrase that bit.

> Neverthless, the active
> migration triggered by asym packing should be treated as the normal
> unbalanced case and reset the interval to default value otherwise active
> migration for asym_packing can be easily delayed for hundreds of ms
> because of this all_pinned detection mecanism.

Mmm so it's not exactly clear why we need this change. If we double the
interval because of a pinned task we wanted to active balance, well it's
just regular pinned task issues and we can't do much about it.

The only scenario I can think of is if you had a workload where you wanted
to do an active balance in several successive load_balance(), in which case
you would keep increasing the interval even though you do migrate a task
every time (which would harm every subsequent active_balance).

In that case every active_balance "user" (pressured CPU, misfit) is
affected, so maybe what we want is something like this:

-----8<-----
@@ -9136,13 +9149,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
                sd->balance_interval = sd->min_interval;
        } else {
                /*
-                * If we've begun active balancing, start to back off. This
-                * case may not be covered by the all_pinned logic if there
-                * is only 1 task on the busy runqueue (because we don't call
-                * detach_tasks).
+                * If we've begun active balancing, start to back off.
+                * Don't increase too much in case we have more active balances
+                * coming up.
                 */
-               if (sd->balance_interval < sd->max_interval)
-                       sd->balance_interval *= 2;
+               sd->balance_interval = 2 * sd->min_interval;
        }
 
        goto out;
----->8-----

Maybe we want a larger threshold - truth be told, it all depends on how
long the cpu stopper can take and if that delay increase is still relevant
nowadays.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9591e7a..487287e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8857,21 +8857,24 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>   */
>  #define MAX_PINNED_INTERVAL	512
>  
> +static inline bool
> +asym_active_balance(struct lb_env *env)
> +{
> +	/*
> +	 * ASYM_PACKING needs to force migrate tasks from busy but
> +	 * lower priority CPUs in order to pack all tasks in the
> +	 * highest priority CPUs.
> +	 */
> +	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> +	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +}
> +
>  static int need_active_balance(struct lb_env *env)
>  {
>  	struct sched_domain *sd = env->sd;
>  
> -	if (env->idle != CPU_NOT_IDLE) {
> -
> -		/*
> -		 * ASYM_PACKING needs to force migrate tasks from busy but
> -		 * lower priority CPUs in order to pack all tasks in the
> -		 * highest priority CPUs.
> -		 */
> -		if ((sd->flags & SD_ASYM_PACKING) &&
> -		    sched_asym_prefer(env->dst_cpu, env->src_cpu))
> -			return 1;
> -	}
> +	if (asym_active_balance(env))
> +		return 1;
>  
>  	/*
>  	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> @@ -9150,7 +9153,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	} else
>  		sd->nr_balance_failed = 0;
>  
> -	if (likely(!active_balance)) {
> +	if (likely(!active_balance) || asym_active_balance(&env)) {

AFAICT this makes us reset the interval whenever we do an asym packing
active balance (if the task is pinned we would goto out_one_pinned).
This goes against the logic I had understood so far and that I explained
higher up.

>  		/* We were unbalanced, so reset the balancing interval */
>  		sd->balance_interval = sd->min_interval;
>  	} else {
> 
