Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDDNnj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:43:39 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:50572 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDDNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:43:38 -0400
X-Google-Smtp-Source: AIpwx4/m9d14zaYlZWj47khVoj9/NfCRZpowmN1FjIU7Y00UXQirc13bCwQqyIa6UCUS4fhtBeeKvleu2jUyxbshem4=
MIME-Version: 1.0
In-Reply-To: <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com> <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com> <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 4 Apr 2018 15:43:17 +0200
Message-ID: <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 April 2018 at 12:44, Valentin Schneider <valentin.schneider@arm.com> wrote:
> Hi,
>
> On 03/04/18 13:17, Vincent Guittot wrote:
>> Hi Valentin,
>>
> [...]
>>>
>>> I believe ASYM_PACKING behaves better here because the workload is only
>>> sysbench threads. As stated above, since task utilization is disregarded, I
>>
>> It behaves better because it doesn't wait for the task's utilization
>> to reach a level before assuming the task needs high compute capacity.
>> The utilization gives an idea of the running time of the task not the
>> performance level that is needed
>>
>
> That's my point actually. ASYM_PACKING disregards utilization and moves those
> threads to the big cores ASAP, which is good here because it's just sysbench
> threads.
>
> What I meant was that if the task composition changes, IOW we mix "small"
> tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
> sysbench threads), we shouldn't assume all of those require to run on a big
> CPU. The thing is, ASYM_PACKING can't make the difference between those, so

That's the 1st point where I tend to disagree: why big cores are only
for long running task and periodic stuff can't need to run on big
cores to get max compute capacity ?
You make the assumption that only long running tasks need high compute
capacity. This patch wants to always provide max compute capacity to
the system and not only long running task

> it'll all come down to which task spawned first.
>
> Furthermore, ASYM_PACKING will forcefully move tasks via active balance
> regardless of the imbalance as long as a big CPU is idle.
>
> So we could have a scenario where loads of "small" tasks spawn, and they all
> get moved to a big CPU until they're all full (because they're periodic tasks
> so the big CPUs will eventually be idle and will pull another task as long as
> they get some idle time).
>
> Then, before the load tracking signals of those tasks ramp up high enough
> that the load balancer would try to move those to LITTLE CPUs, some "big"
> tasks spawn. They get scheduled on LITTLE CPUs, and now the system will look
> balanced so nothing will be done.

As explained above, as long as the big CPUs are always used,I don't
think it's a problem. What is a problem is if a task stays on a little
CPU whereas a big CPU is idle because we can provide more throughput

>
>
> I acknowledge this all sounds convoluted but I hope it highlights what I
> think could go wrong with ASYM_PACKING on asymmetric systems.
>
> Regards,
> Valentin
