Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeCEOfA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:35:00 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:37822 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeCEOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:34:58 -0500
X-Google-Smtp-Source: AG47ELt3UCSEnG9G0/muyjHkYm5OhIQsulVyV7qGgSLZvx6FsaHciJg1c206VzO1W5VDGVCu6muv8Q==
MIME-Version: 1.0
In-Reply-To: <0cd81b39-ffe9-eda3-1358-13afeb2ec25b@arm.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-14-jeffy.chen@rock-chips.com> <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
 <0cd81b39-ffe9-eda3-1358-13afeb2ec25b@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 5 Mar 2018 23:34:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AU_uZ_ywO6p-j9=yukoNf_fjiAqh=qzBBLYXM2rp1Fbw@mail.gmail.com>
Message-ID: <CAAFQd5AU_uZ_ywO6p-j9=yukoNf_fjiAqh=qzBBLYXM2rp1Fbw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 11:13 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 05/03/18 13:49, Tomasz Figa wrote:
> [...]
>>>
>>> @@ -518,7 +520,12 @@ static irqreturn_t rk_iommu_irq(int irq, void
>>> *dev_id)
>>>          u32 int_status;
>>>          dma_addr_t iova;
>>>          irqreturn_t ret = IRQ_NONE;
>>> -       int i;
>>> +       int i, err, need_runtime_put;
>>
>>
>> nit: need_runtime_put could be a bool.
>>
>>> +
>>> +       err = pm_runtime_get_if_in_use(iommu->dev);
>>> +       if (err <= 0 && err != -EINVAL)
>>> +               return ret;
>>> +       need_runtime_put = err > 0;
>>
>>
>> Generally something must be really wrong if we end up with err == 0
>> here, because the IOMMU must be powered on to signal an interrupt. The
>> only case this could happen would be if the IRQ signal was shared with
>> some device from another power domain. Is it possible on Rockchip
>> SoCs? If not, perhaps we should have a WARN_ON() here for such case.
>
>
> In general, there's almost certainly some time window between the interrupt
> level being latched at the GIC and the IRQ actually being taken by its
> target CPU, in which potentially the power could be removed and/or the
> clocks gated - especially if there are higher-priority IRQs pending at the
> same time and the racing PM call is on some other CPU. Sure, it's probably
> unlikely, but I wouldn't necessarily consider it completely erroneous.

Clocks are not a problem here, since the handler re-enables them and
clk_enable() is IRQ-safe. However, runtime PM might need sleeping, so
we can't just get_sync() from the handler. I guess, we should just
bail out in such case, since the power off would probably clear any
internal interrupt state anyway.

Also, the interrupt would be basically a page fault, during which the
master device would be stalled, so it's rather unlikely that we see
its driver putting the runtime PM, which would only happen after the
master device resumes and competes (or something times out). So
probably WARN_ON() isn't such bad idea still.
