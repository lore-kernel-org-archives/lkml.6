Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A270C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79F62157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79F62157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeHXLNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:13:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeHXLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:13:48 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ft6hY-0005MC-KX; Fri, 24 Aug 2018 09:40:12 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ft6hX-00063Z-14; Fri, 24 Aug 2018 09:40:11 +0200
Date:   Fri, 24 Aug 2018 09:40:11 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        linux-clk@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Message-ID: <20180824074011.lufm653imkf6fyd3@pengutronix.de>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:28:17 up 72 days, 16:37, 76 users,  load average: 0.04, 0.06,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Andrey Smirnov who made me aware of this issue.

On Wed, Aug 22, 2018 at 04:48:21PM +0300, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> The driver currently misses the PLL lock check, as the preliminary
> documentation mentions lock configurations, but is quiet about where
> to find the actual lock status signal.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
> +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +	u32 val;
> +	u32 divf;
> +
> +	divf = rate / (parent_rate * 2);
> +
> +	val = readl_relaxed(pll->base + PLL_CFG2);
> +	val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> +	val |= (divf - 1) << PLL_DIVF1_SHIFT;
> +	writel_relaxed(val, pll->base + PLL_CFG2);
> +
> +	/* FIXME: PLL lock check */

Shouldn't be too hard to add, no?

> +
> +	return 0;
> +}
> +
> +static int clk_pll1_prepare(struct clk_hw *hw)
> +{
> +	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->base);
> +	val &= ~(1 << PLL_PD);
> +	writel_relaxed(val, pll->base);

pll->base + PLL_CFG0 please.

> +static const struct clk_ops clk_sccg_pll1_ops = {
> +	.is_prepared	= clk_pll1_is_prepared,
> +	.recalc_rate	= clk_pll1_recalc_rate,
> +	.round_rate	= clk_pll1_round_rate,
> +	.set_rate	= clk_pll1_set_rate,
> +};
> +
> +static const struct clk_ops clk_sccg_pll2_ops = {
> +	.prepare	= clk_pll1_prepare,
> +	.unprepare	= clk_pll1_unprepare,
> +	.recalc_rate	= clk_pll2_recalc_rate,
> +	.round_rate	= clk_pll2_round_rate,
> +	.set_rate	= clk_pll2_set_rate,
> +};

So these are two PLLs that share the same enable register. Doing the
prepare/unprepare for only one PLL can lead to all kinds of trouble.
Finding a good abstraction the properly handles this case with the
clock framework is probably also not easy.

I could imagine we'll need to track the enable state on both PLLs and
only if both are disabled we disable it in hardware.

With the current code we disable the PLLs when all consumers are
reparented to pll1, which probably has bad effects.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
