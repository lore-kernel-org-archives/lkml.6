Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1550C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C92081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeKCAoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:44:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbeKCAoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC8D1596;
        Fri,  2 Nov 2018 08:36:47 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E6693F718;
        Fri,  2 Nov 2018 08:36:40 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org, pkondeti@codeaurora.org
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
Date:   Fri, 2 Nov 2018 16:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 6:11 PM, Vincent Guittot wrote:
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
> current capacity.

Thinking about this new approach on a big.LITTLE platform:

CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor

A 50% (runtime/period) task on a big CPU will become an always running 
task on the little CPU. The utilization signal of the task and the 
cfs_rq of the little CPU converges to 1024.

With contrib scaling the utilization signal of the 50% task converges to 
512 on the little CPU, even it is always running on it, and so does the 
one of the cfs_rq.

Two 25% tasks on a big CPU will become two 50% tasks on a little CPU. 
The utilization signal of the tasks converges to 512 and the one of the 
cfs_rq of the little CPU converges to 1024.

With contrib scaling the utilization signal of the 25% tasks converges 
to 256 on the little CPU, even they run each 50% on it, and the one of 
the cfs_rq converges to 512.

So what do we consider system-wide invariance? I thought that e.g. a 25% 
task should have a utilization value of 256 no matter on which CPU it is 
running?

In both cases, the little CPU is not going idle whereas the big CPU does.
