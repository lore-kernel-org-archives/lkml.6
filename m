Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D3320873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pZftjFoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D3320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeGKNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:45:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45382 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeGKNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:45:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180711134057euoutp02f8b9aca0bd491a25550cc96c3e070f13~AVDRuSQg10739307393euoutp020
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:40:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180711134057euoutp02f8b9aca0bd491a25550cc96c3e070f13~AVDRuSQg10739307393euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531316457;
        bh=736dNNRM35lOQDtEUj+kkfiIyx+D6I6avRgzDdGbccA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pZftjFoECzNDaHFYaGRp0bmWbOMtydc0Ot7OZTeqNDyyVM8TzcAkLSQhfKL9YMFjK
         N/rWQtLCPuzJTVT0zJMYGPAMxy7/PPHTyNtl9aX1NeGwsdmi5OjWK4Joi+qD2QZlCL
         PsFcCoxQkO9FGIKIv7/1tZgVYCkldRWTkQiY45og=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180711134055eucas1p2fee4aa7bf943e9323b073286497ab5b1~AVDQDCHkS2303123031eucas1p2p;
        Wed, 11 Jul 2018 13:40:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.78.17380.7E8064B5; Wed, 11
        Jul 2018 14:40:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n;
        Wed, 11 Jul 2018 13:40:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180711134054eusmtrp2b6ea2e4908fd878e70cbe6eb720832ba~AVDOthN2v0595405954eusmtrp2a;
        Wed, 11 Jul 2018 13:40:54 +0000 (GMT)
X-AuditID: cbfec7f4-b4fc79c0000043e4-ff-5b4608e79d74
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.68.04178.6E8064B5; Wed, 11
        Jul 2018 14:40:54 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180711134053eusmtip295f18e65b3bb51c2747d26c0ec23e530~AVDNu7_bg2480424804eusmtip2J;
        Wed, 11 Jul 2018 13:40:53 +0000 (GMT)
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Tomasz Figa <tfiga@chromium.org>, rafael@kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        Sricharan R <sricharan@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 11 Jul 2018 15:40:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt3t3d7VmP5eyj4qilfYgtSTqB0YUldwCo8dfalizLib5YnP2
        khqFpXM9TMyc81FkE9NMK9FRpjadZppmmWgl1WpmiSsllGrmvFj+d77zncM5H3wsJdMz89jo
        uEReFaeMUTDudFXT+HM/OxscvjqzzZv8nNAz5EzqkJgUWNrFxGhvQ6TwcRCpKDxC0nLvSkjG
        4zYJ6TIbGTJywYJI0etOEckbzaLIs9YXYmK/PkaRlEcWCal32MTE2V1Bk9GMVJqMpDgZ0jxe
        TZEv35vpTd6crT5fxJXmlyIuV9tJc10XL4i4GsNbCVdZksZw/elWEZfZY0LccO0rhrv/6jzN
        jVQu3DUrzH3DIT4mOolXBWw84H64sczCJJRuO9ZeeIPSoqp1OuTGAl4LzcZypEPurAwXIzDX
        GkXCMIogqyyPEoYRBOmXM8TTlqefKigXlmETgufNGkE0jOBZazFyLebibWDPn5jELOuFeTj3
        0s2lobCdgXvZOtqlYfAa0A3pGBemsQ98feeKZllvvA9+mYNctBR7QkuObUruhneDNe3WVAcK
        L4KzD3IpAcuh11Yw1RqwhQXHmx+0YE6Cqqv9SCi9Fepu11MCnguD1vsSAS+AiZpp81kE568Z
        JMKgR/DAWM0IqiB4Yu0Uu9pReAWUmwMEejNUfHZMlQbsAT1DnkIhD7hSlU0JtBRSz8kEtS8Y
        rHf+xdZ3vKAuI4VhxpmGGacZZpxm+J9biOgSJOc16tgoXh0Yxx/1Vytj1Zq4KP+D8bGVaPJH
        W53W0Wpk/h3ZgDCLFLOlHWNbw2ViZZL6eGwDApZSeEnXZU9S0kPK4yd4Vfx+lSaGVzeg+Syt
        kEsjlp8Kk+EoZSJ/hOcTeNX0VsS6zdOiLYGNAysjvTJ9Dn6U/THOcYrf7U3M3f2+z1G35ERR
        SKjdDMkLV/mmp+/s7o3ICekfPCpvkfuFajPNxYFDTb4rltXoN0WvHzdpbl6d32TOCtY597b4
        RT1cXbvT9OhaQZupTvtkz9LwSycHFn/L0nsncx8cBv32RtvpyPYdWrTq4XCfglYfVq5ZSanU
        yr95hqiWnwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7rPONyiDVo7uC2+/e9hs2jqeMtq
        Mf/IOVaLOc/PMlos2G9tsXFBtkXn7A3sFhP3n2W3uLxrDpvF594jjBZLr19kspj7ZSqzxZnT
        l1gtni/8wWzRuvcIu8XBD09YLf5d28hi8WViB4vF59Z/bBYnfu5gtnj58QSLg6jHk4PzmDzW
        zFvD6DG74SKLx+W+XiaPnbPusntsWtXJ5nG/+ziTx+Qbyxk93u+7yuax5Wo7i8fnTXIB3FF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GUfXHmEr
        WONacW7BIuYGxm1mXYycHBICJhKnnm5k7mLk4hASWMooMXfXKRaIhIzEyWkNrBC2sMSfa11s
        EEVvGSXmvH7EBpIQFnCVeD7vPyOILSKQKnFi538mkCJmgddsEps/v2SB6DjKLNHf9pwZpIpN
        wFCi620XWDevgJ3E3q9PwbpZBFQlXt+bwwRiiwrESByd3AJVIyhxcuYTsJM4BQIljncuAzuJ
        WcBMYt7mh8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yo
        V5yYW1yal66XnJ+7iRGYPLYd+7l5B+OljcGHGAU4GJV4eDV+u0QLsSaWFVfmHmKU4GBWEuE1
        mw4U4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgYssriTc0NTS3sDQ0NzY3NrNQEuc9b1AZ
        JSSQnliSmp2aWpBaBNPHxMEp1cC48P4tV9Mvnwz/m9/cv3HLqge1yqL1WZf5b66Sytni81tJ
        xu3enHyJj+0vNhjM2WR37PGFiS5POm3b7iTPO63tzuC+tCNZeP2jqw+lLs97UvrPtaWFJzDc
        O0hHNXRxz70LS+8GsZTYRnD8SJdrmaNlqbDpyI/j9hv9lR+GsdYYSTgrO74SE76qxFKckWio
        xVxUnAgAX8v/azQDAAA=
Message-Id: <20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
X-CMS-MailID: 20180711134054eucas1p208566383b25dd74787034929b3081901
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
        <20180708173413.1965-2-vivek.gautam@codeaurora.org>
        <17407514.unFVTGoGrn@aspire.rjw.lan>
        <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
        <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
        <CGME20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f@epcas1p3.samsung.com>
        <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 2018-07-11 14:51, Tomasz Figa wrote:
> On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> The smmu needs to be functional only when the respective
>>>>> master's using it are active. The device_link feature
>>>>> helps to track such functional dependencies, so that the
>>>>> iommu gets powered when the master device enables itself
>>>>> using pm_runtime. So by adapting the smmu driver for
>>>>> runtime pm, above said dependency can be addressed.
>>>>>
>>>>> This patch adds the pm runtime/sleep callbacks to the
>>>>> driver and also the functions to parse the smmu clocks
>>>>> from DT and enable them in resume/suspend.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>>>> [vivek: Clock rework to request bulk of clocks]
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>> ---
>>>>>
>>>>>   - No change since v11.
>>>>>
>>>>>   drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>   1 file changed, 58 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>> index f7a96bcf94a6..a01d0dde21dd 100644
>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>> @@ -48,6 +48,7 @@
>>>>>   #include <linux/of_iommu.h>
>>>>>   #include <linux/pci.h>
>>>>>   #include <linux/platform_device.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/spinlock.h>
>>>>>
>>>>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>>>>        u32                             num_global_irqs;
>>>>>        u32                             num_context_irqs;
>>>>>        unsigned int                    *irqs;
>>>>> +     struct clk_bulk_data            *clks;
>>>>> +     int                             num_clks;
>>>>>
>>>>>        u32                             cavium_id_base; /* Specific to Cavium */
>>>>>
>>>>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>>>>   struct arm_smmu_match_data {
>>>>>        enum arm_smmu_arch_version version;
>>>>>        enum arm_smmu_implementation model;
>>>>> +     const char * const *clks;
>>>>> +     int num_clks;
>>>>>   };
>>>>>
>>>>>   #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>>>>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>>
>>>>>   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>>>>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>>>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>>>>   };
>>>>>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>>>>
>>>>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>>>>> +                                const char * const *clks)
>>>>> +{
>>>>> +     int i;
>>>>> +
>>>>> +     if (smmu->num_clks < 1)
>>>>> +             return;
>>>>> +
>>>>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>>>>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>>>>> +     if (!smmu->clks)
>>>>> +             return;
>>>>> +
>>>>> +     for (i = 0; i < smmu->num_clks; i++)
>>>>> +             smmu->clks[i].id = clks[i];
>>>>> +}
>>>>> +
>>>>>   #ifdef CONFIG_ACPI
>>>>>   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>>>>   {
>>>>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>>>>        data = of_device_get_match_data(dev);
>>>>>        smmu->version = data->version;
>>>>>        smmu->model = data->model;
>>>>> +     smmu->num_clks = data->num_clks;
>>>>> +
>>>>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>>>>
>>>>>        parse_driver_options(smmu);
>>>>>
>>>>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>>                smmu->irqs[i] = irq;
>>>>>        }
>>>>>
>>>>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>>>> +     if (err)
>>>>> +             return err;
>>>>> +
>>>>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>>>>> +     if (err)
>>>>> +             return err;
>>>>> +
>>>>>        err = arm_smmu_device_cfg_probe(smmu);
>>>>>        if (err)
>>>>>                return err;
>>>>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>>>
>>>>>        /* Turn the thing off */
>>>>>        writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>>> +
>>>>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>>>> +
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>>>>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>>> +{
>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>> +
>>>>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>>> +}
>>>>> +
>>>>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>>>> +{
>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>> +
>>>>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>>>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>>>> This is suspicious.
>>>>
>>>> If you need a runtime suspend method, why do you think that it is not necessary
>>>> to suspend the device during system-wide transitions?
>>> Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
>>> In that case the clocks have to be enabled in the resume path too.
>>>
>>> I remember Tomasz pointed to that we shouldn't need clock enable in resume
>>> path [1].
>>>
>>> [1] https://lkml.org/lkml/2018/3/15/60
> That was an answer for a different question. I don't remember
> suggesting having no suspend function. Although, given the PM
> subsystem internals, the suspend function wouldn't be called on SMMU
> implementation needed power control (since they would have runtime PM
> enabled) and on others, it would be called but do nothing (since no
> clocks).
>
>> Honestly, I just don't know. :-)
>>
>> It just looks odd the way it is done.  I think the clock should be
>> gated during system-wide suspend too, because the system can spend
>> much more time in a sleep state than in the working state, on average.
>>
>> And note that you cannot rely on runtime PM to always do it for you,
>> because it may be disabled at a client device or even blocked by user
>> space via power/control in sysfs and that shouldn't matter for
>> system-wide PM.
> User space blocking runtime PM through sysfs is a good point. I'm not
> 100% sure how the PM subsystem deals with that in case of system-wide
> suspend. I guess for consistency and safety, we should have the
> suspend callback.

Frankly, if there are no other reasons I suggest to wire system
suspend/resume to pm_runtime_force_* helpers:
SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
                         pm_runtime_force_resume).

This way you will have everything related to suspending and resuming in
one place and you would not need to bother about all possible cases (like
suspending from runtime pm active and suspending from runtime pm suspended
cases as well as restoring proper device state on resume). This is
especially important in recent kernel releases, where devices are
system-suspended regardless their runtime pm states (in older kernels
devices were first runtime resumed for system suspend, what made code
simpler, but wasn't best from power consumption perspective).

If you go this way, You only need to ensure that runtime resume will also
restore proper device state besides enabling all the clocks. This will
also prepare your driver to properly operate inside power domain, where it
is possible for device to loose its internal state after runtime suspend
when respective power domain has been turned off.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

