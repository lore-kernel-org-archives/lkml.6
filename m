Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCEONY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:13:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeCEONU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:13:20 -0500
Subject: Re: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
To: Tomasz Figa <tfiga@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-14-jeffy.chen@rock-chips.com>
 <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0cd81b39-ffe9-eda3-1358-13afeb2ec25b@arm.com>
Date: Mon, 5 Mar 2018 14:13:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/18 13:49, Tomasz Figa wrote:
[...]
>> @@ -518,7 +520,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>>          u32 int_status;
>>          dma_addr_t iova;
>>          irqreturn_t ret = IRQ_NONE;
>> -       int i;
>> +       int i, err, need_runtime_put;
> 
> nit: need_runtime_put could be a bool.
> 
>> +
>> +       err = pm_runtime_get_if_in_use(iommu->dev);
>> +       if (err <= 0 && err != -EINVAL)
>> +               return ret;
>> +       need_runtime_put = err > 0;
> 
> Generally something must be really wrong if we end up with err == 0
> here, because the IOMMU must be powered on to signal an interrupt. The
> only case this could happen would be if the IRQ signal was shared with
> some device from another power domain. Is it possible on Rockchip
> SoCs? If not, perhaps we should have a WARN_ON() here for such case.

In general, there's almost certainly some time window between the 
interrupt level being latched at the GIC and the IRQ actually being 
taken by its target CPU, in which potentially the power could be removed 
and/or the clocks gated - especially if there are higher-priority IRQs 
pending at the same time and the racing PM call is on some other CPU. 
Sure, it's probably unlikely, but I wouldn't necessarily consider it 
completely erroneous.

Robin.
