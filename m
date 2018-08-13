Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A77A21761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A77A21761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeHMQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:42:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49383 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:42:21 -0400
X-Originating-IP: 2.224.242.101
Received: from apu3b.nibble.pw (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0F4EC1BF20C;
        Mon, 13 Aug 2018 13:59:50 +0000 (UTC)
Date:   Mon, 13 Aug 2018 15:59:49 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
Message-ID: <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810130359.9882-4-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
> This enables more flexible devicetrees. You can e.g. have two output
> nodes where one is not enabled, without the ordering affecting things.
> 
> Prior to this patch the active node had to have endpoint id zero.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..16c1b2f54b42 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>  	.destroy = drm_encoder_cleanup,
>  };
>  
> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
> +				       struct of_endpoint *endpoint)
>  {
>  	struct drm_encoder *encoder;
>  	struct drm_panel *panel;
>  	struct drm_bridge *bridge;
>  	int ret;
>  
> -	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
> +	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> +					  endpoint->port, endpoint->id,

You are refusing endpoint->port != 0 in the caller, so that could be
0.

Apart from that small nit:
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

>  					  &panel, &bridge);
>  	if (ret)
>  		return ret;
> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  
>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>  {
> -	int endpoint, ret = 0;
> -
> -	for (endpoint = 0; !ret; endpoint++)
> -		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> +	struct of_endpoint endpoint;
> +	struct device_node *node = NULL;
> +	int count = 0;
> +	int ret = 0;
> +
> +	for_each_endpoint_of_node(dev->dev->of_node, node) {
> +		of_graph_parse_endpoint(node, &endpoint);
> +
> +		if (endpoint.port)
> +			continue;
> +
> +		ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret) {
> +			of_node_put(node);
> +			break;
> +		}
> +		count++;
> +	}
>  
>  	/* At least one device was successfully attached.*/
> -	if (ret == -ENODEV && endpoint)
> +	if (ret == -ENODEV && count)
>  		return 0;
>  
>  	return ret;
> -- 
> 2.11.0
> 
