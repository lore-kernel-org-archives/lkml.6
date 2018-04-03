Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeDCMSL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:18:11 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:39210 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:18:09 -0400
X-Google-Smtp-Source: AIpwx48sffVUN5UAwQ/9WOIC0Ttcf93UsxPxMVmmFW7Xth8qfdPPIp/jspNoknIZaoB83jYMaY66qzUUOMEo3PTKzDY=
MIME-Version: 1.0
In-Reply-To: <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com> <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Apr 2018 14:17:48 +0200
Message-ID: <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
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

Hi Valentin,

On 3 April 2018 at 00:27, Valentin Schneider <valentin.schneider@arm.com> wrote:
> Hi,
>
> On 30/03/18 13:34, Vincent Guittot wrote:
>> Hi Morten,
>>
> [..]
>>>
>>> As I see it, the main differences is that ASYM_PACKING attempts to pack
>>> all tasks regardless of task utilization on the higher capacity cpus
>>> whereas the "misfit task" series carefully picks cpus with tasks they
>>> can't handle so we don't risk migrating tasks which are perfectly
>>
>> That's one main difference because misfit task will let middle range
>> load task on little CPUs which will not provide maximum performance.
>> I have put an example below
>>
>>> suitable to for a little cpu to a big cpu unnecessarily. Also it is
>>> based directly on utilization and cpu capacity like the capacity
>>> awareness we already have to deal with big.LITTLE in the wake-up path.
>
> I think that bit is quite important. AFAICT, ASYM_PACKING disregards
> task utilization, it only makes sure that (with your patch) tasks will be
> migrated to big CPUS if those ever go idle (pulls at NEWLY_IDLE balance or
> later on during nohz balance). I didn't see anything related to ASYM_PACKING
> in the wake path.
>
>>> Have to tried taking the misfit patches for a spin on your setup? I
>>> expect them give you the same behaviour as you report above.
>>
>> So I have tried both your tests and mine on both patchset and they
>> provide same results which is somewhat expected as the benches are run
>> for several seconds.
>> In other to highlight the main difference between misfit task and
>> ASYM_PACKING, I have reused your test and reduced the number of
>> max-request for sysbench so that the test duration was in the range of
>> hundreds ms.
>>
>> Hikey960 (emulate dynamiq topology)
>>        min         avg(stdev)          max
>> misfit 0.097500    0.114911(+- 10%)    0.138500
>> asym   0.092500    0.106072(+-  6%)    0.122900
>>
>> In this case, we can see that ASYM_PACKING is doing better( 8%)
>> because it migrates sysbench threads on big core as soon as they are
>> available whereas misfit task has to wait for the utilization to
>> increase above the 80% which takes around 70ms when starting with an
>> utilization that is null
>>
>
> I believe ASYM_PACKING behaves better here because the workload is only
> sysbench threads. As stated above, since task utilization is disregarded, I

It behaves better because it doesn't wait for the task's utilization
to reach a level before assuming the task needs high compute capacity.
The utilization gives an idea of the running time of the task not the
performance level that is needed

> think we could have a scenario where the big CPUs are filled with "small"
> tasks and the LITTLE CPUs hold a few "big" tasks - because what mostly
> matters here is the order in which the tasks spawn, not their utilization -
> which is potentially broken.
>
> There's that bit in *update_sd_pick_busiest()*:
>
> /* No ASYM_PACKING if target CPU is already busy */
> if (env->idle == CPU_NOT_IDLE)
>         return true;
>
> So I'm not entirely sure how realistic that scenario is, but I suppose it
> could still happen. Food for thought in any case.
>
> Regards,
> Valentin
