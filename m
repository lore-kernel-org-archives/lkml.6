Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCOLMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:12:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37106 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOLMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:12:12 -0400
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        robh+dt <robh+dt@kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-5-vivek.gautam@codeaurora.org>
 <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
 <CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <63943de8-198d-32ff-36fe-c3f6c4c10f1d@arm.com>
Date: Thu, 15 Mar 2018 11:12:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/18 08:57, Vivek Gautam wrote:
> Hi Robin,
> 
> 
> On Wed, Mar 14, 2018 at 11:20 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 13/03/18 08:55, Vivek Gautam wrote:
>>>
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
>>> ---
>>>    drivers/iommu/arm-smmu.c | 29 +++++++++++++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 56a04ae80bf3..64953ff2281f 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
>>>          iommu_device_link(&smmu->iommu, dev);
>>>    +     if (pm_runtime_enabled(smmu->dev)) {
>>> +               struct device_link *link;
>>> +
>>> +               /*
>>> +                * Establish the link between smmu and master, so that the
>>> +                * smmu gets runtime enabled/disabled as per the master's
>>> +                * needs.
>>> +                */
>>> +               link = device_link_add(dev, smmu->dev,
>>> DL_FLAG_PM_RUNTIME);
>>> +               if (!link) {
>>
>>
>> FWIW, given that we don't really care about link itself, I'd be quite happy
>> to simplify that lot down to:
>>
>>          if (pm_runtime_enabled(smmu_dev) &&
>>              !device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME)) {
> 
> Sure, will update this.
> 
>>
>>> +                       dev_warn(smmu->dev,
>>> +                                "Unable to add link to the consumer
>>> %s\n",
>>> +                                dev_name(dev));
>>
>>
>> (side note: since device_link_add() already prints a message on success,
>> maybe it could print its own failure message too?)
> 
> Should we make device_link that verbose - to print failure messages at
> each step (there are atleast a couple where we return link as NULL),
> or we can let the users handle printing the message?

I didn't mean to imply anything more than the idea below (although the 
whole function could of course be refactored further to report explicit 
error values). It just seems a bit unbalanced for the core code to be 
noisy about success yet silent about failure, but ultimately that's an 
entirely separate issue which doesn't have to have any bearing on this 
series.

Robin.

----->8-----
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b2261f92f2f1..895da95f5cb9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -275,6 +275,9 @@ struct device_link *device_link_add(struct device 
*consumer,
   out:
  	device_pm_unlock();
  	device_links_write_unlock();
+	if (!link)
+		dev_warn(consumer, "Failed to link to supplier %s\n", 
dev_name(supplier));
+
  	return link;
  }
  EXPORT_SYMBOL_GPL(device_link_add);
