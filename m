Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeEUNnF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:43:05 -0400
Received: from foss.arm.com ([217.140.101.70]:49848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeEUNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:43:01 -0400
Subject: Re: [PATCH 6/6] arm64: perf: Add support for chaining counters
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
To: Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
 <32f2d870-9b9c-0b10-880f-cc99cf969bf6@arm.com>
 <5d53fe1d-dbd9-2aad-73bd-0c4284540240@arm.com>
Message-ID: <c8cb9280-c93d-89c4-43ed-179de8d46dfd@arm.com>
Date: Mon, 21 May 2018 14:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5d53fe1d-dbd9-2aad-73bd-0c4284540240@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 16:57, Suzuki K Poulose wrote:
> Hi Robin,
> 
> On 18/05/18 14:49, Robin Murphy wrote:
>> On 18/05/18 11:22, Suzuki K Poulose wrote:
>>> Add support for chained event counters. PMUv3 allows chaining
>>> a pair of adjacent PMU counters (with the lower counter number
>>> being always "even"). The low counter is programmed to count
>>> the event of interest and the high counter(odd numbered) is
>>> programmed with a special event code (0x1e - Chain). Thus
>>> we need special allocation schemes to make the full use of
>>> available counters. So, we allocate the counters from either
>>> ends. i.e, chained counters are allocated from the lower
>>> end in pairs of two and the normal counters are allocated
>>> from the higher number. Also makes necessary changes to
>>> handle the chained events as a single event with 2 counters.
>>>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> 
>>>   /*
>>> @@ -845,8 +1016,14 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>>>                          &armv8_pmuv3_perf_cache_map,
>>>                          ARMV8_PMU_EVTYPE_EVENT);
>>> -    if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
>>> +    if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
>>> +        /* Prevent chaining for cycle counter */
>>
>> Why? Sure, we want to avoid executing the chaining logic if we're scheduling a cycles event in the dedicated counter (which is perhaps what the comment above wanted to say), but if one ends up allocated into a regular counter (e.g. if the user asks for multiple cycle counts with different filters), then I don't see any reason to forbid that being chained.
> 
> Ah, I didn't think about that case. I was under the assumption that the
> cycles are *only* placed on the cycle counter. I will take care of that.
> Thanks for the review.

Robin, Mark, Will

One potential problem I see with allowing chaining of the cycle counter
*and* the promotion of cycle event to 64bit by default is when the user
may actually be able to count 1 less event (due to the promotion of
cycle event to 64bit and thus forcing to use chain, if the cycle counter
is unavailable).

So one option is to drop automatic promotion of the cycle counter to
64bit and do it only when it is requested by the user and use either the
Cycle counter (preferred) or fall back to chaining. That way, the user
has the control over the number of events he can count using the given
set of counters.

Let me know your thoughts.

Suzuki
