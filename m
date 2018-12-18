Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B49C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0966E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeLRRcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:32:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50464 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeLRRcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:32:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED4A3A78;
        Tue, 18 Dec 2018 09:32:08 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 084723F5C0;
        Tue, 18 Dec 2018 09:32:07 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
Date:   Tue, 18 Dec 2018 17:32:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2018 16:01, Vincent Guittot wrote:
> When check_asym_packing() is triggered, the imbalance is set to :
> busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
> busiest_stat.avg_load also comes from a division and the final rounding
> can make imbalance slightly lower than the weighted load of the cfs_rq.
> But this is enough to skip the rq in find_busiest_queue and prevents asym
> migration to happen.
> 
> Add 1 to the avg_load to make sure that the targeted cpu will not be
> skipped unexpectidly.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ca46964..c215f7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8215,6 +8215,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	/* Adjust by relative CPU capacity of the group */
>  	sgs->group_capacity = group->sgc->capacity;
>  	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> +	/*
> +	 * Prevent division rounding to make the computation of imbalance
> +	 * slightly less than original value and to prevent the rq to be then
> +	 * selected as busiest queue
> +	 */
> +	sgs->avg_load += 1;

I've tried investigating this off-by-one issue by running lmbench, but it
seems to be a gnarly one.



The adventure starts in update_sg_lb_stats() where we compute
sgs->avg_load:

	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity

Then we drop by find_busiest_group() and call check_asym_packing() which,
if we do need to pack, does:

	env->imbalance = DIV_ROUND_CLOSEST(
		sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
		SCHED_CAPACITY_SCALE);

And finally the one check that seems to be failing, and that you're
addressing with a +1 is in find_busiest_queue():

	if (rq->nr_running == 1 && wl > env->imbalance &&
	    !check_cpu_capacity(rq, env->sd))
		continue;



Now, running lmbench on my HiKey960 hacked up to use asym packing, I
get an example where there's a task that should be migrated via asym
packing but isn't:

# This a DIE level balance
update_sg_lb_stats(): 
	cpu=0 load=1
	cpu=1 load=1023
	cpu=2 load=0
	cpu=3 load=0

	avg_load=568

# Busiest group is [0-3]
find_busiest_group(): check_asym_packing():
	env->imbalance = 1022

find_busiest_queue():
	cpu=0 wl=1
	cpu=1 wl=1023
	cpu=2 wl=0
	cpu=3 wl=0

Only CPU1 has rq->nr_running > 0 (==1 actually), but wl > env->imbalance
so we skip it in find_busiest_queue().

Now, I thought it was due to IRQ/rt pressure - 1840 isn't the maximum
group capacity for the LITTLE cluster, it should be (463 * 4) == 1852.
I got curious and threw random group capacity values in that equation while
keeping the same avg_load [1], and it gets wild: you have a signal that
oscillates between 1024 and 1014!

[1]: https://gist.github.com/valschneider/f42252e83be943d276b901f57734b8ba

Adding +1 to avg_load doesn't solve those pesky rounding errors that get
worse as group_capacity grows, but it reverses the trend: the signal
oscillates above 1024.



So in the end a +1 *could* "fix" this, but
a) It'd make more sense to have it in the check_asym_packing() code
b) It's ugly and it makes me feel like this piece of code is flimsy AF.

>  
>  	if (sgs->sum_nr_running)
>  		sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
> 
