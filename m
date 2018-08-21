Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDB6214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDB6214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeHUKRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:17:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUKRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:17:36 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fs0ca-0001yE-52; Tue, 21 Aug 2018 08:58:32 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fs0cZ-0002mA-04; Tue, 21 Aug 2018 08:58:31 +0200
Date:   Tue, 21 Aug 2018 08:58:30 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND v5 4/5] clk: imx: add imx composite clock
Message-ID: <20180821065830.x5illrgyqct6h3nf@pengutronix.de>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
 <1534749367-31085-5-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534749367-31085-5-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:55:30 up 69 days, 16:04, 73 users,  load average: 0.31, 0.15,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 10:16:06AM +0300, Abel Vesa wrote:
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one more complex
> clock type, therefore moving the complexity inside the composite clock and
> outside of the SoC specific clock driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 126 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |   9 +++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b87513c..4fabb0a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -3,6 +3,7 @@
>  obj-y += \
>  	clk.o \
>  	clk-busy.o \
> +	clk-composite.o \
>  	clk-cpu.o \
>  	clk-fixup-div.o \
>  	clk-fixup-mux.o \
> diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
> new file mode 100644
> index 0000000..717c6f1
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +
> +#include "clk.h"
> +
> +#define PCG_PREDIV_SHIFT	16
> +#define PCG_PREDIV_WIDTH	3
> +
> +#define PCG_DIV_SHIFT		0
> +#define PCG_DIV_WIDTH		6
> +
> +#define PCG_PCS_SHIFT		24
> +#define PCG_PCS_MASK		0x7
> +
> +#define PCG_CGC_SHIFT		28
> +
> +static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +						unsigned long rate,
> +						unsigned long *prate)
> +{
> +	return clk_divider_ops.round_rate(hw, rate, prate);
> +}
> +
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +					unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	int value;
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	value = divider_get_val(rate, parent_rate, NULL,
> +				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +	if (value < 0)
> +		return value;
> +
> +	spin_lock_irqsave(divider->lock, flags);
> +
> +	val = clk_readl(divider->reg);
> +	val &= ~((clk_div_mask(divider->width) << divider->shift) |
> +			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
> +
> +	val |= (u32)value << divider->shift;
> +	val |= (u32)value << PCG_DIV_SHIFT;
> +	clk_writel(val, divider->reg);
> +
> +	spin_unlock_irqrestore(divider->lock, flags);
> +
> +	return 0;
> +}

Have you tested this works? I thought those are two cascaded dividers
and you program both to the same value. Normally you would have to
calculate individual values for each divider which together give you the
desired output rate.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
