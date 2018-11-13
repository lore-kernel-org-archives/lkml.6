Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD22245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBD22245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeKMMtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:49:04 -0500
Received: from foss.arm.com ([217.140.101.70]:46318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeKMMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:49:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C98D5A78;
        Mon, 12 Nov 2018 18:53:02 -0800 (PST)
Received: from [192.168.33.175] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D9B3F5CF;
        Mon, 12 Nov 2018 18:53:02 -0800 (PST)
Subject: Re: [PATCH v6 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org, pkondeti@codeaurora.org,
        quentin.perret@arm.com
References: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
 <1541780454-9934-3-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f7725461-bb0e-27fd-04cc-a225c97a9940@arm.com>
Date:   Mon, 12 Nov 2018 18:53:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541780454-9934-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 8:20 AM, Vincent Guittot wrote:

[...]

> In order to achieve this time scaling, a new clock_pelt is created per rq.
> The increase of this clock scales with current capacity when something
> is running on rq and synchronizes with clock_task when rq is idle. With
> this mecanism, we ensure the same running and idle time whatever the

nitpick: s/mecanism/mechanism

[...]

> The responsivness of PELT is improved when CPU is not running at max

nitpick: s/responsivness/responsiveness

> capacity with this new algorithm. I have put below some examples of
> duration to reach some typical load values according to the capacity of the
> CPU with current implementation and with this patch. These values has been
> computed based on the geometric serie and the half period value:

nitpick: s/serie/series

[...]

> +/*
> + * The clock_pelt scales the time to reflect the effective amount of
> + * computation done during the running delta time but then sync back to
> + * clock_task when rq is idle.
> + *
> + *
> + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> + * @ max capacity  ------******---------------******---------------
> + * @ half capacity ------************---------************---------
> + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> + *
> + */
> +static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
> +{
> +	if (unlikely(is_idle_task(rq->curr))) {
> +		/* The rq is idle, we can sync to clock_task */
> +		rq->clock_pelt  = rq_clock_task(rq);
> +		return;

I think the term (time) stretching was used to to describe what's 
happening to the clock_pelt values at lower capacity and to this re-sync 
with the clock task. But IMHO, one has to be called stretching and the 
other compressing so it makes sense. I think it's a question of definition.

> +	}
> +
> +	/*
> +	 * When a rq runs at a lower compute capacity, it will need
> +	 * more time to do the same amount of work than at max
> +	 * capacity: either because it takes more time to compute the
> +	 * same amount of work or because taking more time means
> +	 * sharing more often the CPU between entities.

I wonder if since clock_pelt is related to the sched_avg(s) of the rq 
isn't the only reason the first one "It takes more time to do the same 
amount of work"? IMHO, the sharing of sched entities shouldn't be 
visible here.

> +	 * In order to be invariant, we scale the delta to reflect how
> +	 * much work has been really done.
> +	 * Running at lower capacity also means running longer to do
> +	 * the same amount of work and this results in stealing some

This is already mentioned above.

> +	 * idle time that will disturb the load signal compared to
> +	 * max capacity; This stolen idle time will be automaticcally

nitpick: s/automaticcally/automatically

> +	 * reflected when the rq will be idle and the clock will be
> +	 * synced with rq_clock_task.
> +	 */
> +
> +	/*
> +	 * scale the elapsed time to reflect the real amount of
> +	 * computation
> +	 */
> +	delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
> +	delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
> +
> +	rq->clock_pelt += delta;
> +}
> +
> +/*
> + * When rq becomes idle, we have to check if it has lost some idle time
> + * because it was fully busy. A rq is fully used when the /Sum util_sum
> + * is greater or equal to:
> + * (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> + * For optimization and computing rounding purpose, we don't take into account
> + * the position in the current window (period_contrib) and we use the maximum
> + * util_avg value minus 1
> + */

In v4 you were using:

u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << 
SCHED_CAPACITY_SHIFT;

and switched in v5 to:

u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - 
LOAD_AVG_MAX;

The period_contrib of rq->cfs.avg, rq->avg_rt and rq->avg_dl are not 
necessarily aligned but for overload you sum up the util_sum values for 
cfs, rt and dl. Was this also a reason why you now assume max util_avg - 
1 ?

> +static inline void update_idle_rq_clock_pelt(struct rq *rq)
> +{
> +	u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;

util_avg = util_sum / divider   ,maximum util_avg = 1024

1024 = util_sum / (LOAD_AVG_MAX - 1024)   w/ period_contrib = 0

util_sum >= (LOAD_AVG_MAX - 1024) * 1024

util_sum >= (LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT;

So you want to use 1024 - 1 = 1023 instead. Wouldn't you have to 
subtract (LOAD_AVG_MAX - 1024) from (LOAD_AVG_MAX - 1024) << 
SCHED_CAPACITY_SHIFT in this case?

util_sum >= (LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT - 
(LOAD_AVG_MAX - 1024)

> +	u32 overload = rq->cfs.avg.util_sum;
> +	overload += rq->avg_rt.util_sum;
> +	overload += rq->avg_dl.util_sum;
> +
> +	/*
> +	 * Reflecting some stolen time makes sense only if the idle
> +	 * phase would be present at max capacity. As soon as the
> +	 * utilization of a rq has reached the maximum value, it is
> +	 * considered as an always runnnig rq without idle time to

nitpick: s/runnnig/runnig

> +	 * steal. This potential idle time is considered as lost in
> +	 * this case. We keep track of this lost idle time compare to
> +	 * rq's clock_task.
> +	 */
> +	if ((overload >= divider))
> +		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;

Shouldn't overload still be called util_sum? Overload (or overutilized 
is IMHO the state when util_sum >= divider.

[...]

