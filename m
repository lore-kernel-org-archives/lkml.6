Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CEDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD872087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfAROQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:16:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44735 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfAROQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:16:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AB378207B0; Fri, 18 Jan 2019 15:16:50 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr [109.213.9.46])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1671B207AC;
        Fri, 18 Jan 2019 15:16:49 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v4 4/4] clk: mvebu: armada-37xx-xtal: fill the device entry when registering the clock
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
        <20190108161940.4814-5-miquel.raynal@bootlin.com>
Date:   Fri, 18 Jan 2019 15:16:49 +0100
In-Reply-To: <20190108161940.4814-5-miquel.raynal@bootlin.com> (Miquel
        Raynal's message of "Tue, 8 Jan 2019 17:19:40 +0100")
Message-ID: <87won2m4oe.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> So far the clk_hw_register_fixed_factor() call was not providing any
> device structure. While doing so is harmless for regular use, the
> missing device structure may be a problem for suspend to RAM support.
>
> Since, device links have been added to clocks, links created during
> probe will enforce the suspend/resume orders. When the device is
> missing during the registration, no link can be established, hence the
> order between parent and child clocks are not enforced.
>
> Adding the device structure here will create a link between the XTAL
> clock (this one) and the four TBG clocks that are derived from it.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/clk/mvebu/armada-37xx-xtal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
> index e9e306d4e9af..0e74bcd83d1a 100644
> --- a/drivers/clk/mvebu/armada-37xx-xtal.c
> +++ b/drivers/clk/mvebu/armada-37xx-xtal.c
> @@ -57,7 +57,8 @@ static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
>  		rate = 25000000;
>  
>  	of_property_read_string_index(np, "clock-output-names", 0, &xtal_name);
> -	xtal_hw = clk_hw_register_fixed_rate(NULL, xtal_name, NULL, 0, rate);
> +	xtal_hw = clk_hw_register_fixed_rate(&pdev->dev, xtal_name, NULL, 0,
> +					     rate);
>  	if (IS_ERR(xtal_hw))
>  		return PTR_ERR(xtal_hw);
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, xtal_hw);
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
