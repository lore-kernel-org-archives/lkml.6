Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9221903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ai0vh+Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbeLUErV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:47:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40253 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388977AbeLUErU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 23:47:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so4398621qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 20:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9H1D9Nqf+4PUZlmYIEOQ3XEEn2RwgBMkN+9rPJV20eA=;
        b=ai0vh+GpEJszFZjxgawSbcZLVoZRrKEyh4rUIXLaIf13Z+nv9EcKIYuLzY4vVpMGht
         AVp//wl67+V1H1FFvv+pPd0aQFxBfdZfhCBAx5Y2UAtu9H8GNfsCArtCtMxaseUg53U4
         eJO0jaJh31zVFH9enp+l2BKZbWx8p8ugrahPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9H1D9Nqf+4PUZlmYIEOQ3XEEn2RwgBMkN+9rPJV20eA=;
        b=uWP6lJnDctxL/YmIjn1as+veWZTliSHFgIGOiTAz9HEav2AhITnxvFFBT+0/mozQSY
         TAV+uavqXhsVnbrQ1nFynAn4VyuKmusQqSzg0WZ6bCgBdfG2fwcxoCU40K9WYiEifQtv
         qLSgwpf4Fa85Pv5L9HQA3y1FSDB48aSZ9s0MZHUv3qkZ42tPYSVLpYgaePHWZe2I5myx
         9GsGrJdF5zsmp2b8jRlPyVU3H7HEZhRAHfWhwIyj7wBf6c+l129AsqlMM08X9q7l9wuQ
         tfBaqUAQX4kd8dB4kTXC4rLTWDjQI+iHY7OH1APy/FMAKwWclVg2okzhwzZTnhewFQ9O
         /Lzg==
X-Gm-Message-State: AA+aEWaJdnW21cw5A4/cte88YDUzfQABdPjtVFHHJr+vR9ST+oW37fLK
        f9DIyYtUXurQcEqeBvpqJek2H5pe6eNe0ID+/MxTlg==
X-Google-Smtp-Source: AFSGD/Uk6uM1l3M/mKJcTj7wq5496QVOwEUnJ3E3Itj92NycddxmrafAKhArHCoj68PE12CqYTNVpBN4ZSYaFOD5FNU=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr972568qts.144.1545367639289;
 Thu, 20 Dec 2018 20:47:19 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com> <1544258371-4600-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1544258371-4600-14-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Dec 2018 12:47:08 +0800
Message-ID: <CANMq1KA4GLZHcDH31=W==8BTBZOVbRX9HBTJrpPFNQ3rWaM4xg@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] memory: mtk-smi: Add bus_sel for mt8183
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, arnd@arndb.de,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 4:43 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ee6165e..88eb61a 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -49,6 +49,12 @@
>  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
>  #define F_MMU_EN               BIT(0)
>
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> +
>  enum mtk_smi_gen {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -57,6 +63,7 @@ enum mtk_smi_gen {
>  struct mtk_smi_common_plat {
>         enum mtk_smi_gen gen;
>         bool             has_gals;
> +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -72,8 +79,8 @@ struct mtk_smi {
>         struct clk                      *clk_apb, *clk_smi;
>         struct clk                      *clk_gals0, *clk_gals1;
>         struct clk                      *clk_async; /*only needed by mt2701*/
> -       void __iomem                    *smi_ao_base;
> -
> +       void __iomem                    *smi_ao_base; /* only for gen1 */
> +       void __iomem                    *base;        /* only for gen2 */
>         const struct mtk_smi_common_plat *plat;
>  };
>
> @@ -409,6 +416,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>         .gen      = MTK_SMI_GEN2,
>         .has_gals = true,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),

Maybe it's ok for now, but I wonder if this is something that should
be specified in device tree? Maybe different applications will want
different larb split between MMU0 and MMU1?

>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> @@ -481,6 +490,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(common->clk_async);
>                 if (ret)
>                         return ret;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);
>         }
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, common);
> @@ -496,6 +510,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  {
>         struct mtk_smi *common = dev_get_drvdata(dev);
> +       u32 bus_sel = common->plat->bus_sel;
>         int ret;
>
>         ret = mtk_smi_clk_enable(common);
> @@ -503,6 +518,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>                 dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
>                 return ret;
>         }
> +
> +       if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> +               writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
>
> --
> 1.9.1
>
