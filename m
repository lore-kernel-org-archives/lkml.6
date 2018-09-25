Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D8BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF12F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF12F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIZBEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:04:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57252 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeIZBEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:04:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE4CED1;
        Tue, 25 Sep 2018 11:55:51 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7163F5D3;
        Tue, 25 Sep 2018 11:55:47 -0700 (PDT)
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, robh+dt <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org>
 <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
 <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
 <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
 <CAFp+6iE3+qn6-gpXEzxfoP5yPMARmUcJNn0AZk-kA2AreTLnng@mail.gmail.com>
 <CAFp+6iHnHj_PkPFBUSTdJTW57K51wLqSEw6VOMKxAVo7O+ms9g@mail.gmail.com>
 <CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aedf3f32-68ae-566a-3735-ca4ec5c7559a@arm.com>
Date:   Tue, 25 Sep 2018 19:55:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 2018-09-25 6:56 AM, Vivek Gautam wrote:
> Hi Robin, Will,
> 
> On Tue, Sep 18, 2018 at 8:41 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> Hi Robin,
>>
>> On Fri, Sep 7, 2018 at 3:52 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>
>>> On Fri, Sep 7, 2018 at 3:22 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>>>
>>>> On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>>>
>>>>> Hi Tomasz,
>>>>>
>>>>>
>>>>> On 9/7/2018 2:46 PM, Tomasz Figa wrote:
>>>>>> Hi Vivek,
>>>>>>
>>>>>> On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
>>>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>>>
>>>>>>> The smmu device probe/remove and add/remove master device callbacks
>>>>>>> gets called when the smmu is not linked to its master, that is without
>>>>>>> the context of the master device. So calling runtime apis in those places
>>>>>>> separately.
>>>>>>> Global locks are also initialized before enabling runtime pm as the
>>>>>>> runtime_resume() calls device_reset() which does tlb_sync_global()
>>>>>>> that ultimately requires locks to be initialized.
>>>>>>>
>>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>>> [vivek: Cleanup pm runtime calls]
>>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>>> ---
>>>>>>>    drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
>>>>>>>    1 file changed, 81 insertions(+), 8 deletions(-)
>>>>>> [snip]
>>>>>>> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>>>>>           if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>>>>>>>                   dev_err(&pdev->dev, "removing device with active domains!\n");
>>>>>>>
>>>>>>> +       arm_smmu_rpm_get(smmu);
>>>>>>>           /* Turn the thing off */
>>>>>>>           writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>>>>> +       arm_smmu_rpm_put(smmu);
>>>>>>> +
>>>>>>> +       if (pm_runtime_enabled(smmu->dev))
>>>>>>> +               pm_runtime_force_suspend(smmu->dev);
>>>>>>> +       else
>>>>>>> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
>>>>>>>
>>>>>>> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>>>>>>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>>>>> Aren't we missing pm_runtime_disable() here? We'll have the enable
>>>>>> count unbalanced if the driver is removed and probed again.
>>>>>
>>>>> pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
>>>>> wrong.
>>>>> And, as mentioned in a previous thread [1], we were seeing a warning
>>>>> which we avoided
>>>>> by keeping force_suspend().
>>>>>
>>>>> [1] https://lkml.org/lkml/2018/7/8/124
>>>>
>>>> I see, thanks. I didn't realize that pm_runtime_force_suspend()
>>>> already disables runtime PM indeed. Sorry for the noise.
>>>
>>> Hi Tomasz,
>>> No problem. Thanks for looking back at it.
>>>
>>> Hi Robin,
>>> If you are fine with this series, then can you please consider giving
>>> Reviewed-by, so that we are certain that this series will go in the next merge
>>> window.
>>> Thanks
>>
>> Gentle ping.
>> You ack will be very helpful in letting Will pull this series for 4.20.
>> Thanks.
> 
> I would really appreciate if you could provide your ack for this series.
> Or if there are any concerns, I am willing to address them.

Apologies, I thought I'd replied to say I'd be getting to this shortly, 
but apparently not :(

FWIW, "shortly" is now tomorrow - I don't *think* there's anything 
outstanding, but given the number of subtleties we've turned up so far I 
do just want one last thorough double-check to make sure.

Thanks,
Robin.
