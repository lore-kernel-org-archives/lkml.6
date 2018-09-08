Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816DB20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816DB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIIBED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:04:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43234 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeIIBED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:04:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6994318A;
        Sat,  8 Sep 2018 13:17:06 -0700 (PDT)
Received: from [192.168.1.77] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17C223F5BC;
        Sat,  8 Sep 2018 13:17:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/fair: fix 1 task per CPU
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com
References: <1536334803-21059-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <60ace509-8a90-f8eb-3d22-a5be6e3d863a@arm.com>
Date:   Sat, 8 Sep 2018 13:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536334803-21059-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 07/09/18 08:40, Vincent Guittot wrote:
> When CPUs have different capacity because of RT/DL tasks or
> micro-architecture or max frequency differences, there are situation where
> the imbalance is not correctly set to migrate waiting task on the idle CPU.
> 

This is essentially always for down migrations (high capacity src CPU to lower
capacity dst CPU), right?

For instance, I've often seen that issue on HiKey960 (4x4 big.LITTLE) where
if you spawn 8 CPU-hogs you can end up with 5 on the bigs and 3 on the
LITTLES, but since avg_load scales with the inverse of group_capacity it's
seen as balanced. I don't recall seeing this problem for low capacity ->
big capacity migration, especially with the misfit logic that makes this a 
non-problem.

Also, a nit on the commit header: although we've called it "1 task per CPU"
in the past, it might be more explicit to call it "1 long running task per
CPU", if just for the sake of clarity for people not directly involved in
our previous discussions.

> The UC uses the force_balance case :
> 	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> 	    busiest->group_no_capacity)
> 		goto force_balance;
> 
> But calculate_imbalance fails to set the right amount of load to migrate
> a task because of the special condition:
>   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> 
> Add in fix_small_imbalance, this special case that triggered the force
> balance in order to make sure that the amount of load to migrate will be
> enough.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

So we happen to have come up with a (relatively) similar patch for Android
(see [1]) which also stemmed from the 1 always running task per CPU issue. It
only applies to SD_ASYM_CPUCAPACITY sched domains though, and targets
down-migrations (local->group_capacity < busiest->group_capacity).

I'd argue that we should make it so this kind of imbalance gets detected way
before we hit fix_small_imbalance(), but until we get there I think we do want
an extra condition like this.

>  kernel/sched/fair.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 309c93f..57b4d83 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
>  	local = &sds->local_stat;
>  	busiest = &sds->busiest_stat;
>  
> +	/*
> +	 * There is available capacity in local group and busiest group is
> +	 * overloaded but calculate_imbalance can't compute the amount of load
> +	 * to migrate because they became meaningless because asymetric

What do you mean by 'they'? 

Also, s/because/due to/ on the second "because".

> +	 * capacity between group. In such case, we only want to migrate at
> +	 * least one tasks of the busiest group and rely of the average load
> +	 * per task to ensure the migration.
> +	 */
> +	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> +	    busiest->group_no_capacity) {
> +		env->imbalance = busiest->load_per_task;
> +		return;
> +	}
> +

The condition is an exact copy of the one in that goto force_balance
path you mention (in find_busiest_group()), is that just a coincidence? If
not you might want to mention it in the comment.

>  	if (!local->sum_nr_running)
>  		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
>  	else if (busiest->load_per_task > local->load_per_task)
> 

[1]: https://android.googlesource.com/kernel/common/+/9fae72e924961f3b32816193fcb56d19c1f644c2%5E%21/#F0
