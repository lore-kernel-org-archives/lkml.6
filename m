Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DAC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B29F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B29F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeKTNEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:04:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53652 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726576AbeKTNEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:04:39 -0500
X-UUID: c9bea406be8b41f0b93deaa6b2f8e2a9-20181120
X-UUID: c9bea406be8b41f0b93deaa6b2f8e2a9-20181120
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1915616742; Tue, 20 Nov 2018 10:37:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 10:37:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 10:37:35 +0800
Message-ID: <1542681454.5132.9.camel@mtksdaap41>
Subject: Re: [PATCH v1 04/11] soc: mediatek: add new flow for mtcmos power.
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>, <sboyd@codeaurora.org>,
        "Rob Herring" <robh@kernel.org>, <jamesjj.liao@mediatek.com>,
        <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <owen.chen@mediatek.com>,
        <mars.cheng@mediatek.com>
Date:   Tue, 20 Nov 2018 10:37:34 +0800
In-Reply-To: <CANMq1KDbauouMDvsZS3KsNJrNs1gGg7mDjsKRw=zTcuQXSTa0Q@mail.gmail.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
         <20181106064206.17535-6-weiyi.lu@mediatek.com>
         <CANMq1KDbauouMDvsZS3KsNJrNs1gGg7mDjsKRw=zTcuQXSTa0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 11:31 -0800, Nicolas Boichat wrote:
> (not a complete review...)
> 
> On Mon, Nov 5, 2018 at 10:42 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > From: Owen Chen <owen.chen@mediatek.com>
> >
> > Both MT8183 & MT6765 add more bus protect node than previous project,
> > therefore we add two more register for setup bus protect, which reside
> > at INFRA_CFG & SMI_COMMON.
> >
> > With the following change
> > 1. bus protect need not only infracfg but smi_common registers involved
> >    to setup. Therefore we add a set/clr APIs with more customize arguments.
> >
> > The second change is that we also add subsys CG control flow before/after
> > the bus protect/sram control, due to bus protect need SMI bus relative CGs
> > enable to feed-back its ack, and some master's sram control need CG enable
> > to on/off its resource sequentially.
> >
> > With the following change
> > 1. turn on subsys CG before sram pwron and release bus protect.
> > 2. turn off subsys CG after the process of set bus protect/receive
> >    ack/disable sram.
> >
> > The last change is for some power domains like vpu_core on MT8183 whose
> > sram need to do clock and internal isolation while power on/off sram.
> > We add a flag "sram_iso_ctrl" in scp_domain_data to judge if we need to
> > do the extra sram isolation control or not.
> >
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Makefile           |   2 +-
> >  drivers/soc/mediatek/mtk-scpsys-ext.c   | 102 +++++++
> >  drivers/soc/mediatek/mtk-scpsys.c       | 379 +++++++++++++++++++-----
> >  include/linux/soc/mediatek/scpsys-ext.h |  39 +++
> >  4 files changed, 451 insertions(+), 71 deletions(-)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
> >  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
> >
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 12998b08819e..9dc6670c19cb 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1,3 +1,3 @@
> > -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> > +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > new file mode 100644
> > index 000000000000..fa5623b47d6b
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <Owen.Chen@mediatek.com>
> > + */
> > +#include <linux/ktime.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/soc/mediatek/scpsys-ext.h>
> > +
> > +#define MTK_POLL_DELAY_US   10
> > +#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> 
> This is just 1000000 (USEC_PER_SEC), right?
> 
Yes, correct.
> > +
> > +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> > +               u32 reg_set, u32 reg_sta, u32 reg_en)
> > +{
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (reg_set)
> > +               regmap_write(map, reg_set, mask);
> > +       else
> > +               regmap_update_bits(map, reg_en, mask, mask);
> > +
> > +       ret = regmap_read_poll_timeout(map, reg_sta,
> > +                       val, (val & ack_mask) == ack_mask,
> > +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> 
> Just return regmap_read...()
> 
will fix in next version
> > +
> > +       return ret;
> > +}
> > +
> > +static int clear_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> > +               u32 reg_clr, u32 reg_sta, u32 reg_en)
> > +{
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (reg_clr)
> > +               regmap_write(map, reg_clr, mask);
> > +       else
> > +               regmap_update_bits(map, reg_en, mask, 0);
> > +
> > +       ret = regmap_read_poll_timeout(map, reg_sta,
> > +                       val, !(val & ack_mask),
> > +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +
> > +       return ret;
> > +}
> > +
> > +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> > +       struct regmap *infracfg, struct regmap *smi_common)
> > +{
> > +       int i, ret;
> 
> You need to initialize ret = 0, in case bp_table[0].mask == 0 (unless
> you want to do the changes below).
> 
Actually bp_table[].mask won't be 0, only bp_table[].clr_ack_mask could
be 0. But we'll fix it.
> > +       struct regmap *map;
> 
> I'd move this inside the loop.
> 
OK, will fix in next version
> > +
> > +       for (i = 0; i < MAX_STEPS && bp_table[i].mask; i++) {
> > +               map = (bp_table[i].type == IFR_TYPE) ? infracfg :
> > +                       (bp_table[i].type == SMI_TYPE) ? smi_common :
> > +                       NULL;
> > +               if (!map)
> > +                       return -EINVAL;
> 
> This feels more readable:
> if (bp_table[i].type == IFR_TYPE)
>  map = infracfg;
> else if (bp_table[i].type == SMI_TYPE)
>   map = smi_common;
> else
>    return -EINVAL;
> 
OK, will fix in next version
> > +
> > +               ret = set_bus_protection(map,
> > +                               bp_table[i].mask, bp_table[i].mask,
> > +                               bp_table[i].set_ofs, bp_table[i].sta_ofs,
> > +                               bp_table[i].en_ofs);
> > +
> > +               if (ret)
> > +                       break;
> 
> Or just return ret?
> 
OK, will fix in next version
> > +       }
> > +
> > +       return ret;
> 
> Then this can just be return 0;
> 
OK, will fix in next version
> > +}
> > +
> > +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> > +       struct regmap *infracfg, struct regmap *smi_common)
> > +{
> > +       int i, ret = 0;
> > +       struct regmap *map;
> > +
> > +       for (i = MAX_STEPS - 1; i >= 0; i--) {
> > +               if (!bp_table[i].mask)
> > +                       continue;
> > +
> > +               map = (bp_table[i].type == IFR_TYPE) ? infracfg :
> > +                       (bp_table[i].type == SMI_TYPE) ? smi_common :
> > +                       NULL;
> > +               if (!map)
> > +                       return -EINVAL;
> > +
> > +               ret = clear_bus_protection(map,
> > +                               bp_table[i].mask, bp_table[i].clr_ack_mask,
> > +                               bp_table[i].clr_ofs, bp_table[i].sta_ofs,
> > +                               bp_table[i].en_ofs);
> > +
> > +               if (ret)
> > +                       break;
> > +       }
> > +
> > +       return ret;
> 
> Similar comments for this function.
OK, will fix in next version
> 
> > +}
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 5b24bb4bfbf6..80be2e05e4e0 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> >   *
> > @@ -20,6 +21,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/soc/mediatek/infracfg.h>
> > +#include <linux/soc/mediatek/scpsys-ext.h>
> >
> >  #include <dt-bindings/power/mt2701-power.h>
> >  #include <dt-bindings/power/mt2712-power.h>
> > @@ -64,6 +66,8 @@
> >  #define PWR_ON_BIT                     BIT(2)
> >  #define PWR_ON_2ND_BIT                 BIT(3)
> >  #define PWR_CLK_DIS_BIT                        BIT(4)
> > +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> > +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
> >
> >  #define PWR_STATUS_CONN                        BIT(1)
> >  #define PWR_STATUS_DISP                        BIT(3)
> > @@ -115,16 +119,38 @@ static const char * const clk_names[] = {
> >  };
> >
> >  #define MAX_CLKS       3
> > -
> > +#define MAX_SUBSYS_CLKS 10
> > +
> > +/**
> > + * struct scp_domain_data - scp domain data for power on/off flow
> > + * @name: The domain name.
> > + * @sta_mask: The mask for power on/off status bit.
> > + * @ctl_offs: The offset for main power control register.
> > + * @sram_pdn_bits: The mask for sram power control bits.
> > + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> > + * @bus_prot_mask: The mask for single step bus protection.
> > + * @clk_id: The basic clock needs to be enabled before enabling certain
> > + *          power domains.
> > + * @basic_clk_name: provide the same purpose with field "clk_id"
> > + *                  by declaring basic clock prefix name rathan than clk_id.
> > + * @subsys_clk_prefix: The prefix name of the clocks need to be enabled
> > + *                     before releasing bus protection.
> > + * @caps: The flag for active wake-up action.
> > + * @bp_table: The mask table for multiple step bus protection.
> > + */
> >  struct scp_domain_data {
> >         const char *name;
> >         u32 sta_mask;
> >         int ctl_offs;
> > +       bool sram_iso_ctrl;
> >         u32 sram_pdn_bits;
> >         u32 sram_pdn_ack_bits;
> >         u32 bus_prot_mask;
> >         enum clk_id clk_id[MAX_CLKS];
> > +       const char *basic_clk_name[MAX_CLKS];
> > +       const char *subsys_clk_prefix;
> >         u8 caps;
> > +       struct bus_prot bp_table[MAX_STEPS];
> >  };
> >
> >  struct scp;
> > @@ -133,6 +159,7 @@ struct scp_domain {
> >         struct generic_pm_domain genpd;
> >         struct scp *scp;
> >         struct clk *clk[MAX_CLKS];
> > +       struct clk *subsys_clk[MAX_SUBSYS_CLKS];
> >         const struct scp_domain_data *data;
> >         struct regulator *supply;
> >  };
> > @@ -148,6 +175,7 @@ struct scp {
> >         struct device *dev;
> >         void __iomem *base;
> >         struct regmap *infracfg;
> > +       struct regmap *smi_common;
> >         struct scp_ctrl_reg ctrl_reg;
> >         bool bus_prot_reg_update;
> >  };
> > @@ -188,20 +216,26 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
> >         return -EINVAL;
> >  }
> >
> > -static int scpsys_power_on(struct generic_pm_domain *genpd)
> > +static int scpsys_regulator_onoff(struct scp_domain *scpd, bool on)
> >  {
> > -       struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> > -       struct scp *scp = scpd->scp;
> > -       void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> > -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> > -       u32 val;
> > -       int ret, tmp;
> > +       struct regulator *s = scpd->supply;
> > +
> > +       if (!s)
> > +               return 0;
> > +
> > +       return on ? regulator_enable(s) : regulator_disable(s);
> > +}
> > +
> > +static int scpsys_basic_clk_onoff(struct scp_domain *scpd, bool on)
> > +{
> > +       int ret = 0;
> >         int i;
> >
> > -       if (scpd->supply) {
> > -               ret = regulator_enable(scpd->supply);
> > -               if (ret)
> > -                       return ret;
> > +       if (!on) {
> > +               for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> > +                       clk_disable_unprepare(scpd->clk[i]);
> > +
> > +               return ret;
> >         }
> >
> >         for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
> > @@ -210,10 +244,147 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >                         for (--i; i >= 0; i--)
> >                                 clk_disable_unprepare(scpd->clk[i]);
> >
> > -                       goto err_clk;
> > +                       break;
> >                 }
> >         }
> >
> > +       return ret;
> > +}
> > +
> > +static int scpsys_sram_onoff(struct scp_domain *scpd, void __iomem *ctl_addr,
> > +               bool on)
> > +{
> > +       u32 val, ack;
> > +       int tmp;
> > +       int ret = 0;
> > +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> > +
> > +       if (!on && scpd->data->sram_iso_ctrl)   {
> > +               val = readl(ctl_addr);
> > +               val |= PWR_SRAM_CLKISO_BIT;
> > +               writel(val, ctl_addr);
> > +               val &= ~PWR_SRAM_ISOINT_B_BIT;
> > +               writel(val, ctl_addr);
> > +               udelay(1);
> > +       }
> > +
> > +       val = readl(ctl_addr);
> > +       if (on) {
> > +               val &= ~scpd->data->sram_pdn_bits;
> > +               ack = 0;
> > +       } else {
> > +               val |= scpd->data->sram_pdn_bits;
> > +               ack = pdn_ack;
> > +       }
> > +       writel(val, ctl_addr);
> > +
> > +       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> > +       if (on && MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> > +               /*
> > +                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> > +                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> > +                * is applied here.
> > +                */
> > +               usleep_range(12000, 12100);
> > +       } else
> > +               /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> > +               ret = readl_poll_timeout(ctl_addr, tmp,
> > +                               (tmp & pdn_ack) == ack,
> > +                               MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +
> > +       if (on && scpd->data->sram_iso_ctrl)    {
> > +               val = readl(ctl_addr);
> > +               val |= PWR_SRAM_ISOINT_B_BIT;
> > +               writel(val, ctl_addr);
> > +               udelay(1);
> > +               val &= ~PWR_SRAM_CLKISO_BIT;
> > +               writel(val, ctl_addr);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int scpsys_subsys_clk_onoff(struct scp_domain *scpd, bool on)
> > +{
> > +       int ret = 0;
> > +       int i;
> > +
> > +       if (!on) {
> > +               for (i = MAX_SUBSYS_CLKS - 1; i >= 0; i--) {
> > +                       struct clk *clk = scpd->subsys_clk[i];
> > +
> > +                       if (clk)
> > +                               clk_disable_unprepare(clk);
> > +               }
> > +
> > +               return ret;
> > +       }
> > +
> > +       for (i = 0; i < MAX_SUBSYS_CLKS && scpd->subsys_clk[i]; i++) {
> > +               struct clk *clk = scpd->subsys_clk[i];
> > +
> > +               ret = clk_prepare_enable(clk);
> > +               if (ret) {
> > +                       for (--i; i >= 0; i--) {
> > +                               struct clk *clk = scpd->subsys_clk[i];
> > +
> > +                               clk_disable_unprepare(clk);
> > +                       }
> > +
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int scpsys_bus_protect_onoff(struct scp_domain *scpd, bool on)
> > +{
> > +       struct scp *scp = scpd->scp;
> > +       int ret = 0;
> > +
> > +       if (scpd->data->bus_prot_mask) {
> > +               if (on)
> > +                       ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > +                                       scpd->data->bus_prot_mask,
> > +                                       scp->bus_prot_reg_update);
> > +               else
> > +                       ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > +                                       scpd->data->bus_prot_mask,
> > +                                       scp->bus_prot_reg_update);
> > +       } else if (scpd->data->bp_table[0].mask) {
> > +               if (on)
> > +                       ret = mtk_scpsys_ext_set_bus_protection(
> > +                                       scpd->data->bp_table,
> > +                                       scp->infracfg,
> > +                                       scp->smi_common);
> > +               else
> > +                       ret = mtk_scpsys_ext_clear_bus_protection(
> > +                                       scpd->data->bp_table,
> > +                                       scp->infracfg,
> > +                                       scp->smi_common);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int scpsys_power_on(struct generic_pm_domain *genpd)
> > +{
> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> > +       struct scp *scp = scpd->scp;
> > +       void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> > +       u32 val;
> > +       int ret, tmp;
> > +
> > +       ret = scpsys_regulator_onoff(scpd, true);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = scpsys_basic_clk_onoff(scpd, true);
> > +       if (ret)
> > +               goto err_clk;
> > +
> > +       /* subsys power on */
> >         val = readl(ctl_addr);
> >         val |= PWR_ON_BIT;
> >         writel(val, ctl_addr);
> > @@ -226,6 +397,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         if (ret < 0)
> >                 goto err_pwr_ack;
> >
> > +
> 
> Drop this.
Why do we try to drop this? Once the power-on step fail, the following
steps should not be permitted.
> 
> >         val &= ~PWR_CLK_DIS_BIT;
> >         writel(val, ctl_addr);
> >
> > @@ -235,43 +407,26 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         val |= PWR_RST_B_BIT;
> >         writel(val, ctl_addr);
> >
> > -       val &= ~scpd->data->sram_pdn_bits;
> > -       writel(val, ctl_addr);
> > -
> > -       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> > -       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> > -               /*
> > -                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> > -                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> > -                * applied here.
> > -                */
> > -               usleep_range(12000, 12100);
> > +       ret = scpsys_subsys_clk_onoff(scpd, true);
> > +       if (ret < 0)
> > +               goto err_pwr_ack;
> >
> > -       } else {
> > -               ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> > -                                        MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > -               if (ret < 0)
> > -                       goto err_pwr_ack;
> > -       }
> > +       ret = scpsys_sram_onoff(scpd, ctl_addr, true);
> > +       if (ret < 0)
> > +               goto err_sram;
> >
> > -       if (scpd->data->bus_prot_mask) {
> > -               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > -                               scpd->data->bus_prot_mask,
> > -                               scp->bus_prot_reg_update);
> > -               if (ret)
> > -                       goto err_pwr_ack;
> > -       }
> > +       ret = scpsys_bus_protect_onoff(scpd, false);
> > +       if (ret < 0)
> > +               goto err_sram;
> >
> >         return 0;
> >
> > +err_sram:
> > +       scpsys_subsys_clk_onoff(scpd, false);
> >  err_pwr_ack:
> > -       for (i = MAX_CLKS - 1; i >= 0; i--) {
> > -               if (scpd->clk[i])
> > -                       clk_disable_unprepare(scpd->clk[i]);
> > -       }
> > +       scpsys_basic_clk_onoff(scpd, false);
> >  err_clk:
> > -       if (scpd->supply)
> > -               regulator_disable(scpd->supply);
> > +       scpsys_regulator_onoff(scpd, false);
> >
> >         dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
> >
> > @@ -283,29 +438,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> >         struct scp *scp = scpd->scp;
> >         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> > -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> >         u32 val;
> >         int ret, tmp;
> > -       int i;
> >
> > -       if (scpd->data->bus_prot_mask) {
> > -               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > -                               scpd->data->bus_prot_mask,
> > -                               scp->bus_prot_reg_update);
> > -               if (ret)
> > -                       goto out;
> > -       }
> > -
> > -       val = readl(ctl_addr);
> > -       val |= scpd->data->sram_pdn_bits;
> > -       writel(val, ctl_addr);
> > +       ret = scpsys_bus_protect_onoff(scpd, true);
> > +       if (ret < 0)
> > +               goto out;
> >
> > -       /* wait until SRAM_PDN_ACK all 1 */
> > -       ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> > -                                MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +       ret = scpsys_sram_onoff(scpd, ctl_addr, false);
> >         if (ret < 0)
> >                 goto out;
> >
> > +       ret = scpsys_subsys_clk_onoff(scpd, false);
> > +
> > +       /* subsys power off */
> > +       val = readl(ctl_addr);
> >         val |= PWR_ISO_BIT;
> >         writel(val, ctl_addr);
> >
> > @@ -327,11 +474,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         if (ret < 0)
> >                 goto out;
> >
> > -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> > -               clk_disable_unprepare(scpd->clk[i]);
> > +       scpsys_basic_clk_onoff(scpd, false);
> >
> > -       if (scpd->supply)
> > -               regulator_disable(scpd->supply);
> > +       scpsys_regulator_onoff(scpd, false);
> >
> >         return 0;
> >
> > @@ -341,6 +486,69 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         return ret;
> >  }
> >
> > +static int init_subsys_clks(struct platform_device *pdev,
> > +               const char *prefix, struct clk **clk)
> > +{
> > +       struct device_node *node = pdev->dev.of_node;
> > +       u32 sub_clk_cnt = 0;
> > +       u32 prefix_len = 0;
> > +       int str_sz = 0;
> > +       int clk_idx;
> > +       int ret = 0;
> > +
> > +       if (!node) {
> > +               dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> > +                       PTR_ERR(node));
> > +               return PTR_ERR(node);
> > +       }
> > +
> > +       str_sz = of_property_count_strings(node, "clock-names");
> > +       if (str_sz < 0) {
> > +               dev_err(&pdev->dev, "Cannot get any subsys strings: %d\n",
> > +                               str_sz);
> > +               return str_sz;
> > +       }
> > +
> > +       prefix_len = strlen(prefix);
> > +
> > +       for (clk_idx = 0; clk_idx < str_sz; clk_idx++) {
> > +               const char *clk_name;
> > +
> > +               ret = of_property_read_string_index(node, "clock-names",
> > +                                       clk_idx, &clk_name);
> > +               if (ret < 0) {
> > +                       dev_err(&pdev->dev,
> > +                                       "Cannot read subsys string[%d]: %d\n",
> > +                                       clk_idx, ret);
> > +                       return ret;
> > +               }
> > +
> > +               if (!strncmp(clk_name, prefix, prefix_len)
> > +                               && (strchr(clk_name + prefix_len, '-')
> > +                               != NULL)) {
> > +                       if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
> > +                               dev_err(&pdev->dev,
> > +                                       "subsys clk out of range %d\n",
> > +                                       sub_clk_cnt);
> > +                               return -ENOMEM;
> > +                       }
> > +
> > +                       clk[sub_clk_cnt] = devm_clk_get(
> > +                                       &pdev->dev, clk_name);
> > +
> > +                       if (IS_ERR(clk)) {
> > +                               dev_err(&pdev->dev,
> > +                                       "Subsys clk read fail %ld\n",
> > +                                       PTR_ERR(clk));
> > +                               return PTR_ERR(clk);
> > +                       }
> > +                       sub_clk_cnt++;
> > +               }
> > +       }
> > +
> > +       return sub_clk_cnt;
> > +}
> > +
> >  static void init_clks(struct platform_device *pdev, struct clk **clk)
> >  {
> >         int i;
> > @@ -396,6 +604,17 @@ static struct scp *init_scp(struct platform_device *pdev,
> >                 return ERR_CAST(scp->infracfg);
> >         }
> >
> > +       scp->smi_common = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                       "smi_comm");
> > +
> > +       if (scp->smi_common == ERR_PTR(-ENODEV)) {
> > +               scp->smi_common = NULL;
> > +       } else if (IS_ERR(scp->smi_common)) {
> > +               dev_err(&pdev->dev, "Cannot find smi_common controller: %ld\n",
> > +                               PTR_ERR(scp->smi_common));
> > +               return ERR_CAST(scp->smi_common);
> > +       }
> > +
> >         for (i = 0; i < num; i++) {
> >                 struct scp_domain *scpd = &scp->domains[i];
> >                 const struct scp_domain_data *data = &scp_domain_data[i];
> > @@ -417,22 +636,42 @@ static struct scp *init_scp(struct platform_device *pdev,
> >                 struct scp_domain *scpd = &scp->domains[i];
> >                 struct generic_pm_domain *genpd = &scpd->genpd;
> >                 const struct scp_domain_data *data = &scp_domain_data[i];
> > +               int clk_cnt = 0;
> >
> >                 pd_data->domains[i] = genpd;
> >                 scpd->scp = scp;
> >
> >                 scpd->data = data;
> >
> > -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> > -                       struct clk *c = clk[data->clk_id[j]];
> > +               if (data->clk_id[0])
> > +                       for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> > +                               struct clk *c = clk[data->clk_id[j]];
> > +
> > +                               if (IS_ERR(c)) {
> > +                                       dev_err(&pdev->dev,
> > +                                               "%s: clk unavailable\n",
> > +                                               data->name);
> > +                                       return ERR_CAST(c);
> > +                               }
> >
> > -                       if (IS_ERR(c)) {
> > -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> > +                               scpd->clk[j] = c;
> > +                       }
> > +               else if (data->basic_clk_name[0])
> > +                       for (j = 0; j < MAX_CLKS
> > +                                       && data->basic_clk_name[j]; j++)
> > +                               scpd->clk[j] = devm_clk_get(&pdev->dev,
> > +                                               data->basic_clk_name[j]);
> > +
> > +               if (data->subsys_clk_prefix) {
> > +                       clk_cnt = init_subsys_clks(pdev,
> > +                                       data->subsys_clk_prefix,
> > +                                       scpd->subsys_clk);
> > +                       if (clk_cnt < 0) {
> > +                               dev_err(&pdev->dev,
> > +                                       "%s: subsys clk unavailable\n",
> >                                         data->name);
> > -                               return ERR_CAST(c);
> > +                               return ERR_PTR(clk_cnt);
> >                         }
> > -
> > -                       scpd->clk[j] = c;
> >                 }
> >
> >                 genpd->name = data->name;
> > diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
> > new file mode 100644
> > index 000000000000..d0ed295c88a7
> > --- /dev/null
> > +++ b/include/linux/soc/mediatek/scpsys-ext.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
> > +#define __SOC_MEDIATEK_SCPSYS_EXT_H
> > +
> > +#define MAX_STEPS      4
> > +
> > +#define BUS_PROT(_type, _set_ofs, _clr_ofs,                    \
> > +               _en_ofs, _sta_ofs, _mask, _clr_ack_mask) {      \
> > +               .type = _type,                                  \
> > +               .set_ofs = _set_ofs,                            \
> > +               .clr_ofs = _clr_ofs,                            \
> > +               .en_ofs = _en_ofs,                              \
> > +               .sta_ofs = _sta_ofs,                            \
> > +               .mask = _mask,                                  \
> > +               .clr_ack_mask = _clr_ack_mask,                  \
> > +       }
> > +
> > +enum regmap_type {
> > +       IFR_TYPE,
> > +       SMI_TYPE,
> > +       MAX_REGMAP_TYPE,
> > +};
> > +
> > +struct bus_prot {
> > +       enum regmap_type type;
> > +       u32 set_ofs;
> > +       u32 clr_ofs;
> > +       u32 en_ofs;
> > +       u32 sta_ofs;
> > +       u32 mask;
> > +       u32 clr_ack_mask;
> > +};
> > +
> > +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> > +       struct regmap *infracfg, struct regmap *smi_common);
> > +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> > +       struct regmap *infracfg, struct regmap *smi_common);
> > +
> > +#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
> > --
> > 2.18.0
> >


