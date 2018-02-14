Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967013AbeBNKEE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:04:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeBNKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:04:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA98060791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
To: Robin Murphy <robin.murphy@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, jcliang@chromium.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
 <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <edc5002d-c83f-cf11-ecfb-0c4400b10d07@codeaurora.org>
Date: Wed, 14 Feb 2018 15:33:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2018 7:19 PM, Robin Murphy wrote:
> On 24/01/18 10:35, Jeffy Chen wrote:
>> From: Tomasz Figa <tfiga@chromium.org>
>>
>> Current code relies on master driver enabling necessary clocks before
>> IOMMU is accessed, however there are cases when the IOMMU should be
>> accessed while the master is not running yet, for example allocating
>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>> mapping API and doesn't engage the master driver at all.
>>
>> This patch fixes the problem by letting clocks needed for IOMMU
>> operation to be listed in Device Tree and making the driver enable them
>> for the time of accessing the hardware.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>
>> Changes in v5:
>> Use clk_bulk APIs.
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None

[snip]

>>   +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
>> +{
>> +    struct device_node *np = iommu->dev->of_node;
>> +    int ret;
>> +    int i;
>> +
>> +    ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>> +    if (ret == -ENOENT)
>> +        return 0;
>> +    else if (ret < 0)
>> +        return ret;
>> +
>> +    iommu->num_clocks = ret;
>> +    iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
>> +                     sizeof(*iommu->clocks), GFP_KERNEL);
>> +    if (!iommu->clocks)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < iommu->num_clocks; ++i) {
>> +        iommu->clocks[i].clk = of_clk_get(np, i);
>> +        if (IS_ERR(iommu->clocks[i].clk)) {
>> +            ret = PTR_ERR(iommu->clocks[i].clk);
>> +            goto err_clk_put;
>> +        }
>> +    }
>
> Just to confirm my understanding from a quick scan through the code, 
> the reason we can't use clk_bulk_get() here is that currently, 
> clocks[i].id being NULL means we'd end up just getting the first clock 
> multiple times, right?
>
> I guess there could be other users who also want "just get whatever 
> clocks I have" functionality, so it might be worth proposing that for 
> the core API as a separate/follow-up patch, but it definitely doesn't 
> need to be part of this series.

Just to understand. Is it okay to make the driver "just get whatever 
clocks device node gives"?
Doesn't the driver need to be aware of which all clocks are supposed to 
be obtained and enabled
  It's should good for debug to let the world know which clock we failed 
to get.

regards
Vivek

>
> I really don't know enough about correct clk API usage, but modulo the 
> binding comments it certainly looks nice and tidy now;
>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
>
> Thanks,
> Robin.
[snip]

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
