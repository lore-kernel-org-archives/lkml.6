Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F12C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C8120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C8120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeINIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:34:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56370 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeINIeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:34:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A1980D;
        Thu, 13 Sep 2018 20:22:10 -0700 (PDT)
Received: from [192.168.1.77] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABD93F5C0;
        Thu, 13 Sep 2018 20:22:09 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <acea081e-e9c0-10de-8a66-762a01f15b7b@arm.com>
Date:   Thu, 13 Sep 2018 20:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/09/18 07:43, Vincent Guittot wrote:
> When CPUs have different capacity because of RT/DL tasks or
> micro-architecture or max frequency differences, there are situation where
> the imbalance is not correctly set to migrate waiting task on the idle CPU.
> 
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

Other than the commit nit, LGTM. Out of curiosity I ran some kernel compile
on my HiKey960 (-j8) but didn't see much change - something along the lines 
of ~1% speedup, and although it was consistent over a few iterations, I'd
need a whole lot more of them to back this up. 

I kind of expected it because some sporadic task can show up and tip the
scale in the right direction, so even without the patch the situation can
"fix itself" eventually, and it becomes less noticeable on really long
workloads.

I do see a difference by looking at the trace of a simple 8 100% tasks rt-app
workload though, as I no longer see that idling LITTLE I sometimes get
without the patch, which is what we expect, so:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> ---

Again, I'd argue for a slightly more explicit header. As you pointed out in
v1, it's not just long running tasks, so maybe just "fix 1 *running* task per
CPU"? Otherwise I feel it's a tad obscure.

>  kernel/sched/fair.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 309c93f..72bc5e8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
>  	local = &sds->local_stat;
>  	busiest = &sds->busiest_stat;
>  
> +	/*
> +	 * There is available capacity in local group and busiest group is
> +	 * overloaded but calculate_imbalance can't compute the amount of load
> +	 * to migrate because load_avg became meaningless due to asymetric
> +	 * capacity between groups.

Could you add something along the lines of "(see similar condition in
find_busiest_group())"?

In such case, we only want to migrate at
> +	 * least one tasks of the busiest group and rely of the average load
> +	 * per task to ensure the migration.
> +	 */
> +	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> +	    busiest->group_no_capacity) {
> +		env->imbalance = busiest->load_per_task;
> +		return;
> +	}
> +
>  	if (!local->sum_nr_running)
>  		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
>  	else if (busiest->load_per_task > local->load_per_task)
> 
