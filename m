Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165200AbeCBTUC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:20:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165178AbeCBTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:19:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E18AD60117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A99A3DC.9020400@codeaurora.org>
Date: Fri, 02 Mar 2018 11:19:56 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jonathan.cameron@huawei.com, frowand.list@gmail.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A90B77E.8040105@codeaurora.org> <20180225143653.peb4quk3ha5h3t5x@salmiak> <5A972A7D.9020301@codeaurora.org> <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com> <5A986425.9080007@codeaurora.org> <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
In-Reply-To: <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 02:42 AM, Mark Rutland wrote:
> On Thu, Mar 01, 2018 at 12:35:49PM -0800, Saravana Kannan wrote:
>> On 03/01/2018 03:49 AM, Mark Rutland wrote:
>>> On Wed, Feb 28, 2018 at 02:17:33PM -0800, Saravana Kannan wrote:
>>>> On 02/25/2018 06:36 AM, Mark Rutland wrote:
>>>>> On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
>>>>>> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>>>>>>> +static void dsu_pmu_event_update(struct perf_event *event)
>>>>>>> +{
>>>>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>>>>> +	u64 delta, prev_count, new_count;
>>>>>>> +
>>>>>>> +	do {
>>>>>>> +		/* We may also be called from the irq handler */
>>>>>>> +		prev_count = local64_read(&hwc->prev_count);
>>>>>>> +		new_count = dsu_pmu_read_counter(event);
>>>>>>> +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
>>>>>>> +			prev_count);
>>>>>>> +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
>>>>>>> +	local64_add(delta, &event->count);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void dsu_pmu_read(struct perf_event *event)
>>>>>>> +{
>>>>>>> +	dsu_pmu_event_update(event);
>>>>>>> +}
>>>>>
>>>>>> I sent out a patch that'll allow PMUs to set an event flag to avoid
>>>>>> unnecessary smp calls when the event can be read from any CPU. You could
>>>>>> just always set that if you can't have multiple DSU's running the kernel (I
>>>>>> don't know if the current ARM designs support having multiple DSUs in a
>>>>>> SoC/system) or set it if associated_cpus == cpu_present_mask.
>>>>>
>>>>> As-is, that won't be safe, given the read function calls the event_update()
>>>>> function, which has side-effects on hwc->prec_count and event->count. Those
>>>>> need to be serialized somehow.
>>>>
>>>> You have to grab the dsu_pmu->pmu_lock spin lock anyway because the system
>>>> registers are shared across all CPUs.
>>>
>>> I believe that lock is currently superfluous, because the perf core
>>> ensures operations are cpu-affine, and have interrupts disabled in most
>>> cases (thanks to the context lock).
>>
>> I don't think it's superfluous. You have a common "event counter" selection
>> register and a common "event counter value" register. You can two CPUs
>> racing to read two unrelated event counters and end up causing one of them
>> to read a bogus value from the wrong event counter.
>
> It's important to note that the DSU PMU's event_init() ensures events
> are affine to a single CPU, and the perf core code serializes operations
> on those events via the context lock.

Ah, I see that now. Thanks!

> Therefore, two CPUs *won't* try to access the registers simultaneously.

Right, and this driver seems to be going through a lot of work to make 
sure all events are read in one CPU.

Do you even have an upstream target where there are multiple DSU's in a 
system? If not, we can simplify a ton of this code (no hotplug 
notifiers, no migrating PMUs, no SMP calls, etc) by just adding a 
spinlock and letting any CPU read these DSU counters.

If you need to support a system with multiple DSUs, I think it's still 
useful to add CPU mask for events and letting the perf framework read 
events on any of those CPUs.

> If events could be active on multiple CPUs simultaneously, I agree that
> the lock would be necessary. However, there would also be other problems
> to deal with in that case.
>
> If we want to allow pmu::read() from arbitrary CPUs the DSU is affine
> to, I agree we'd need the lock to serialize accesses to the registers
> and data structures.

Agreed.

So, depending on how many DSUs you want to support in the mainline 
kernel, we can simplify it a ton. And if not, we can still try to remove 
the need for smp calls so that we don't cause power impact when trying 
to profile while measuring power.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
