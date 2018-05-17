Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEQKku (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:40:50 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:52742 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeEQKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:40:49 -0400
Subject: Re: [PATCH v3 5/7] MIPS: perf: Allocate per-core counters on demand
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <linux-mips@linux-mips.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <1524219789-31241-6-git-send-email-matt.redfearn@mips.com>
 <20180516180518.GB12837@jamesdev>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <ea713dfc-a4ef-a2ea-de9f-bd40ef28b128@mips.com>
Date: Thu, 17 May 2018 11:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180516180518.GB12837@jamesdev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526553619-637139-24071-42272-1
X-BESS-VER: 2018.6-r1805161801
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193074
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 16/05/18 19:05, James Hogan wrote:
> On Fri, Apr 20, 2018 at 11:23:07AM +0100, Matt Redfearn wrote:
>> Previously when performance counters are per-core, rather than
>> per-thread, the number available were divided by 2 on detection, and the
>> counters used by each thread in a core were "swizzled" to ensure
>> separation. However, this solution is suboptimal since it relies on a
>> couple of assumptions:
>> a) Always having 2 VPEs / core (number of counters was divided by 2)
>> b) Always having a number of counters implemented in the core that is
>>     divisible by 2. For instance if an SoC implementation had a single
>>     counter and 2 VPEs per core, then this logic would fail and no
>>     performance counters would be available.
>> The mechanism also does not allow for one VPE in a core using more than
>> it's allocation of the per-core counters to count multiple events even
>> though other VPEs may not be using them.
>>
>> Fix this situation by instead allocating (and releasing) per-core
>> performance counters when they are requested. This approach removes the
>> above assumptions and fixes the shortcomings.
>>
>> In order to do this:
>> Add additional logic to mipsxx_pmu_alloc_counter() to detect if a
>> sibling is using a per-core counter, and to allocate a per-core counter
>> in all sibling CPUs.
>> Similarly, add a mipsxx_pmu_free_counter() function to release a
>> per-core counter in all sibling CPUs when it is finished with.
>> A new spinlock, core_counters_lock, is introduced to ensure exclusivity
>> when allocating and releasing per-core counters.
>> Since counters are now allocated per-core on demand, rather than being
>> reserved per-thread at boot, all of the "swizzling" of counters is
>> removed.
>>
>> The upshot is that in an SoC with 2 counters / thread, counters are
>> reported as:
>> Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
>> available to each CPU, irq 18
>>
>> Running an instance of a test program on each of 2 threads in a
>> core, both threads can use their 2 counters to count 2 events:
>>
>> taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
>> perf stat -e instructions:u,branches:u ./test_prog
>>
>>   Performance counter stats for './test_prog':
>>
>>               30002      instructions:u
>>               10000      branches:u
>>
>>         0.005164264 seconds time elapsed
>>   Performance counter stats for './test_prog':
>>
>>               30002      instructions:u
>>               10000      branches:u
>>
>>         0.006139975 seconds time elapsed
>>
>> In an SoC with 2 counters / core (which can be forced by setting
>> cpu_has_mipsmt_pertccounters = 0), counters are reported as:
>> Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
>> available to each core, irq 18
>>
>> Running an instance of a test program on each of 2 threads in a/soak/bin/bashsoak -E cpuhotplugHi
>> core, now only one thread manages to secure the performance counters to
>> count 2 events. The other thread does not get any counters.
>>
>> taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
>> perf stat -e instructions:u,branches:u ./test_prog
>>
>>   Performance counter stats for './test_prog':
>>
>>       <not counted>       instructions:u
>>       <not counted>       branches:u
>>
>>         0.005179533 seconds time elapsed
>>
>>   Performance counter stats for './test_prog':
>>
>>               30002      instructions:u
>>               10000      branches:u
>>
>>         0.005179467 seconds time elapsed
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> While this sounds like an improvement in practice, being able to use
> more counters on single threaded stuff than otherwise, I'm a little
> concerned what would happen if a task was migrated to a different CPU
> and the perf counters couldn't be obtained on the new CPU due to
> counters already being in use. Would the values be incorrectly small?

This change was really forced by the new I7200 development. Current 
configurations have 2 counters per core, but each core has 3 VPEs - 
which means the current logic cannot correctly assign counters. IoW the 
2 assumptions stated in the commit log are no longer true.

Though you are right that if a task migrated to a core on which another 
VPE is already using the counters, this change would mean counters 
cannot be assigned. In that case we return EAGAIN. I'm not sure if that 
error would be handled gracefully by the scheduler and the task 
scheduled away again... The code events logic that backs this is tricky 
to follow.

Thanks,
Matt


> 
> Cheers
> James
> 
