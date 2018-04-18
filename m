Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeDRHhE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:37:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53772 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeDRHhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:37:02 -0400
Date: Wed, 18 Apr 2018 09:36:49 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/6] drm/atmel-hlcdc: add support for connecting to
 tda998x HDMI encoder
Message-ID: <20180418093649.2c304f29@bbrezillon>
In-Reply-To: <20180417131052.16336-6-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
        <20180417131052.16336-6-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 15:10:51 +0200
Peter Rosin <peda@axentia.se> wrote:

> When the of-graph points to a tda998x-compatible HDMI encoder, register
> as a component master and bind to the encoder/connector provided by
> the tda998x driver.

Can't we do the opposite: make the tda998x driver expose its devices as
drm bridges. I'd rather not add another way to connect external
encoders (or bridges) to display controller drivers, especially since,
when I asked DRM maintainers/devs what was the good approach to
represent such external encoders they pointed me to the drm_bridge
interface.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |  81 ++++++++++++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  15 +++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 130 +++++++++++++++++++++++
>  3 files changed, 220 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index c1ea5c36b006..8523c40fac94 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/component.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/module.h>
> @@ -568,10 +569,13 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>  
>  	drm_mode_config_init(dev);
>  
> -	ret = atmel_hlcdc_create_outputs(dev);
> -	if (ret) {
> -		dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
> -		return ret;
> +	if (!dc->is_componentized) {
> +		ret = atmel_hlcdc_create_outputs(dev);
> +		if (ret) {
> +			dev_err(dev->dev,
> +				"failed to create HLCDC outputs: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = atmel_hlcdc_create_planes(dev);
> @@ -586,6 +590,16 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>  		return ret;
>  	}
>  
> +	if (dc->is_componentized) {
> +		ret = component_bind_all(dev->dev, dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = atmel_hlcdc_add_component_encoder(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	dev->mode_config.min_width = dc->desc->min_width;
>  	dev->mode_config.min_height = dc->desc->min_height;
>  	dev->mode_config.max_width = dc->desc->max_width;
> @@ -617,6 +631,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  	if (!dc)
>  		return -ENOMEM;
>  
> +	dc->is_componentized =
> +		atmel_hlcdc_get_external_components(dev->dev, NULL) > 0;
> +
>  	dc->wq = alloc_ordered_workqueue("atmel-hlcdc-dc", 0);
>  	if (!dc->wq)
>  		return -ENOMEM;
> @@ -751,7 +768,7 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
>  	.minor = 0,
>  };
>  
> -static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
> +static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
>  {
>  	struct drm_device *ddev;
>  	int ret;
> @@ -779,7 +796,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
> +static int atmel_hlcdc_dc_drm_fini(struct platform_device *pdev)
>  {
>  	struct drm_device *ddev = platform_get_drvdata(pdev);
>  
> @@ -790,6 +807,58 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int atmel_hlcdc_bind(struct device *dev)
> +{
> +	return atmel_hlcdc_dc_drm_init(to_platform_device(dev));
> +}
> +
> +static void atmel_hlcdc_unbind(struct device *dev)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +
> +	/* Check if a subcomponent has already triggered the unloading. */
> +	if (!ddev->dev_private)
> +		return;
> +
> +	atmel_hlcdc_dc_drm_fini(to_platform_device(dev));
> +}
> +
> +static const struct component_master_ops atmel_hlcdc_comp_ops = {
> +	.bind = atmel_hlcdc_bind,
> +	.unbind = atmel_hlcdc_unbind,
> +};
> +
> +static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
> +{
> +	struct component_match *match = NULL;
> +	int ret;
> +
> +	ret = atmel_hlcdc_get_external_components(&pdev->dev, &match);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret)
> +		return component_master_add_with_match(&pdev->dev,
> +						       &atmel_hlcdc_comp_ops,
> +						       match);
> +	else
> +		return atmel_hlcdc_dc_drm_init(pdev);
> +}
> +
> +static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = atmel_hlcdc_get_external_components(&pdev->dev, NULL);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret)
> +		component_master_del(&pdev->dev, &atmel_hlcdc_comp_ops);
> +	else
> +		atmel_hlcdc_dc_drm_fini(pdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
>  {
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index ab32d5b268d2..cae77c245661 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -370,6 +370,10 @@ struct atmel_hlcdc_plane_properties {
>   * @wq: display controller workqueue
>   * @suspend: used to store the HLCDC state when entering suspend
>   * @commit: used for async commit handling
> + * @external_encoder: used encoder when componentized
> + * @external_connector: used connector when componentized
> + * @connector_funcs: original helper funcs of the external connector
> + * @is_componentized: operating mode
>   */
>  struct atmel_hlcdc_dc {
>  	const struct atmel_hlcdc_dc_desc *desc;
> @@ -386,6 +390,12 @@ struct atmel_hlcdc_dc {
>  		wait_queue_head_t wait;
>  		bool pending;
>  	} commit;
> +
> +	struct drm_encoder *external_encoder;
> +	struct drm_connector *external_connector;
> +	const struct drm_connector_helper_funcs *connector_funcs;
> +
> +	bool is_componentized;
>  };
>  
>  extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
> @@ -455,4 +465,9 @@ int atmel_hlcdc_crtc_create(struct drm_device *dev);
>  
>  int atmel_hlcdc_create_outputs(struct drm_device *dev);
>  
> +struct component_match;
> +int atmel_hlcdc_add_component_encoder(struct drm_device *dev);
> +int atmel_hlcdc_get_external_components(struct device *dev,
> +					struct component_match **match);
> +
>  #endif /* DRM_ATMEL_HLCDC_H */
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..3f86527e0473 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -6,6 +6,11 @@
>   * Author: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>   * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
>   *
> + * Handling of external components adapted from the tilcdc driver
> + * by Peter Rosin <peda@axentia.se>. That original code had:
> + *   Copyright (C) 2015 Texas Instruments
> + *   Author: Jyri Sarha <jsarha@ti.com>
> + *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2 as published by
>   * the Free Software Foundation.
> @@ -19,6 +24,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/component.h>
>  #include <linux/of_graph.h>
>  
>  #include <drm/drmP.h>
> @@ -88,3 +94,127 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
>  
>  	return ret;
>  }
> +
> +static int atmel_hlcdc_external_mode_valid(struct drm_connector *connector,
> +					   struct drm_display_mode *mode)
> +{
> +	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
> +	int ret;
> +
> +	ret = atmel_hlcdc_dc_mode_valid(dc, mode);
> +	if (ret != MODE_OK)
> +		return ret;
> +
> +	if (WARN_ON(dc->external_connector != connector))
> +		return MODE_ERROR;
> +	if (WARN_ON(!dc->connector_funcs))
> +		return MODE_ERROR;
> +
> +	if (IS_ERR(dc->connector_funcs) || !dc->connector_funcs->mode_valid)
> +		return MODE_OK;
> +
> +	/* The connector has its own mode_valid, call it. */
> +	return dc->connector_funcs->mode_valid(connector, mode);
> +}
> +
> +static int atmel_hlcdc_add_external_connector(struct drm_device *dev,
> +					      struct drm_connector *connector)
> +{
> +	struct atmel_hlcdc_dc *dc = dev->dev_private;
> +	struct drm_connector_helper_funcs *connector_funcs;
> +
> +	/* There should never be more than one connector. */
> +	if (WARN_ON(dc->external_connector))
> +		return -EINVAL;
> +
> +	dc->external_connector = connector;
> +	connector_funcs = devm_kzalloc(dev->dev, sizeof(*connector_funcs),
> +				       GFP_KERNEL);
> +	if (!connector_funcs)
> +		return -ENOMEM;
> +
> +	/*
> +	 * connector->helper_private always contains the struct
> +	 * connector_helper_funcs pointer. For the atmel-hlcdc crtc
> +	 * to have a say if a specific mode is Ok, we install our
> +	 * own helper functions. In our helper functions we copy
> +	 * everything else but use our own mode_valid() (above).
> +	 */
> +	if (connector->helper_private) {
> +		dc->connector_funcs = connector->helper_private;
> +		*connector_funcs = *dc->connector_funcs;
> +	} else {
> +		dc->connector_funcs = ERR_PTR(-ENOENT);
> +	}
> +	connector_funcs->mode_valid = atmel_hlcdc_external_mode_valid;
> +	drm_connector_helper_add(connector, connector_funcs);
> +
> +	dev_dbg(dev->dev, "External connector '%s' connected\n",
> +		connector->name);
> +
> +	return 0;
> +}
> +
> +static struct drm_connector *
> +atmel_hlcdc_encoder_find_connector(struct drm_device *dev,
> +				   struct drm_encoder *encoder)
> +{
> +	struct drm_connector *connector;
> +	int i;
> +
> +	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
> +		for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++)
> +			if (connector->encoder_ids[i] == encoder->base.id)
> +				return connector;
> +
> +	dev_err(dev->dev, "No connector found for %s encoder (id %d)\n",
> +		encoder->name, encoder->base.id);
> +
> +	return NULL;
> +}
> +
> +int atmel_hlcdc_add_component_encoder(struct drm_device *dev)
> +{
> +	struct atmel_hlcdc_dc *dc = dev->dev_private;
> +	struct drm_connector *connector;
> +	struct drm_encoder *encoder;
> +
> +	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
> +		if (encoder->possible_crtcs & (1 << dc->crtc->index))
> +			break;
> +	}
> +
> +	if (!encoder) {
> +		dev_err(dev->dev, "%s: No suitable encoder found\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	connector = atmel_hlcdc_encoder_find_connector(dev, encoder);
> +	if (!connector)
> +		return -ENODEV;
> +
> +	return atmel_hlcdc_add_external_connector(dev, connector);
> +}
> +
> +static int dev_match_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +int atmel_hlcdc_get_external_components(struct device *dev,
> +					struct component_match **match)
> +{
> +	struct device_node *node;
> +
> +	node = of_graph_get_remote_node(dev->of_node, 0, 0);
> +
> +	if (!of_device_is_compatible(node, "nxp,tda998x")) {
> +		of_node_put(node);
> +		return 0;
> +	}
> +
> +	if (match)
> +		drm_of_component_match_add(dev, match, dev_match_of, node);
> +	of_node_put(node);
> +	return 1;
> +}
