Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCOGYE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:24:04 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39556 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeCOGYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:24:02 -0400
X-Google-Smtp-Source: AG47ELuStzZtiIQZkAPqxZ5iT+E+sxUlEhK1ShVkemXG9H7EJnDLmH1ouCSe6jahKGICVXd6tthuVw==
MIME-Version: 1.0
In-Reply-To: <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-5-vivek.gautam@codeaurora.org> <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 15 Mar 2018 15:18:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AqERQMLsJNLAsVXox79kZ+ZtpCUuMSutn70FGK-3Q7vw@mail.gmail.com>
Message-ID: <CAAFQd5AqERQMLsJNLAsVXox79kZ+ZtpCUuMSutn70FGK-3Q7vw@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 2:50 AM, Robin Murphy <robin.murphy@arm.com> wrote:
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
>
>> +                       dev_warn(smmu->dev,
>> +                                "Unable to add link to the consumer
>> %s\n",
>> +                                dev_name(dev));
>
>
> (side note: since device_link_add() already prints a message on success,
> maybe it could print its own failure message too?)

I think we care whether adding the link succeeded. If it fails to be
added, we might end up with a complete system lockup on a system with
power domains.

Best regards,
Tomasz
