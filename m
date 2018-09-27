Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366EC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B652159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B652159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeI0XeL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:34:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60723 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeI0XeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:34:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0299120798; Thu, 27 Sep 2018 19:14:52 +0200 (CEST)
Received: from localhost (unknown [91.116.141.28])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0C4F2075C;
        Thu, 27 Sep 2018 19:14:51 +0200 (CEST)
Date:   Thu, 27 Sep 2018 19:14:51 +0200
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
Subject: Re: [PATCH 08/12] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
Message-ID: <20180927171451.7iqt2nt2log5qojf@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-9-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180927114850.24565-9-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:18:46PM +0530, Jagan Teki wrote:
> Accordingly to BPI-M64-bsp DE DSI code Video start delay
> can be computed by subtracting total vertical timing with
> front porch timing and with adding 1 delay line for TCON.

This is what the current code is doing as well.

> This patch simply add the start_delay logic from BPI-M64-bsp,
> w/o this new computation, the DSI on A64 encounter vblank time out.
> 
> [CRTC:36:crtc-0] vblank wait timed out
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 9918fdb990ff..217db74c6dc3 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>  					   struct drm_display_mode *mode)
>  {
> -	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> +	u32 vfp = mode->vsync_start - mode->vdisplay;

Again, this is wrong and contrary to what your commit log is saying.

The Allwinner code has:

u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
u32 dsi_start_delay = panel->lcd_vt - vfp + 1;

So, essentially:

vtotal - (vtotal - vdisplay - back porch) + 1

The backporch is hsync_total - hsync_end, so we end up, removing the
addition / removal of vtotal, with:

vdisplay - (vsync_total - vsync_end) + 1

The formula used there looks indeed different, but unlike what you
were saying.

> +	u32 start_delay;
> +
> +	start_delay = mode->vtotal - vfp + 1;
> +	if (start_delay > mode->vtotal)
> +		start_delay -= mode->vtotal;
> +
> +	if (!start_delay)
> +		start_delay = 1;
> +

I guess that it's actually the clamping that fixes thing. It should be
mentionned in your commit log.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
