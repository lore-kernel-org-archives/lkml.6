Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35607ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CB220861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jf+lCZVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CB220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeINOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:48:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60972 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeINOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:48:16 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A995ACE;
        Fri, 14 Sep 2018 11:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536917674;
        bh=ekbC+Fmc9r/TdCMqKs69qWNQdUBTr3EVeUsUOf4idOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jf+lCZVn6BZ/b0soQ6LE58U7/HtBpd6WJV8j8BDVlL+l45yepzdpaRUEPHNgtj5E7
         FCwsPNlxa6/5sujYQ3BJNqOuiVSJkG/rPrKnfDylNWpY/NICA3b5EU4ATQzHrs4C6c
         rsz1gG9jEqUYUN1N4qx/QSsILNij2x4mmgH1HCWk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] drm/bridge: simplify bridge timing info
Date:   Fri, 14 Sep 2018 12:34:47 +0300
Message-ID: <1573320.Q96Iu7qNKK@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180912183222.25414-4-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch> <20180912183222.25414-4-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wednesday, 12 September 2018 21:32:17 EEST Stefan Agner wrote:
> Bridges are typically connected to a parallel display signal with
> pixel clock, sync signals and data lines. Parallel display signals
> are also used in lower-end embedded display panels. For parallel
> display panels we currently do not specify setup/hold times. From
> discussions on the mailing list it seems not convincing that this
> is currently really required for bridges either.
> 
> Remove setup/hold timings again to better align timing information
> of displays and briges.

The setup and hold timings were the result of a long discussion with Linux 
Walleij, who was confronted with a system that didn't work properly unless he 
flipped the clock polarity. His initial patch contradicted the bridge 
datasheet, and after investigating we found out that timings played a major 
role.

In a nutshell, given the setup and hold time requirements, the polarity on the 
driving side depends on the pixel clock frequency. As the frequency increases, 
when the half clock period reaches the setup time, you can't latch on the 
opposite edge anymore or you will violate the setup time. The component 
connected to the bridge thus needs to select a driving edge based on the 
sampling edge of the bridge, on the bridge's setup time requirement, and on 
the pixel clock frequency.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 17 +++++------------
>  include/drm/drm_bridge.h              | 14 --------------
>  2 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index d5aa0f931ef2..b2309ad228cf
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -229,14 +229,14 @@ static int dumb_vga_remove(struct platform_device
> *pdev) /*
>   * We assume the ADV7123 DAC is the "default" for historical reasons
>   * Information taken from the ADV7123 datasheet, revision D.
> - * NOTE: the ADV7123EP seems to have other timings and need a new timings
> - * set if used.
>   */
>  static const struct drm_bridge_timings default_dac_timings = {
> -	/* Timing specifications, datasheet page 7 */
> +	/*
> +	 * From Timing diagram, datasheet page 7. The bridge samples
> +	 * on pixel clocks positive edge, hence the display controller
> +	 * should drive signals on the negative edge.
> +	 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	.setup_time_ps = 500,
> -	.hold_time_ps = 1500,
>  };
> 
>  /*
> @@ -246,10 +246,6 @@ static const struct drm_bridge_timings
> default_dac_timings = { static const struct drm_bridge_timings
> ti_ths8134_dac_timings = { /* From timing diagram, datasheet page 9 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	/* From datasheet, page 12 */
> -	.setup_time_ps = 3000,
> -	/* I guess this means latched input */
> -	.hold_time_ps = 0,
>  };
> 
>  /*
> @@ -259,9 +255,6 @@ static const struct drm_bridge_timings
> ti_ths8134_dac_timings = { static const struct drm_bridge_timings
> ti_ths8135_dac_timings = { /* From timing diagram, datasheet page 14 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	/* From datasheet, page 16 */
> -	.setup_time_ps = 2000,
> -	.hold_time_ps = 500,
>  };
> 
>  static const struct of_device_id dumb_vga_match[] = {
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 45e90f4b46c3..1a1d08350eaf 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -251,20 +251,6 @@ struct drm_bridge_timings {
>  	 * &drm_display_info->bus_flags.
>  	 */
>  	u32 input_bus_flags;
> -	/**
> -	 * @setup_time_ps:
> -	 *
> -	 * Defines the time in picoseconds the input data lines must be
> -	 * stable before the clock edge.
> -	 */
> -	u32 setup_time_ps;
> -	/**
> -	 * @hold_time_ps:
> -	 *
> -	 * Defines the time in picoseconds taken for the bridge to sample the
> -	 * input signal after the clock edge.
> -	 */
> -	u32 hold_time_ps;
>  };
> 
>  /**


-- 
Regards,

Laurent Pinchart



