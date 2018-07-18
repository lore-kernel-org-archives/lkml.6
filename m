Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C439ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3362075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3362075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeGRNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:21:13 -0400
Received: from foss.arm.com ([217.140.101.70]:33472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeGRNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:21:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080967A9;
        Wed, 18 Jul 2018 05:43:27 -0700 (PDT)
Received: from [10.1.211.22] (e110467-lin.cambridge.arm.com [10.1.211.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950323F318;
        Wed, 18 Jul 2018 05:43:24 -0700 (PDT)
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, robh+dt <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org>
 <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <48139f68-5a79-8531-00fa-fbdd787f50f5@arm.com>
Date:   Wed, 18 Jul 2018 13:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/18 10:30, Vivek Gautam wrote:
> On Wed, Jul 11, 2018 at 3:23 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Lukas Wunner <lukas@wunner.de>
>>> ---
>>>
>>>   - Change since v11
>>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>
>>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 09265e206e2d..916cde4954d2 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>
>>>        iommu_device_link(&smmu->iommu, dev);
>>>
>>> +     if (pm_runtime_enabled(smmu->dev) &&
>>
>> Why does the creation of the link depend on whether or not runtime PM
>> is enabled for the MMU device?
>>
>> What about system-wide PM and system shutdown?  Are they always guaranteed
>> to happen in the right order without the link?
> 
> Hi Robin,
> 
> As Rafael pointed, we should the device link creation should not depend on
> runtime PM being enabled or not, as we would also want to guarantee
> that system wide PM callbacks are called in the right order for smmu
> and clients.
> 
> Does this change of removing the check for pm_runtime_enabled() from here
> looks okay to you?

FWIW the existing system PM ops make no claim to be perfect, and I 
wouldn't be at all surprised if it was only by coincidence that my 
devices happened to put on the relevant lists in the right order to 
start with. If we no longer need to worry about explicit device_link 
housekeeping in the SMMU driver, then creating them unconditionally 
sounds like the sensible thing to do. I'd be inclined to treat failure 
as non-fatal like we do for the sysfs link, though, since it's another 
thing that correct SMMU operation doesn't actually depend on (at this 
point we don't necessarily know if this consumer even has a driver at all).

> FYI, as discussed in the first patch [1] of this series, I will add a
> system wide
> suspend callback - arm_smmu_pm_suspend, that would do clock disable, and will
> add corresponding clock enable calls in arm_smmu_pm_resume().

OK, I still don't really understand the finer points of how system PM 
and runtime PM interact, but if making it robust is just a case of 
calling the runtime suspend/resume hooks as appropriate from the system 
ones, that sounds reasonable.

Robin.

> 
> [1] https://lore.kernel.org/patchwork/patch/960460/
> 
> 
> Best regards
> Vivek
> 
>>
>>> +         !device_link_add(dev, smmu->dev,
>>> +                     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>>> +             dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
>>> +                     dev_name(dev));
>>> +             ret = -ENODEV;
>>> +             goto out_unlink;
>>> +     }
>>> +
>>>        return 0;
>>>
>>> +out_unlink:
>>> +     iommu_device_unlink(&smmu->iommu, dev);
>>> +     arm_smmu_master_free_smes(fwspec);
>>>   out_cfg_free:
>>>        kfree(cfg);
>>>   out_free:
>>>
>>
>>
> 
> 
> 
