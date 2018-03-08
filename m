Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965527AbeCHE75 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:59:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965466AbeCHE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D171260618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
X-Google-Smtp-Source: AG47ELtaxhGAYiI1FqAq7hYDl1lwZDOxDSh/FV4ZLPkdBuLuOgvZXcHdSbaAFZMm9TownnmzKdACMz5sSNU8Jlf76B4=
MIME-Version: 1.0
In-Reply-To: <f3011ef1-7ffe-8c2b-b9d6-3fb094789656@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-5-vivek.gautam@codeaurora.org> <f3011ef1-7ffe-8c2b-b9d6-3fb094789656@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 8 Mar 2018 10:29:47 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF1oM=fmRCqSG-SxcUVvvOLet_Y0p7pmGn+=B-LdMNiww@mail.gmail.com>
Message-ID: <CAFp+6iF1oM=fmRCqSG-SxcUVvvOLet_Y0p7pmGn+=B-LdMNiww@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, jcrouse@codeaurora.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:17 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/03/18 10:10, Vivek Gautam wrote:
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
>> ---
>>   drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 3d6a1875431f..bb1ea82c1003 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -217,6 +217,9 @@ struct arm_smmu_device {
>>         /* IOMMU core code handle */
>>         struct iommu_device             iommu;
>> +
>> +       /* runtime PM link to master */
>> +       struct device_link *link;
>
>
> Just the one?
>
>>   };
>>     enum arm_smmu_context_fmt {
>> @@ -1470,10 +1473,26 @@ static int arm_smmu_add_device(struct device *dev)
>>         iommu_device_link(&smmu->iommu, dev);
>>   +     /*
>> +        * Establish the link between smmu and master, so that the
>> +        * smmu gets runtime enabled/disabled as per the master's
>> +        * needs.
>> +        */
>> +       smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>
>
> Maybe I've misunderstood how the API works, but AFAICS the second and
> subsequent devices are all just going to overwrite (and leak) the link of
> the previous one...

Sorry, my bad. Will take care of this.

regards
Vivek

>
>> +       if (!smmu->link) {
>> +               dev_warn(smmu->dev, "Unable to create device link between
>> %s and %s\n",
>> +                        dev_name(smmu->dev), dev_name(dev));
>> +               ret = -ENODEV;
>> +               goto out_unlink;
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
>> @@ -1496,6 +1515,8 @@ static void arm_smmu_remove_device(struct device
>> *dev)
>>         cfg  = fwspec->iommu_priv;
>>         smmu = cfg->smmu;
>>   +     device_link_del(smmu->link);
>
>
> ...and equivalently you end up with a double-free (or more) here of a link
> which may not have belonged to dev anyway.
>
> Robin.
>
>
>> +
>>         ret = arm_smmu_rpm_get(smmu);
>>         if (ret < 0)
>>                 return;
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
