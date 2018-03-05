Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935285AbeCENtk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:49:40 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46790 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCENtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:49:36 -0500
X-Google-Smtp-Source: AG47ELt40w5xCGtZCfT4Bw0qjPpBmLI8+sMrP9G2L6NHFnYrsDwbwuIpI7ZAbBtrxC3+RrB03tQH5g==
MIME-Version: 1.0
In-Reply-To: <20180301101837.27969-14-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com> <20180301101837.27969-14-jeffy.chen@rock-chips.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 5 Mar 2018 22:49:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
Message-ID: <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
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

On Thu, Mar 1, 2018 at 7:18 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
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
>  drivers/iommu/rockchip-iommu.c | 181 +++++++++++++++++++++++++++++++----------
>  1 file changed, 140 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 2448a0528e39..0e0a42f41818 100644
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
> @@ -106,6 +107,7 @@ struct rk_iommu {
>  };
>
>  struct rk_iommudata {
> +       struct device_link *link; /* runtime PM link from IOMMU to master */

Kerneldoc comment for the struct could be added instead.

>         struct rk_iommu *iommu;
>  };
>
> @@ -518,7 +520,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>         u32 int_status;
>         dma_addr_t iova;
>         irqreturn_t ret = IRQ_NONE;
> -       int i;
> +       int i, err, need_runtime_put;

nit: need_runtime_put could be a bool.

> +
> +       err = pm_runtime_get_if_in_use(iommu->dev);
> +       if (err <= 0 && err != -EINVAL)
> +               return ret;
> +       need_runtime_put = err > 0;

Generally something must be really wrong if we end up with err == 0
here, because the IOMMU must be powered on to signal an interrupt. The
only case this could happen would be if the IRQ signal was shared with
some device from another power domain. Is it possible on Rockchip
SoCs? If not, perhaps we should have a WARN_ON() here for such case.

>
>         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>
> @@ -570,6 +577,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>
> +       if (need_runtime_put)
> +               pm_runtime_put(iommu->dev);
> +
>         return ret;
>  }
>
> @@ -611,10 +621,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
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
> +                       WARN_ON(clk_bulk_enable(iommu->num_clocks,
> +                                               iommu->clocks));
> +                       rk_iommu_zap_lines(iommu, iova, size);
> +                       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +               }
> +               if (ret > 0)
> +                       pm_runtime_put(iommu->dev);
>         }
>         spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  }
> @@ -817,22 +837,30 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>         return data ? data->iommu : NULL;
>  }
>
> -static int rk_iommu_attach_device(struct iommu_domain *domain,
> -                                 struct device *dev)
> +/* Must be called with iommu powered on and attached */
> +static void rk_iommu_shutdown(struct rk_iommu *iommu)
>  {
> -       struct rk_iommu *iommu;
> +       int i;
> +
> +       /* Ignore error while disabling, just keep going */
> +       WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> +       rk_iommu_enable_stall(iommu);
> +       rk_iommu_disable_paging(iommu);
> +       for (i = 0; i < iommu->num_mmu; i++) {
> +               rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
> +               rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
> +       }
> +       rk_iommu_disable_stall(iommu);
> +       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +}
> +
> +/* Must be called with iommu powered on and attached */
> +static int rk_iommu_startup(struct rk_iommu *iommu)
> +{
> +       struct iommu_domain *domain = iommu->domain;
>         struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> -       unsigned long flags;
>         int ret, i;
>
> -       /*
> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
> -        * Such a device does not belong to an iommu group.
> -        */
> -       iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)
> -               return 0;
> -
>         ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>         if (ret)
>                 return ret;
> @@ -845,8 +873,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         if (ret)
>                 goto out_disable_stall;
>
> -       iommu->domain = domain;
> -
>         for (i = 0; i < iommu->num_mmu; i++) {
>                 rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>                                rk_domain->dt_dma);
> @@ -855,14 +881,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         }
>
>         ret = rk_iommu_enable_paging(iommu);
> -       if (ret)
> -               goto out_disable_stall;
> -
> -       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> -       list_add_tail(&iommu->node, &rk_domain->iommus);
> -       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> -
> -       dev_dbg(dev, "Attached to iommu domain\n");
>
>  out_disable_stall:
>         rk_iommu_disable_stall(iommu);
> @@ -877,31 +895,76 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>         struct rk_iommu *iommu;
>         struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>         unsigned long flags;
> -       int i;
> +       int ret;
>
>         /* Allow 'virtual devices' (eg drm) to detach from domain */
>         iommu = rk_iommu_from_dev(dev);
>         if (!iommu)
>                 return;
>
> +       dev_dbg(dev, "Detaching from iommu domain\n");
> +
> +       /* iommu already detached */
> +       if (iommu->domain != domain)
> +               return;
> +
> +       iommu->domain = NULL;
> +
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_del_init(&iommu->node);
>         spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>
> -       /* Ignore error while disabling, just keep going */
> -       WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> -       rk_iommu_enable_stall(iommu);
> -       rk_iommu_disable_paging(iommu);
> -       for (i = 0; i < iommu->num_mmu; i++) {
> -               rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
> -               rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
> -       }
> -       rk_iommu_disable_stall(iommu);
> -       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +       ret = pm_runtime_get_if_in_use(iommu->dev);
> +       if (ret > 0 || ret == -EINVAL)
> +               rk_iommu_shutdown(iommu);
> +       if (ret > 0)
> +               pm_runtime_put(iommu->dev);
> +}
>
> -       iommu->domain = NULL;
> +static int rk_iommu_attach_device(struct iommu_domain *domain,
> +               struct device *dev)
> +{
> +       struct rk_iommu *iommu;
> +       struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> +       unsigned long flags;
> +       int ret, need_runtime_put;

nit: need_runtime_put could be bool

Best regards,
Tomasz
