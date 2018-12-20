Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB40C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BC221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbeLTLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:16:34 -0500
Received: from foss.arm.com ([217.140.101.70]:52428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTLQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:16:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C2BA78;
        Thu, 20 Dec 2018 03:16:33 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7288E3F5C0;
        Thu, 20 Dec 2018 03:16:32 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: fix rounding issue for asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ec8ccd83-0613-e37a-1a7b-ec680c4c4779@arm.com>
Date:   Thu, 20 Dec 2018 11:16:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 07:55, Vincent Guittot wrote:
> When check_asym_packing() is triggered, the imbalance is set to :
>   busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
> But busiest_stat.avg_load equals
>   sgs->group_load *SCHED_CAPACITY_SCALE / sgs->group_capacity
> These divisions can generate a rounding that will make imbalance slightly
> lower than the weighted load of the cfs_rq.
> But this is enough to skip the rq in find_busiest_queue and prevents asym
> migration to happen.
> 
> Directly set imbalance to sgs->group_load to remove the rounding.
                            ^^^^^^^^^^^^^^^
I see where that's coming from, but using 'sgs' here is tad confusing since
'sds->busiest_stat' is what's actually used.

Maybe just something like 'the busiest's sgs->group_load' would be good
enough to make things explicit.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ca46964..9b31247 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8476,9 +8476,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
>  	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
>  		return 0;
>  
> -	env->imbalance = DIV_ROUND_CLOSEST(
> -		sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
> -		SCHED_CAPACITY_SCALE);
> +	env->imbalance = sds->busiest_stat.avg_load;

That should be group_load, not avg_load. With that fixed:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>  
>  	return 1;
>  }
> 
