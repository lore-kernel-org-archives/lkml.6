Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67394217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeLSL6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:58:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeLSL6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:58:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFB25EBD;
        Wed, 19 Dec 2018 03:58:35 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B72C3F5C0;
        Wed, 19 Dec 2018 03:58:34 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
 <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com>
Date:   Wed, 19 Dec 2018 11:58:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 08:32, Vincent Guittot wrote:
[...]
> This is another UC, asym packing is used at SMT level for now and we
> don't face this kind of problem, it has been also tested and DynamiQ
> configuration which is similar to SMT : 1 CPU per sched_group
> The legacy b.L one was not the main target although it can be
> 
> The rounding error is there and should be fixed and your UC is another
> case for legacy b.L that can be treated in another patch
> 

I used that setup out of convenience for myself, but AFAICT that use-case
just stresses that issue.

In the end we still have an imbalance value that can vary with only
slight group_capacity changes. And that's true even if that group
contains a single CPU, as the imbalance value computed by
check_asym_packing() can vary by +/-1 with very tiny capacity changes 
(rt/IRQ pressure). That means that sometimes you're off by one and don't
do the packing because some CPU was pressured, but some other time you
might do it because that CPU was *more* pressured. It's doesn't make sense. 


In the end problem is that in update_sg_lb_stats() we do:

	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;

and in check_asym_packing() we do:

	env->imbalance = DIV_ROUND_CLOSEST(
		sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
		SCHED_CAPACITY_SCALE)

So we end up with something like:

		    group_load * SCHED_CAPACITY_SCALE * group_capacity
	imbalance = --------------------------------------------------
			    group_capacity * SCHED_CAPACITY_SCALE

Which you'd hope to reduce down to:

	imbalance = group_load

but you get division errors all over the place. So actually, the fix we'd
want would be:

-----8<-----
@@ -8463,9 +8463,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
        if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
                return 0;
 
-       env->imbalance = DIV_ROUND_CLOSEST(
-               sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
-               SCHED_CAPACITY_SCALE);
+       env->imbalance = sds->busiest_stat.group_load;
 
        return 1;
 }
----->8-----
