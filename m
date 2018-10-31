Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C6BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441202064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENR5bcVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441202064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeKADbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbeKADbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:31:16 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E4572081B;
        Wed, 31 Oct 2018 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541010724;
        bh=hIvIjY70T8umZjsOxm4Ahn8MHAuiHxvdEs2DozcLNgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ENR5bcVzspmY7ekgiATAlZ1vZc743SI9BShX5q9lrGmdO1+P7vXgr3FrxfOvfgWCr
         uGBtoVIqwXluNi7AnyEFttUPO5uw2Sm38dURuSkRi/8UzxCu9GBj3hWQJgan5reJ/7
         lHIo9FGzfpnAd5XsoeaELAu4pxbCnVrawGsuckw4=
Received: by mail-qk1-f174.google.com with SMTP id u68so6775873qkg.9;
        Wed, 31 Oct 2018 11:32:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJzwcSG1u7oqlD15vZmyrYh4koNWAZQmsR3qdh3xf0FANbmW0JQ
        a8Q7xHP9cdm63UHGZt47uZsth4UU+BjWfNTU9w==
X-Google-Smtp-Source: AJdET5eWT6ewjEQTBQ1UTZ8Q1i5lkuDr5R848APi3393/fKZP3G9AY9IOXJK46227xHTAZpM9ZNScOqYo09ijD7rpgs=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr3416965qkd.29.1541010723283;
 Wed, 31 Oct 2018 11:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
In-Reply-To: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 31 Oct 2018 13:31:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+V8HmmHV98Wsq-Kec2NXgY4ih+KKEVd-1nZbCoLUPe7Q@mail.gmail.com>
Message-ID: <CAL_Jsq+V8HmmHV98Wsq-Kec2NXgY4ih+KKEVd-1nZbCoLUPe7Q@mail.gmail.com>
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
To:     jaewon02.kim@gmail.com
Cc:     Frank Rowand <frowand.list@gmail.com>, jaewon02.kim@samsung.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:40 AM Jaewon Kim <jaewon02.kim@gmail.com> wrote:
>
> This patch supports dynamic device-tree for AMBA device.
> The AMBA device must be registered on the AMBA bus, not the platform bus.

I'm not convinced we should even support this. There's a limited
number of AMBA devices. They would almost certainly be on-chip and
static. I suppose in theory you could have them in an FPGA, but
generally the FPGA vendors have their own IP blocks and don't use ARM
Primecell IP. So what is the usecase?

>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>

Your author and S-o-b emails should match.

> ---
>  drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312..b9ac105 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>         of_node_clear_flag(node, OF_POPULATED);
>         return NULL;
>  }
> +
> +/**
> + * of_find_amba_device_by_node - Find the amba_device associated with a node
> + * @np: Pointer to device tree node
> + *
> + * Returns amba_device pointer, or NULL if not found
> + */
> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> +{
> +       struct device *dev;
> +
> +       dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
> +       return dev ? to_amba_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL(of_find_amba_device_by_node);

I would prefer we add (or change the platform device version) an
of_find_device_by_node which can be extended to different bus types.

> +
>  #else /* CONFIG_ARM_AMBA */
>  static struct amba_device *of_amba_device_create(struct device_node *node,
>                                                  const char *bus_id,
> @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  {
>         return NULL;
>  }
> +
> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> +{
> +       return NULL;
> +}
> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>  #endif /* CONFIG_ARM_AMBA */
>
>  /**
> @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
>  {
>         struct of_reconfig_data *rd = arg;
>         struct platform_device *pdev_parent, *pdev;
> +       struct amba_device *adev_p, *adev;
>         bool children_left;
>
>         switch (of_reconfig_get_state_change(action, rd)) {
> @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
>                 if (of_node_check_flag(rd->dn, OF_POPULATED))
>                         return NOTIFY_OK;
>
> -               /* pdev_parent may be NULL when no bus platform device */
> -               pdev_parent = of_find_device_by_node(rd->dn->parent);
> -               pdev = of_platform_device_create(rd->dn, NULL,
> -                               pdev_parent ? &pdev_parent->dev : NULL);
> -               of_dev_put(pdev_parent);
> -
> -               if (pdev == NULL) {
> -                       pr_err("%s: failed to create for '%pOF'\n",
> -                                       __func__, rd->dn);
> -                       /* of_platform_device_create tosses the error code */
> -                       return notifier_from_errno(-EINVAL);
> +               if (of_device_is_compatible(rd->dn, "arm,primecell")) {
> +                       /* adev_p may be NULL when no bus amba device */
> +                       adev_p = of_find_amba_device_by_node(rd->dn->parent);

An amba_device can't ever have a parent that's an amba_device. The
parent of an amba_device is typically a platform_device for a
'simple-bus'.

> +                       adev = of_amba_device_create(rd->dn, NULL, NULL,
> +                                       adev_p ? &adev_p->dev : NULL);
> +
> +                       if (adev_p)
> +                               put_device(&adev_p->dev);
> +
> +                       if (adev == NULL) {
> +                               pr_err("%s: failed to create for '%s'\n",
> +                                               __func__, rd->dn->full_name);
> +                               /* of_amba_device_create tosses the error */
> +                               return notifier_from_errno(-EINVAL);
> +                       }
> +               } else {
> +                       /* pdev_parent may be NULL when no bus platform device*/
> +                       pdev_parent = of_find_device_by_node(rd->dn->parent);
> +                       pdev = of_platform_device_create(rd->dn, NULL,
> +                                       pdev_parent ? &pdev_parent->dev : NULL);
> +                       of_dev_put(pdev_parent);
> +
> +                       if (pdev == NULL) {
> +                               pr_err("%s: failed to create for '%pOF'\n",
> +                                               __func__, rd->dn);
> +                               /* of_platform_device_create tosses the error */
> +                               return notifier_from_errno(-EINVAL);
> +                       }

This all pretty much duplicates what of_platform_bus_create() does and
we should use it here rather than have another copy. Plus what about
handling of any child devices (in the platform device case).

>                 }
>                 break;
>
> @@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
>                         return NOTIFY_OK;
>
>                 /* find our device by node */
> -               pdev = of_find_device_by_node(rd->dn);
> -               if (pdev == NULL)
> -                       return NOTIFY_OK;       /* no? not meant for us */
> -
> -               /* unregister takes one ref away */
> -               of_platform_device_destroy(&pdev->dev, &children_left);
> -
> -               /* and put the reference of the find */
> -               of_dev_put(pdev);
> +               if (of_device_is_compatible(rd->dn, "arm,primecell")) {
> +                       adev = of_find_amba_device_by_node(rd->dn);

With the above suggested function returning a struct device for the
node, you can get rid of the if {} else {}.

> +                       if (adev == NULL)
> +                               return NOTIFY_OK; /* no? not meant for us */
> +
> +                       /* unregister takes one ref away */
> +                       of_platform_device_destroy(&adev->dev, &children_left);
> +
> +                       /* and put the reference of the find */
> +                       if (adev)
> +                               put_device(&adev->dev);
> +               } else {
> +                       pdev = of_find_device_by_node(rd->dn);
> +                       if (pdev == NULL)
> +                               return NOTIFY_OK; /* no? not meant for us */
> +
> +                       /* unregister takes one ref away */
> +                       of_platform_device_destroy(&pdev->dev, &children_left);
> +
> +                       /* and put the reference of the find */
> +                       of_dev_put(pdev);
> +               }
>                 break;
>         }
>
> --
> 2.7.4
>
