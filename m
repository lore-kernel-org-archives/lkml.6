Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeERP5Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:57:25 -0400
Received: from foss.arm.com ([217.140.101.70]:55294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeERP5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:57:21 -0400
Subject: Re: [PATCH 6/6] arm64: perf: Add support for chaining counters
To: Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
 <32f2d870-9b9c-0b10-880f-cc99cf969bf6@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <5d53fe1d-dbd9-2aad-73bd-0c4284540240@arm.com>
Date: Fri, 18 May 2018 16:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <32f2d870-9b9c-0b10-880f-cc99cf969bf6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 18/05/18 14:49, Robin Murphy wrote:
> On 18/05/18 11:22, Suzuki K Poulose wrote:
>> Add support for chained event counters. PMUv3 allows chaining
>> a pair of adjacent PMU counters (with the lower counter number
>> being always "even"). The low counter is programmed to count
>> the event of interest and the high counter(odd numbered) is
>> programmed with a special event code (0x1e - Chain). Thus
>> we need special allocation schemes to make the full use of
>> available counters. So, we allocate the counters from either
>> ends. i.e, chained counters are allocated from the lower
>> end in pairs of two and the normal counters are allocated
>> from the higher number. Also makes necessary changes to
>> handle the chained events as a single event with 2 counters.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/kernel/perf_event.c | 226 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 202 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index ea8e060..5f81cd0 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -446,9 +446,11 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {

..

>> +static inline u64 armv8pmu_read_chain_counter(int idx)
>> +{
>> +    u64 prev_hi, hi, lo;
>> +
>> +    do {
>> +        prev_hi = armv8pmu_read_evcntr(idx);
>> +        isb();
>> +        lo = armv8pmu_read_evcntr(idx - 1);
>> +        isb();
>> +        hi = armv8pmu_read_evcntr(idx);
>> +        isb();
>> +    } while (prev_hi != hi);
> 
> Is it worth trying to elide that last isb() in the highly likely case that we don't need it?

You're right. Also, I will rework the code to reuse the "hi".

>> +static inline void armv8pmu_write_chain_counter(int idx, u64 value)
>> +{
>> +    armv8pmu_write_evcntr(idx, value >> 32);
>> +    isb();
>> +    armv8pmu_write_evcntr(idx - 1, value);
>> +    isb();
> 
> Either that isb() is unnecessary, or we are (and have been) missing one after a non-chained write.

Thats right, it is not necessary, will remove it.


>>   static inline int armv8pmu_disable_counter(int idx)
>>   {
>>       u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>> @@ -567,6 +669,24 @@ static inline int armv8pmu_disable_counter(int idx)
>>       return idx;
>>   }
>> +static inline void armv8pmu_disable_event_counter(struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
> 
> Nit: might as well drop this and be consistent with the enable case.

Sure.

>>   static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>>                     struct perf_event *event)
>>   {
>> @@ -755,7 +915,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>>       struct hw_perf_event *hwc = &event->hw;
>>       unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>> -    /* Always prefer to place a cycle counter into the cycle counter. */
>> +    /*
>> +     * Always prefer to place a cycle counter into the cycle counter
>> +     * irrespective of whether we are counting 32bit/64bit
> 
> I don't think that comment change adds much :/
> 

Thats a left over from rebasing. Thanks for spotting.

>>   /*
>> @@ -845,8 +1016,14 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>>                          &armv8_pmuv3_perf_cache_map,
>>                          ARMV8_PMU_EVTYPE_EVENT);
>> -    if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
>> +    if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
>> +        /* Prevent chaining for cycle counter */
> 
> Why? Sure, we want to avoid executing the chaining logic if we're scheduling a cycles event in the dedicated counter (which is perhaps what the comment above wanted to say), but if one ends up allocated into a regular counter (e.g. if the user asks for multiple cycle counts with different filters), then I don't see any reason to forbid that being chained.

Ah, I didn't think about that case. I was under the assumption that the
cycles are *only* placed on the cycle counter. I will take care of that.
Thanks for the review.

Suzuki
