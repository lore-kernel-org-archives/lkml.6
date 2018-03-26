Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbeCZGb1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:31:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37598 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeCZGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:31:24 -0400
X-Google-Smtp-Source: AG47ELtzvx5O0rDnjTf2oto8+JJ8FS4BekJbsRkFAldFjvQ24vREwiMbEaBUAOfykplhOThmsFHjJ+C19WDrSYnCQEE=
MIME-Version: 1.0
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com> <20180323073814.5802-12-jeffy.chen@rock-chips.com>
In-Reply-To: <20180323073814.5802-12-jeffy.chen@rock-chips.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 26 Mar 2018 06:31:12 +0000
Message-ID: <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com>
Subject: Re: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices automatically
To: Jeffy <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, xxm <xxm@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 1:40 AM Jeffy Chen <jeffy.chen@rock-chips.com>
wrote:

> Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
> which allows attaching master devices to their IOMMUs automatically
> according to DT properties.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---

> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> Add struct rk_iommudata.
> Squash iommu/rockchip: Use iommu_group_get_for_dev() for add_device

> Changes in v2: None

>   drivers/iommu/rockchip-iommu.c | 135
++++++++++++-----------------------------
>   1 file changed, 40 insertions(+), 95 deletions(-)

> diff --git a/drivers/iommu/rockchip-iommu.c
b/drivers/iommu/rockchip-iommu.c
> index 7970d21b9858..bd8580b897e9 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -19,6 +19,7 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_iommu.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> @@ -104,6 +105,10 @@ struct rk_iommu {
>          struct iommu_domain *domain; /* domain to which iommu is attached
*/
>   };

> +struct rk_iommudata {
> +       struct rk_iommu *iommu;
> +};

Why do we need this struct?  Can't we just assign a pointer to struct
rk_iommu directly to dev->archdata.iommu?


> +
>   static struct device *dma_dev;

>   static inline void rk_table_flush(struct rk_iommu_domain *dom,
dma_addr_t dma,
> @@ -807,18 +812,9 @@ static size_t rk_iommu_unmap(struct iommu_domain
*domain, unsigned long _iova,

>   static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>   {
> -       struct iommu_group *group;
> -       struct device *iommu_dev;
> -       struct rk_iommu *rk_iommu;
> +       struct rk_iommudata *data = dev->archdata.iommu;

> -       group = iommu_group_get(dev);
> -       if (!group)
> -               return NULL;
> -       iommu_dev = iommu_group_get_iommudata(group);
> -       rk_iommu = dev_get_drvdata(iommu_dev);
> -       iommu_group_put(group);
> -
> -       return rk_iommu;
> +       return data ? data->iommu : NULL;
>   }

>   static int rk_iommu_attach_device(struct iommu_domain *domain,
> @@ -989,110 +985,53 @@ static void rk_iommu_domain_free(struct
iommu_domain *domain)
>                  iommu_put_dma_cookie(&rk_domain->domain);
>   }

> -static bool rk_iommu_is_dev_iommu_master(struct device *dev)
> -{
> -       struct device_node *np = dev->of_node;
> -       int ret;
> -
> -       /*
> -        * An iommu master has an iommus property containing a list of
phandles
> -        * to iommu nodes, each with an #iommu-cells property with value
0.
> -        */
> -       ret = of_count_phandle_with_args(np, "iommus", "#iommu-cells");
> -       return (ret > 0);
> -}
> -
> -static int rk_iommu_group_set_iommudata(struct iommu_group *group,
> -                                       struct device *dev)
> +static int rk_iommu_add_device(struct device *dev)
>   {
> -       struct device_node *np = dev->of_node;
> -       struct platform_device *pd;
> -       int ret;
> -       struct of_phandle_args args;
> +       struct iommu_group *group;
> +       struct rk_iommu *iommu;

> -       /*
> -        * An iommu master has an iommus property containing a list of
phandles
> -        * to iommu nodes, each with an #iommu-cells property with value
0.
> -        */
> -       ret = of_parse_phandle_with_args(np, "iommus", "#iommu-cells", 0,
> -                                        &args);
> -       if (ret) {
> -               dev_err(dev, "of_parse_phandle_with_args(%pOF) => %d\n",
> -                       np, ret);
> -               return ret;
> -       }
> -       if (args.args_count != 0) {
> -               dev_err(dev, "incorrect number of iommu params found for
%pOF (found %d, expected 0)\n",
> -                       args.np, args.args_count);
> -               return -EINVAL;
> -       }
> +       iommu = rk_iommu_from_dev(dev);
> +       if (!iommu)
> +               return -ENODEV;

> -       pd = of_find_device_by_node(args.np);
> -       of_node_put(args.np);
> -       if (!pd) {
> -               dev_err(dev, "iommu %pOF not found\n", args.np);
> -               return -EPROBE_DEFER;
> -       }
> +       group = iommu_group_get_for_dev(dev);
> +       if (IS_ERR(group))
> +               return PTR_ERR(group);
> +       iommu_group_put(group);

> -       /* TODO(djkurtz): handle multiple slave iommus for a single
master */
> -       iommu_group_set_iommudata(group, &pd->dev, NULL);
> +       iommu_device_link(&iommu->iommu, dev);

>          return 0;
>   }

> -static int rk_iommu_add_device(struct device *dev)
> +static void rk_iommu_remove_device(struct device *dev)
>   {
> -       struct iommu_group *group;
>          struct rk_iommu *iommu;
> -       int ret;
> -
> -       if (!rk_iommu_is_dev_iommu_master(dev))
> -               return -ENODEV;
> -
> -       group = iommu_group_get(dev);
> -       if (!group) {
> -               group = iommu_group_alloc();
> -               if (IS_ERR(group)) {
> -                       dev_err(dev, "Failed to allocate IOMMU group\n");
> -                       return PTR_ERR(group);
> -               }
> -       }
> -
> -       ret = iommu_group_add_device(group, dev);
> -       if (ret)
> -               goto err_put_group;
> -
> -       ret = rk_iommu_group_set_iommudata(group, dev);
> -       if (ret)
> -               goto err_remove_device;

>          iommu = rk_iommu_from_dev(dev);
> -       if (iommu)
> -               iommu_device_link(&iommu->iommu, dev);

> -       iommu_group_put(group);
> -
> -       return 0;
> -
> -err_remove_device:
> +       iommu_device_unlink(&iommu->iommu, dev);
>          iommu_group_remove_device(dev);
> -err_put_group:
> -       iommu_group_put(group);
> -       return ret;
>   }

> -static void rk_iommu_remove_device(struct device *dev)
> +static int rk_iommu_of_xlate(struct device *dev,
> +                            struct of_phandle_args *args)
>   {
> -       struct rk_iommu *iommu;
> +       struct platform_device *iommu_dev;
> +       struct rk_iommudata *data;

> -       if (!rk_iommu_is_dev_iommu_master(dev))
> -               return;
> +       data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;

> -       iommu = rk_iommu_from_dev(dev);
> -       if (iommu)
> -               iommu_device_unlink(&iommu->iommu, dev);
> +       iommu_dev = of_find_device_by_node(args->np);

> -       iommu_group_remove_device(dev);
> +       data->iommu = platform_get_drvdata(iommu_dev);
> +       dev->archdata.iommu = data;
> +
> +       of_dev_put(iommu_dev);
> +
> +       return 0;
>   }

>   static const struct iommu_ops rk_iommu_ops = {
> @@ -1106,7 +1045,9 @@ static const struct iommu_ops rk_iommu_ops = {
>          .add_device = rk_iommu_add_device,
>          .remove_device = rk_iommu_remove_device,
>          .iova_to_phys = rk_iommu_iova_to_phys,
> +       .device_group = generic_device_group,
>          .pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
> +       .of_xlate = rk_iommu_of_xlate,
>   };

>   static int rk_iommu_probe(struct platform_device *pdev)
> @@ -1178,6 +1119,8 @@ static int rk_iommu_probe(struct platform_device
*pdev)
>                  goto err_unprepare_clocks;

>          iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
> +       iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
> +
>          err = iommu_device_register(&iommu->iommu);
>          if (err)
>                  goto err_remove_sysfs;
> @@ -1250,6 +1193,8 @@ static int __init rk_iommu_init(void)
>   }
>   subsys_initcall(rk_iommu_init);

> +IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu");
> +
>   MODULE_DESCRIPTION("IOMMU API for Rockchip");
>   MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <
djkurtz@chromium.org>");
>   MODULE_ALIAS("platform:rockchip-iommu");
> --
> 2.11.0
