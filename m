Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C0820C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C0820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeIXMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:48:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37759 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:48:04 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1g4KeA-0003In-Py; Mon, 24 Sep 2018 08:47:06 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1g4Ke7-0007IH-SK; Mon, 24 Sep 2018 08:47:03 +0200
Date:   Mon, 24 Sep 2018 08:47:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-imx@nxp.com,
        Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 4/5] clk: imx: add imx composite clock
Message-ID: <20180924064703.GY4097@pengutronix.de>
References: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
 <1537531894-18499-5-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537531894-18499-5-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:39:50 up 129 days, 18:20, 153 users,  load average: 0.68, 1.36,
 1.30
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Fri, Sep 21, 2018 at 03:11:33PM +0300, Abel Vesa wrote:
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one composite clock,
> but we need to deal with both predivider and divider at the same time and
> therefore we add the imx_clk_composite_divider_ops and register the composite
> clock with those.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 156 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |  14 ++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
> 
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +					unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	unsigned long prediv_rate;
> +	unsigned long flags = 0;
> +	int prediv_value;
> +	int div_value;
> +	u32 val;
> +
> +	prediv_value = divider_get_val(rate, parent_rate, NULL,
> +				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +	if (prediv_value < 0)
> +		return prediv_value;
> +
> +	prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
> +
> +	div_value = divider_get_val(rate, prediv_rate, NULL,
> +				PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +	if (div_value < 0)
> +		return div_value;

Does this work with expected accuracy? Consider the best divider you are
looking for is 9. With the above you'll end up with a predivider of 8
and a postdivider of 1 instead of the optimum divider values of 3 and 3.

I think you have to iterate over all possible divider combinations and
then use the best one found. The original divider code does this, albeit
a little obfuscated.

You have to do the same in round_rate aswell.

Sorry, I missed that when I last looked at it in v6.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
