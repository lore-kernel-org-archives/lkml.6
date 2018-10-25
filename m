Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32998C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EDD2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EDD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJYTIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:08:10 -0400
Received: from foss.arm.com ([217.140.101.70]:54606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJYTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:08:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590CBA78;
        Thu, 25 Oct 2018 03:36:00 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B6D43F627;
        Thu, 25 Oct 2018 03:35:57 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <43b126ab-403b-3fb3-5951-45a107e4a14b@arm.com>
Date:   Thu, 25 Oct 2018 12:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 10/19/18 6:17 PM, Vincent Guittot wrote:
> The current implementation of load tracking invariance scales the
> contribution with current frequency and uarch performance (only for
> utilization) of the CPU. One main result of this formula is that the
> figures are capped by current capacity of CPU. Another one is that the
> load_avg is not invariant because not scaled with uarch.
> 
> The util_avg of a periodic task that runs r time slots every p time slots
> varies in the range :
> 
>      U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)
> 
> with U is the max util_avg value = SCHED_CAPACITY_SCALE
> 
> At a lower capacity, the range becomes:
> 
>      U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)
> 
> with C reflecting the compute capacity ratio between current capacity and
> max capacity.
> 
> so C tries to compensate changes in (1-y^r') but it can't be accurate.
> 
> Instead of scaling the contribution value of PELT algo, we should scale the
> running time. The PELT signal aims to track the amount of computation of
> tasks and/or rq so it seems more correct to scale the running time to
> reflect the effective amount of computation done since the last update.
> 
> In order to be fully invariant, we need to apply the same amount of
> running time and idle time whatever the current capacity. Because running
> at lower capacity implies that the task will run longer, we have to ensure
> that the same amount of idle time will be apply when system becomes idle
> and no idle time has been "stolen". But reaching the maximum utilization
> value (SCHED_CAPACITY_SCALE) means that the task is seen as an
> always-running task whatever the capacity of the CPU (even at max compute
> capacity). In this case, we can discard this "stolen" idle times which
> becomes meaningless.
> 
> In order to achieve this time scaling, a new clock_pelt is created per rq.
> The increase of this clock scales with current capacity when something
> is running on rq and synchronizes with clock_task when rq is idle. With
> this mecanism, we ensure the same running and idle time whatever the
> current capacity. This also enables to simplify the pelt algorithm by
> removing all references of uarch and frequency and applying the same
> contribution to utilization and loads. Furthermore, the scaling is done
> only once per update of clock (update_rq_clock_task()) instead of during
> each update of sched_entities and cfs/rt/dl_rq of the rq like the current
> implementation. This is interesting when cgroup are involved as shown in
> the results below:

I have a couple of questions related to the tests you ran.

> On a hikey (octo ARM platform).
> Performance cpufreq governor and only shallowest c-state to remove variance
> generated by those power features so we only track the impact of pelt algo.

So you disabled c-state 'cpu-sleep' and 'cluster-sleep'?

I get 'hisi_thermal f7030700.tsensor: THERMAL ALARM: 66385 > 65000' on 
my hikey620. Did you change the thermal configuration? Not sure if there 
are any actions attached to this warning though.

> each test runs 16 times
> 
> ./perf bench sched pipe
> (higher is better)
> kernel	tip/sched/core     + patch
>          ops/seconds        ops/seconds         diff
> cgroup
> root    59648(+/- 0.13%)   59785(+/- 0.24%)    +0.23%
> level1  55570(+/- 0.21%)   56003(+/- 0.24%)    +0.78%
> level2  52100(+/- 0.20%)   52788(+/- 0.22%)    +1.32%
> 
> hackbench -l 1000

Shouldn't this be '-l 100'?

> (lower is better)
> kernel	tip/sched/core     + patch
>          duration(sec)      duration(sec)        diff
> cgroup
> root    4.472(+/- 1.86%)   4.346(+/- 2.74%)     -2.80%
> level1  5.039(+/- 11.05%)  4.662(+/- 7.57%)     -7.47%
> level2  5.195(+/- 10.66%)  4.877(+/- 8.90%)     -6.12%
> 
> The responsivness of PELT is improved when CPU is not running at max
> capacity with this new algorithm. I have put below some examples of
> duration to reach some typical load values according to the capacity of the
> CPU with current implementation and with this patch.
> 
> Util (%)     max capacity  half capacity(mainline)  half capacity(w/ patch)
> 972 (95%)    138ms         not reachable            276ms
> 486 (47.5%)  30ms          138ms                     60ms
> 256 (25%)    13ms           32ms                     26ms

Could you describe these testcases in more detail?

So I assume you run one 100% task (possibly pinned to one CPU) on your 
hikey620 with userspace governor and for:

  (1) max capacity:

  echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed

  (2) half capacity:

  echo 729000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed

and then you measure the time till t1 reaches 25%, 47.5% and 95% 
utilization?
What's the initial utilization value of t1? I assume t1 starts with 
utilization=512 (post_init_entity_util_avg()).

> On my hikey (octo ARM platform) with schedutil governor, the time to reach
> max OPP when starting from a null utilization, decreases from 223ms with
> current scale invariance down to 121ms with the new algorithm. For this
> test, I have enable arch_scale_freq for arm64.

Isn't the arch-specific arch_scale_freq_capacity() enabled by default on 
arm64 with cpufreq support?

I would like to run the same tests so we can discuss results more easily.
