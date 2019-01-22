Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABA121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kbRrZ3mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAVVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:02:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55898 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfAVVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:02:03 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8DC36575;
        Tue, 22 Jan 2019 22:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548190920;
        bh=LOtRytkw+jrom9cIWhQdQtl04YrC4p221I9BUeN4F5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbRrZ3mg91UVN7BP2/JncWrGj0s60XpEHYmo62aqzIS2KFl+t9iUTygQkFq9tKriU
         AVsut6KubGHOFDejNeiJ4Gz9AJUgIGtuQsLxcDO/11YIpoXyTUHvamn+4fcj3385Oz
         gkqyLxqQxDc7bxc2XvuOoSq5Ykq6KSVr//i/bRg8=
Date:   Tue, 22 Jan 2019 23:01:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] drm/bridge: lvds-encoder: add powerdown-gpios
 support
Message-ID: <20190122210159.GI3264@pendragon.ideasonboard.com>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-6-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-6-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sat, Dec 29, 2018 at 07:07:43AM +0000, Peter Rosin wrote:
> Optionally power down the LVDS-encoder when it is not in use.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

As the powerdown-gpios property is only defined for two encoders, and
both of them should work well with this code, I think the change is
fine. In the future if different power-up/down sequences need to be
implemented for different devices this will need to be made
device-specific.

> ---
>  drivers/gpu/drm/bridge/lvds-encoder.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
> index f6770e83d49d..36d8557bc097 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -11,11 +11,13 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_panel.h>
>  
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_graph.h>
>  
>  struct lvds_encoder {
>  	struct drm_bridge bridge;
>  	struct drm_bridge *panel_bridge;
> +	struct gpio_desc *powerdown_gpio;
>  };
>  
>  static int lvds_encoder_attach(struct drm_bridge *bridge)
> @@ -28,8 +30,30 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
>  				 bridge);
>  }
>  
> +static void lvds_encoder_enable(struct drm_bridge *bridge)
> +{
> +	struct lvds_encoder *lvds_encoder = container_of(bridge,
> +							 struct lvds_encoder,
> +							 bridge);
> +
> +	if (lvds_encoder->powerdown_gpio)
> +		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);

gpiod_set_value_cansleep() already contains a NULL check, so you can
drop it from here.

> +}
> +
> +static void lvds_encoder_disable(struct drm_bridge *bridge)
> +{
> +	struct lvds_encoder *lvds_encoder = container_of(bridge,
> +							 struct lvds_encoder,
> +							 bridge);
> +
> +	if (lvds_encoder->powerdown_gpio)
> +		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);

Same here.

> +}
> +
>  static struct drm_bridge_funcs funcs = {

While at it, could you make this const ?

With these fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	.attach = lvds_encoder_attach,
> +	.enable = lvds_encoder_enable,
> +	.disable = lvds_encoder_disable,
>  };
>  
>  static int lvds_encoder_probe(struct platform_device *pdev)
> @@ -45,6 +69,16 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>  	if (!lvds_encoder)
>  		return -ENOMEM;
>  
> +	lvds_encoder->powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
> +							       GPIOD_OUT_HIGH);
> +	if (IS_ERR(lvds_encoder->powerdown_gpio)) {
> +		int err = PTR_ERR(lvds_encoder->powerdown_gpio);
> +
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "powerdown GPIO failure: %d\n", err);
> +		return err;
> +	}
> +
>  	/* Locate the panel DT node. */
>  	port = of_graph_get_port_by_id(dev->of_node, 1);
>  	if (!port) {

-- 
Regards,

Laurent Pinchart
