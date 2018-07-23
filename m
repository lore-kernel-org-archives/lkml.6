Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69420858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jbTUxBET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF69420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbeGWG7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:59:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43772 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeGWG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:59:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180723060002euoutp011caac08cb03c30c689becbc56b9b050d~D6gRKJ2g60858508585euoutp01A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 06:00:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180723060002euoutp011caac08cb03c30c689becbc56b9b050d~D6gRKJ2g60858508585euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532325602;
        bh=xx7bao1cLC2MiUgLcKSRsGErJSR52rxRfwPH+lphfFw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jbTUxBET8UXXGYRx3wpTRlUdrP87uiSn2MWfqr5DYzioAuqS9ibj3T42TdIl4POS5
         SoID8M4XWU+n9ndhzJRYAhEDHMIo/zavZJKdJFZ+FD2nQzwvUDFqQP0v8jTZdqFXOr
         qyWfq2Ukc3+vm8zVlIMYagTAiSGMkWCK6gCBGQ4U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180723060000eucas1p2d15aa85f9b6ae6c95315a306873fa501~D6gPz_DjV2290822908eucas1p2I;
        Mon, 23 Jul 2018 06:00:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.6C.61560.0EE655B5; Mon, 23
        Jul 2018 07:00:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R;
        Mon, 23 Jul 2018 05:59:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180723055959eusmtrp1bd499c61c46efbe9c12c2bdaa8d4232b~D6gORZLa71384313843eusmtrp1l;
        Mon, 23 Jul 2018 05:59:59 +0000 (GMT)
X-AuditID: cbfec7f5-1edff7000002f078-93-5b556ee07b65
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.79.04178.FDE655B5; Mon, 23
        Jul 2018 06:59:59 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180723055958eusmtip2259bccf4b1f7e2f79a8d989215ae526c~D6gNXQ4qO1457814578eusmtip2g;
        Mon, 23 Jul 2018 05:59:58 +0000 (GMT)
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 23 Jul 2018 07:59:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g0NwkLmd=tJ0sT4pc8FJSRE8sEu5GRQ7KUUd+YedzjMg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxNcRj2O+fcc0/ltl+X9C4Nu8N8RFFrvy0ZG3P4I8xtKJNLR6zuxb0V
        9Udr+UrlI6ZyS8VKlnwUkqZSLpdV1K1oSJnLrXSllWgoHcdH/z3v8zzv3ufZXo5WprDu3G5d
        lKDXaSJVrCNT9mj42YJOXVCId07vTDI0msqSxCS7jOSanspItq0Bkbxqf1KSF0GOZd2Qk7Tq
        BjlprshmycBxEyIFL5oocn7wLE3q6ywyYrvwjSaHK01yUvPZKiMjz0sYMpiWxJCBwyMseTxc
        TpPu/sfMMlfeWpND8cU5xYjPSmhi+OYTxyn+rrFdzpcWHWP5jhQzxZ9pK0R8X1Ury99qPcrw
        A6XT1jkFOy4JEyJ3xwh6r6XbHHdVN1xm9xYGHrAU9bAJqCsgGTlwgH3hgekVm4wcOSW+jCDl
        2ltKFJR4EEH3RxdJGEBgyrxL/91oybBRklCI4OTVDzJp6ENwpa1bLrom4ZVgyxlFIp6M50P+
        xVZaNNG4g4WnL1MYUWDxIki2J48d5zgGz4KbbWEidMVb4HuFv+hQYBd4cs762+2A10P9w8zf
        mMbT4Y49m5awG7y05lJSuPsc/HzvI+3GQGNaOyPxK6C9tksu4UnQY771B3tA3ZlURowG+CCC
        o5lGuTSkIridXc5KLn94YG6SieFoPBeuV3hJ9HIo+fCZEmnAztBmd5HyOMPpsgxaohWQdEQp
        uWeD0Xzt39maRgt9CqmM41oaxzUzjmtm/H83DzFFyE2INmjDBYOPTti/0KDRGqJ14Qt37NGW
        orEXrRsxfylHVT+21yLMIdVExTe7OkQp08QYYrW1CDhaNVlhYYNClIowTWycoN8Tqo+OFAy1
        aCrHqNwUW+fEBytxuCZKiBCEvYL+r0pxDu4JqCBUcUjr+Wl+C9tQ2b8hZMgpK8PTO8nBY/8X
        btMEsurd+iFbb8kl99DR3vSW04lV6WF+r8vVam+/WebZRzbXX8qNc07PClYXpM/omxIfuLa9
        +Pqhe1s91Uymb2vZm9VfA+Ks1L6l4U7yidPyvTYGTt2ZELlyzc/4NaFqvrOyd7GvZbGKMezS
        LJpH6w2aX+WlycueAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XYuOzMHx6n0IZUy6I/R9Hjbp+nIyDpBV7J+aGXDndR0m+5s
        lv2y6DatSMKsadMiqcwoL6SFNlzeQi28TK0sEVZT6eQVyQht0wL/Pbzf87zwwUthsnIigMrQ
        GTmDTp0lJ73wrqWOr1tHdUeSQ13nvdHC8jUSXbgqEKi89T2Bylw9AFXYtqGaikxkLn0hRkW2
        HjHqf11GornrrQBVDvWK0L35Ygx1d/URyHX/F4YuNbeKUcu0k0BLgzU4mi+6iqO5S0sk6lxs
        xNDETCe+3Z91tlhFbLW1GrCl+b0423/juoh9ZfkiZmurzCQ7WtghYm8NPwLs1BsHydY7ruDs
        XO2mg+uSFLEGvcnIBaXreWOcPJlBYQomGinCIqIVTLjyeExYpDxEFavhsjJyOUOI6qQi3dbz
        mMx+tP9sX9UkmQ/G4wqAhIJ0BBwocYk8LKMrAfzTvm91vgG+u51PrLIv/DNYQBYAL7cjAPh0
        3rry4EsnQJd1GXjYj94CHz5wYB4Jo7+RcKDZTqwWizgsavq9YpE0AwsEzyoJJaVVcG5gzC1R
        FE5vhnXDGs/Ynz4G225d/Kf4wHd3nbiHJfQh2N12Z4UxOgpa68awVQ6EDULZP14PPznLRTeB
        zLImt6xJLGsSy5qkAuBVwI8z8do0Lc8oeLWWN+nSFKl6bS1wH8fL9sW6RtBXc9gOaArIvaW/
        hMRkGaHO5fO0dgApTO4n7SOPJMukGnXeOc6gTzGYsjjeDiLdfyvCAvxT9e5T0xlTmEhGiaIZ
        ZbgyPArJ10s/hOYlyeg0tZHL5LhszvC/E1GSgHwQ8FxfHX+adAg5y0EdcTt8/D93KqciYxKM
        V+qJQMnk7AEhO9i8e0GcWDa2sNXy0znEjljaMifSzUddCZdPqeQj49OOplKb8Ufd0erZ3Ik9
        M/FImvM9+yNRvGDeuPOEQzM1ufeQqe1Mk2ro97NFp/D2SV6gUBLSMGDHnhKGXYVynE9XM8GY
        gVf/BVyoMwMyAwAA
Message-Id: <20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R@eucas1p1.samsung.com>
X-CMS-MailID: 20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d
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
        <20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
        <CAJZ5v0g0NwkLmd=tJ0sT4pc8FJSRE8sEu5GRQ7KUUd+YedzjMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018-07-11 22:36, Rafael J. Wysocki wrote:
> On Wed, Jul 11, 2018 at 3:40 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi Tomasz,
>>
>> On 2018-07-11 14:51, Tomasz Figa wrote:
>>> On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>> On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>>>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>>>
>>>>>>> The smmu needs to be functional only when the respective
>>>>>>> master's using it are active. The device_link feature
>>>>>>> helps to track such functional dependencies, so that the
>>>>>>> iommu gets powered when the master device enables itself
>>>>>>> using pm_runtime. So by adapting the smmu driver for
>>>>>>> runtime pm, above said dependency can be addressed.
>>>>>>>
>>>>>>> This patch adds the pm runtime/sleep callbacks to the
>>>>>>> driver and also the functions to parse the smmu clocks
>>>>>>> from DT and enable them in resume/suspend.
>>>>>>>
>>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>>>>>> [vivek: Clock rework to request bulk of clocks]
>>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>>    - No change since v11.
>>>>>>>
>>>>>>>    drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>>    1 file changed, 58 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>>> index f7a96bcf94a6..a01d0dde21dd 100644
>>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>>> @@ -48,6 +48,7 @@
>>>>>>>    #include <linux/of_iommu.h>
>>>>>>>    #include <linux/pci.h>
>>>>>>>    #include <linux/platform_device.h>
>>>>>>> +#include <linux/pm_runtime.h>
>>>>>>>    #include <linux/slab.h>
>>>>>>>    #include <linux/spinlock.h>
>>>>>>>
>>>>>>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>>>>>>         u32                             num_global_irqs;
>>>>>>>         u32                             num_context_irqs;
>>>>>>>         unsigned int                    *irqs;
>>>>>>> +     struct clk_bulk_data            *clks;
>>>>>>> +     int                             num_clks;
>>>>>>>
>>>>>>>         u32                             cavium_id_base; /* Specific to Cavium */
>>>>>>>
>>>>>>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>>>>>>    struct arm_smmu_match_data {
>>>>>>>         enum arm_smmu_arch_version version;
>>>>>>>         enum arm_smmu_implementation model;
>>>>>>> +     const char * const *clks;
>>>>>>> +     int num_clks;
>>>>>>>    };
>>>>>>>
>>>>>>>    #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>>>>>>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>>>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>>>>
>>>>>>>    ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>>>>>>    ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>>>>>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>>>>>>    };
>>>>>>>    MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>>>>>>
>>>>>>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>>>>>>> +                                const char * const *clks)
>>>>>>> +{
>>>>>>> +     int i;
>>>>>>> +
>>>>>>> +     if (smmu->num_clks < 1)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>>>>>>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>>>>>>> +     if (!smmu->clks)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     for (i = 0; i < smmu->num_clks; i++)
>>>>>>> +             smmu->clks[i].id = clks[i];
>>>>>>> +}
>>>>>>> +
>>>>>>>    #ifdef CONFIG_ACPI
>>>>>>>    static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>>>>>>    {
>>>>>>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>>>>>>         data = of_device_get_match_data(dev);
>>>>>>>         smmu->version = data->version;
>>>>>>>         smmu->model = data->model;
>>>>>>> +     smmu->num_clks = data->num_clks;
>>>>>>> +
>>>>>>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>>>>>>
>>>>>>>         parse_driver_options(smmu);
>>>>>>>
>>>>>>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>>>>                 smmu->irqs[i] = irq;
>>>>>>>         }
>>>>>>>
>>>>>>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>>>>>> +     if (err)
>>>>>>> +             return err;
>>>>>>> +
>>>>>>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>>>>>>> +     if (err)
>>>>>>> +             return err;
>>>>>>> +
>>>>>>>         err = arm_smmu_device_cfg_probe(smmu);
>>>>>>>         if (err)
>>>>>>>                 return err;
>>>>>>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>>>>>
>>>>>>>         /* Turn the thing off */
>>>>>>>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>>>>> +
>>>>>>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>>>>>> +
>>>>>>>         return 0;
>>>>>>>    }
>>>>>>>
>>>>>>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>>>>>>         return 0;
>>>>>>>    }
>>>>>>>
>>>>>>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>>>>>>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>>>>> +{
>>>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>>>>>> +{
>>>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>>>>>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>>>>>> This is suspicious.
>>>>>>
>>>>>> If you need a runtime suspend method, why do you think that it is not necessary
>>>>>> to suspend the device during system-wide transitions?
>>>>> Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
>>>>> In that case the clocks have to be enabled in the resume path too.
>>>>>
>>>>> I remember Tomasz pointed to that we shouldn't need clock enable in resume
>>>>> path [1].
>>>>>
>>>>> [1] https://lkml.org/lkml/2018/3/15/60
>>> That was an answer for a different question. I don't remember
>>> suggesting having no suspend function. Although, given the PM
>>> subsystem internals, the suspend function wouldn't be called on SMMU
>>> implementation needed power control (since they would have runtime PM
>>> enabled) and on others, it would be called but do nothing (since no
>>> clocks).
>>>
>>>> Honestly, I just don't know. :-)
>>>>
>>>> It just looks odd the way it is done.  I think the clock should be
>>>> gated during system-wide suspend too, because the system can spend
>>>> much more time in a sleep state than in the working state, on average.
>>>>
>>>> And note that you cannot rely on runtime PM to always do it for you,
>>>> because it may be disabled at a client device or even blocked by user
>>>> space via power/control in sysfs and that shouldn't matter for
>>>> system-wide PM.
>>> User space blocking runtime PM through sysfs is a good point. I'm not
>>> 100% sure how the PM subsystem deals with that in case of system-wide
>>> suspend. I guess for consistency and safety, we should have the
>>> suspend callback.
>> Frankly, if there are no other reasons I suggest to wire system
>> suspend/resume to pm_runtime_force_* helpers:
>> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>                           pm_runtime_force_resume).
> Not a good idea at all IMO.
>
> Use PM driver flags rather I'd say.

Frankly, till now I wasn't aware of the DPM_FLAG_* in struct dev_pm_info
'driver_flags'. I've briefly checked them but I don't see the equivalent
of using SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
pm_runtime_force_resume): keep device suspend if it was runtime suspended
AND really call pm_runtime_suspend if it was not runtime suspended on
system suspend.

>> This way you will have everything related to suspending and resuming in
>> one place and you would not need to bother about all possible cases (like
>> suspending from runtime pm active and suspending from runtime pm suspended
>> cases as well as restoring proper device state on resume). This is
>> especially important in recent kernel releases, where devices are
>> system-suspended regardless their runtime pm states (in older kernels
>> devices were first runtime resumed for system suspend, what made code
>> simpler, but wasn't best from power consumption perspective).
>>
>> If you go this way, You only need to ensure that runtime resume will also
>> restore proper device state besides enabling all the clocks. This will
>> also prepare your driver to properly operate inside power domain, where it
>> is possible for device to loose its internal state after runtime suspend
>> when respective power domain has been turned off.
> I'm not sure if you are aware of the pm_runtime_force_* limitations, though.

What are those limitations?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

