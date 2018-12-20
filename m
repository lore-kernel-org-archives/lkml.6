Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62C218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbeLTLWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:22:49 -0500
Received: from foss.arm.com ([217.140.101.70]:52596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:22:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B1DA78;
        Thu, 20 Dec 2018 03:22:47 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E97553F5C0;
        Thu, 20 Dec 2018 03:22:46 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c482361e-cfb4-d172-32c3-4d82ceb1e7d2@arm.com>
Date:   Thu, 20 Dec 2018 11:22:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 07:55, Vincent Guittot wrote:
> In case of active balance, we increase the balance interval to cover
> pinned tasks cases not covered by all_pinned logic. Neverthless, the
> active migration triggered by asym packing should be treated as the normal
> unbalanced case and reset the interval to default value otherwise active
> migration for asym_packing can be easily delayed for hundreds of ms
> because of this pinned task detection mecanism.
> The same happen to other conditions tested in need_active_balance() like
> mistfit task and when the capacity of src_cpu is reduced compared to
> dst_cpu (see comments in need_active_balance() for details).
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 487c73e..9b1e701 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8849,21 +8849,25 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>   */
>  #define MAX_PINNED_INTERVAL	512
>  
> -static int need_active_balance(struct lb_env *env)
> +static inline bool
> +asym_active_balance(struct lb_env *env)
>  {
> -	struct sched_domain *sd = env->sd;
> +	/*
> +	 * ASYM_PACKING needs to force migrate tasks from busy but
> +	 * lower priority CPUs in order to pack all tasks in the
> +	 * highest priority CPUs.
> +	 */
> +	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> +	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +}
>  
> -	if (env->idle != CPU_NOT_IDLE) {
> +static inline bool
> +voluntary_active_balance(struct lb_env *env)
> +{
> +	struct sched_domain *sd = env->sd;
>  
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
> @@ -8881,6 +8885,16 @@ static int need_active_balance(struct lb_env *env)
>  	if (env->src_grp_type == group_misfit_task)
>  		return 1;
>  
> +	return 0;
> +}
> +

Yeah so that's the active balance classification I was afraid of, and I
don't agree with it.

The way I see things, we happen to have some mechanisms that let us know
straight away if we need an active balance (asym packing, misfit, lowered
capacity), and we rely on the sd->nr_balance_failed threshold for the
scenarios where we don't have any more information.

We do happen to have a threshold because we don't want to go overboard with
it, but when it is reached it's a clear sign that we *do* want to active
balance because that's all we can do to try and solve the imbalance.

To me, those are all legitimate reasons to. So they're all "voluntary"
really, we *do* want all of these.

> +static int need_active_balance(struct lb_env *env)
> +{
> +	struct sched_domain *sd = env->sd;
> +
> +	if (voluntary_active_balance(env))
> +		return 1;
> +
>  	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
>  }
>  
> @@ -9142,7 +9156,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	} else
>  		sd->nr_balance_failed = 0;
>  
> -	if (likely(!active_balance)) {
> +	if (likely(!active_balance) || voluntary_active_balance(&env)) {

So now  we reset the interval for all active balances (expect last active
balance case), even when it is done as a last resort because all other
tasks were pinned.

Arguably the current code isn't much better (always increase the interval
when active balancing), but at least it covers this case. It would be a
waste not to take this into account when we can detect this scenario
(I'll reiterate my LBF_ALL_PINNED suggestion).

>  		/* We were unbalanced, so reset the balancing interval */
>  		sd->balance_interval = sd->min_interval;
>  	} else {
> 
