Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2BC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA492159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA492159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeI0Xhu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:37:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32803 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeI0Xhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:37:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 43E80207CF; Thu, 27 Sep 2018 19:18:31 +0200 (CEST)
Received: from localhost (unknown [91.116.141.28])
        by mail.bootlin.com (Postfix) with ESMTPSA id 008FD20795;
        Thu, 27 Sep 2018 19:18:30 +0200 (CEST)
Date:   Thu, 27 Sep 2018 19:18:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 05/12] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
Message-ID: <20180927171831.2nfybgn2xmc4vrgt@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180927114850.24565-6-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:18:43PM +0530, Jagan Teki wrote:
> Short transfer write support for DCS and Generic transfer types
> share similar way to process command sequence in DSI block so
> add generic write 2 param transfer type macro so-that the panels
> which are requesting similar transfer type may process properly.
> 
> Also added error check for unsupporting transfer types this make
> debugging easy for new transfer types.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 156b371243c6..1c7e42015645 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -869,6 +869,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
>  		     SUN6I_DSI_CMD_CTL_TX_FLAG);
>  
>  	switch (msg->type) {
> +	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
>  	case MIPI_DSI_DCS_SHORT_WRITE:
>  	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:

You should order them by alphabetical order.

>  		ret = sun6i_dsi_dcs_write_short(dsi, msg);
> @@ -885,6 +886,8 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
>  		}
>  
>  	default:
> +		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> +			msg->type);

And this isn't an error check.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
