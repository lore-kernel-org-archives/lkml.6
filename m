Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2BEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AD220856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AD220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeICIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:55:13 -0400
Received: from foss.arm.com ([217.140.101.70]:50018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:55:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1567B18A;
        Sun,  2 Sep 2018 21:36:50 -0700 (PDT)
Received: from [192.168.1.76] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAECD3F575;
        Sun,  2 Sep 2018 21:36:49 -0700 (PDT)
Subject: Re: [PATCH v3] sched/pelt: fix update_blocked_averages() for dl and
 rt
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <1535728975-22799-1-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8c0824b8-e877-c678-a15b-2a97594c2d6c@arm.com>
Date:   Sun, 2 Sep 2018 21:36:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535728975-22799-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 08:22 AM, Vincent Guittot wrote:
> update_blocked_averages() is called to periodiccally decay the stalled load
> of idle CPUs and to sync all loads before running load balance.
> 
> When cfs rq is idle, it trigs a load balance during pick_next_task_fair()
> in order to potentially pull tasks and to use this newly idle CPU. This
> load balance happens whereas prev task from another class has not been put
> and its utilization updated yet. This may lead to wrongly account running
> time as idle time for rt or dl classes.
> 
> Test that no rt or dl task is running when updating their utilization in
> update_blocked_averages().

Shouldn't this be 's/that no/if an' ?

You still update the utilization of the rt or dl task if they are 
running (accrue + decay) instead of only decay. Similar to the 
'cfs_rq->curr != NULL' in __update_load_avg_cfs_rq().

> We still update rt and dl utilization instead of simply skipping them to
> make sure that all metrics are synced when used during load balance.

I assume this sentence is indirectly saying this.

> 
> Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
> Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> -V3
>    - move rq->curr dereference under the rq->lock
> 
> -V2
>    - Add missing fixes tags
>    - apply fix to other version of update_blocked_averages
> 
>   kernel/sched/fair.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 309c93f..53bbcd4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
>   	struct cfs_rq *cfs_rq, *pos;
> +	const struct sched_class *curr_class;
>   	struct rq_flags rf;
>   	bool done = true;
>   
> @@ -7298,8 +7299,10 @@ static void update_blocked_averages(int cpu)
>   		if (cfs_rq_has_blocked(cfs_rq))
>   			done = false;
>   	}
> -	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> -	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> +
> +	curr_class = rq->curr->sched_class;
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
> +	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
>   	update_irq_load_avg(rq, 0);
>   	/* Don't need periodic decay once load/util_avg are null */
>   	if (others_have_blocked(rq))
> @@ -7364,13 +7367,16 @@ static inline void update_blocked_averages(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
>   	struct cfs_rq *cfs_rq = &rq->cfs;
> +	const struct sched_class *curr_class;
>   	struct rq_flags rf;
>   
>   	rq_lock_irqsave(rq, &rf);
>   	update_rq_clock(rq);
>   	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
> -	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> -	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> +
> +	curr_class = rq->curr->sched_class;
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
> +	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
>   	update_irq_load_avg(rq, 0);
>   #ifdef CONFIG_NO_HZ_COMMON
>   	rq->last_blocked_load_update_tick = jiffies;
> 

