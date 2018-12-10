Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A77420880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anDLb1cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A77420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeLJMwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:52:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:52:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so5221341plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkU42FeWVBNk5+pjsgevfRVziHzkeU/NfrHukert9TY=;
        b=anDLb1cdSI94thzWpimYodH7LynFCVf0yaWtgeF9cZb2AW34j6J+Uxj6saeQdqp7XY
         8q5/i/MTsQqmr7fMCNODd3TP43LAMtLmLZlYjt5NO/86Yy6wRZnNej0Os72mXYMx+N/n
         yY+XeQOdwskUy7j5sb2EyOmT3j47CrcmlMaTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkU42FeWVBNk5+pjsgevfRVziHzkeU/NfrHukert9TY=;
        b=KqCur0X3Rs4TiwEpxk91yfroFSCauGvWhGDRUgSQ+AluanIHr94bQfsW3FqTRebBfa
         O1lzERYT2G4Axvd2kfV7g/CgTwkdIPEOv6An9zLccMGVTDxqWhLcpOG/bVO4qQDhnyg3
         0E9zRnQYWTT4VaUWuvhGIFdfgqLAi7nlywOeW13j4qeuOg47jJyfR1L8KeXdomvqbBO1
         2EPwQcTpMJKLCX6GYDoq1ODKWuS+jrcIZd+or0zJjNuPizvmdoItIhIMKlEz6tqqMkE0
         Hhg1lVmQf37qIAV/9jufjcEMiAuYBKEB2gNCIZlD2w82tjL32xKI4j4tf8WFB0i9bbT8
         7sPg==
X-Gm-Message-State: AA+aEWbaOYQRVfkJhQFRCtlOkRT7iQ/2aOO++cTa0T7RsdcPU8QfDA7F
        J11AtvM3gClneXzN30VkfRNWIwfEE1NhLO1g8h+UaA==
X-Google-Smtp-Source: AFSGD/U4M2MPYa2LE1tSZM/ijxNfhM4tdAwyURp9dzOsQr0zCDvQtQbobVIsi5hKEfnmI6DOS9H7vcegsU9Zp4PepN8=
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr11595386pln.224.1544446365835;
 Mon, 10 Dec 2018 04:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20181210073240.32278-1-weiyi.lu@mediatek.com> <20181210073240.32278-6-weiyi.lu@mediatek.com>
In-Reply-To: <20181210073240.32278-6-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 10 Dec 2018 20:52:32 +0800
Message-ID: <CANMq1KBq5Srgwb+awSTPenXU6AWNyU_BR4axh4h9qcCD=KuMmw@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] soc: mediatek: add new flow for mtcmos power.
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sboyd@codeaurora.org,
        Rob Herring <robh@kernel.org>, jamesjj.liao@mediatek.com,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        owen.chen@mediatek.com, Cheng Mars <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:33 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> From: Owen Chen <owen.chen@mediatek.com>
>
> Both MT8183 & MT6765 add more bus protect node than previous project,
> therefore we add two more register for setup bus protect, which reside
> at INFRA_CFG & SMI_COMMON.
>
> With the following change
> 1. bus protect need not only infracfg but smi_common registers involved
>    to setup. Therefore we add a set/clr APIs with more customize arguments.
>
> The second change is that we also add subsys CG control flow before/after
> the bus protect/sram control, due to bus protect need SMI bus relative CGs
> enable to feed-back its ack, and some master's sram control need CG enable
> to on/off its resource sequentially.
>
> With the following change
> 1. turn on subsys CG before sram pwron and release bus protect.
> 2. turn off subsys CG after the process of set bus protect/receive
>    ack/disable sram.
>
> The last change is for some power domains like vpu_core on MT8183 whose
> sram need to do clock and internal isolation while power on/off sram.
> We add a flag "sram_iso_ctrl" in scp_domain_data to judge if we need to
> do the extra sram isolation control or not.
>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile           |   2 +-
>  drivers/soc/mediatek/mtk-scpsys-ext.c   |  99 ++++++
>  drivers/soc/mediatek/mtk-scpsys.c       | 390 ++++++++++++++++++------
>  include/linux/soc/mediatek/scpsys-ext.h |  39 +++
>  4 files changed, 443 insertions(+), 87 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
>
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b08819e..9dc6670c19cb 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,3 @@
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> new file mode 100644
> index 000000000000..54df42db2a8f
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <Owen.Chen@mediatek.com>
> + */
> +#include <linux/ktime.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
> +
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))

That's just USEC_PER_SEC.

> +
> +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +               u32 reg_set, u32 reg_sta, u32 reg_en)
> +{
> +       u32 val;
> +
> +       if (reg_set)
> +               regmap_write(map, reg_set, mask);
> +       else
> +               regmap_update_bits(map, reg_en, mask, mask);
> +
> +       return regmap_read_poll_timeout(map, reg_sta,
> +                       val, (val & ack_mask) == ack_mask,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int clear_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +               u32 reg_clr, u32 reg_sta, u32 reg_en)
> +{
> +       u32 val;
> +
> +       if (reg_clr)
> +               regmap_write(map, reg_clr, mask);
> +       else
> +               regmap_update_bits(map, reg_en, mask, 0);
> +
> +       return regmap_read_poll_timeout(map, reg_sta,
> +                       val, !(val & ack_mask),
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_STEPS && bp_table[i].mask; i++) {
> +               struct regmap *map;
> +               int ret;
> +
> +               if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +               else
> +                       return -EINVAL;
> +
> +               ret = set_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].mask,
> +                               bp_table[i].set_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = MAX_STEPS - 1; i >= 0; i--) {
> +               struct regmap *map;
> +               int ret;
> +
> +               if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +               else
> +                       return -EINVAL;
> +
> +               ret = clear_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].clr_ack_mask,
> +                               bp_table[i].clr_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 5b24bb4bfbf6..98ccef566ce1 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -1,15 +1,8 @@
> -/*
> - * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2015 Pengutronix
> +// Author: Sascha Hauer <kernel@pengutronix.de>

I'm not super familiar with copyright rules in Germany, but I would
not change this line. I.e., I'd keep:
// Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>

> +
>  #include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -20,6 +13,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
>
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -64,6 +58,8 @@
>  #define PWR_ON_BIT                     BIT(2)
>  #define PWR_ON_2ND_BIT                 BIT(3)
>  #define PWR_CLK_DIS_BIT                        BIT(4)
> +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
>
>  #define PWR_STATUS_CONN                        BIT(1)
>  #define PWR_STATUS_DISP                        BIT(3)
> @@ -115,16 +111,38 @@ static const char * const clk_names[] = {
>  };
>
>  #define MAX_CLKS       3
> -
> +#define MAX_SUBSYS_CLKS 10
> +
> +/**
> + * struct scp_domain_data - scp domain data for power on/off flow
> + * @name: The domain name.
> + * @sta_mask: The mask for power on/off status bit.
> + * @ctl_offs: The offset for main power control register.

Thanks for adding documentation, but @sram_iso_ctrl is missing here.

> + * @sram_pdn_bits: The mask for sram power control bits.
> + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> + * @bus_prot_mask: The mask for single step bus protection.
> + * @clk_id: The basic clock needs to be enabled before enabling certain
> + *          power domains.
> + * @basic_clk_name: provide the same purpose with field "clk_id"
> + *                  by declaring basic clock prefix name rather than clk_id.
> + * @subsys_clk_prefix: The prefix name of the clocks need to be enabled
> + *                     before releasing bus protection.
> + * @caps: The flag for active wake-up action.
> + * @bp_table: The mask table for multiple step bus protection.
> + */
>  struct scp_domain_data {
>         const char *name;
>         u32 sta_mask;
>         int ctl_offs;
> +       bool sram_iso_ctrl;
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
>         enum clk_id clk_id[MAX_CLKS];
> +       const char *basic_clk_name[MAX_CLKS];
> +       const char *subsys_clk_prefix;
>         u8 caps;
> +       struct bus_prot bp_table[MAX_STEPS];
>  };
>
>  struct scp;
> @@ -133,6 +151,7 @@ struct scp_domain {
>         struct generic_pm_domain genpd;
>         struct scp *scp;
>         struct clk *clk[MAX_CLKS];
> +       struct clk *subsys_clk[MAX_SUBSYS_CLKS];
>         const struct scp_domain_data *data;
>         struct regulator *supply;
>  };
> @@ -148,6 +167,7 @@ struct scp {
>         struct device *dev;
>         void __iomem *base;
>         struct regmap *infracfg;
> +       struct regmap *smi_common;
>         struct scp_ctrl_reg ctrl_reg;
>         bool bus_prot_reg_update;
>  };
> @@ -188,32 +208,166 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
>         return -EINVAL;
>  }
>
> +static int scpsys_regulator_enable(struct scp_domain *scpd)
> +{
> +       if (!scpd->supply)
> +               return 0;
> +       else

nit: Else branch not strictly needed.

> +               return regulator_enable(scpd->supply);
> +}
> +
> +static int scpsys_regulator_disable(struct scp_domain *scpd)
> +{
> +       if (!scpd->supply)
> +               return 0;
> +       else
> +               return regulator_disable(scpd->supply);
> +}
> +
> +static int scpsys_clk_enable(struct clk *clk[], int max_num)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < max_num && clk[i]; i++) {
> +               ret = clk_prepare_enable(clk[i]);
> +               if (ret) {
> +                       for (--i; i >= 0; i--)
> +                               clk_disable_unprepare(clk[i]);
> +
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int scpsys_clk_disable(struct clk *clk[], int max_num)
> +{
> +       int i;
> +
> +       for (i = max_num - 1; i >= 0; i--) {
> +               if (clk[i])
> +                       clk_disable_unprepare(clk[i]);
> +       }
> +
> +       return 0;
> +}
> +
> +static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
> +{
> +       u32 val;
> +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +       int tmp, ret = 0;
> +
> +       val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
> +       writel(val, ctl_addr);
> +
> +       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> +       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> +               /*
> +                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> +                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> +                * is applied here.
> +                */
> +               usleep_range(12000, 12100);
> +       } else {
> +               /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +               ret = readl_poll_timeout(ctl_addr, tmp,
> +                               (tmp & pdn_ack) == 0,
> +                               MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +       }
> +
> +       if (scpd->data->sram_iso_ctrl)  {

Are we ok with doing this even if readl_poll_timeout fails? Should we
return ret earlier?

> +               val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +               val &= ~PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +       }
> +
> +       return ret;
> +}
> +
> +static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> +{
> +       u32 val;
> +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +       int tmp, ret = 0;

No need to init ret to 0.

> +
> +       if (scpd->data->sram_iso_ctrl)  {
> +               val = readl(ctl_addr);
> +               val |= PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +               val &= ~PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +       }
> +
> +       val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
> +       writel(val, ctl_addr);
> +
> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +       ret = readl_poll_timeout(ctl_addr, tmp,
> +                       (tmp & pdn_ack) == pdn_ack,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +
> +       return ret;

Just return readl_poll_timeout.

> +}
> +
> +static int scpsys_bus_protect_enable(struct scp_domain *scpd)
> +{
> +       struct scp *scp = scpd->scp;
> +       int ret = 0;
> +
> +       if (scpd->data->bus_prot_mask) {
> +               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> +                               scpd->data->bus_prot_mask,
> +                               scp->bus_prot_reg_update);
> +       } else if (scpd->data->bp_table[0].mask) {
> +               ret = mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
> +                               scp->infracfg,
> +                               scp->smi_common);
> +       }
> +
> +       return ret;

More simply:

       if (scpd->data->bus_prot_mask)
              return mtk_infracfg_set_bus_protection(scp->infracfg,
                               scpd->data->bus_prot_mask,
                               scp->bus_prot_reg_update);

      if (scpd->data->bp_table[0].mask)
               return mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
                               scp->infracfg,
                               scp->smi_common);

       return 0;

(feel free to add else's, if you like that better)

> +}
> +
> +static int scpsys_bus_protect_disable(struct scp_domain *scpd)
> +{
> +       struct scp *scp = scpd->scp;
> +       int ret = 0;
> +
> +       if (scpd->data->bus_prot_mask) {
> +               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> +                               scpd->data->bus_prot_mask,
> +                               scp->bus_prot_reg_update);
> +       } else if (scpd->data->bp_table[0].mask) {
> +               ret = mtk_scpsys_ext_clear_bus_protection(
> +                               scpd->data->bp_table,
> +                               scp->infracfg,
> +                               scp->smi_common);
> +       }
> +
> +       return ret;

ditto

> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>         struct scp *scp = scpd->scp;
>         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
> -       int i;
> -
> -       if (scpd->supply) {
> -               ret = regulator_enable(scpd->supply);
> -               if (ret)
> -                       return ret;
> -       }
>
> -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
> -               ret = clk_prepare_enable(scpd->clk[i]);
> -               if (ret) {
> -                       for (--i; i >= 0; i--)
> -                               clk_disable_unprepare(scpd->clk[i]);
> +       ret = scpsys_regulator_enable(scpd);
> +       if (ret < 0)
> +               return ret;
>
> -                       goto err_clk;
> -               }
> -       }
> +       ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
> +       if (ret)
> +               goto err_clk;
>
> +       /* subsys power on */
>         val = readl(ctl_addr);
>         val |= PWR_ON_BIT;
>         writel(val, ctl_addr);
> @@ -235,43 +389,26 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         val |= PWR_RST_B_BIT;
>         writel(val, ctl_addr);
>
> -       val &= ~scpd->data->sram_pdn_bits;
> -       writel(val, ctl_addr);
> -
> -       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> -       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> -               /*
> -                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> -                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> -                * applied here.
> -                */
> -               usleep_range(12000, 12100);
> +       ret = scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +       if (ret < 0)
> +               goto err_pwr_ack;
>
> -       } else {
> -               ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> -                                        MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -               if (ret < 0)
> -                       goto err_pwr_ack;
> -       }
> +       ret = scpsys_sram_enable(scpd, ctl_addr);
> +       if (ret < 0)
> +               goto err_sram;
>
> -       if (scpd->data->bus_prot_mask) {
> -               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -               if (ret)
> -                       goto err_pwr_ack;
> -       }
> +       ret = scpsys_bus_protect_disable(scpd);
> +       if (ret < 0)
> +               goto err_sram;
>
>         return 0;
>
> +err_sram:
> +       scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>  err_pwr_ack:
> -       for (i = MAX_CLKS - 1; i >= 0; i--) {
> -               if (scpd->clk[i])
> -                       clk_disable_unprepare(scpd->clk[i]);
> -       }
> +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  err_clk:
> -       if (scpd->supply)
> -               regulator_disable(scpd->supply);
> +       scpsys_regulator_disable(scpd);
>
>         dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
>
> @@ -283,29 +420,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>         struct scp *scp = scpd->scp;
>         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
> -       int i;
>
> -       if (scpd->data->bus_prot_mask) {
> -               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -               if (ret)
> -                       goto out;
> -       }
> -
> -       val = readl(ctl_addr);
> -       val |= scpd->data->sram_pdn_bits;
> -       writel(val, ctl_addr);
> +       ret = scpsys_bus_protect_enable(scpd);
> +       if (ret < 0)
> +               goto out;
>
> -       /* wait until SRAM_PDN_ACK all 1 */
> -       ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> -                                MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +       ret = scpsys_sram_disable(scpd, ctl_addr);
>         if (ret < 0)
>                 goto out;
>
> +       ret = scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +
> +       /* subsys power off */
> +       val = readl(ctl_addr);
>         val |= PWR_ISO_BIT;
>         writel(val, ctl_addr);
>
> @@ -327,11 +456,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 goto out;
>
> -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> -               clk_disable_unprepare(scpd->clk[i]);
> +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
>
> -       if (scpd->supply)
> -               regulator_disable(scpd->supply);
> +       scpsys_regulator_disable(scpd);
>
>         return 0;
>
> @@ -341,6 +468,65 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         return ret;
>  }
>
> +static int init_subsys_clks(struct platform_device *pdev,
> +               const char *prefix, struct clk **clk)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       u32 prefix_len, sub_clk_cnt = 0;
> +       int str_sz, clk_idx, ret;
> +
> +       if (!node) {
> +               dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> +                       PTR_ERR(node));
> +               return PTR_ERR(node);
> +       }
> +
> +       str_sz = of_property_count_strings(node, "clock-names");
> +       if (str_sz < 0) {
> +               dev_err(&pdev->dev, "Cannot get any subsys strings: %d\n",
> +                               str_sz);
> +               return str_sz;
> +       }

Would it be nicer to use of_property_for_each_string to iterate over
the clock-names?

> +
> +       prefix_len = strlen(prefix);
> +
> +       for (clk_idx = 0; clk_idx < str_sz; clk_idx++) {
> +               const char *clk_name;
> +
> +               ret = of_property_read_string_index(node, "clock-names",
> +                                       clk_idx, &clk_name);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev,
> +                                       "Cannot read subsys string[%d]: %d\n",
> +                                       clk_idx, ret);
> +                       return ret;
> +               }
> +
> +               if (!strncmp(clk_name, prefix, prefix_len) &&
> +                               (clk_name[prefix_len] == '-')) {
> +                       if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
> +                               dev_err(&pdev->dev,
> +                                       "subsys clk out of range %d\n",
> +                                       sub_clk_cnt);
> +                               return -ENOMEM;
> +                       }
> +
> +                       clk[sub_clk_cnt] = devm_clk_get(&pdev->dev,
> +                                               clk_name);
> +
> +                       if (IS_ERR(clk)) {
> +                               dev_err(&pdev->dev,
> +                                       "Subsys clk read fail %ld\n",
> +                                       PTR_ERR(clk));
> +                               return PTR_ERR(clk);
> +                       }
> +                       sub_clk_cnt++;
> +               }
> +       }
> +
> +       return sub_clk_cnt;
> +}
> +
>  static void init_clks(struct platform_device *pdev, struct clk **clk)
>  {
>         int i;
> @@ -396,6 +582,17 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 return ERR_CAST(scp->infracfg);
>         }
>
> +       scp->smi_common = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                       "smi_comm");
> +
> +       if (scp->smi_common == ERR_PTR(-ENODEV)) {
> +               scp->smi_common = NULL;
> +       } else if (IS_ERR(scp->smi_common)) {
> +               dev_err(&pdev->dev, "Cannot find smi_common controller: %ld\n",
> +                               PTR_ERR(scp->smi_common));
> +               return ERR_CAST(scp->smi_common);
> +       }
> +
>         for (i = 0; i < num; i++) {
>                 struct scp_domain *scpd = &scp->domains[i];
>                 const struct scp_domain_data *data = &scp_domain_data[i];
> @@ -417,22 +614,43 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 struct scp_domain *scpd = &scp->domains[i];
>                 struct generic_pm_domain *genpd = &scpd->genpd;
>                 const struct scp_domain_data *data = &scp_domain_data[i];
> +               int clk_cnt;
>
>                 pd_data->domains[i] = genpd;
>                 scpd->scp = scp;
>
>                 scpd->data = data;
>
> -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -                       struct clk *c = clk[data->clk_id[j]];
> +               if (data->clk_id[0]) {
> +                       for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> +                               struct clk *c = clk[data->clk_id[j]];
>
> -                       if (IS_ERR(c)) {
> -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> -                                       data->name);
> -                               return ERR_CAST(c);
> +                               if (IS_ERR(c)) {
> +                                       dev_err(&pdev->dev,
> +                                               "%s: clk unavailable\n",
> +                                               data->name);
> +                                       return ERR_CAST(c);
> +                               }
> +
> +                               scpd->clk[j] = c;
>                         }
> +               } else if (data->basic_clk_name[0]) {
> +                       for (j = 0; j < MAX_CLKS &&
> +                                       data->basic_clk_name[j]; j++)
> +                               scpd->clk[j] = devm_clk_get(&pdev->dev,
> +                                               data->basic_clk_name[j]);
> +               }
>
> -                       scpd->clk[j] = c;
> +               if (data->subsys_clk_prefix) {
> +                       clk_cnt = init_subsys_clks(pdev,
> +                                       data->subsys_clk_prefix,
> +                                       scpd->subsys_clk);
> +                       if (clk_cnt < 0) {
> +                               dev_err(&pdev->dev,
> +                                       "%s: subsys clk unavailable\n",
> +                                       data->name);
> +                               return ERR_PTR(clk_cnt);
> +                       }
>                 }
>
>                 genpd->name = data->name;
> diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
> new file mode 100644
> index 000000000000..d0ed295c88a7
> --- /dev/null
> +++ b/include/linux/soc/mediatek/scpsys-ext.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
> +#define __SOC_MEDIATEK_SCPSYS_EXT_H
> +
> +#define MAX_STEPS      4
> +
> +#define BUS_PROT(_type, _set_ofs, _clr_ofs,                    \
> +               _en_ofs, _sta_ofs, _mask, _clr_ack_mask) {      \
> +               .type = _type,                                  \
> +               .set_ofs = _set_ofs,                            \
> +               .clr_ofs = _clr_ofs,                            \
> +               .en_ofs = _en_ofs,                              \
> +               .sta_ofs = _sta_ofs,                            \
> +               .mask = _mask,                                  \
> +               .clr_ack_mask = _clr_ack_mask,                  \
> +       }
> +
> +enum regmap_type {
> +       IFR_TYPE,
> +       SMI_TYPE,
> +       MAX_REGMAP_TYPE,
> +};
> +
> +struct bus_prot {
> +       enum regmap_type type;
> +       u32 set_ofs;
> +       u32 clr_ofs;
> +       u32 en_ofs;
> +       u32 sta_ofs;
> +       u32 mask;
> +       u32 clr_ack_mask;
> +};
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common);
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common);
> +
> +#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
> --
> 2.18.0
>
