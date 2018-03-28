Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeC1B4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:56:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45385 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeC1B4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:56:32 -0400
X-Google-Smtp-Source: AIpwx4/3FRyey127nR+571q3aKJMJlHzpiiriS31v9gsdFGxSjFGBdvJh6QES77scHERjh1oZGl3MK0G8JidS03Kqdo=
MIME-Version: 1.0
In-Reply-To: <20180327234038.32241-1-f.fainelli@gmail.com>
References: <20180327234038.32241-1-f.fainelli@gmail.com>
From: Markus Mayer <markus.mayer@broadcom.com>
Date: Tue, 27 Mar 2018 18:56:31 -0700
Message-ID: <CAGt4E5skUrFFdiG9KEaupVZkxmepxBw3wgobkALnfdiE6QOcgw@mail.gmail.com>
Subject: Re: [PATCH] memory: brcmstb: dpfe: Remove need for dpfe_dev
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM STB DPFE DRIVER"
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 March 2018 at 16:40, Florian Fainelli <f.fainelli@gmail.com> wrote:
> We can hook sysfs objects to the parent platform device that we are
> created from, no need to have a synthetic dpfe_dev just for that. This
> incidentally removes the need for having an index, since we are
> guaranteed to have an unique path in the sysfs hiearchy.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Looks good. Thanks.

Acked-by: Markus Mayer <mmayer@broadcom.com>

> ---
>  drivers/memory/brcmstb_dpfe.c | 42 ++++++++++--------------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 0a7bdbed3a6f..5f8d5aff6040 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -168,7 +168,6 @@ struct private_data {
>         void __iomem *dmem;
>         void __iomem *imem;
>         struct device *dev;
> -       unsigned int index;
>         struct mutex lock;
>  };
>
> @@ -628,10 +627,8 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct private_data *priv;
> -       struct device *dpfe_dev;
>         struct init_data init;
>         struct resource *res;
> -       u32 index;
>         int ret;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -641,11 +638,6 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>         mutex_init(&priv->lock);
>         platform_set_drvdata(pdev, priv);
>
> -       /* Cell index is optional; default to 0 if not present. */
> -       ret = of_property_read_u32(dev->of_node, "cell-index", &index);
> -       if (ret)
> -               index = 0;
> -
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");
>         priv->regs = devm_ioremap_resource(dev, res);
>         if (IS_ERR(priv->regs)) {
> @@ -669,35 +661,20 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>
>         ret = brcmstb_dpfe_download_firmware(pdev, &init);
>         if (ret)
> -               goto err;
> -
> -       dpfe_dev = devm_kzalloc(dev, sizeof(*dpfe_dev), GFP_KERNEL);
> -       if (!dpfe_dev) {
> -               ret = -ENOMEM;
> -               goto err;
> -       }
> -
> -       priv->dev = dpfe_dev;
> -       priv->index = index;
> +               return ret;
>
> -       dpfe_dev->parent = dev;
> -       dpfe_dev->groups = dpfe_groups;
> -       dpfe_dev->of_node = dev->of_node;
> -       dev_set_drvdata(dpfe_dev, priv);
> -       dev_set_name(dpfe_dev, "dpfe%u", index);
> +       ret = sysfs_create_groups(&pdev->dev.kobj, dpfe_groups);
> +       if (!ret)
> +               dev_info(dev, "registered.\n");
>
> -       ret = device_register(dpfe_dev);
> -       if (ret)
> -               goto err;
> +       return ret;
> +}
>
> -       dev_info(dev, "registered.\n");
> +static int brcmstb_dpfe_remove(struct platform_device *pdev)
> +{
> +       sysfs_remove_groups(&pdev->dev.kobj, dpfe_groups);
>
>         return 0;
> -
> -err:
> -       dev_err(dev, "failed to initialize -- error %d\n", ret);
> -
> -       return ret;
>  }
>
>  static const struct of_device_id brcmstb_dpfe_of_match[] = {
> @@ -712,6 +689,7 @@ static struct platform_driver brcmstb_dpfe_driver = {
>                 .of_match_table = brcmstb_dpfe_of_match,
>         },
>         .probe = brcmstb_dpfe_probe,
> +       .remove = brcmstb_dpfe_remove,
>         .resume = brcmstb_dpfe_resume,
>  };
>
> --
> 2.14.1
>
