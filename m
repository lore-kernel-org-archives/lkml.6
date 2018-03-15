Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCOI5c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:57:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeCOI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:57:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AE5460AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
X-Google-Smtp-Source: AG47ELtzTZmC+//C5dXpGWJUavugmiW5LMUkg22XgAV2vTxln3MVzO5WLNZ/wThn38e0u8UOQs7andIYhwn893jvnb0=
MIME-Version: 1.0
In-Reply-To: <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-5-vivek.gautam@codeaurora.org> <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 15 Mar 2018 14:27:26 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w@mail.gmail.com>
Message-ID: <CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On Wed, Mar 14, 2018 at 11:20 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/03/18 08:55, Vivek Gautam wrote:
>>
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> Finally add the device link between the master device and
>> smmu, so that the smmu gets runtime enabled/disabled only when the
>> master needs it. This is done from add_device callback which gets
>> called once when the master is added to the smmu.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 56a04ae80bf3..64953ff2281f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
>>         iommu_device_link(&smmu->iommu, dev);
>>   +     if (pm_runtime_enabled(smmu->dev)) {
>> +               struct device_link *link;
>> +
>> +               /*
>> +                * Establish the link between smmu and master, so that the
>> +                * smmu gets runtime enabled/disabled as per the master's
>> +                * needs.
>> +                */
>> +               link = device_link_add(dev, smmu->dev,
>> DL_FLAG_PM_RUNTIME);
>> +               if (!link) {
>
>
> FWIW, given that we don't really care about link itself, I'd be quite happy
> to simplify that lot down to:
>
>         if (pm_runtime_enabled(smmu_dev) &&
>             !device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME)) {

Sure, will update this.

>
>> +                       dev_warn(smmu->dev,
>> +                                "Unable to add link to the consumer
>> %s\n",
>> +                                dev_name(dev));
>
>
> (side note: since device_link_add() already prints a message on success,
> maybe it could print its own failure message too?)

Should we make device_link that verbose - to print failure messages at
each step (there are atleast a couple where we return link as NULL),
or we can let the users handle printing the message?

regards
Vivek

>
> Robin.
>
>
>> +                       ret = -ENODEV;
>> +                       goto out_unlink;
>> +               }
>> +       }
>> +
>>         arm_smmu_rpm_put(smmu);
>>         return 0;
>>   +out_unlink:
>> +       iommu_device_unlink(&smmu->iommu, dev);
>> +       arm_smmu_master_free_smes(fwspec);
>>   out_rpm_put:
>>         arm_smmu_rpm_put(smmu);
>>   out_cfg_free:
>> @@ -1486,6 +1507,14 @@ static void arm_smmu_remove_device(struct device
>> *dev)
>>         cfg  = fwspec->iommu_priv;
>>         smmu = cfg->smmu;
>>   +     if (pm_runtime_enabled(smmu->dev)) {
>> +               struct device_link *link;
>> +
>> +               link = device_link_find(dev, smmu->dev);
>> +               if (link)
>> +                       device_link_del(link);
>> +       }
>> +
>>         ret = arm_smmu_rpm_get(smmu);
>>         if (ret < 0)
>>                 return;
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
