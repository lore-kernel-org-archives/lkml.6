Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeB1WRk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:17:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935314AbeB1WRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:17:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F294607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A972A7D.9020301@codeaurora.org>
Date: Wed, 28 Feb 2018 14:17:33 -0800
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
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A90B77E.8040105@codeaurora.org> <20180225143653.peb4quk3ha5h3t5x@salmiak>
In-Reply-To: <20180225143653.peb4quk3ha5h3t5x@salmiak>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2018 06:36 AM, Mark Rutland wrote:
> On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
>> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>>> +static void dsu_pmu_event_update(struct perf_event *event)
>>> +{
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +	u64 delta, prev_count, new_count;
>>> +
>>> +	do {
>>> +		/* We may also be called from the irq handler */
>>> +		prev_count = local64_read(&hwc->prev_count);
>>> +		new_count = dsu_pmu_read_counter(event);
>>> +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
>>> +			prev_count);
>>> +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
>>> +	local64_add(delta, &event->count);
>>> +}
>>> +
>>> +static void dsu_pmu_read(struct perf_event *event)
>>> +{
>>> +	dsu_pmu_event_update(event);
>>> +}
>
>> I sent out a patch that'll allow PMUs to set an event flag to avoid
>> unnecessary smp calls when the event can be read from any CPU. You could
>> just always set that if you can't have multiple DSU's running the kernel (I
>> don't know if the current ARM designs support having multiple DSUs in a
>> SoC/system) or set it if associated_cpus == cpu_present_mask.
>
> As-is, that won't be safe, given the read function calls the event_update()
> function, which has side-effects on hwc->prec_count and event->count. Those
> need to be serialized somehow.

You have to grab the dsu_pmu->pmu_lock spin lock anyway because the 
system registers are shared across all CPUs. So, just expanding it a bit 
to lock the hwc->prev_count and event->count updated doesn't seem to be 
any worse. In fact, it's better than sending pointless IPIs.

The local64_read/cmpxchg/add etc makes sense when you have per-cpu 
system registers like in the case of the ARM CPU PMU registers. It 
doesn't really buy us much for registers shared across the CPUs.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
