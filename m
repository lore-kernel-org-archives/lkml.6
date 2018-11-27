Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C941BC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eC83hecs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754C72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeK0RIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:08:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46812 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeK0RIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:08:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so15074720ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 22:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y23FnFMaO6YrW2i31ESgNSKdX3WAEiLSrILGYcVJTUM=;
        b=eC83hecsH8wV31fX9f9EARfHoHFK4aJSIaShlnD0t0ossfcqWVrtjKitcK4pECp0Oz
         LdoBnSeNjDtdS7L/+557XHQlfeEaEZse4zgs3a0Zd68lZ6+CAe75torNksQ7tZFyZvrK
         7JqMPe2WDUhUNcSEemNAhzLFy3n4Hd5GTblc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y23FnFMaO6YrW2i31ESgNSKdX3WAEiLSrILGYcVJTUM=;
        b=boA0DvKCQKVkOL4O0wy70BL0jYJUFgSzUOy1+dX6fu414XWLpck8fURMyzN8b4WeaA
         wUE4oKuCuXq0d5CN70mEVuAXtGBnEHEoaEUPv+aR06SKXi44H+avytNku+yV9zpR5Q6f
         mVCpVdiDWj4x3Fiq9VTd+dDpGXtux6g2Ft1CAHZc5oOgJQF6AdfjvBetwBNq8WrjG9iH
         7h4yTS2ufWAPJheWjrsu4VPlGEOe8ZQcfAGhPzt9Y0iXfvxIvr5Vom276m0WrF2087zZ
         lS4aHkwYptIx+yff5epTjJfefg4E6Ya2MMKK/QdQFRg73z6kx4WuNMlDlVfg2LG0uvTF
         UbaQ==
X-Gm-Message-State: AA+aEWZxbldMj+V0JT/HZSVl9LIm0xKhCybWbJteWowQflQQYLcWJZ0+
        LV6m3oRH+cTA3R3PWrlCEfOjT9KmC2vAo0T97hYc+g==
X-Google-Smtp-Source: AFSGD/XAnF/79j+d9SPaa4UgIn90+0geQB1AJiUlWx4xqAHtVOKoxvaQScQPGZrhTYvfdZ1ezFqN9ntSMsGyUT6Lfio=
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr30308943plb.176.1543299097441;
 Mon, 26 Nov 2018 22:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-13-weiyi.lu@mediatek.com>
In-Reply-To: <20181127034254.24721-13-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Nov 2018 14:11:26 +0800
Message-ID: <CANMq1KA+YSXv+zFebk0goeeax_sLZUo1t0oMsUOe0ioiwaCOHw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] soc: mediatek: Add MT8183 scpsys support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sboyd@codeaurora.org,
        Rob Herring <robh@kernel.org>, jamesjj.liao@mediatek.com,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:43 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add scpsys driver for MT8183
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 227 +++++++++++++++++++++++++++++-
>  1 file changed, 226 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 80be2e05e4e0..aac76c45a681 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -29,6 +29,7 @@
>  #include <dt-bindings/power/mt7622-power.h>
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
> +#include <dt-bindings/power/mt8183-power.h>
>
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> @@ -397,7 +398,6 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 goto err_pwr_ack;
>
> -

Oh, this belongs in patch [04/11].

>         val &= ~PWR_CLK_DIS_BIT;
>         writel(val, ctl_addr);
>
> @@ -1179,6 +1179,217 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
>         {MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
>  };
>
> +/*
> + * MT8183 power domain support
> + */
> +
> +static const struct scp_domain_data scp_domain_data_mt8183[] = {
> +       [MT8183_POWER_DOMAIN_AUDIO] = {
> +               .name = "audio",
> +               .sta_mask = PWR_STATUS_AUDIO,
> +               .ctl_offs = 0x0314,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(15, 12),
> +               .basic_clk_name = {"audio", "audio1", "audio2"},
> +       },
> +       [MT8183_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
> +               .sta_mask = PWR_STATUS_CONN,
> +               .ctl_offs = 0x032c,
> +               .sram_pdn_bits = 0,
> +               .sram_pdn_ack_bits = 0,
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(13) | BIT(14), BIT(13) | BIT(14)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_ASYNC] = {
> +               .name = "mfg_async",
> +               .sta_mask = PWR_STATUS_MFG_ASYNC,
> +               .ctl_offs = 0x0334,
> +               .sram_pdn_bits = 0,
> +               .sram_pdn_ack_bits = 0,
> +               .basic_clk_name = {"mfg"},
> +       },
> +       [MT8183_POWER_DOMAIN_MFG] = {
> +               .name = "mfg",
> +               .sta_mask = PWR_STATUS_MFG,
> +               .ctl_offs = 0x0338,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_CORE0] = {
> +               .name = "mfg_core0",
> +               .sta_mask = BIT(7),
> +               .ctl_offs = 0x034c,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_CORE1] = {
> +               .name = "mfg_core1",
> +               .sta_mask = BIT(20),
> +               .ctl_offs = 0x0310,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_2D] = {
> +               .name = "mfg_2d",
> +               .sta_mask = PWR_STATUS_MFG_2D,
> +               .ctl_offs = 0x0348,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               BIT(19) | BIT(20) | BIT(21),
> +                               BIT(19) | BIT(20) | BIT(21)),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(21) | BIT(22), BIT(21) | BIT(22)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_DISP] = {
> +               .name = "disp",
> +               .sta_mask = PWR_STATUS_DISP,
> +               .ctl_offs = 0x030c,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .basic_clk_name = {"mm"},
> +               .subsys_clk_prefix = "mm",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               BIT(16) | BIT(17), BIT(16) | BIT(17)),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               GENMASK(7, 0), GENMASK(7, 0)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_CAM] = {
> +               .name = "cam",
> +               .sta_mask = BIT(25),
> +               .ctl_offs = 0x0344,
> +               .sram_pdn_bits = GENMASK(9, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"cam"},
> +               .subsys_clk_prefix = "cam",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(4) | BIT(5) | BIT(9) | BIT(13),
> +                               BIT(4) | BIT(5) | BIT(9) | BIT(13)),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(28), BIT(28)),
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(11), 0),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(3) | BIT(4), BIT(3) | BIT(4)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
> +               .sta_mask = PWR_STATUS_ISP,
> +               .ctl_offs = 0x0308,
> +               .sram_pdn_bits = GENMASK(9, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"isp"},
> +               .subsys_clk_prefix = "isp",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(3) | BIT(8), BIT(3) | BIT(8)),
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(10), 0),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(2), BIT(2)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
> +               .sta_mask = BIT(31),
> +               .ctl_offs = 0x0300,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .bp_table = {
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(7), BIT(7)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VENC] = {
> +               .name = "venc",
> +               .sta_mask = PWR_STATUS_VENC,
> +               .ctl_offs = 0x0304,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(15, 12),
> +               .bp_table = {
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(1), BIT(1)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_TOP] = {
> +               .name = "vpu_top",
> +               .sta_mask = BIT(26),
> +               .ctl_offs = 0x0324,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .basic_clk_name = {"vpu", "vpu1"},
> +               .subsys_clk_prefix = "vpu",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               GENMASK(9, 6) | BIT(12),
> +                               GENMASK(9, 6) | BIT(12)),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(27), BIT(27)),
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(5) | BIT(6), BIT(5) | BIT(6)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_CORE0] = {
> +               .name = "vpu_core0",
> +               .sta_mask = BIT(27),
> +               .ctl_offs = 0x33c,
> +               .sram_iso_ctrl = true,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"vpu2"},
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(6), BIT(6)),
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(0) | BIT(2) | BIT(4),
> +                               BIT(0) | BIT(2) | BIT(4)),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_CORE1] = {
> +               .name = "vpu_core1",
> +               .sta_mask = BIT(28),
> +               .ctl_offs = 0x0340,
> +               .sram_iso_ctrl = true,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"vpu3"},
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(7), BIT(7)),
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(1) | BIT(3) | BIT(5),
> +                               BIT(1) | BIT(3) | BIT(5)),
> +               },
> +       },
> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt8183[] = {
> +       {MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
> +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
> +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
> +};
> +
>  static const struct scp_soc_data mt2701_data = {
>         .domains = scp_domain_data_mt2701,
>         .num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
> @@ -1245,6 +1456,17 @@ static const struct scp_soc_data mt8173_data = {
>         .bus_prot_reg_update = true,
>  };
>
> +static const struct scp_soc_data mt8183_data = {
> +       .domains = scp_domain_data_mt8183,
> +       .num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
> +       .subdomains = scp_subdomain_mt8183,
> +       .num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
> +       .regs = {
> +               .pwr_sta_offs = 0x0180,
> +               .pwr_sta2nd_offs = 0x0184
> +       }
> +};
> +
>  /*
>   * scpsys driver init
>   */
> @@ -1268,6 +1490,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>         }, {
>                 .compatible = "mediatek,mt8173-scpsys",
>                 .data = &mt8173_data,
> +       }, {
> +               .compatible = "mediatek,mt8183-scpsys",
> +               .data = &mt8183_data,
>         }, {
>                 /* sentinel */
>         }
> --
> 2.18.0
>
