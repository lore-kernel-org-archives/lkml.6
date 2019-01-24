Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEACC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BCC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfAXSZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:25:24 -0500
Received: from foss.arm.com ([217.140.101.70]:33946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAXSZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:25:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB75FA78;
        Thu, 24 Jan 2019 10:25:23 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54AC93F237;
        Thu, 24 Jan 2019 10:25:21 -0800 (PST)
Subject: Re: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
To:     Andrew Murray <andrew.murray@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
 <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
Date:   Thu, 24 Jan 2019 18:25:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2019 12:14, Andrew Murray wrote:
[...]
>>>> +static inline void smmu_pmu_counter_set_value(struct smmu_pmu
>>> *smmu_pmu,
>>>> +					      u32 idx, u64 value)
>>>> +{
>>>> +	if (smmu_pmu->counter_mask & BIT(32))
>>>> +		writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 8));
>>>> +	else
>>>> +		writel(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 4));
>>>
>>> The arm64 IO macros use __force u32 and so it's probably OK to provide a 64
>>> bit
>>> value to writel. But you could use something like lower_32_bits for clarity.
>>
>> Yes, macro uses __force u32. I will change it to make it more clear though.

To be pedantic, the first cast which the value actually undergoes is to 
(__u32) ;)

Ultimately, __raw_writel() takes a u32, so in that sense it's never a 
problem to pass a u64, since unsigned truncation is well-defined in the 
C standard. The casting involved in the I/O accessors is mostly about 
going to an endian-specific type and back again.

[...]
>>>> +static void smmu_pmu_event_start(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +	u32 filter_span, filter_sid;
>>>> +	u32 evtyper;
>>>> +
>>>> +	hwc->state = 0;
>>>> +
>>>> +	smmu_pmu_set_period(smmu_pmu, hwc);
>>>> +
>>>> +	smmu_pmu_get_event_filter(event, &filter_span, &filter_sid);
>>>> +
>>>> +	evtyper = get_event(event) |
>>>> +		  filter_span << SMMU_PMCG_SID_SPAN_SHIFT;
>>>> +
>>>> +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
>>>> +	smmu_pmu_set_smr(smmu_pmu, idx, filter_sid);
>>>> +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
>>>> +	smmu_pmu_counter_enable(smmu_pmu, idx);
>>>> +}
>>>> +
>>>> +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +
>>>> +	if (hwc->state & PERF_HES_STOPPED)
>>>> +		return;
>>>> +
>>>> +	smmu_pmu_counter_disable(smmu_pmu, idx);
>>>
>>> Is it intentional not to call smmu_pmu_interrupt_disable here?
>>
>> Yes, it is. Earlier patch had the interrupt toggling and Robin pointed out that
>> it is not really needed as counters are anyway stopped and explicitly disabling
>> may not solve the spurious interrupt case as well.
>>
> 
> Ah apologies for not seeing that in earlier reviews.

Hmm, I didn't exactly mean "keep enabling it every time an event is 
restarted and never disable it anywhere", though. I was thinking more 
along the lines of enabling in event_add() and disabling in event_del() 
(i.e. effectively tying it to allocation and deallocation of the counter).

Robin.
