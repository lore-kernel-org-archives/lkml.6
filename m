Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E08520846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E08520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbeGZQsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:48:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58236 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbeGZQsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58ED515A2;
        Thu, 26 Jul 2018 08:30:57 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C187B3F575;
        Thu, 26 Jul 2018 08:30:54 -0700 (PDT)
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
 <20180719101539.6104-2-vivek.gautam@codeaurora.org>
 <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
 <CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
 <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <401d8509-b9ad-913b-334e-f4ac853472e3@arm.com>
Date:   Thu, 26 Jul 2018 16:30:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/18 08:12, Vivek Gautam wrote:
> On Wed, Jul 25, 2018 at 11:46 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> On Tue, Jul 24, 2018 at 8:51 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> On 19/07/18 11:15, Vivek Gautam wrote:
>>>>
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> The smmu needs to be functional only when the respective
>>>> master's using it are active. The device_link feature
>>>> helps to track such functional dependencies, so that the
>>>> iommu gets powered when the master device enables itself
>>>> using pm_runtime. So by adapting the smmu driver for
>>>> runtime pm, above said dependency can be addressed.
>>>>
>>>> This patch adds the pm runtime/sleep callbacks to the
>>>> driver and also the functions to parse the smmu clocks
>>>> from DT and enable them in resume/suspend.
>>>>
>>>> Also, while we enable the runtime pm add a pm sleep suspend
>>>> callback that pushes devices to low power state by turning
>>>> the clocks off in a system sleep.
>>>> Also add corresponding clock enable path in resume callback.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>>> [vivek: rework for clock and pm ops]
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>> ---
>>>>
>>>> Changes since v12:
>>>>    - Added pm sleep .suspend callback. This disables the clocks.
>>>>    - Added corresponding change to enable clocks in .resume
>>>>     pm sleep callback.
>>>>
>>>>    drivers/iommu/arm-smmu.c | 75
>>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 73 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index c73cfce1ccc0..9138a6fffe04 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
> 
> [snip]
> 
>>>> platform_device *pdev)
>>>>          arm_smmu_device_remove(pdev);
>>>>    }
>>>>    +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>> +{
>>>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>> +
>>>> +       return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>
>>>
>>> If there's a power domain being automatically switched by genpd then we need
>>> a reset here because we may have lost state entirely. Since I remembered the
>>> otherwise-useless GPU SMMU on Juno is in a separate power domain, I gave it
>>> a poking via sysfs with some debug stuff to dump sCR0 in these callbacks,
>>> and the problem is clear:
>>>
>>> ...
>>> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
>>> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
>>> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
>>> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
>>> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
>>> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
>>> ...
>>
>> Qualcomm SoCs have retention enabled for SMMU registers so they don't
>> lose state.
>> ...
>> [  256.013367] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>> SCR0 = 0x201e36
>> [  256.013367]
>> [  256.019160] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>> SCR0 = 0x201e36
>> [  256.019160]
>> [  256.027368] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>> SCR0 = 0x201e36
>> [  256.027368]
>> [  256.036786] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>> SCR0 = 0x201e36
>> ...
>>
>> However after adding arm_smmu_device_reset() in runtime_resume() I observe
>> some performance degradation when kill an instance of 'kmscube' and
>> start it again.
>> The launch time with arm_smmu_device_reset() in runtime_resume() change is
>> more.
>> Could this be because of frequent TLB invalidation and sync?

Probably. Plus the reset procedure is a big chunk of MMIO accesses, 
which for a non-trivial SMMU configuration probably isn't negligible in 
itself. Unfortunately, unless you know for absolute certain that you 
don't need to do that, you do.

> Some more information that i gathered.
> On Qcom SoCs besides the registers retention, TCU invalidates TLB cache on
> a CX power collapse exit, which is the system wide suspend case.
> The arm-smmu software is not aware of this CX power collapse /
> auto-invalidation.
> 
> So wouldn't doing an explicit TLB invalidations during runtime resume be
> detrimental to performance?

Indeed it would be, but resuming with TLBs full of random valid-looking 
junk is even more so.

> I have one more doubt here -
> We do runtime power cycle around arm_smmu_map/unmap() too.
> Now during map/unmap we selectively do TLB maintenance (either
> tlb_sync or tlb_add_flush).
> But with runtime pm we want to do TLBIALL*. Is that a problem?

It's technically redundant to do both, true, but as we've covered in 
previous rounds of discussion it's very difficult to know *which* one is 
sufficient at any given time, so in order to make progress for now I 
think we have to settle with doing both.

Robin.
