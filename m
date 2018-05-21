Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeEUKuD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:50:03 -0400
Received: from foss.arm.com ([217.140.101.70]:46886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeEUKuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:50:02 -0400
Subject: Re: [PATCH 6/6] arm64: perf: Add support for chaining counters
To: Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
 <5ff704da-b767-33d7-68c4-7aa02f83ac0a@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <8fd2f592-c489-8710-92a5-2f4666b1c290@arm.com>
Date: Mon, 21 May 2018 11:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5ff704da-b767-33d7-68c4-7aa02f83ac0a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 15:57, Robin Murphy wrote:
> One more thing now that I've actually looked at the Arm ARM...
> 
> On 18/05/18 11:22, Suzuki K Poulose wrote:
> [...]
>> +static inline void armv8pmu_write_event_type(struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    int idx = hwc->idx;
>> +
>> +    /*
>> +     * For chained events, write the high counter event type
>> +     * followed by the low counter.
>> +     */
>> +    if (armv8pmu_event_is_chained(event)) {
>> +        u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN;
>> +
>> +        /* Set the filters as that of the main event for chain */
>> +        chain_evt |= hwc->config_base & ~ARMV8_PMU_EVTYPE_EVENT;
> 
> The description of the chain event says that the filtering must only be set on the lower counter, and that the chain event itself should be set to count everything.

You're right. I intended to fix it, but missed in the rebases.
Thanks for pointing out.

> 
>> +        armv8pmu_write_evtype(idx, chain_evt);
>> +        isb();
>> +        idx--;
>> +    }
>> +
>> +    armv8pmu_write_evtype(idx, hwc->config_base);
> 
> It also says that the 'real' event should be set up first and the chain event second, with the rather ominous warning of "If software does not program the event in this way, the count becomes UNPREDICTABLE."
> 

Yep, will fix it.

Thanks for the review

Suzuki
