Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeCFKH4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:07:56 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40475 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCFKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:07:55 -0500
X-Google-Smtp-Source: AG47ELuiprB+i0pxae4HcCXDv62uvq5fe2GYiA50nrJ0zxrKkdtdCUohnUqs/ujhLPPGSCmlNartMw==
MIME-Version: 1.0
In-Reply-To: <20180306032759.29069-4-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com> <20180306032759.29069-4-jeffy.chen@rock-chips.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 6 Mar 2018 19:07:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DPewKda7ThqMGKRvnArZ0X8ChD10E06nLZaNa-SBNdwA@mail.gmail.com>
Message-ID: <CAAFQd5DPewKda7ThqMGKRvnArZ0X8ChD10E06nLZaNa-SBNdwA@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] iommu/rockchip: Add runtime PM support
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

It looks like I missed some details of how runtime PM enable works
before, so we might be able to simplify things. Sorry for not getting
things right earlier.

On Tue, Mar 6, 2018 at 12:27 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> When the power domain is powered off, the IOMMU cannot be accessed and
> register programming must be deferred until the power domain becomes
> enabled.
>
> Add runtime PM support, and use runtime PM device link from IOMMU to
> master to startup and shutdown IOMMU.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v7:
> Add WARN_ON in irq isr, and modify iommu archdata comment.
>
> Changes in v6: None
> Changes in v5:
> Avoid race about pm_runtime_get_if_in_use() and pm_runtime_enabled().
>
> Changes in v4: None
> Changes in v3:
> Only call startup() and shutdown() when iommu attached.
> Remove pm_mutex.
> Check runtime PM disabled.
> Check pm_runtime in rk_iommu_irq().
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 189 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 148 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 2448a0528e39..db08978203f7 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -105,7 +106,14 @@ struct rk_iommu {
>         struct iommu_domain *domain; /* domain to which iommu is attached */
>  };
>
> +/**
> + * struct rk_iommudata - iommu archdata of master device.
> + * @link:      device link with runtime PM integration from the master
> + *             (consumer) to the IOMMU (supplier).
> + * @iommu:     IOMMU of the master device.
> + */
>  struct rk_iommudata {
> +       struct device_link *link;
>         struct rk_iommu *iommu;
>  };
>
> @@ -518,7 +526,13 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>         u32 int_status;
>         dma_addr_t iova;
>         irqreturn_t ret = IRQ_NONE;
> -       int i;
> +       bool need_runtime_put;
> +       int i, err;
> +
> +       err = pm_runtime_get_if_in_use(iommu->dev);
> +       if (WARN_ON(err <= 0 && err != -EINVAL))
> +               return ret;
> +       need_runtime_put = err > 0;

Actually, for our purposes, we can assume that runtime PM enable
status can be only changed by the driver itself. Looking at the LXR,
PM core also calls __pm_runtime_disable() before calling
.suspend_late() callback and pm_runtime_enable() after calling
.resume_early() callback, but we should be able to ignore this,
because we handle things in .suspend() callback in this driver.

With this assumption in mind, all we need to do here is:

if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
    return 0;

>
>         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>
> @@ -570,6 +584,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>
> +       if (need_runtime_put)
> +               pm_runtime_put(iommu->dev);

if (pm_runtime_enabled())
        pm_runtime_put(iommu->dev);

> +
>         return ret;
>  }
>
> @@ -611,10 +628,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_for_each(pos, &rk_domain->iommus) {
>                 struct rk_iommu *iommu;
> +               int ret;
> +
>                 iommu = list_entry(pos, struct rk_iommu, node);
> -               WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> -               rk_iommu_zap_lines(iommu, iova, size);
> -               clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +
> +               /* Only zap TLBs of IOMMUs that are powered on. */
> +               ret = pm_runtime_get_if_in_use(iommu->dev);
> +               if (ret > 0 || ret == -EINVAL) {

if (pm_runtime_get_if_in_use(iommu->dev)) {

> +                       WARN_ON(clk_bulk_enable(iommu->num_clocks,
> +                                               iommu->clocks));
> +                       rk_iommu_zap_lines(iommu, iova, size);
> +                       clk_bulk_disable(iommu->num_clocks, iommu->clocks);

        if (pm_runtime_enabled(iommu->dev))
                pm_runtime_put(iommu->dev);

And so on, in other places.

Really sorry for the confusion before.

Best regards,
Tomasz
