Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDDKoI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:44:08 -0400
Received: from foss.arm.com ([217.140.101.70]:43044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeDDKoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:44:07 -0400
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
 <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
Date: Wed, 4 Apr 2018 11:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/04/18 13:17, Vincent Guittot wrote:
> Hi Valentin,
> 
[...]
>>
>> I believe ASYM_PACKING behaves better here because the workload is only
>> sysbench threads. As stated above, since task utilization is disregarded, I
> 
> It behaves better because it doesn't wait for the task's utilization
> to reach a level before assuming the task needs high compute capacity.
> The utilization gives an idea of the running time of the task not the
> performance level that is needed
> 

That's my point actually. ASYM_PACKING disregards utilization and moves those
threads to the big cores ASAP, which is good here because it's just sysbench
threads.

What I meant was that if the task composition changes, IOW we mix "small"
tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
sysbench threads), we shouldn't assume all of those require to run on a big
CPU. The thing is, ASYM_PACKING can't make the difference between those, so
it'll all come down to which task spawned first.

Furthermore, ASYM_PACKING will forcefully move tasks via active balance
regardless of the imbalance as long as a big CPU is idle.

So we could have a scenario where loads of "small" tasks spawn, and they all
get moved to a big CPU until they're all full (because they're periodic tasks
so the big CPUs will eventually be idle and will pull another task as long as
they get some idle time).

Then, before the load tracking signals of those tasks ramp up high enough 
that the load balancer would try to move those to LITTLE CPUs, some "big"
tasks spawn. They get scheduled on LITTLE CPUs, and now the system will look
balanced so nothing will be done.


I acknowledge this all sounds convoluted but I hope it highlights what I
think could go wrong with ASYM_PACKING on asymmetric systems.

Regards,
Valentin
