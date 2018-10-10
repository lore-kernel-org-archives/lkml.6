Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C372087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C372087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJJWVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:21:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56021 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeJJWVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:21:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27FD0207A3; Wed, 10 Oct 2018 16:59:00 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E49D7207C4;
        Wed, 10 Oct 2018 16:58:49 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:58:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 2/4] drm/panel: simple: Add support for the Lemaker BL035
 3.5" LCD
Message-ID: <20181010145850.krwe7wlqkbcpja33@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010114134.8211-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181010114134.8211-2-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:41:32PM +0200, Paul Kocialkowski wrote:
> This adds support for the 3.5" LCD panel from Lemaker, sold for use with
> BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
> requires an active-low DE signal
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 97964f7f2ace..229080fcf65e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1461,6 +1461,30 @@ static const struct panel_desc kyo_tcg121xglp = {
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
>  };
>  
> +static const struct drm_display_mode lemaker_bl035_mode = {
> +	.clock = 7000,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 20,
> +	.hsync_end = 320 + 20 + 30,
> +	.htotal = 320 + 20 + 30 + 38,
> +	.vdisplay = 240,
> +	.vsync_start = 240 + 4,
> +	.vsync_end = 240 + 4 + 3,
> +	.vtotal = 240 + 4 + 3 + 15,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc lemaker_bl035 = {
> +	.modes = &lemaker_bl035_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 70,
> +		.height = 52,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_LOW,
> +};
> +
>  static const struct drm_display_mode lg_lb070wv8_mode = {
>  	.clock = 33246,
>  	.hdisplay = 800,
> @@ -2456,6 +2480,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "kyo,tcg121xglp",
>  		.data = &kyo_tcg121xglp,
> +	}, {
> +		.compatible = "lemaker,bl035",
> +		.data = &lemaker_bl035,

You should document that new compatible. Also, where is this name
coming from? Is it the name it's sold under? something you came up
with?

Thanks,
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
