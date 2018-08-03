Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106AAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03932172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03932172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeHCKNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:13:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52793 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeHCKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:13:14 -0400
X-Originating-IP: 82.50.90.136
Received: from w540 (host136-90-dynamic.50-82-r.retail.telecomitalia.it [82.50.90.136])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 08D04FF80A;
        Fri,  3 Aug 2018 08:17:53 +0000 (UTC)
Date:   Fri, 3 Aug 2018 10:17:51 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [RESEND PATCH v5 3/3] drm/atmel-hlcdc: support bus-width
 (12/16/18/24) in endpoint nodes
Message-ID: <20180803081751.GB4528@w540>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20180803072308.14962-4-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,

On Fri, Aug 03, 2018 at 09:23:08AM +0200, Peter Rosin wrote:
> This beats the heuristic that the connector is involved in what format
> should be output for cases where this fails.
>
> E.g. if there is a bridge that changes format between the encoder and the
> connector, or if some of the RGB pins between the lcd controller and the
> encoder are not routed on the PCB.
>
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 67 ++++++++++++++++++++---
>  3 files changed, 111 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index d73281095fac..c38a479ada98 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>
> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
> +{
> +	struct drm_connector *connector = state->connector;
> +	struct drm_display_info *info = &connector->display_info;
> +	struct drm_encoder *encoder;
> +	unsigned int supported_fmts = 0;
> +	int j;
> +
> +	encoder = state->best_encoder;
> +	if (!encoder)
> +		encoder = connector->encoder;
> +
> +	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +	case 0:
> +		break;
> +	case MEDIA_BUS_FMT_RGB444_1X12:
> +		return ATMEL_HLCDC_RGB444_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		return ATMEL_HLCDC_RGB565_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		return ATMEL_HLCDC_RGB666_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		return ATMEL_HLCDC_RGB888_OUTPUT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (j = 0; j < info->num_bus_formats; j++) {
> +		switch (info->bus_formats[j]) {
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return supported_fmts;
> +}
> +
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> @@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
> -		struct drm_display_info *info = &connector->display_info;
>  		unsigned int supported_fmts = 0;
> -		int j;
>
>  		if (!cstate->crtc)
>  			continue;
>
> -		for (j = 0; j < info->num_bus_formats; j++) {
> -			switch (info->bus_formats[j]) {
> -			case MEDIA_BUS_FMT_RGB444_1X12:
> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB565_1X16:
> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB666_1X18:
> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB888_1X24:
> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>
>  		if (crtc->dc->desc->conflicting_output_formats)
>  			output_fmts &= supported_fmts;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 60c937f42114..4cc1e03f0aee 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
>  int atmel_hlcdc_crtc_create(struct drm_device *dev);
>
>  int atmel_hlcdc_create_outputs(struct drm_device *dev);
> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
>
>  #endif /* DRM_ATMEL_HLCDC_H */
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..db4d6aaaef93 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -27,33 +27,86 @@
>
>  #include "atmel_hlcdc_dc.h"
>
> +struct atmel_hlcdc_rgb_output {
> +	struct drm_encoder encoder;
> +	int bus_fmt;
> +};
> +
>  static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>  	.destroy = drm_encoder_cleanup,
>  };
>
> +static struct atmel_hlcdc_rgb_output *
> +atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
> +{
> +	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
> +}
> +
> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)

'static' missing?

> +{
> +	struct atmel_hlcdc_rgb_output *output;
> +
> +	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
> +
> +	return output->bus_fmt;
> +}
> +
> +static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
> +{
> +	u32 bus_width = 0;
> +
> +	of_property_read_u32(ep, "bus-width", &bus_width);
> +
> +	switch (bus_width) {
> +	case 0:
> +		return 0;
> +	case 12:
> +		return MEDIA_BUS_FMT_RGB444_1X12;
> +	case 16:
> +		return MEDIA_BUS_FMT_RGB565_1X16;
> +	case 18:
> +		return MEDIA_BUS_FMT_RGB666_1X18;
> +	case 24:
> +		return MEDIA_BUS_FMT_RGB888_1X24;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  {
> -	struct drm_encoder *encoder;
> +	struct atmel_hlcdc_rgb_output *output;
> +	struct device_node *ep;
>  	struct drm_panel *panel;
>  	struct drm_bridge *bridge;
>  	int ret;
>
> +	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
> +	if (!ep)
> +		return -ENODEV;
> +
>  	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>  					  &panel, &bridge);
>  	if (ret)
>  		return ret;
>
> -	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
> -	if (!encoder)
> +	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
> +	if (!output)
>  		return -EINVAL;
>
> -	ret = drm_encoder_init(dev, encoder,
> +	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
> +	if (output->bus_fmt < 0) {
> +		dev_err(dev->dev, "invalid bus width\n");

Nit: Bindings do not specify 0 as an accepted value.

Feel free to add my
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
with those two minors addressed.

Thanks
   j
> +		return -EINVAL;
> +	}
> +
> +	ret = drm_encoder_init(dev, &output->encoder,
>  			       &atmel_hlcdc_panel_encoder_funcs,
>  			       DRM_MODE_ENCODER_NONE, NULL);
>  	if (ret)
>  		return ret;
>
> -	encoder->possible_crtcs = 0x1;
> +	output->encoder.possible_crtcs = 0x1;
>
>  	if (panel) {
>  		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
> @@ -62,7 +115,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  	}
>
>  	if (bridge) {
> -		ret = drm_bridge_attach(encoder, bridge, NULL);
> +		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
>  		if (!ret)
>  			return 0;
>
> @@ -70,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  			drm_panel_bridge_remove(bridge);
>  	}
>
> -	drm_encoder_cleanup(encoder);
> +	drm_encoder_cleanup(&output->encoder);
>
>  	return ret;
>  }
> --
> 2.11.0
>

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbZA+vAAoJEHI0Bo8WoVY8Qq8QAKaZOzZx2SFuEJoERwUXt/vI
aGUzQqaEswjoggR5h8dQF+dMRwNT0TqYlIgCW4+6Xa+uMt3VEdtm43tWaMatH9XM
0XcCMZEBVdi87jA6VOYgB2SgHuNQYPuCyBzpgHeWqBD2IcpSi30kP1UiKWRuc2Uv
eoewamjMPsakhwBYXhzEhlrmjVt7beE/Goo+rP2IxrjdAHa4pxezPY+snXfEt1ma
wIMpMVIJTpGrI14zKTtFSNmEtc/EhFYQEzASeEntpZ9xQ1LlabJbRz2kIW3zQJWl
08vftYwGC0RbxS6taw+2dEGC0Eb3Lsjqon+wTw60bQqUbsmy680QdsdVU65AwUPP
7PQdJjjhEvx8/NrnzFOFyB7od1ZlLHT5qykbBJ9xseIjf17KYsqCfgumnfNgTh/R
WuyT1ZPjviCnEX6dkxdqr2uBlxHZKd1GroAAnw7t7kIRLXW5U9KZDzBSGlPaUhir
j/7vVLtncto8I3tqikiy5rtwfMFwfcvstmEtidfr0HRQLt4Q15C7XqQX7ttGY1Gf
i1hQya5NMiJEcKZeYLJNRfBxQTJB7CJG9C1nIiQuCPHjZyLwdkG2Rdpm8Vinmdgq
q2dQ6C7m8dMGwFKJpjY/B/AQw8JxhxJz8otAqD2m4qavIJOvWkavx9Q0yoIhFxXt
PHKOH4dwbinfidGQgtSY
=e7Yk
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
