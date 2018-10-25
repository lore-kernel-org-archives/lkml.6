Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D94C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473162082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sEI9X82g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473162082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJYV1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:27:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36901 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJYV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:27:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so1399415wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGI5V0bACew6PdE7vV/zsfxHeuxzdMtG/m4get3fz2s=;
        b=sEI9X82gebIxTu/HI7viYZudFR3otPGBcHP9zNimP4BUY/Oe4iDbQTZ+vbF8GER9JR
         ztgm4quEMiWQy8AHscLGsvsQzh4y26lF7mMXwghW4Dln9NIWh1CV0vGIh2RbPI6HndUa
         0zvyc+/TbbjY4OJdpr7XnGHMvbRJe/i8sRtJ/N5MaWQ8f93lYl4ivlI2ySRlpreLz5sg
         XcoYHfw7KrBsKQRBQ1ojJI1R69xekK8gWEaFEeDFLVut4dlfAVQ+YiLx+MEyi90UOSKz
         CgJ319toU/Q31vkV185DB7iOYYhR8xPOBv+Xg8ol6KEzMiD11mEogmozNkDHMZN4O/ey
         iAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGI5V0bACew6PdE7vV/zsfxHeuxzdMtG/m4get3fz2s=;
        b=rltA3SNwKge/P0J1/HjjJmYQjUmiJmsNakCsA7E+2m1P0A0vtEHafYhuZ22UAAKeIi
         XqhutLAFcaT3wrYpJldfLq6MkRlmTb3BXUIwmhS2nXaY07UURAcKo8uh7DOlh1GywsJv
         AzUw8KktDLG/fJGtVBupijal9ruVSCXLX49b49WiU8CX8flB6N7WfRhVgtgfMQM3+ekv
         xbAtJCd1O0AL/W5xUOb7HTRza1KJaK87z088EqnlEMflf/M/GUmBCZ9Qg3XQa4ZsTJyz
         mVlX/FM2tntVzHCwKopVsxVY9tAY9sKgHTQAcTdzdrhShtSeM5KKGEMf7+M1aeLOSPhM
         nelg==
X-Gm-Message-State: AGRZ1gJu1iOwAx25So1d1vl+rPqBBvUwMnRWR8MEs92KdaTj3WVtzLJW
        /EmEYczbSP72eLkeGjvjhMwdOA==
X-Google-Smtp-Source: AJdET5cXVFfvbeTUUzpFOQvPZbDkyd5lqL8hmWPDvzrH5sI83703EL/1rojI4/fguWI1I36j6D1SQA==
X-Received: by 2002:a1c:c187:: with SMTP id r129-v6mr1800817wmf.20.1540472095372;
        Thu, 25 Oct 2018 05:54:55 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h78-v6sm1470215wmd.4.2018.10.25.05.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 05:54:54 -0700 (PDT)
Message-ID: <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 25 Oct 2018 14:54:53 +0200
In-Reply-To: <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
         <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
         <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
         <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 19:48 +0800, Jianxin Pan wrote:
> Hi Jerome,
> 
> On 2018/10/24 17:01, Jerome Brunet wrote:
> > On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
> > > From: Yixun Lan <yixun.lan@amlogic.com>
> > > 
> > > The patch will add a MMC clock controller driver which used by MMC or NAND,
> > > It provide a mux and divider clock, and three phase clocks - core, tx, tx.
> > > 
> 
> [...]
> > > diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> > > index efaa70f..8b8ccbc 100644
> > > --- a/drivers/clk/meson/Kconfig
> > > +++ b/drivers/clk/meson/Kconfig
> > > @@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
> > >  	select COMMON_CLK_REGMAP_MESON
> > >  	select RESET_CONTROLLER
> > >  
> > > +config COMMON_CLK_MMC_MESON
> > > +	tristate "Meson MMC Sub Clock Controller Driver"
> > > +	depends on COMMON_CLK_AMLOGIC
> > 
> > COMMON_CLK_AMLOGIC is not something that is manually enabled
> > You should select it, not depends on it. Have a look at how it is done for the
> > other controller (like in v4.19)
> 
> OK. I will fix it.
> > 
> > > +	select MFD_SYSCON
> > > +	select REGMAP
> > 
> > this is already selected by COMMON_CLK_AMLOGIC, please drop this.
> 
> OK.
> > 
> > > +	help
> > > +	  Support for the MMC sub clock controller on Amlogic Meson Platform,
> > > +	  which include S905 (GXBB, GXL), A113D/X (AXG) devices.
> > > +	  Say Y if you want this clock enabled.
> > > +
> > >  config COMMON_CLK_REGMAP_MESON
> > >  	bool
> > >  	select REGMAP
> > > diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> > > index 39ce566..31c16d5 100644
> > > --- a/drivers/clk/meson/Makefile
> > > +++ b/drivers/clk/meson/Makefile
> > > @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> > >  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
> > >  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
> > >  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
> > > +obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
> > >  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> > > diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> > > index 305ee30..f96314d 100644
> > > --- a/drivers/clk/meson/clk-regmap.c
> > > +++ b/drivers/clk/meson/clk-regmap.c
> > > @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
> > >  				  clk_div_mask(div->width) << div->shift, val);
> > >  };
> > >  
> > > -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > +{
> > > +	struct clk_regmap *clk = to_clk_regmap(hw);
> > > +	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(clk->map, div->offset, &val);
> > > +	if (ret)
> > > +		return;
> > >  
> > > +	val &= (clk_div_mask(div->width) << div->shift);
> > > +	if (!val)
> > > +		regmap_update_bits(clk->map, div->offset,
> > > +				   clk_div_mask(div->width) << div->shift,
> > > +				   clk_div_mask(div->width));
> > 
> > This is wrong for several reasons:
> > * You should hard code the initial value in the driver.
> > * If shift is not 0, I doubt this will give the expected result.
> 
> The value 0x00 of divider means nand clock off then read/write nand register is forbidden.

That is not entirely true, you can access the clock register or you'd be in a
chicken and egg situation.

> Should we set the initial value in nand driver, or in sub emmc clk driver?

In the nand driver, which is the consumer of the clock. see my previous comments
about it.

If your device (nand in your case) needs a (sane) clock before doing anything
else, just call clk_set_rate() and enable it with clk_prepare_enable().

Look at our MMC driver, this is the first thing done after registering the
clocks.

The controller does no care at all about the clock rate or state. It is up to
the consumer to express their needs.

On a more general note:
I agree that having a 0 value for CLK_DIVIDER_ONE_BASED divider makes no sense.
If you think this point needs to be addressed, please:

* make separated generic patch
* against driver/clk/clk-divider.c 
* addressing specifically CLK_DIVIDER_ONE_BASED dividers (not all, as your
change does)
* with some comments explaining the intent.

>  
> > 
> > > +}
> > 
> > Please drop this. 
> > 
> > > +
> > > +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > >  const struct clk_ops clk_regmap_divider_ops = {
> > >  	.recalc_rate = clk_regmap_div_recalc_rate,
> > >  	.round_rate = clk_regmap_div_round_rate,
> > > @@ -122,6 +139,14 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
> > >  };
> > >  EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
> > >  
> > > +const struct clk_ops clk_regmap_divider_with_init_ops = {
> > > +	.recalc_rate = clk_regmap_div_recalc_rate,
> > > +	.round_rate = clk_regmap_div_round_rate,
> > > +	.set_rate = clk_regmap_div_set_rate,
> > > +	.init = clk_regmap_div_init,
> > > +};
> > > +EXPORT_SYMBOL_GPL(clk_regmap_divider_with_init_ops);
> > 
> > ... and this.
> > 
> > > +
> > >  const struct clk_ops clk_regmap_divider_ro_ops = {
> > >  	.recalc_rate = clk_regmap_div_recalc_rate,
> > >  	.round_rate = clk_regmap_div_round_rate,
> > > diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> > > index ed2d434..0ab7d37 100644
> > > --- a/drivers/clk/meson/clk-regmap.h
> > > +++ b/drivers/clk/meson/clk-regmap.h
> > > @@ -109,5 +109,6 @@ struct clk_regmap_mux_data {
> > >  
> > >  extern const struct clk_ops clk_regmap_mux_ops;
> > >  extern const struct clk_ops clk_regmap_mux_ro_ops;
> > > +extern const struct clk_ops clk_regmap_divider_with_init_ops;
> > 
> > ... and this as well.
> > 
> > There is no reason to to init the divider to something other than what it is
> > already when we register the clock controller.
> > 
> > If your consumer needs the clocks to be initialised, it should call
> > clk_set_rate()
> > 
> > >  
> > >  #endif /* __CLK_REGMAP_H */
> > > diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> > > new file mode 100644
> > > index 0000000..5555e3f
> > > --- /dev/null
> > > +++ b/drivers/clk/meson/mmc-clkc.c
> > > @@ -0,0 +1,296 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Amlogic Meson MMC Sub Clock Controller Driver
> > > + *
> > > + * Copyright (c) 2017 Baylibre SAS.
> > > + * Author: Jerome Brunet <jbrunet@baylibre.com>
> > > + *
> > > + * Copyright (c) 2018 Amlogic, inc.
> > > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/platform_device.h>
> > > +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> > > +
> > > +#include "clkc.h"
> > > +
> > > +/* clock ID used by internal driver */
> > > +#define CLKID_MMC_MUX			0
> > > +
> > > +#define   SD_EMMC_CLOCK		0
> > > +#define   CLK_DELAY_STEP_PS		200
> > > +#define   CLK_PHASE_STEP		30
> > > +#define   CLK_PHASE_POINT_NUM		(360 / CLK_PHASE_STEP)
> > > +
> > > +#define MUX_CLK_NUM_PARENTS		2
> > > +#define MMC_MAX_CLKS			5
> > > +
> > > +struct mmc_clkc_data {
> > > +	struct meson_clk_phase_delay_data	tx;
> > > +	struct meson_clk_phase_delay_data	rx;
> > > +};
> > > +
> > > +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> > > +	.offset		= SD_EMMC_CLOCK,
> > > +	.mask		= 0x3,
> > > +	.shift		= 6,
> > > +	.flags		= CLK_DIVIDER_ROUND_CLOSEST,

Missed that earlier

This flag makes no sense for a mux.
Anyway this particular mux should never round up has doing so would be unsafe.
The clock provided to the nand or the eMMC should be the requested or lower.

> > > +};
> > > +
> > > +static struct clk_regmap_div_data mmc_clkc_div_data = {
> > > +	.offset		= SD_EMMC_CLOCK,
> > > +	.shift		= 0,
> > > +	.width		= 6,
> > > +	.flags		= CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,

Same here, drop CLK_DIVIDER_ROUND_CLOSEST

> > > +};
> > > +
> > > +static struct meson_clk_phase_data mmc_clkc_core_phase = {
> > > +	.ph = {
> > > +		.reg_off	= SD_EMMC_CLOCK,
> > > +		.shift	= 8,
> > > +		.width	= 2,
> > > +	}
> > > +};
> > > +
> > > +static const struct mmc_clkc_data mmc_clkc_gx_data = {
> > > +	.tx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 10,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 16,
> > > +			.width	= 4,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +	.rx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 12,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 20,
> > > +			.width	= 4,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +};
> > > +
> > > +static const struct mmc_clkc_data mmc_clkc_axg_data = {
> > > +	.tx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 10,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 16,
> > > +			.width	= 6,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +	.rx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 12,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 22,
> > > +			.width	= 6,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +};
> > > +
> > > +static const struct of_device_id mmc_clkc_match_table[] = {
> > > +	{
> > > +		.compatible	= "amlogic,gx-mmc-clkc",
> > > +		.data		= &mmc_clkc_gx_data
> > > +	},
> > > +	{
> > > +		.compatible	= "amlogic,axg-mmc-clkc",
> > > +		.data		= &mmc_clkc_axg_data
> > > +	},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> > > +
> > > +static struct clk_regmap *
> > > +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
> > > +		      struct clk_init_data *init,
> > > +		      const char *suffix, void *data)
> > > +{
> > > +	struct clk_regmap *clk;
> > > +	char *name;
> > > +	int ret;
> > > +
> > > +	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> > > +	if (!clk)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
> > > +	if (!name)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	init->name = name;
> > > +
> > > +	clk->map = map;
> > > +	clk->data = data;
> > > +	clk->hw.init = init;
> > > +
> > > +	ret = devm_clk_hw_register(dev, &clk->hw);
> > > +	if (ret)
> > > +		clk = ERR_PTR(ret);
> > > +
> > > +	kfree(name);
> > > +	return clk;
> > > +}
> > > +
> > > +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
> > > +						struct regmap *map)
> > > +{
> > > +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> > > +	struct clk_init_data init;
> > > +	struct clk_regmap *mux;
> > > +	struct clk *clk;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> > > +		char name[8];
> > > +
> > > +		snprintf(name, sizeof(name), "clkin%d", i);
> > > +		clk = devm_clk_get(dev, name);
> > > +		if (IS_ERR(clk)) {
> > > +			if (clk != ERR_PTR(-EPROBE_DEFER))
> > > +				dev_err(dev, "Missing clock %s\n", name);
> > > +			return ERR_PTR((long)clk);
> > > +		}
> > > +
> > > +		parent_names[i] = __clk_get_name(clk);
> > > +	}
> > > +
> > > +	init.ops = &clk_regmap_mux_ops;
> > > +	init.flags = CLK_SET_RATE_PARENT;
> > > +	init.parent_names = parent_names;
> > > +	init.num_parents = MUX_CLK_NUM_PARENTS;
> > > +
> > > +	mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
> > > +	if (IS_ERR(mux))
> > > +		dev_err(dev, "Mux clock registration failed\n");
> > > +
> > > +	return mux;
> > > +}
> > > +
> > > +static struct clk_regmap *
> > > +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
> > > +				  char *suffix, const char *parent,
> > 
> > I would prefer if you passed the parent clk_hw pointer and call
> > clk_hw_get_name() in here
> 
> OK. I will fix it. Thanks for your review.
> > 
> > > +				  unsigned long flags,
> > > +				  const struct clk_ops *ops, void *data)
> > > +{
> > > +	struct clk_init_data init;
> > > +	struct clk_regmap *clk;
> > > +
> > > +	init.ops = ops;
> > > +	init.flags = flags;
> > > +	init.parent_names = (const char* const []){ parent, };
> > > +	init.num_parents = 1;
> > > +
> > > +	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> > > +	if (IS_ERR(clk))
> > > +		dev_err(dev, "Core %s clock registration failed\n", suffix);
> > > +
> > > +	return clk;
> > > +}
> > > +
> > > +static int mmc_clkc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct clk_hw_onecell_data *onecell_data;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct mmc_clkc_data *data;
> > > +	struct regmap *map;
> > > +	struct clk_regmap *mux, *div, *core, *rx, *tx;
> > 
> > You really don't need all these local variables ( I think I already pointed this
> > out in past reviews ...)
> > 
> > You can keep one struct clk_regmap *clk and store the clk->hw in the onecell
> > data right after registering the clock.
> 
> OK, I will remove them.
> > 
> > 
> > > +
> > > +	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> > > +	if (!data)
> > > +		return -ENODEV;
> > > +
> > > +	map = syscon_node_to_regmap(dev->of_node);
> > > +	if (IS_ERR(map)) {
> > > +		dev_err(dev, "could not find mmc clock controller\n");
> > > +		return PTR_ERR(map);
> > > +	}
> > > +
> > > +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> > > +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> > > +				    GFP_KERNEL);
> > > +	if (!onecell_data)
> > > +		return -ENOMEM;
> > > +
> > > +	mux = mmc_clkc_register_mux(dev, map);
> > > +	if (IS_ERR(mux))
> > > +		return PTR_ERR(mux);
> > > +
> > > +	div = mmc_clkc_register_clk_with_parent(dev, map, "div",
> > > +						clk_hw_get_name(&mux->hw),
> > > +						CLK_SET_RATE_PARENT,
> > > +						&clk_regmap_divider_with_init_ops,
> > > +						&mmc_clkc_div_data);
> > > +	if (IS_ERR(div))
> > > +		return PTR_ERR(div);
> > > +
> > > +	core = mmc_clkc_register_clk_with_parent(dev, map, "core",
> > > +						 clk_hw_get_name(&div->hw),
> > > +						 CLK_SET_RATE_PARENT,
> > > +						 &meson_clk_phase_ops,
> > > +						 &mmc_clkc_core_phase);
> > > +	if (IS_ERR(core))
> > > +		return PTR_ERR(core);
> > > +
> > > +	rx = mmc_clkc_register_clk_with_parent(dev, map, "rx",
> > > +					       clk_hw_get_name(&core->hw),  0,
> > > +					       &meson_clk_phase_delay_ops,
> > > +					       &data->rx);
> > > +	if (IS_ERR(rx))
> > > +		return PTR_ERR(rx);
> > > +
> > > +	tx = mmc_clkc_register_clk_with_parent(dev, map, "tx",
> > > +					       clk_hw_get_name(&core->hw),  0,
> > > +					       &meson_clk_phase_delay_ops,
> > > +					       &data->tx);
> > > +	if (IS_ERR(tx))
> > > +		return PTR_ERR(tx);
> > > +
> > > +	onecell_data->hws[CLKID_MMC_MUX]		= &mux->hw,
> > > +	onecell_data->hws[CLKID_MMC_DIV]		= &div->hw,
> > > +	onecell_data->hws[CLKID_MMC_PHASE_CORE]		= &core->hw,
> > > +	onecell_data->hws[CLKID_MMC_PHASE_RX]		= &rx->hw,
> > > +	onecell_data->hws[CLKID_MMC_PHASE_TX]		= &tx->hw,
> > > +	onecell_data->num				= MMC_MAX_CLKS;
> > > +
> > > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > > +					   onecell_data);
> > > +}
> > > +
> > > +static struct platform_driver mmc_clkc_driver = {
> > > +	.probe		= mmc_clkc_probe,
> > > +	.driver		= {
> > > +		.name	= "meson-mmc-clkc",
> > > +		.of_match_table = of_match_ptr(mmc_clkc_match_table),
> > > +	},
> > > +};
> > > +
> > > +module_platform_driver(mmc_clkc_driver);
> > 
> > This can be compiled as module so please append the proper:
> > MODULE_DESCRIPTION()
> > MODULE_AUTHOR()
> > MODULE_LICENSE()
> 
> OK. I will fix it in the next version.
> > 
> > .
> > 
> 
> 


