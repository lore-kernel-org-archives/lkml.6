Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeCLKVu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:21:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeCLKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:21:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93DF0607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
X-Google-Smtp-Source: AG47ELtuQsPXfytBNMZFTRz+1MvxH8DFhNbbiMqSezmhZyUM3y1qTCp76Hj+EbNiJ5bpAPg5F/1EUekfN1O+r+NR874=
MIME-Version: 1.0
In-Reply-To: <f6822915-8921-c9cc-218a-f094ac5ed032@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-5-vivek.gautam@codeaurora.org> <f3011ef1-7ffe-8c2b-b9d6-3fb094789656@arm.com>
 <CAFp+6iF1oM=fmRCqSG-SxcUVvvOLet_Y0p7pmGn+=B-LdMNiww@mail.gmail.com>
 <CAFp+6iFzGYWZMLkNrN1ZJJ2xH4CxQsiU6oYboHDzL0jDwm+4VQ@mail.gmail.com> <f6822915-8921-c9cc-218a-f094ac5ed032@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 12 Mar 2018 15:51:44 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGPWxRVUjiTW34eDoce55HZ0Y8EcKMCSyfg2RnHuX0zMw@mail.gmail.com>
Message-ID: <CAFp+6iGPWxRVUjiTW34eDoce55HZ0Y8EcKMCSyfg2RnHuX0zMw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
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

On Fri, Mar 9, 2018 at 6:04 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/03/18 07:11, Vivek Gautam wrote:
>>
>> On Thu, Mar 8, 2018 at 10:29 AM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>>
>>> On Wed, Mar 7, 2018 at 6:17 PM, Robin Murphy <robin.murphy@arm.com>
>>> wrote:
>>>>
>>>> On 02/03/18 10:10, Vivek Gautam wrote:
>>>>>
>>>>>
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> Finally add the device link between the master device and
>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>> master needs it. This is done from add_device callback which gets
>>>>> called once when the master is added to the smmu.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> ---
>>>>>    drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
>>>>>    1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>> index 3d6a1875431f..bb1ea82c1003 100644
>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>> @@ -217,6 +217,9 @@ struct arm_smmu_device {
>>>>>          /* IOMMU core code handle */
>>>>>          struct iommu_device             iommu;
>>>>> +
>>>>> +       /* runtime PM link to master */
>>>>> +       struct device_link *link;
>>>>
>>>>
>>>>
>>>> Just the one?
>>
>>
>> we will either have to count all the devices that are present on the
>> iommu bus, or
>> maintain a list to which all the links can be added.
>> But to add the list, we will have to initialize a LIST_HEAD in struct
>> device_link
>> as well.
>>
>> Or, I think we don't even need to maintain a pointer to link with smmu.
>> In arm_smmu_remove_device(), we can find out the correct link, and delete
>> it.
>>
>>          list_for_each_entry(link, &dev->links.suppliers, c_node)
>>                  if (link->supplier == smmu->dev);
>>                             device_link_del(link);
>>
>> Should that be fine?
>>
>> Rafael, does the above snippet looks right to you? Context: smmu->dev
>> is the supplier, and dev is the consumer. We want to find the link,
>> and delete it.
>
>
> Actually, looking at the existing code, it seems like device_link_add() will
> in fact look up and return any existing link between a given supplier and
> consumer - is that intentional API behaviour that users may rely on to avoid
> keeping track of explicit link pointers?
> (or conversely, might it be
> reasonable to factor out a device_link_find() function?)

Yea, that sounds better.

regards
Vivek

>
> Robin.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
