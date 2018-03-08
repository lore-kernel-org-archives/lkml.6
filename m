Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966452AbeCHFdH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:33:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeCHFcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:32:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B66B6043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
X-Google-Smtp-Source: AG47ELtb9hzbLO0yPnKrW73SVJR8MfAiRw6ox63bNyP3u4al7G/k8KEhtyjc2N0iktAo3wQfLxQJcJC4NXaUwHZiwIY=
MIME-Version: 1.0
In-Reply-To: <d3500b33-8ce6-d767-7e9b-2fd75fea6cbb@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-2-vivek.gautam@codeaurora.org> <d3500b33-8ce6-d767-7e9b-2fd75fea6cbb@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 8 Mar 2018 11:02:49 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH7DdMnG2oMXWDGXNUjQsB1aPwOXEnrfHR-VoJzzqUPUA@mail.gmail.com>
Message-ID: <CAFp+6iH7DdMnG2oMXWDGXNUjQsB1aPwOXEnrfHR-VoJzzqUPUA@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] iommu/arm-smmu: Destroy domain context in failure path
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

On Wed, Mar 7, 2018 at 5:50 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/03/18 10:10, Vivek Gautam wrote:
>>
>> If we fail after initializing domain_context, we should destroy
>> the context to free up resources.
>
>
> Have another think about why the "problem" this patch caters for cannot ever
> happen (hint: consider how domain->smmu is used in
> arm_smmu_init_domain_context()). And then also about the really
> catastrophically bad problem it actually introduces (hint:
> "iommu_attach(domain, good_dev); iommu_attach(domain, bad_dev);")

Got it, we would end up destroying good_dev's domain context with this.
Thanks

regards
Vivek

>
> Robin.
>
>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>
>>   * New patch added in this series.
>>
>>   drivers/iommu/arm-smmu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 69e7c60792a8..ffc152c36002 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1223,11 +1223,16 @@ static int arm_smmu_attach_dev(struct iommu_domain
>> *domain, struct device *dev)
>>                 dev_err(dev,
>>                         "cannot attach to SMMU %s whilst already attached
>> to domain on SMMU %s\n",
>>                         dev_name(smmu_domain->smmu->dev),
>> dev_name(smmu->dev));
>> -               return -EINVAL;
>> +               ret = -EINVAL;
>> +               goto destroy_domain;
>>         }
>>         /* Looks ok, so add the device to the domain */
>>         return arm_smmu_domain_add_master(smmu_domain, fwspec);
>> +
>> +destroy_domain:
>> +       arm_smmu_destroy_domain_context(domain);
>> +       return ret;
>>   }
>>     static int arm_smmu_map(struct iommu_domain *domain, unsigned long
>> iova,
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
