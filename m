Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169CFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PwYIsfSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C6520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeINOhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:37:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60834 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeINOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:37:18 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA473CE;
        Fri, 14 Sep 2018 11:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536917019;
        bh=8mts+t+mvT0l3TepE0abz7fJInNbpbaC2lApUyANfQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwYIsfSQeJ5Fz118gDlCeIgCfLC5DHDBwoQeX7Qoa+q8nt6hR9nGXKPzAkGNEVGGq
         nbmDaB9BzckPN7cVGTNANlw1jJMcESwrVlZ7C6HrKC8xjeSqxrFC4P4tR7yoiSNJPk
         s/HZkDTbwKB9hi5eU5YpvxzQ/yTshqwSaJVSom/U=
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
Subject: Re: [PATCH v2 1/8] drm/bridge: use bus flags in bridge timings
Date:   Fri, 14 Sep 2018 12:23:52 +0300
Message-ID: <6714863.eJMplaj6yU@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180912183222.25414-2-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch> <20180912183222.25414-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thankk you for the patch.

On Wednesday, 12 September 2018 21:32:15 EEST Stefan Agner wrote:
> The DRM bus flags conveys additional information on pixel data on
> the bus. All currently available bus flags might be of interest for
> a bridge. In the case at hand a dumb VGA bridge needs a specific
> data enable polarity (DRM_BUS_FLAG_DE_LOW).
> 
> Replace the sampling_edge field with input_bus_flags and allow all
> currently documented bus flags.
> 
> This changes the perspective from sampling side to the driving
> side for the currently supported flags. We assume that the sampling
> edge is always the opposite of the driving edge (hence we need to
> invert the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE flags). This is an
> assumption we already make for displays. For all we know it is a
> safe assumption for bridges too.

Please don't, that will get confusing very quickly. Flag names such as 
DRM_BUS_FLAG_PIXDATA_NEGEDGE don't mention sampling or driving. There's only a 
small comment next to their definition, which will easily be overlooked. I'd 
rather update the definition to cover both sampling and driving, and document 
the input_bus_flags field to explain that all flags refer to sampling.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
>  include/drm/drm_bridge.h              | 11 +++++------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 9b706789a341..d5aa0f931ef2
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
> */
>  static const struct drm_bridge_timings default_dac_timings = {
>  	/* Timing specifications, datasheet page 7 */
> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>  	.setup_time_ps = 500,
>  	.hold_time_ps = 1500,
>  };
> @@ -245,7 +245,7 @@ static const struct drm_bridge_timings
> default_dac_timings = { */
>  static const struct drm_bridge_timings ti_ths8134_dac_timings = {
>  	/* From timing diagram, datasheet page 9 */
> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>  	/* From datasheet, page 12 */
>  	.setup_time_ps = 3000,
>  	/* I guess this means latched input */
> @@ -258,7 +258,7 @@ static const struct drm_bridge_timings
> ti_ths8134_dac_timings = { */
>  static const struct drm_bridge_timings ti_ths8135_dac_timings = {
>  	/* From timing diagram, datasheet page 14 */
> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>  	/* From datasheet, page 16 */
>  	.setup_time_ps = 2000,
>  	.hold_time_ps = 500,
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index bd850747ce54..45e90f4b46c3 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -244,14 +244,13 @@ struct drm_bridge_funcs {
>   */
>  struct drm_bridge_timings {
>  	/**
> -	 * @sampling_edge:
> +	 * @input_bus_flags:
>  	 *
> -	 * Tells whether the bridge samples the digital input signal
> -	 * from the display engine on the positive or negative edge of the
> -	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
> -	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
> +	 * Additional settings this bridge requires for the pixel data on
> +	 * the input bus (e.g. pixel signal polarity). See also
> +	 * &drm_display_info->bus_flags.
>  	 */
> -	u32 sampling_edge;
> +	u32 input_bus_flags;
>  	/**
>  	 * @setup_time_ps:
>  	 *

-- 
Regards,

Laurent Pinchart



