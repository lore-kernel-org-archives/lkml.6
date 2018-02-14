Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967468AbeBNL1x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:27:53 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:38345 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967415AbeBNL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:27:50 -0500
X-Google-Smtp-Source: AH8x225B5VbC7APup5Ooelr5Xv57b0Sbhy/3vVis590N2IpoixWpsLEKHVWwwIP79R1zWBTPnN5ODg927Iuq5DFOmdw=
MIME-Version: 1.0
In-Reply-To: <edc5002d-c83f-cf11-ecfb-0c4400b10d07@codeaurora.org>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com> <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
 <edc5002d-c83f-cf11-ecfb-0c4400b10d07@codeaurora.org>
From: Tomasz Figa <tfiga@google.com>
Date: Wed, 14 Feb 2018 20:27:28 +0900
Message-ID: <CAAFQd5DHYn2VK2GwSa0E_hX9Zh3BL5K0b1BnQqz+xzfmhPzhpg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, Ricky Liang <jcliang@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 7:03 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
>
> On 1/24/2018 7:19 PM, Robin Murphy wrote:
>>
>> On 24/01/18 10:35, Jeffy Chen wrote:
>>>
>>> From: Tomasz Figa <tfiga@chromium.org>
>>>
>>> Current code relies on master driver enabling necessary clocks before
>>> IOMMU is accessed, however there are cases when the IOMMU should be
>>> accessed while the master is not running yet, for example allocating
>>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>>> mapping API and doesn't engage the master driver at all.
>>>
>>> This patch fixes the problem by letting clocks needed for IOMMU
>>> operation to be listed in Device Tree and making the driver enable them
>>> for the time of accessing the hardware.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>
>>> Changes in v5:
>>> Use clk_bulk APIs.
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2: None
>
>
> [snip]
>
>
>>>   +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
>>> +{
>>> +    struct device_node *np = iommu->dev->of_node;
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>>> +    if (ret == -ENOENT)
>>> +        return 0;
>>> +    else if (ret < 0)
>>> +        return ret;
>>> +
>>> +    iommu->num_clocks = ret;
>>> +    iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
>>> +                     sizeof(*iommu->clocks), GFP_KERNEL);
>>> +    if (!iommu->clocks)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < iommu->num_clocks; ++i) {
>>> +        iommu->clocks[i].clk = of_clk_get(np, i);
>>> +        if (IS_ERR(iommu->clocks[i].clk)) {
>>> +            ret = PTR_ERR(iommu->clocks[i].clk);
>>> +            goto err_clk_put;
>>> +        }
>>> +    }
>>
>>
>> Just to confirm my understanding from a quick scan through the code, the
>> reason we can't use clk_bulk_get() here is that currently, clocks[i].id
>> being NULL means we'd end up just getting the first clock multiple times,
>> right?
>>
>> I guess there could be other users who also want "just get whatever clocks
>> I have" functionality, so it might be worth proposing that for the core API
>> as a separate/follow-up patch, but it definitely doesn't need to be part of
>> this series.
>
>
> Just to understand. Is it okay to make the driver "just get whatever clocks
> device node gives"?
> Doesn't the driver need to be aware of which all clocks are supposed to be
> obtained and enabled
>  It's should good for debug to let the world know which clock we failed to
> get.

Yeah, in general that's desired. However, it is at least impractical
to specify all the clocks in Rockchip case, because it's different for
each block and depends on the master next to which it is located.

Best regards,
Tomasz
