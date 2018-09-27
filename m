Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057BBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92722152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92722152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeI0XSH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:18:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60494 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbeI0XSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:18:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E0F8C20795; Thu, 27 Sep 2018 18:58:53 +0200 (CEST)
Received: from localhost (unknown [91.116.141.28])
        by mail.bootlin.com (Postfix) with ESMTPSA id 98FDB20730;
        Thu, 27 Sep 2018 18:58:53 +0200 (CEST)
Date:   Thu, 27 Sep 2018 18:58:53 +0200
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
Subject: Re: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Message-ID: <20180927165853.dpluekbqzat663q7@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180927114850.24565-8-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
> TCON DRQ set bits for non-burst DSI mode can computed via
> horizontal front porch instead of front porch + sync timings.
>
> Since there no documentation for TCON_DRQ_REG(0x7c) register
> this change is taken as reference from BPI-M64-bsp.

Detailing more what the issue is would be great.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 599284971ab6..9918fdb990ff 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>  	struct mipi_dsi_device *device = dsi->device;
>  	u32 val = 0;

The computation here is in the A64 driver:

if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
	dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode = 0;
} else {
	dsi_dev[sel]->dsi_tcon_drq.bits.drq_set	=
		(panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
		dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
}

It is testing that the sync + front porch is smaller than 21, and
otherwise sets the drq.

> -	if ((mode->hsync_end - mode->hdisplay) > 20) {

My code here is testing that the difference between hsync_end and
hdisplay is superior to 20, and sets the DRQ if true. The condition is
reversed, but otherwise, that difference is the front porch plus the
sync length.

> +	if ((mode->hsync_start - mode->hdisplay) > 20) {

However, you are testing for just the front porch, unlike what your
commit log is saying, and unlike what allwinner's code is saying. So
this deserves some explanation.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
