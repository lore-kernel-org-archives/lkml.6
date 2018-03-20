Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeCTN7R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:59:17 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34106 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeCTN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:59:14 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] drm: bridge: lvds-encoder: on request, override the bus format
Date: Tue, 20 Mar 2018 16:00:19 +0200
Message-ID: <11191357.lM4H1k0N3I@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180317221525.18534-4-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se> <20180317221525.18534-4-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sunday, 18 March 2018 00:15:25 EET Peter Rosin wrote:
> If the bridge changes the bus format, allow this to be described in
> the bridge, instead of providing false information about the bus
> format of the panel itself.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/display/bridge/lvds-transmitter.txt       |  8 ++++++++
>  drivers/gpu/drm/bridge/lvds-encoder.c                  | 18 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index 9d09190d9210..c0fbe74272e7 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -29,6 +29,14 @@ Required properties:
> 
>  	      "ti,ds90c185"
> 
> +Optional properties:
> +
> +- interface-pix-fmt:
> +	      Override the bus format of the panel, in case the bridge
> +	      converts the signals. Recognized formats include:
> +
> +	      "rgb565"

Please describe the format in more details, with an explicit mapping of bits 
to signals, otherwise we'll end up again with multiple different 
interpretations (at least when it comes to endianness).

> +
>  Required nodes:
> 
>  This device has two video ports. Their connections are modeled using the OF
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c
> b/drivers/gpu/drm/bridge/lvds-encoder.c index 75b0d3f6e4de..acff3a5b0562
> 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -39,6 +39,9 @@ static int lvds_encoder_probe(struct platform_device
> *pdev) struct device_node *panel_node;
>  	struct drm_panel *panel;
>  	struct lvds_encoder *lvds_encoder;
> +	u32 bus_format = 0;
> +	const char *fmt;
> +	int ret;
> 
>  	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
>  				    GFP_KERNEL);
> @@ -79,6 +82,21 @@ static int lvds_encoder_probe(struct platform_device
> *pdev) if (IS_ERR(lvds_encoder->panel_bridge))
>  		return PTR_ERR(lvds_encoder->panel_bridge);
> 
> +	ret = of_property_read_string(pdev->dev.of_node,
> +				      "interface-pix-fmt", &fmt);
> +	if (!ret) {
> +		if (!strcmp(fmt, "rgb565")) {
> +			bus_format = MEDIA_BUS_FMT_RGB565_1X16;

I think the string to fourcc conversion should take place in the DRM core, not 
in the LVDS encoder driver. This would avoid ending up with multiple 
incompatible conversions. It might even be better to move the DT parsing to 
the core as well, not just the conversion.

> +		} else {
> +			dev_dbg(&pdev->dev,
> +				"requested interface-pix-fmt not recognized\n");
> +			return -EINVAL;
> +		}
> +	}
> +	if (bus_format)
> +		drm_panel_bridge_set_bus_format(lvds_encoder->panel_bridge,
> +						bus_format);
> +
>  	/* The panel_bridge bridge is attached to the panel's of_node,
>  	 * but we need a bridge attached to our of_node for our user
>  	 * to look up.

-- 
Regards,

Laurent Pinchart
