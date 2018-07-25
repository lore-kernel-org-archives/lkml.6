Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BD020685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BD020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeGYKxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:53:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62031 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728731AbeGYKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:53:39 -0400
X-UUID: fdaf659d3adc497cb7e6a566b7aa2dee-20180725
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <owen.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2023091842; Wed, 25 Jul 2018 17:42:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 25 Jul 2018 17:42:29 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 25 Jul 2018 17:42:29 +0800
Message-ID: <1532511749.16851.17.camel@mtkswgap22>
Subject: Re: [PATCH v5 06/11] soc: mediatek: add new flow for mtcmos power.
From:   Owen Chen <owen.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "CC Hwang" <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Date:   Wed, 25 Jul 2018 17:42:29 +0800
In-Reply-To: <261612ef-cc32-3eaf-442c-5d61dc279a08@gmail.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
         <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
         <261612ef-cc32-3eaf-442c-5d61dc279a08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias

On Wed, 2018-07-18 at 16:50 +0200, Matthias Brugger wrote:
> 
> On 17/07/18 10:52, Mars Cheng wrote:
> > From: Owen Chen <owen.chen@mediatek.com>
> > 
> > MT6765 need multiple register and actions to setup bus
> > protect.
> > 1. turn on subsys CG before release bus protect to receive
> >    ack.
> > 2. turn off subsys CG after set bus protect and receive
> >    ack.
> > 3. bus protect need not only infracfg but other domain
> >    register to setup. Therefore we add a set/clr APIs
> >    with more customize arguments.
> > 
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Makefile           |    2 +-
> >  drivers/soc/mediatek/mtk-infracfg.c     |  178 +++++++++++---
> >  drivers/soc/mediatek/mtk-scpsys-ext.c   |  405 +++++++++++++++++++++++++++++++
> >  drivers/soc/mediatek/mtk-scpsys.c       |  147 +++++++++--
> >  include/linux/soc/mediatek/infracfg.h   |    9 +-
> >  include/linux/soc/mediatek/scpsys-ext.h |   66 +++++
> >  6 files changed, 745 insertions(+), 62 deletions(-)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
> >  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
> > 
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 12998b0..9dc6670 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1,3 +1,3 @@
> > -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> > +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> > index 958861c..11eadf8 100644
> > --- a/drivers/soc/mediatek/mtk-infracfg.c
> > +++ b/drivers/soc/mediatek/mtk-infracfg.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> >   *
> > @@ -15,6 +16,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/regmap.h>
> >  #include <linux/soc/mediatek/infracfg.h>
> > +#include <linux/soc/mediatek/scpsys-ext.h>
> >  #include <asm/processor.h>
> >  
> >  #define MTK_POLL_DELAY_US   10
> > @@ -26,62 +28,176 @@
> >  #define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
> >  
> >  /**
> > - * mtk_infracfg_set_bus_protection - enable bus protection
> > - * @regmap: The infracfg regmap
> > - * @mask: The mask containing the protection bits to be enabled.
> > - * @reg_update: The boolean flag determines to set the protection bits
> > - *              by regmap_update_bits with enable register(PROTECTEN) or
> > - *              by regmap_write with set register(PROTECTEN_SET).
> > + * mtk_generic_set_cmd - enable bus protection with set register
> > + * @regmap: The bus protect regmap
> > + * @set_ofs: The set register offset to set corresponding bit to 1.
> > + * @sta_ofs: The status register offset to show bus protect enable/disable.
> > + * @mask: The mask containing the protection bits to be disabled.
> >   *
> >   * This function enables the bus protection bits for disabled power
> >   * domains so that the system does not hang when some unit accesses the
> >   * bus while in power down.
> >   */
> > -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> > -		bool reg_update)
> > +int mtk_generic_set_cmd(struct regmap *regmap, u32 set_ofs,
> > +			u32 sta_ofs, u32 mask)
> >  {
> >  	u32 val;
> >  	int ret;
> >  
> > -	if (reg_update)
> > -		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
> > -				mask);
> > -	else
> > -		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> > +	regmap_write(regmap, set_ofs, mask);
> >  
> > -	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> > -				       val, (val & mask) == mask,
> > -				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +	ret = regmap_read_poll_timeout(regmap, sta_ofs, val,
> > +				       (val & mask) == mask,
> > +				       MTK_POLL_DELAY_US,
> > +				       MTK_POLL_TIMEOUT);
> >  
> >  	return ret;
> >  }
> >  
> >  /**
> > - * mtk_infracfg_clear_bus_protection - disable bus protection
> > - * @regmap: The infracfg regmap
> > + * mtk_generic_clr_cmd - disable bus protection  with clr register
> > + * @regmap: The bus protect regmap
> > + * @clr_ofs: The clr register offset to clear corresponding bit to 0.
> > + * @sta_ofs: The status register offset to show bus protect enable/disable.
> >   * @mask: The mask containing the protection bits to be disabled.
> > - * @reg_update: The boolean flag determines to clear the protection bits
> > - *              by regmap_update_bits with enable register(PROTECTEN) or
> > - *              by regmap_write with clear register(PROTECTEN_CLR).
> >   *
> >   * This function disables the bus protection bits previously enabled with
> > - * mtk_infracfg_set_bus_protection.
> > + * mtk_set_bus_protection.
> >   */
> >  
> > -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > -		bool reg_update)
> > +int mtk_generic_clr_cmd(struct regmap *regmap, u32 clr_ofs,
> > +			u32 sta_ofs, u32 mask)
> >  {
> >  	int ret;
> >  	u32 val;
> >  
> > -	if (reg_update)
> > -		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> > -	else
> > -		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> > +	regmap_write(regmap, clr_ofs, mask);
> >  
> > -	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> > -				       val, !(val & mask),
> > -				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +	ret = regmap_read_poll_timeout(regmap, sta_ofs, val,
> > +				       !(val & mask),
> > +				       MTK_POLL_DELAY_US,
> > +				       MTK_POLL_TIMEOUT);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * mtk_generic_enable_cmd - enable bus protection with upd register
> > + * @regmap: The bus protect regmap
> > + * @upd_ofs: The update register offset to directly rewrite value to
> > + *              corresponding bit.
> > + * @sta_ofs: The status register offset to show bus protect enable/disable.
> > + * @mask: The mask containing the protection bits to be disabled.
> > + *
> > + * This function enables the bus protection bits for disabled power
> > + * domains so that the system does not hang when some unit accesses the
> > + * bus while in power down.
> > + */
> > +int mtk_generic_enable_cmd(struct regmap *regmap, u32 upd_ofs,
> > +			   u32 sta_ofs, u32 mask)
> > +{
> > +	u32 val;
> > +	int ret;
> > +
> > +	regmap_update_bits(regmap, upd_ofs, mask, mask);
> >  
> > +	ret = regmap_read_poll_timeout(regmap, sta_ofs, val,
> > +				       (val & mask) == mask,
> > +				       MTK_POLL_DELAY_US,
> > +				       MTK_POLL_TIMEOUT);
> >  	return ret;
> >  }
> > +
> > +/**
> > + * mtk_generic_disable_cmd - disable bus protection with updd register
> > + * @regmap: The bus protect regmap
> > + * @upd_ofs: The update register offset to directly rewrite value to
> > + *              corresponding bit.
> > + * @sta_ofs: The status register offset to show bus protect enable/disable.
> > + * @mask: The mask containing the protection bits to be disabled.
> > + *
> > + * This function disables the bus protection bits previously enabled with
> > + * mtk_set_bus_protection.
> > + */
> > +
> > +int mtk_generic_disable_cmd(struct regmap *regmap, u32 upd_ofs,
> > +			    u32 sta_ofs, u32 mask)
> > +{
> > +	int ret;
> > +	u32 val;
> > +
> > +	regmap_update_bits(regmap, upd_ofs, mask, 0);
> > +
> > +	ret = regmap_read_poll_timeout(regmap, sta_ofs,
> > +				       val, !(val & mask),
> > +				       MTK_POLL_DELAY_US,
> > +				       MTK_POLL_TIMEOUT);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * mtk_set_bus_protection - enable bus protection
> > + * @infracfg: The bus protect regmap, default use infracfg
> > + * @mask: The mask containing the protection bits to be enabled.
> > + *
> > + * This function enables the bus protection bits for disabled power
> > + * domains so that the system does not hang when some unit accesses the
> > + * bus while in power down.
> > + */
> > +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> > +{
> > +	return mtk_generic_set_cmd(infracfg,
> > +				   INFRA_TOPAXI_PROTECTEN_SET,
> > +				   INFRA_TOPAXI_PROTECTSTA1,
> > +				   mask);
> > +}
> > +
> > +/**
> > + * mtk_clear_bus_protection - disable bus protection
> > + * @infracfg: The bus protect regmap, default use infracfg
> > + * @mask: The mask containing the protection bits to be disabled.
> > + *
> > + * This function disables the bus protection bits previously enabled with
> > + * mtk_set_bus_protection.
> > + */
> > +
> > +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
> > +{
> > +	return mtk_generic_clr_cmd(infracfg,
> > +				   INFRA_TOPAXI_PROTECTEN_CLR,
> > +				   INFRA_TOPAXI_PROTECTSTA1,
> > +				   mask);
> > +}
> > +
> > +/**
> > + * mtk_infracfg_enable_bus_protection - enable bus protection
> > + * @infracfg: The bus protect regmap, default use infracfg
> > + * @mask: The mask containing the protection bits to be disabled.
> > + *
> > + * This function enables the bus protection bits for disabled power
> > + * domains so that the system does not hang when some unit accesses the
> > + * bus while in power down.
> > + */
> > +int mtk_infracfg_enable_bus_protection(struct regmap *infracfg, u32 mask)
> > +{
> > +	return mtk_generic_enable_cmd(infracfg,
> > +				      INFRA_TOPAXI_PROTECTEN,
> > +				      INFRA_TOPAXI_PROTECTSTA1,
> > +				      mask);
> > +}
> > +
> > +/**
> > + * mtk_infracfg_disable_bus_protection - disable bus protection
> > + * @infracfg: The bus protect regmap, default use infracfg
> > + * @mask: The mask containing the protection bits to be disabled.
> > + *
> > + * This function disables the bus protection bits previously enabled with
> > + * mtk_infracfg_set_bus_protection.
> > + */
> > +
> > +int mtk_infracfg_disable_bus_protection(struct regmap *infracfg, u32 mask)
> > +{
> > +	return mtk_generic_disable_cmd(infracfg,
> > +				       INFRA_TOPAXI_PROTECTEN,
> > +				       INFRA_TOPAXI_PROTECTSTA1,
> > +				       mask);
> > +}
> > diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > new file mode 100644
> > index 0000000..965e64d
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > @@ -0,0 +1,405 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/slab.h>
> > +#include <linux/export.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> > +#include <linux/soc/mediatek/scpsys-ext.h>
> > +
> > +
> > +#define MAX_CLKS		10
> > +#define INFRA			"infracfg"
> > +#define SMIC			"smi_comm"
> 
> Don't use defines for this. While at it I suppose it should be "smi_common"

OK. I will fix it.

> 
> > +
> > +static LIST_HEAD(ext_clk_map_list);
> > +static LIST_HEAD(ext_attr_map_list);
> > +
> > +static struct regmap *infracfg;
> > +static struct regmap *smi_comm;
> > +
> > +enum regmap_type {
> > +	IFR_TYPE,
> > +	SMI_TYPE,
> > +	MAX_REGMAP_TYPE,
> > +};
> > +
> > +/**
> > + * struct ext_reg_ctrl - set multiple register for bus protect
> > + * @regmap: The bus protect regmap, 1: infracfg, 2: other master regmap
> > + *                  such as SMI.
> > + * @set_ofs: The set register offset to set corresponding bit to 1.
> > + * @clr_ofs: The clr register offset to clear corresponding bit to 0.
> > + * @sta_ofs: The status register offset to show bus protect enable/disable.
> > + */
> > +struct ext_reg_ctrl {
> > +	enum regmap_type type;
> > +	u32 set_ofs;
> > +	u32 clr_ofs;
> > +	u32 sta_ofs;
> > +};
> > +
> > +/**
> > + * struct ext_clk_ctrl - enable multiple clks for bus protect
> > + * @clk: The clk need to enable before pwr on/bus protect.
> > + * @scpd_n: The name present the scpsys domain where the clks belongs to.
> > + * @clk_list: The list node linked to ext_clk_map_list.
> > + */
> > +struct ext_clk_ctrl {
> > +	struct clk *clk;
> > +	const char *scpd_n;
> > +	struct list_head clk_list;
> > +};
> > +
> > +struct bus_mask_ops {
> > +	int	(*set)(struct regmap *regmap, u32 set_ofs,
> > +		       u32 sta_ofs, u32 mask);
> > +	int	(*release)(struct regmap *regmap, u32 clr_ofs,
> > +			   u32 sta_ofs, u32 mask);
> > +};
> > +
> > +static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
> > +{
> > +	struct scpsys_ext_attr *attr;
> > +
> > +	if (!parent_n)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	list_for_each_entry(attr, &ext_attr_map_list, attr_list) {
> > +		if (attr->scpd_n && !strcmp(parent_n, attr->scpd_n))
> > +			return attr;
> > +	}
> > +
> > +	return ERR_PTR(-EINVAL);
> > +}
> > +
> > +int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
> > +{
> > +	int i;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < MAX_STEP_NUM && attr->mask[i].mask; i++) {
> > +		struct ext_reg_ctrl *rc = attr->mask[i].regs;
> > +		struct regmap *regmap;
> > +
> > +		if (rc->type == IFR_TYPE)
> > +			regmap = infracfg;
> > +		else if (rc->type == SMI_TYPE)
> > +			regmap = smi_comm;
> > +		else
> > +			return -EINVAL;
> > +
> > +		if (set)
> > +			ret = attr->mask[i].ops->set(regmap,
> > +						rc->set_ofs,
> > +						rc->sta_ofs,
> > +						attr->mask[i].mask);
> > +		else
> > +			ret = attr->mask[i].ops->release(regmap,
> > +						rc->clr_ofs,
> > +						rc->sta_ofs,
> > +						attr->mask[i].mask);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int bus_ctrl_set(struct scpsys_ext_attr *attr)
> > +{
> > +	return bus_ctrl_set_release(attr, CMD_ENABLE);
> > +}
> > +
> > +int bus_ctrl_release(struct scpsys_ext_attr *attr)
> > +{
> > +	return bus_ctrl_set_release(attr, CMD_DISABLE);
> > +}
> > +
> > +int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
> > +{
> > +	int i = 0;
> > +	int ret = 0;
> > +	struct ext_clk_ctrl *cc;
> > +	struct clk *clk[MAX_CLKS];
> > +
> > +	list_for_each_entry(cc, &ext_clk_map_list, clk_list) {
> 
> Why can't we handle this in the same way as we do in mtk-scpsys.c ?


We originally thought it would be better to put all the additional flow
at new created file, but after consider the readability of code flow, we
would put this cg operation back to mtk_scpsys.c.

> 
> > +		if (!strcmp(cc->scpd_n, attr->scpd_n)) {
> > +			if (enable)
> > +				ret = clk_prepare_enable(cc->clk);
> > +			else
> > +				clk_disable_unprepare(cc->clk);
> > +
> > +			if (ret) {
> > +				pr_err("Failed to  %s %s\n",
> > +				       enable ? "enable" : "disable",
> > +				       __clk_get_name(cc->clk));
> > +				goto err;
> > +			} else {
> > +				clk[i] = cc->clk;
> > +				i++;
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +
> > +err:
> > +	for (--i; i >= 0; i--)
> > +		if (enable)
> > +			clk_disable_unprepare(clk[i]);
> > +		else
> > +			clk_prepare_enable(clk[i]);
> > +	return ret;
> > +}
> > +
> > +int bus_clk_enable(struct scpsys_ext_attr *attr)
> > +{
> > +	struct scpsys_ext_attr *attr_p;
> > +	int ret = 0;
> > +
> > +	attr_p = __get_attr_parent(attr->parent_n);
> 
> Why can't we implement this using the pg_genpd_add_subdomain approach?

OK, we will follow it.

> 
> > +	if (!IS_ERR(attr_p)) {
> > +		ret = bus_clk_enable_disable(attr_p, CMD_ENABLE);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return bus_clk_enable_disable(attr, CMD_ENABLE);
> > +}
> > +
> > +int bus_clk_disable(struct scpsys_ext_attr *attr)
> > +{
> > +	struct scpsys_ext_attr *attr_p;
> > +	int ret = 0;
> > +
> > +	ret = bus_clk_enable_disable(attr, CMD_DISABLE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr_p = __get_attr_parent(attr->parent_n);
> > +	if (!IS_ERR(attr_p))
> > +		ret = bus_clk_enable_disable(attr_p, CMD_DISABLE);
> 
> Same here.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +const struct bus_mask_ops bus_mask_set_clr_ctrl = {
> > +	.set = &mtk_generic_set_cmd,
> > +	.release = &mtk_generic_clr_cmd,
> > +};
> > +
> > +const struct bus_ext_ops ext_bus_ctrl = {
> > +	.enable = &bus_ctrl_set,
> > +	.disable = &bus_ctrl_release,
> > +};
> > +
> > +const struct bus_ext_ops ext_cg_ctrl = {
> > +	.enable = &bus_clk_enable,
> > +	.disable = &bus_clk_disable,
> > +};
> > +
> > +/*
> > + * scpsys bus driver init
> > + */
> > +struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
> > +						   const char *property,
> > +						   int index)
> > +{
> > +	struct device_node *syscon_np;
> > +	struct regmap *regmap;
> > +
> > +	if (property)
> > +		syscon_np = of_parse_phandle(np, property, index);
> > +	else
> > +		syscon_np = np;
> > +
> > +	if (!syscon_np)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	regmap = syscon_node_to_regmap(syscon_np);
> > +	of_node_put(syscon_np);
> > +
> > +	return regmap;
> > +}
> 
> Why do we need this? It is never called...

Sorry, Forgot to delete it.

> 
> > +
> > +int scpsys_ext_regmap_init(struct platform_device *pdev)
> > +{
> > +	infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +						   INFRA);
> > +	if (IS_ERR(infracfg)) {
> > +		dev_err(&pdev->dev,
> > +			"Cannot find bus infracfg controller: %ld\n",
> > +			PTR_ERR(infracfg));
> > +		return PTR_ERR(infracfg);
> > +	}
> > +
> > +	smi_comm = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +						   SMIC);
> > +	if (IS_ERR(smi_comm)) {
> > +		dev_err(&pdev->dev,
> > +			"Cannot find bus smi_comm controller: %ld\n",
> > +			PTR_ERR(smi_comm));
> > +		return PTR_ERR(smi_comm);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int add_clk_to_list(struct platform_device *pdev,
> > +			   const char *name,
> > +			   const char *scpd_n)
> > +{
> > +	struct clk *clk;
> > +	struct ext_clk_ctrl *cc;
> > +
> > +	clk = devm_clk_get(&pdev->dev, name);
> > +	if (IS_ERR(clk)) {
> > +		dev_err(&pdev->dev, "Failed add clk %ld\n", PTR_ERR(clk));
> > +		return PTR_ERR(clk);
> > +	}
> > +
> > +	cc = kzalloc(sizeof(*cc), GFP_KERNEL);
> > +	cc->clk = clk;
> > +	cc->scpd_n = kstrdup(scpd_n, GFP_KERNEL);
> > +
> > +	list_add(&cc->clk_list, &ext_clk_map_list);
> > +
> > +	return 0;
> > +}
> > +
> > +static int add_cg_to_list(struct platform_device *pdev)
> > +{
> > +	int i = 0;
> > +
> > +	struct device_node *node = pdev->dev.of_node;
> > +
> > +	if (!node) {
> > +		dev_err(&pdev->dev, "Cannot find topcksys node: %ld\n",
> 
> Why topcksys? Shouldn't that be the node of scpsys?


it's typo.we will fix it.

> 
> > +			PTR_ERR(node));
> > +		return PTR_ERR(node);
> > +	}
> > +
> > +	do {
> > +		const char *ck_name;
> > +		char *temp_str;
> > +		char *tok[2] = {NULL};
> > +		int cg_idx = 0;
> > +		int idx = 0;
> > +		int ret = 0;
> > +
> > +		ret = of_property_read_string_index(node, "clock-names", i,
> > +						    &ck_name);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		temp_str = kmalloc_array(strlen(ck_name), sizeof(char),
> > +					 GFP_KERNEL | __GFP_ZERO);
> > +		memcpy(temp_str, ck_name, strlen(ck_name));
> > +		temp_str[strlen(ck_name)] = '\0';
> 
> why don't you use kstrdup or similar?


we will fix it.

> 
> > +		do {
> > +			tok[idx] = strsep(&temp_str, "-");
> > +			idx++;
> > +		} while (temp_str);
> 
> You want to split the clock name like "mm-2" in
> char **tok = {"mm", "2"};
> correct? That can be done easier AFAIK:
> tok[0] = strsep(&temp_str, "-");
> tok[1] = &temp_str;

we will fix it.

> 
> > +
> > +		if (idx == 2) {
> 
> You don't add clocks like "mfg" and "mm". Why?

it's not the same, "mm" and "mfg" belong to mux, not a cg.and mux is
handle by mtk_scpsys.c
 
> 
> > +			if (kstrtouint(tok[1], 10, &cg_idx))
> i
> And then? You don't do anything with cg_idx..t

yes, we will delete this check.

> 
> > +				return -EINVAL;
> > +
> > +			if (add_clk_to_list(pdev, ck_name, tok[0]))
> 
> add_clk_to_list third parameter is the name of the scp domain, but you pass the
> clock name here. I'm puzzled.

yes, our idea is to set the prefix same as scp domain name, so we can
find the correct cg clks which belong to relative scp domain.
ex: "mm-0""mm-1" need to enable for "mm" scp domain power control flow.

> 
> > +				return -EINVAL;
> > +		}
> > +		kfree(temp_str);
> > +		i++;
> > +	} while (1);
> > +
> > +	return 0;
> > +}
> > +
> > +int scpsys_ext_clk_init(struct platform_device *pdev)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = add_cg_to_list(pdev);
> > +	if (ret)
> > +		goto err;
> > +
> > +err:
> > +	return ret;
> > +}
> 
> Why do we need add_cg_to_list, it can be implemented directly here. Why is here
> a goto to a return statement that will be executed anyway? Please go through the
> code and check that it is clean before submitting.

yes, we will fix it.

> 
> > +
> > +int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
> > +{
> > +	int i, count = 0;
> > +
> > +	for (i = 0; i < data->num_attr; i++) {
> > +		struct scpsys_ext_attr *node = data->attr + i;
> > +
> > +		if (!node)
> > +			continue;
> > +
> > +		list_add(&node->attr_list, &ext_attr_map_list);
> > +		count++;
> > +	}
> > +
> > +	if (!count)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id of_scpsys_ext_match_tbl[] = {
> > +	{
> > +		/* sentinel */
> > +	}
> > +};
> > +
> > +struct scpsys_ext_data *scpsys_ext_init(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *match;
> > +	struct scpsys_ext_data *data;
> > +	int ret;
> > +
> > +	match = of_match_device(of_scpsys_ext_match_tbl, &pdev->dev);
> > +
> > +	if (!match) {
> > +		dev_err(&pdev->dev, "no match\n");
> > +		return ERR_CAST(match);
> > +	}
> > +
> > +	data = (struct scpsys_ext_data *)match->data;
> > +	if (IS_ERR(data)) {
> > +		dev_err(&pdev->dev, "no match scpext data\n");
> > +		return ERR_CAST(data);
> > +	}
> > +
> > +	ret = scpsys_ext_attr_init(data);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to init bus attr: %d\n",
> > +			ret);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	ret = scpsys_ext_regmap_init(pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to init bus register: %d\n",
> > +			ret);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	ret = scpsys_ext_clk_init(pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to init bus clks: %d\n",
> > +			ret);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return data;
> > +}
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 4bb6c7a..03df2d6 100644
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
> > @@ -117,6 +119,15 @@ enum clk_id {
> >  
> >  #define MAX_CLKS	3
> >  
> > +/**
> > + * struct scp_domain_data - scp domain data for power on/off flow
> > + * @name: The domain name.
> > + * @sta_mask: The mask for power on/off status bit.
> > + * @ctl_offs: The offset for main power control register.
> > + * @sram_pdn_bits: The mask for sram power control bits.
> > + * @sram_pdn_ack_bits The mask for sram power control acked bits.
> > + * @caps: The flag for active wake-up action.
> > + */
> >  struct scp_domain_data {
> >  	const char *name;
> >  	u32 sta_mask;
> > @@ -150,7 +161,7 @@ struct scp {
> >  	void __iomem *base;
> >  	struct regmap *infracfg;
> >  	struct scp_ctrl_reg ctrl_reg;
> > -	bool bus_prot_reg_update;
> > +	struct scpsys_ext_data *ext_data;
> >  };
> >  
> >  struct scp_subdomain {
> > @@ -164,7 +175,6 @@ struct scp_soc_data {
> >  	const struct scp_subdomain *subdomains;
> >  	int num_subdomains;
> >  	const struct scp_ctrl_reg regs;
> > -	bool bus_prot_reg_update;
> >  };
> >  
> >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> > @@ -236,6 +246,31 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  	val |= PWR_RST_B_BIT;
> >  	writel(val, ctl_addr);
> >  
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->cg_ops) {
> > +			ret = attr->cg_ops->enable(attr);
> > +			if (ret)
> > +				goto err_ext_clk;
> > +		}
> > +	}
> > +
> > +	val &= ~scpd->data->sram_pdn_bits;
> > +	writel(val, ctl_addr);
> > +
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->cg_ops) {
> > +			ret = attr->cg_ops->enable(attr);
> > +			if (ret)
> > +				goto err_ext_clk;
> > +		}
> > +	}
> > +
> >  	val &= ~scpd->data->sram_pdn_bits;
> >  	writel(val, ctl_addr);
> >  
> > @@ -247,25 +282,65 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  		 * applied here.
> >  		 */
> >  		usleep_range(12000, 12100);
> > -
> >  	} else {
> >  		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> >  					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >  		if (ret < 0)
> > -			goto err_pwr_ack;
> > +			goto err_sram;
> >  	}
> >  
> >  	if (scpd->data->bus_prot_mask) {
> >  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > -				scpd->data->bus_prot_mask,
> > -				scp->bus_prot_reg_update);
> > +				scpd->data->bus_prot_mask);
> >  		if (ret)
> > -			goto err_pwr_ack;
> > +			goto err_sram;
> > +	}
> > +
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->bus_ops) {
> > +			ret = attr->bus_ops->disable(attr);
> > +			if (ret)
> > +				goto err_sram;
> > +		}
> > +	}
> > +
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->cg_ops) {
> > +			ret = attr->cg_ops->disable(attr);
> > +			if (ret)
> > +				goto err_sram;
> > +		}
> >  	}
> >  
> >  	return 0;
> >  
> > +err_sram:
> > +	val = readl(ctl_addr);
> > +	val |= scpd->data->sram_pdn_bits;
> > +	writel(val, ctl_addr);
> > +err_ext_clk:
> > +	val = readl(ctl_addr);
> > +	val |= PWR_ISO_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val &= ~PWR_RST_B_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val |= PWR_CLK_DIS_BIT;
> > +	writel(val, ctl_addr);
> >  err_pwr_ack:
> > +	val &= ~PWR_ON_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val &= ~PWR_ON_2ND_BIT;
> > +	writel(val, ctl_addr);
> > +
> >  	for (i = MAX_CLKS - 1; i >= 0; i--) {
> >  		if (scpd->clk[i])
> >  			clk_disable_unprepare(scpd->clk[i]);
> > @@ -274,8 +349,6 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  	if (scpd->supply)
> >  		regulator_disable(scpd->supply);
> >  
> > -	dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
> > -
> >  	return ret;
> >  }
> >  
> > @@ -289,14 +362,35 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >  	int ret, tmp;
> >  	int i;
> >  
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->cg_ops) {
> > +			ret = attr->cg_ops->enable(attr);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +	}
> > +
> >  	if (scpd->data->bus_prot_mask) {
> >  		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > -				scpd->data->bus_prot_mask,
> > -				scp->bus_prot_reg_update);
> > +				scpd->data->bus_prot_mask);
> >  		if (ret)
> >  			goto out;
> >  	}
> >  
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->bus_ops) {
> > +			ret = attr->bus_ops->enable(attr);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +	}
> > +
> >  	val = readl(ctl_addr);
> >  	val |= scpd->data->sram_pdn_bits;
> >  	writel(val, ctl_addr);
> > @@ -307,6 +401,17 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >  	if (ret < 0)
> >  		goto out;
> >  
> > +	if (!IS_ERR(scp->ext_data)) {
> > +		struct scpsys_ext_attr *attr;
> > +
> > +		attr = scp->ext_data->get_attr(scpd->data->name);
> > +		if (!IS_ERR(attr) && attr->cg_ops) {
> > +			ret = attr->cg_ops->disable(attr);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +	}
> > +
> >  	val |= PWR_ISO_BIT;
> >  	writel(val, ctl_addr);
> >  
> > @@ -337,8 +442,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >  	return 0;
> >  
> >  out:
> > -	dev_err(scp->dev, "Failed to power off domain %s\n", genpd->name);
> > -
> >  	return ret;
> >  }
> >  
> > @@ -352,8 +455,7 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> >  
> >  static struct scp *init_scp(struct platform_device *pdev,
> >  			const struct scp_domain_data *scp_domain_data, int num,
> > -			const struct scp_ctrl_reg *scp_ctrl_reg,
> > -			bool bus_prot_reg_update)
> > +			const struct scp_ctrl_reg *scp_ctrl_reg)
> >  {
> >  	struct genpd_onecell_data *pd_data;
> >  	struct resource *res;
> > @@ -367,11 +469,10 @@ static struct scp *init_scp(struct platform_device *pdev,
> >  
> >  	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
> >  	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
> > -
> > -	scp->bus_prot_reg_update = bus_prot_reg_update;
> > -
> >  	scp->dev = &pdev->dev;
> >  
> > +	scp->ext_data = scpsys_ext_init(pdev);
> > +
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	scp->base = devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(scp->base))
> > @@ -1021,7 +1122,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> >  	},
> > -	.bus_prot_reg_update = true,
> >  };
> >  
> >  static const struct scp_soc_data mt2712_data = {
> > @@ -1033,7 +1133,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> >  	},
> > -	.bus_prot_reg_update = false,
> >  };
> >  
> >  static const struct scp_soc_data mt6765_data = {
> > @@ -1056,7 +1155,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
> >  	},
> > -	.bus_prot_reg_update = true,
> 
> I don't understand why you can delete this flag if you don't change anything
> else in the data structure. For me this looks like you will break other chips.
> Please explain.
> 
> I have the gut feeling that this can be implemented in the existing mtk-scpsys
> driver. Can you please explain what are the points that this is not possible.
> I want to understand the design decisions you made here, because they seem
> really odd to me.
> 
> Best regards,
> Matthias
> 

sorry, it should not be deleted. we will fix it.

> >  };
> >  
> >  static const struct scp_soc_data mt7622_data = {
> > @@ -1066,7 +1164,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> >  	},
> > -	.bus_prot_reg_update = true,
> >  };
> >  
> >  static const struct scp_soc_data mt7623a_data = {
> > @@ -1076,7 +1173,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> >  	},
> > -	.bus_prot_reg_update = true,
> >  };
> >  
> >  static const struct scp_soc_data mt8173_data = {
> > @@ -1088,7 +1184,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >  		.pwr_sta_offs = SPM_PWR_STATUS,
> >  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> >  	},
> > -	.bus_prot_reg_update = true,
> >  };
> >  
> >  /*
> > @@ -1132,8 +1227,8 @@ static int scpsys_probe(struct platform_device *pdev)
> >  
> >  	soc = of_device_get_match_data(&pdev->dev);
> >  
> > -	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
> > -			soc->bus_prot_reg_update);
> > +	scp = init_scp(pdev, soc->domains, soc->num_domains,
> > +		       &soc->regs);
> >  	if (IS_ERR(scp))
> >  		return PTR_ERR(scp);
> >  
> > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > index fd25f01..bfad082 100644
> > --- a/include/linux/soc/mediatek/infracfg.h
> > +++ b/include/linux/soc/mediatek/infracfg.h
> > @@ -32,8 +32,9 @@
> >  #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> >  						 BIT(7) | BIT(8))
> >  
> > -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> > -		bool reg_update);
> > -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > -		bool reg_update);
> > +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
> > +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
> > +int mtk_infracfg_enable_bus_protection(struct regmap *infracfg, u32 mask);
> > +int mtk_infracfg_disable_bus_protection(struct regmap *infracfg, u32 mask);
> > +
> >  #endif /* __SOC_MEDIATEK_INFRACFG_H */
> > diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
> > new file mode 100644
> > index 0000000..99b5ff1
> > --- /dev/null
> > +++ b/include/linux/soc/mediatek/scpsys-ext.h
> > @@ -0,0 +1,66 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
> > +#define __SOC_MEDIATEK_SCPSYS_EXT_H
> > +
> > +#include <linux/platform_device.h>
> > +
> > +#define CMD_ENABLE	1
> > +#define CMD_DISABLE	0
> > +
> > +#define MAX_STEP_NUM	4
> > +
> > +/**
> > + * struct bus_mask - set mask and corresponding operation for bus protect
> > + * @regs: The register set of bus register control, including set/clr/sta.
> > + * @mask: The mask set for bus protect.
> > + * @flag: The flag to idetify which operation we take for bus protect.
> > + */
> > +struct bus_mask {
> > +	struct ext_reg_ctrl *regs;
> > +	u32 mask;
> > +	const struct bus_mask_ops *ops;
> > +};
> > +
> > +/**
> > + * struct scpsys_ext_attr - extended attribute for bus protect and further
> > + *                                           operand.
> > + *
> > + * @scpd_n: The name present the scpsys domain where the clks belongs to.
> > + * @mask: The mask set for bus protect.
> > + * @bus_ops: The operation we take for bus protect.
> > + * @cg_ops: The operation we take for cg on/off.
> > + * @attr_list: The list node linked to ext_attr_map_list.
> > + */
> > +struct scpsys_ext_attr {
> > +	const char *scpd_n;
> > +	struct bus_mask mask[MAX_STEP_NUM];
> > +	const char *parent_n;
> > +	const struct bus_ext_ops *bus_ops;
> > +	const struct bus_ext_ops *cg_ops;
> > +
> > +	struct list_head attr_list;
> > +};
> > +
> > +struct scpsys_ext_data {
> > +	struct scpsys_ext_attr *attr;
> > +	u8 num_attr;
> > +	struct scpsys_ext_attr * (*get_attr)(const char *scpd_n);
> > +};
> > +
> > +struct bus_ext_ops {
> > +	int	(*enable)(struct scpsys_ext_attr *attr);
> > +	int	(*disable)(struct scpsys_ext_attr *attr);
> > +};
> > +
> > +int mtk_generic_set_cmd(struct regmap *regmap, u32 set_ofs,
> > +			u32 sta_ofs, u32 mask);
> > +int mtk_generic_clr_cmd(struct regmap *regmap, u32 clr_ofs,
> > +			u32 sta_ofs, u32 mask);
> > +int mtk_generic_enable_cmd(struct regmap *regmap, u32 upd_ofs,
> > +			   u32 sta_ofs, u32 mask);
> > +int mtk_generic_disable_cmd(struct regmap *regmap, u32 upd_ofs,
> > +			    u32 sta_ofs, u32 mask);
> > +
> > +struct scpsys_ext_data *scpsys_ext_init(struct platform_device *pdev);
> > +
> > +#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
> > 


