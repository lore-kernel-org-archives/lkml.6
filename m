Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeC3Mey (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:34:54 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:44658 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeC3Mex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:34:53 -0400
X-Google-Smtp-Source: AIpwx48PLxNHdn9XnRjbv8HBWmsPX8oEb7fmld/xgyktstdNqNKgYggOI4DaLaWH4G7D8pmNNKUUJqsBnptsJ6Irce8=
MIME-Version: 1.0
In-Reply-To: <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org> <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 30 Mar 2018 14:34:31 +0200
Message-ID: <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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

Hi Morten,

On 29 March 2018 at 14:53, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Wed, Mar 28, 2018 at 09:46:55AM +0200, Vincent Guittot wrote:
>> Arm DynamiQ system can integrate cores with different micro architecture
>> or max OPP under the same DSU so we can have cores with different compute
>> capacity at the LLC (which was not the case with legacy big/LITTLE
>> architecture). Such configuration is similar in some way to ITMT on intel
>> platform which allows some cores to be boosted to higher turbo frequency
>> than others and which uses SD_ASYM_PACKING feature to ensures that CPUs with
>> highest capacity, will always be used in priortiy in order to provide
>> maximum throughput.
>>
>> Add arch_asym_cpu_priority() for arm64 as this function is used to
>> differentiate CPUs in the scheduler. The CPU's capacity is used to order
>> CPUs in the same DSU.
>>
>> Create sched domain topolgy level for arm64 so we can set SD_ASYM_PACKING
>> at MC level.
>>
>> Some tests have been done on a hikey960 platform (quad cortex-A53,
>> quad cortex-A73). For the test purpose, the CPUs topology of the hikey960
>> has been modified so the 8 heterogeneous cores are described as being part
>> of the same cluster and sharing resources (MC level) like with a DynamiQ DSU.
>>
>> Results below show the time in seconds to run sysbench --test=cpu with an
>> increasing number of threads. The sysbench test run 32 times
>>
>>              without patch     with patch    diff
>> 1 threads    11.04(+/- 30%)    8.86(+/- 0%)  -19%
>> 2 threads     5.59(+/- 14%)    4.43(+/- 0%)  -20%
>> 3 threads     3.80(+/- 13%)    2.95(+/- 0%)  -22%
>> 4 threads     3.10(+/- 12%)    2.22(+/- 0%)  -28%
>> 5 threads     2.47(+/-  5%)    1.95(+/- 0%)  -21%
>> 6 threads     2.09(+/-  0%)    1.73(+/- 0%)  -17%
>> 7 threads     1.64(+/-  0%)    1.56(+/- 0%)  - 7%
>> 8 threads     1.42(+/-  0%)    1.42(+/- 0%)    0%
>>
>> Results show a better and stable results across iteration with the patch
>> compared to mainline because we are always using big cores in priority whereas
>> with mainline, the scheduler randomly choose a big or a little cores when
>> there are more cores than number of threads.
>> With 1 thread, the test duration varies in the range [8.85 .. 15.86] for
>> mainline whereas it stays in the range [8.85..8.87] with the patch
>
> Using ASYM_PACKING is essentially an easier but somewhat less accurate
> way to achieve the same behaviour for big.LITTLE system as with the
> "misfit task" series that been under review here for the last couple of
> months.

I think that it's not exactly the same goal although if it's probably
close but ASYM_PACKING ensures that the maximum compute capacity is
used.

>
> As I see it, the main differences is that ASYM_PACKING attempts to pack
> all tasks regardless of task utilization on the higher capacity cpus
> whereas the "misfit task" series carefully picks cpus with tasks they
> can't handle so we don't risk migrating tasks which are perfectly

That's one main difference because misfit task will let middle range
load task on little CPUs which will not provide maximum performance.
I have put an example below

> suitable to for a little cpu to a big cpu unnecessarily. Also it is
> based directly on utilization and cpu capacity like the capacity
> awareness we already have to deal with big.LITTLE in the wake-up path.
> Furthermore, it should work for all big.LITTLE systems regardless of the
> topology, where I think ASYM_PACKING might not work well for systems
> with separate big and little sched_domains.

I haven't look in details if ASYM_PACKING can work correctly on legacy
big/little as I was mainly focus on dynamiQ config but I guess that
might also work

>
> Have to tried taking the misfit patches for a spin on your setup? I
> expect them give you the same behaviour as you report above.

So I have tried both your tests and mine on both patchset and they
provide same results which is somewhat expected as the benches are run
for several seconds.
In other to highlight the main difference between misfit task and
ASYM_PACKING, I have reused your test and reduced the number of
max-request for sysbench so that the test duration was in the range of
hundreds ms.

Hikey960 (emulate dynamiq topology)
       min         avg(stdev)          max
misfit 0.097500    0.114911(+- 10%)    0.138500
asym   0.092500    0.106072(+-  6%)    0.122900

In this case, we can see that ASYM_PACKING is doing better( 8%)
because it migrates sysbench threads on big core as soon as they are
available whereas misfit task has to wait for the utilization to
increase above the 80% which takes around 70ms when starting with an
utilization that is null

Regards,
Vincent

>
> Morten
