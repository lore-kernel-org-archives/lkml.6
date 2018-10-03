Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B76C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6C52098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6C52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJCQez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:34:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeJCQez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:34:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DFFA18A;
        Wed,  3 Oct 2018 02:47:17 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E473F5B7;
        Wed,  3 Oct 2018 02:47:14 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838793F4E@FRAEML521-MBX.china.huawei.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <6d51a825-325f-5f78-20da-bf27f208fe37@arm.com>
Date:   Wed, 3 Oct 2018 10:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838793F4E@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 09:46, Shameerali Kolothum Thodi wrote:
[...]
>>> +	/* Verify specified event is supported on this PMU */
>>> +	event_id = get_event(event);
>>> +	if (((event_id < SMMU_ARCH_MAX_EVENT_ID) &&
>>> +	    (!test_bit(event_id, smmu_pmu->supported_events))) ||
>>> +	    (event_id > SMMU_IMPDEF_MAX_EVENT_ID)) {
>>
>>> = ?
> 
> I was slightly confused by the spec here as it says,
> 
> Performance events are indicated by a numeric ID, in the following ranges:
> • 0x0000 to 0x007F: Architected events
> • 0x0080 to 0xFFFF: IMPLEMENTATION DEFINED events
> 
> It looks to me the ids are valid including those limits.

Yes my mistake, I mixed up IMPDEF_MAX_EVENT_ID which is inclusive with
ARCH_MAX_EVENT_ID which isn't, sorry about that

[...]
>>> +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
>>
>> You can probably remove "PMU @%pa" from error and info messages, since
>> the device name already uniquely identifies it:
>> "[    6.168200] arm-smmu-v3-pmu 2b442000.smmu-pmcg: Registered SMMU
>> PMU
>> @ 0x000000002b442000 using 4 counters"
> 
> Interesting. What I have is,
> 
> [   25.669636] arm-smmu-v3-pmu arm-smmu-v3-pmu.6.auto: Registered SMMU
> PMU @ 0x0000000148001000 using 8 counters
> 
> Are you using the same patches and is booting using ACPI? IIRC, in the iort
> code  it uses the name "arm-smmu-v3-pmu" and AUTO id to register/add the platform
> dev. So not sure, how it is printing the address in your case. 
> 
> Please check and let me know.

Right, I've been using device tree for my tests, not ACPI. I thought it
was the core platform code that was creating the names. I guess we could
add nicer names to IORT but that's probably for a different series, so
nevermind.

Thanks,
Jean
