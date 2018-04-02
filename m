Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeDBW1R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:27:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754492AbeDBW1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:27:16 -0400
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
Date: Mon, 2 Apr 2018 23:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/03/18 13:34, Vincent Guittot wrote:
> Hi Morten,
> 
[..]
>>
>> As I see it, the main differences is that ASYM_PACKING attempts to pack
>> all tasks regardless of task utilization on the higher capacity cpus
>> whereas the "misfit task" series carefully picks cpus with tasks they
>> can't handle so we don't risk migrating tasks which are perfectly
> 
> That's one main difference because misfit task will let middle range
> load task on little CPUs which will not provide maximum performance.
> I have put an example below
> 
>> suitable to for a little cpu to a big cpu unnecessarily. Also it is
>> based directly on utilization and cpu capacity like the capacity
>> awareness we already have to deal with big.LITTLE in the wake-up path.

I think that bit is quite important. AFAICT, ASYM_PACKING disregards
task utilization, it only makes sure that (with your patch) tasks will be
migrated to big CPUS if those ever go idle (pulls at NEWLY_IDLE balance or
later on during nohz balance). I didn't see anything related to ASYM_PACKING
in the wake path.

>> Have to tried taking the misfit patches for a spin on your setup? I
>> expect them give you the same behaviour as you report above.
> 
> So I have tried both your tests and mine on both patchset and they
> provide same results which is somewhat expected as the benches are run
> for several seconds.
> In other to highlight the main difference between misfit task and
> ASYM_PACKING, I have reused your test and reduced the number of
> max-request for sysbench so that the test duration was in the range of
> hundreds ms.
> 
> Hikey960 (emulate dynamiq topology)
>        min         avg(stdev)          max
> misfit 0.097500    0.114911(+- 10%)    0.138500
> asym   0.092500    0.106072(+-  6%)    0.122900
> 
> In this case, we can see that ASYM_PACKING is doing better( 8%)
> because it migrates sysbench threads on big core as soon as they are
> available whereas misfit task has to wait for the utilization to
> increase above the 80% which takes around 70ms when starting with an
> utilization that is null
> 

I believe ASYM_PACKING behaves better here because the workload is only
sysbench threads. As stated above, since task utilization is disregarded, I
think we could have a scenario where the big CPUs are filled with "small"
tasks and the LITTLE CPUs hold a few "big" tasks - because what mostly
matters here is the order in which the tasks spawn, not their utilization -
which is potentially broken.

There's that bit in *update_sd_pick_busiest()*:

/* No ASYM_PACKING if target CPU is already busy */                                     
if (env->idle == CPU_NOT_IDLE)                                                          
	return true;

So I'm not entirely sure how realistic that scenario is, but I suppose it
could still happen. Food for thought in any case.

Regards,
Valentin
