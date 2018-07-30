Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FBFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A502C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A502C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeG3L4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:56:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41123 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeG3L4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:56:35 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fk5JR-0007qR-ST; Mon, 30 Jul 2018 12:22:01 +0200
Message-ID: <1532946112.3471.2.camel@pengutronix.de>
Subject: Re: [PATCH 7/9] clk: actions: Add Actions Semi Owl SoCs Reset
 Management Unit support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Date:   Mon, 30 Jul 2018 12:21:52 +0200
In-Reply-To: <20180727184527.13287-8-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
         <20180727184527.13287-8-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

Thank you for the patch, a few small comments below:

On Sat, 2018-07-28 at 00:15 +0530, Manivannan Sadhasivam wrote:
> Add Reset Management Unit (RMU) support for Actions Semi Owl SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/actions/Kconfig      |  1 +
>  drivers/clk/actions/Makefile     |  1 +
>  drivers/clk/actions/owl-common.h |  2 +
>  drivers/clk/actions/owl-reset.c  | 72 ++++++++++++++++++++++++++++++++
>  drivers/clk/actions/owl-reset.h  | 32 ++++++++++++++
>  5 files changed, 108 insertions(+)
>  create mode 100644 drivers/clk/actions/owl-reset.c
>  create mode 100644 drivers/clk/actions/owl-reset.h
> 
> diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> index dc38c85a4833..04f0a6355726 100644
> --- a/drivers/clk/actions/Kconfig
> +++ b/drivers/clk/actions/Kconfig
> @@ -2,6 +2,7 @@ config CLK_ACTIONS
>  	bool "Clock driver for Actions Semi SoCs"
>  	depends on ARCH_ACTIONS || COMPILE_TEST
>  	select REGMAP_MMIO
> +	select RESET_CONTROLLER
>  	default ARCH_ACTIONS
>  
>  if CLK_ACTIONS
> diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> index 78c17d56f991..ccfdf9781cef 100644
> --- a/drivers/clk/actions/Makefile
> +++ b/drivers/clk/actions/Makefile
> @@ -7,6 +7,7 @@ clk-owl-y			+= owl-divider.o
>  clk-owl-y			+= owl-factor.o
>  clk-owl-y			+= owl-composite.o
>  clk-owl-y			+= owl-pll.o
> +clk-owl-y			+= owl-reset.o
>  
>  # SoC support
>  obj-$(CONFIG_CLK_OWL_S700)	+= owl-s700.o
> diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
> index 56f01f7774aa..4dc7f286831f 100644
> --- a/drivers/clk/actions/owl-common.h
> +++ b/drivers/clk/actions/owl-common.h
> @@ -26,6 +26,8 @@ struct owl_clk_desc {
>  	struct owl_clk_common		**clks;
>  	unsigned long			num_clks;
>  	struct clk_hw_onecell_data	*hw_clks;
> +	struct owl_reset_map		*resets;

Could this be:
	const struct owl_reset_map	*resets;
?

> +	unsigned long			num_resets;
>  	struct regmap			*regmap;
>  };
>  
> diff --git a/drivers/clk/actions/owl-reset.c b/drivers/clk/actions/owl-reset.c
> new file mode 100644
> index 000000000000..91b161cc68de
> --- /dev/null
> +++ b/drivers/clk/actions/owl-reset.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Actions Semi Owl SoCs Reset Management Unit driver
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>

This seems unnecessary, since register access is done via regmap.

> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include "owl-reset.h"
> +
> +static int owl_reset_assert(struct reset_controller_dev *rcdev,
> +			    unsigned long id)
> +{
> +	struct owl_reset *reset = to_owl_reset(rcdev);
> +	const struct owl_reset_map *map = &reset->reset_map[id];
> +	u32 reg;
> +
> +	regmap_read(reset->regmap, map->reg, &reg);
> +	regmap_write(reset->regmap, map->reg, reg & ~map->bit);

This read-modify-write sequence needs locking against concurrent
register access. Better use regmap_update_bits():

	return regmap_update_bits(reset->regmap, map->reg, map->bit, 0);

> +
> +	return 0;
> +}
> +
> +static int owl_reset_deassert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct owl_reset *reset = to_owl_reset(rcdev);
> +	const struct owl_reset_map *map = &reset->reset_map[id];
> +	u32 reg;
> +
> +	regmap_read(reset->regmap, map->reg, &reg);
> +	regmap_write(reset->regmap, map->reg, reg | map->bit);

Better:

	return regmap_update_bits(reset->regmap, map->reg, map->bit, map->bit);

> +
> +	return 0;
> +}
> +
> +static int owl_reset_reset(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	owl_reset_assert(rcdev, id);
> +	udelay(1);

Is the delay valid for all IP cores on all SoCs variants?

> +	owl_reset_deassert(rcdev, id);
> +
> +	return 0;
> +}
> +
> +static int owl_reset_status(struct reset_controller_dev *rcdev,
> +			    unsigned long id)
> +{
> +	struct owl_reset *reset = to_owl_reset(rcdev);
> +	const struct owl_reset_map *map = &reset->reset_map[id];
> +	u32 reg;
> +
> +	regmap_read(reset->regmap, map->reg, &reg);

If this could return an error, better report it.

> +
> +	/*
> +	 * The reset control API expects 0 if reset is not asserted,
> +	 * which is the opposite of what our hardware uses.
> +	 */
> +	return !(map->bit & reg);
> +}
> +
> +const struct reset_control_ops owl_reset_ops = {
> +	.assert		= owl_reset_assert,
> +	.deassert	= owl_reset_deassert,
> +	.reset		= owl_reset_reset,
> +	.status		= owl_reset_status,
> +};
> diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
> new file mode 100644
> index 000000000000..1a5e987ba99b
> --- /dev/null
> +++ b/drivers/clk/actions/owl-reset.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Actions Semi Owl SoCs Reset Management Unit driver
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +#ifndef _OWL_RESET_H_
> +#define _OWL_RESET_H_
> +
> +#include <linux/reset-controller.h>
> +#include <linux/spinlock.h>

spinlock?

> +
> +struct owl_reset_map {
> +	u16	reg;

Note that this will be aligned to 32-bits. If the intention was to save
space, consider storing an u8 bit index instead of the mask.

> +	u32	bit;
> +};
> +
> +struct owl_reset {
> +	struct reset_controller_dev	rcdev;
> +	struct owl_reset_map		*reset_map;

Could this be
	const struct owl_reset_map	*reset_map;
?

> +	struct regmap			*regmap;
> +};
> +
> +static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct owl_reset, rcdev);
> +}
> +
> +extern const struct reset_control_ops owl_reset_ops;
> +
> +#endif /* _OWL_RESET_H_ */

regards
Philipp
