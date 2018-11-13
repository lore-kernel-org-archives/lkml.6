Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B77EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83E223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n2/ypjwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83E223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeKNFfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:35:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41700 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbeKNFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:35:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so6155341pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=158Uwnv8slvUqvmkKS6E4lhBncGugyc39GQmVzLaRT4=;
        b=n2/ypjwFerhEmwFgxB26s/4DZz6DWlBW5vi4ss365FW6CFslRWtiGj/3A09p73JMxX
         XUp4dpCG9IqtFwWDC0gX0ylpZ0o8xQm55pHKhJYDwYvb5tL7pZwQa0c8pKq7CvgXjZgQ
         udHXGg0G92ByXzuzrl92pjjAV8AOkLT7zzrJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=158Uwnv8slvUqvmkKS6E4lhBncGugyc39GQmVzLaRT4=;
        b=YaxGE573G2IufZacVe06Zysv8pi8DfRkJhH2cbX+wL1L1ZNqYQJse+lL2x7dBYP8ze
         XMxRtsIkyWFzxKI0SLUNDfWOEA/TJOfILZ1L/PAeYO9lhCHYBRXgEcHTLSO/U85XlFi3
         y6op0PnWXoOJFg3yvqXacsYzopPejPmqKd++eLmFX8IMdjOYnedsqS46xoP/wBnbjOtS
         pVHMdmklFsPAnzB33XBycO7G5OL2twOKokHUKhy33STOjN60tdHVK5YSp2fRO1iSlrXd
         sTcuYp25/aypL9pwDxaVGlBsBcpVuJUO3vsBDIvLqy+peFA5eFXjG555SGlAqnRgOjvM
         ISxA==
X-Gm-Message-State: AGRZ1gKuWsJ1azauE/Vocfs1XQUwQTKJLNUF9EAS/Q2BYNib4BQzVfV4
        NTGG3YSEQoHn3AT7WHRA7m/pKHh6H3SaVPqcIj9+0g==
X-Google-Smtp-Source: AJdET5coV5c6ekljgMYbaT0oN6dkEOFM8E9UV1yaiZPCn7sskVXvRfmzWF7t3nt/3jy7mSuZG1rs40vp8LLzTvorP8I=
X-Received: by 2002:a65:4646:: with SMTP id k6mr5821631pgr.153.1542137741971;
 Tue, 13 Nov 2018 11:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20181106064206.17535-1-weiyi.lu@mediatek.com> <20181106064206.17535-13-weiyi.lu@mediatek.com>
In-Reply-To: <20181106064206.17535-13-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 13 Nov 2018 11:35:30 -0800
Message-ID: <CANMq1KBoCScwixLoB0oEtbavLW8b_NjufAjbPKJLcLgj=vHC9A@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] soc: mediatek: Add MT8183 scpsys support
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

On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add scpsys driver for MT8183
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 80be2e05e4e0..57b9f04a69de 100644
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
> @@ -1179,6 +1180,217 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
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
> +               .basic_clk_name = {"audio"},
> +       },
> +       [MT8183_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
> +               .sta_mask = PWR_STATUS_CONN,
> +               .ctl_offs = 0x032c,
> +               .sram_pdn_bits = 0,
> +               .sram_pdn_ack_bits = 0,
> +               .bp_table = {
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               BIT(19) | BIT(20) | BIT(21),
> +                               BIT(19) | BIT(20) | BIT(21)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               BIT(16) | BIT(17), BIT(16) | BIT(17)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> +                       [2] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(4) | BIT(5) | BIT(9) | BIT(13),
> +                               BIT(4) | BIT(5) | BIT(9) | BIT(13)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(28), BIT(28)),
> +                       [2] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(11), 0),
> +                       [3] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               BIT(3) | BIT(4), BIT(3) | BIT(4)),

Why do you need to specify the indexes ([0], [1], ...)? Can you just
use automatic indexes? (especially considering that your code assumes
there is no gap in the bp_table entries.

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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(3) | BIT(8), BIT(3) | BIT(8)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(10), 0),
> +                       [2] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
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
> +                       [0] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
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
> +                       [0] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               GENMASK(9, 6) | BIT(12),
> +                               GENMASK(9, 6) | BIT(12)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               BIT(27), BIT(27)),
> +                       [2] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> +                       [3] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(6), BIT(6)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
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
> +                       [0] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               BIT(7), BIT(7)),
> +                       [1] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
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
> @@ -1245,6 +1457,17 @@ static const struct scp_soc_data mt8173_data = {
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
> @@ -1268,6 +1491,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
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
