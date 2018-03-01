Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161682AbeCAUfx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:35:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161597AbeCAUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:35:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D27CB60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A986425.9080007@codeaurora.org>
Date: Thu, 01 Mar 2018 12:35:49 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        jonathan.cameron@huawei.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        sudeep.holla@arm.com, frowand.list@gmail.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A90B77E.8040105@codeaurora.org> <20180225143653.peb4quk3ha5h3t5x@salmiak> <5A972A7D.9020301@codeaurora.org> <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
In-Reply-To: <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 03:49 AM, Mark Rutland wrote:
> On Wed, Feb 28, 2018 at 02:17:33PM -0800, Saravana Kannan wrote:
>> On 02/25/2018 06:36 AM, Mark Rutland wrote:
>>> On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
>>>> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>>>>> +static void dsu_pmu_event_update(struct perf_event *event)
>>>>> +{
>>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>>> +	u64 delta, prev_count, new_count;
>>>>> +
>>>>> +	do {
>>>>> +		/* We may also be called from the irq handler */
>>>>> +		prev_count = local64_read(&hwc->prev_count);
>>>>> +		new_count = dsu_pmu_read_counter(event);
>>>>> +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
>>>>> +			prev_count);
>>>>> +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
>>>>> +	local64_add(delta, &event->count);
>>>>> +}
>>>>> +
>>>>> +static void dsu_pmu_read(struct perf_event *event)
>>>>> +{
>>>>> +	dsu_pmu_event_update(event);
>>>>> +}
>>>
>>>> I sent out a patch that'll allow PMUs to set an event flag to avoid
>>>> unnecessary smp calls when the event can be read from any CPU. You could
>>>> just always set that if you can't have multiple DSU's running the kernel (I
>>>> don't know if the current ARM designs support having multiple DSUs in a
>>>> SoC/system) or set it if associated_cpus == cpu_present_mask.
>>>
>>> As-is, that won't be safe, given the read function calls the event_update()
>>> function, which has side-effects on hwc->prec_count and event->count. Those
>>> need to be serialized somehow.
>>
>> You have to grab the dsu_pmu->pmu_lock spin lock anyway because the system
>> registers are shared across all CPUs.
>
> I believe that lock is currently superfluous, because the perf core
> ensures operations are cpu-affine, and have interrupts disabled in most
> cases (thanks to the context lock).

I don't think it's superfluous. You have a common "event counter" 
selection register and a common "event counter value" register. You can 
two CPUs racing to read two unrelated event counters and end up causing 
one of them to read a bogus value from the wrong event counter.

AFAIK, the *DSU* PMU event selection registers are not per-CPU (the 
per-CPU CPU PMU event selection registers are). If this understanding is 
correct, you definitely need the spinlock.

>> So, just expanding it a bit to lock the hwc->prev_count and
>> event->count updated doesn't seem to be any worse.  In fact, it's
>> better than sending pointless IPIs.
>
> That's a fair point.
>
> I'll leave it to Suzuki to decide.
>
>> The local64_read/cmpxchg/add etc makes sense when you have per-cpu system
>> registers like in the case of the ARM CPU PMU registers. It doesn't really
>> buy us much for registers shared across the CPUs.
>
> Theoretically, because operations are currnetly cpu-affine, they
> potentially reduce the overhead of sertialization and synchronization.
> In practice for arm64 they're just LL/SC loops, so I agree we don't lose
> much.

See my point above. Serialization isn't optional AFAIK.

Suzuki,

Are you open to using per event CPU masks if I send a patch for that? So 
that we can reduce IPIs and not mess up power measurements?


Thanks,
Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
