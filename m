Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EA32082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh8DW7cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EA32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLAHKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:10:06 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7ADD2082F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543607981;
        bh=mtupHFf2LFA1JWPiIbPkldnsJEog70DgFKNAScssUAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zh8DW7cYmn8Mu1dK02leBM6GBWMFhGTU6zrVM31rhXbc7xJ0SYDbrlc9ZHqk+JeW8
         G5kGFCB2LRYEIf1M+fF4EVJgvdxZNEBW7ht2nqG8VEY9AxJRV1/mnZXX10hSN08D5i
         OF71dHeArUMFjn1YvdIt9VNPxNudHuyv23mdWikw=
Received: by mail-qt1-f178.google.com with SMTP id r14so7306847qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:59:41 -0800 (PST)
X-Gm-Message-State: AA+aEWaccEpF/xklHjek41rTT7YfjZwdhKdFrGdUKZSpz5rOBxNHLz2q
        7XRgBYQO6HSV/BMFLjDDFLJX41r97nyBy1hjhg==
X-Google-Smtp-Source: AFSGD/XO/pyxkdBRuSlz42CERxt5B94alUuw0SegW+cwzlyyvhU1YMvw1ofKGKdjt35SiIpcybWKqhu1RlY1TZ18l5Q=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr6906861qvi.90.1543607980981;
 Fri, 30 Nov 2018 11:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20181130170754.346-1-TheSven73@googlemail.com> <20181130170754.346-3-TheSven73@googlemail.com>
In-Reply-To: <20181130170754.346-3-TheSven73@googlemail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 13:59:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjqUZRhGsnW4C+-DRLb-XWzYRj+S0R_siGyDBq-LNY8w@mail.gmail.com>
Message-ID: <CAL_JsqJjqUZRhGsnW4C+-DRLb-XWzYRj+S0R_siGyDBq-LNY8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] bus: imx-weim: guard against timing configuration conflicts
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:08 AM <thesven73@gmail.com> wrote:
>
> From: Sven Van Asbroeck <TheSven73@googlemail.com>
>
> When adding weim child devices, there is a risk that the developer will
> (by mistake) specify more than one timing setting for the same chip select.
>
> The driver cannot support such a configuration.
>
> In case of conflict, this patch will print a warning to the log,
> and will ignore the child node in question.
>
> In this example, node acme@1 will be ignored, as it tries to modify
> timing settings for CS0:
>
> &weim {
>         acme@0 {

This should be '@0,0'

>                 compatible = "acme,whatever";
>                 reg = <0 0 0x100>;
>                 fsl,weim-cs-timing = <something>;
>         };
>         acme@1 {

And '@0,500'

>                 compatible = "acme,whatnot";
>                 reg = <0 0x500 0x100>;
>                 fsl,weim-cs-timing = <something else>;
>         };
> };
>
> However in this example, the driver will be happy:
>
> &weim {
>         acme@0 {
>                 compatible = "acme,whatever";
>                 reg = <0 0 0x100>;
>                 fsl,weim-cs-timing = <something>;
>         };
>         acme@1 {
>                 compatible = "acme,whatnot";
>                 reg = <0 0x500 0x100>;
>                 fsl,weim-cs-timing = <something>;
>         };
> };
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
>  drivers/bus/imx-weim.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 24f22285395d..114e503ec785 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -46,8 +46,18 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
>  };
>
>  #define MAX_CS_REGS_COUNT      6
> +#define MAX_CS_REGS            6
>  #define OF_REG_SIZE            3
>
> +struct cs_timing {
> +       bool is_applied;
> +       u32 regs[MAX_CS_REGS_COUNT];
> +};
> +
> +struct cs_timing_state {
> +       struct cs_timing cs[MAX_CS_REGS];
> +};
> +
>  static const struct of_device_id weim_id_table[] = {
>         /* i.MX1/21 */
>         { .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> @@ -112,11 +122,14 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
>  }
>
>  /* Parse and set the timing for this device. */
> -static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
> -                                   const struct imx_weim_devtype *devtype)
> +static int __init weim_timing_setup(struct device *dev,
> +                                   struct device_node *np, void __iomem *base,
> +                                   const struct imx_weim_devtype *devtype,
> +                                   struct cs_timing_state *ts)
>  {
>         u32 cs_idx, value[MAX_CS_REGS_COUNT];
>         int i, ret, reg_idx, num_regs;
> +       struct cs_timing *cst;
>
>         if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
>                 return -EINVAL;
> @@ -145,10 +158,23 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>                 if (cs_idx >= devtype->cs_count)
>                         return -EINVAL;
>
> +               /* prevent re-configuring a CS that's already been configured */
> +               cst = &ts->cs[cs_idx];
> +               if (cst->is_applied && memcmp(value, cst->regs,
> +                                       devtype->cs_regs_count*sizeof(u32))) {
> +                       dev_err(dev, "fsl,weim-cs-timing conflict on %pOF", np);
> +                       return -EINVAL;
> +               }
> +
>                 /* set the timing for WEIM */
>                 for (i = 0; i < devtype->cs_regs_count; i++)
>                         writel(value[i],
>                                 base + cs_idx * devtype->cs_stride + i * 4);
> +               if (!cst->is_applied) {
> +                       cst->is_applied = true;
> +                       memcpy(cst->regs, value,
> +                               devtype->cs_regs_count*sizeof(u32));
> +               }
>         }
>
>         return 0;
> @@ -165,6 +191,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>         const struct imx_weim_devtype *devtype = of_id->data;
>         struct device_node *child;
>         int ret, have_child = 0;
> +       struct cs_timing_state ts = {};
>
>         if (devtype == &imx50_weim_devtype) {
>                 ret = imx_weim_gpr_setup(pdev);
> @@ -179,7 +206,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>         }
>
>         for_each_available_child_of_node(pdev->dev.of_node, child) {
> -               ret = weim_timing_setup(child, base, devtype);
> +               ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
>                 if (ret)
>                         dev_warn(&pdev->dev, "%pOF set timing failed.\n",
>                                 child);
> --
> 2.17.1
>
