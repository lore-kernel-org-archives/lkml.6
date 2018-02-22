Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeBVUip (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:38:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeBVUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:38:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D6156019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A8F2A4F.5020105@codeaurora.org>
Date: Thu, 22 Feb 2018 12:38:39 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
        robh@kernel.org, sudeep.holla@arm.com, mathieu.poirier@linaro.org,
        peterz@infradead.org, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, leo.yan@linaro.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        avilaj@codeaurora.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A8E2BCE.3050509@codeaurora.org> <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com>
In-Reply-To: <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 03:33 AM, Mark Rutland wrote:
> On Wed, Feb 21, 2018 at 06:32:46PM -0800, Saravana Kannan wrote:
>> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>>> +static int dsu_pmu_event_init(struct perf_event *event)
>>> +{
>>> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>>> +
>>> +	if (event->attr.type != event->pmu->type)
>>> +		return -ENOENT;
>>
>> You are checking if the caller set the attr.type "correctly".
>
> This is necessary for the case where perf_init_event() falls back to
> iterating over the list of PMUs, if event->attr.type wasn't found in the
> idr.
>
> Without this, we'd erroneously check events intended for other PMUs.
> So this is correct, and necessary.

Right, I'm aware of this. Which is why I also mentioned below that we 
can't just blindly delete this.

>>> +static int dsu_pmu_device_probe(struct platform_device *pdev)
>
>>> +	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
>>
>> You are passing in -1 here. Which means the event type is assigned by the
>> perf framework. perf framework uses idr_alloc(&pmu_idr, ...) to get the id.
>> So the id assigned is going to depend on the probe order among the different
>> PMU drivers in the board/platform. So, this seems pretty random.
>
> The dynamic IDs are supposed to by looked up by name.
>
> Each PMU has a folder: /sys/bus/event_source/devices/$PMU
>
> ... with /sys/bus/event_source/devices/$PMU/type giving the type.
>
>> How is the caller supposed to know what to set the "type" to?
>
> The perf tools understand this already. If you do:
>
> perf stat -e $PMU/config=0xf00/
>
> ... they will look up the type for that PMU and use it automatically.
>

Ah, thanks! This finally explains how this is supposed to work from 
userspace.

>> You also can't just delete the check in dsu_pmu_event_init() because the
>> event numbers you expose overlap with the per-CPU event numbers.
>
> The type check is necessary and cannot be deleted. It provides a
> namespace for the event IDs.

Right. Which is my point too.

>> I'm not exactly sure if we can add entries to perf_type_id. If that's
>> allowed maybe we need to add something line PERF_TYPE_DSU and use that?
>>
>> Or if that's not allowed then would it be better to offset the DSU PMU
>> events by some number (say 0x1000) and then delete the event type check or
>> pass PERF_TYPE_RAW to perf_pmu_register()?
>
> As above, neither of these should be necessary.
>

For the userspace interface. How about the kernel interface though?
perf_event_create_kernel_counter() takes attr.type as an input. But 
there's no way to look up the DSU PMU's "type".

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
