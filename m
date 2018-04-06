Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeDFNYu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:24:50 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34925 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbeDFNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:24:47 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Date: Fri, 06 Apr 2018 16:24:44 +0300
Message-ID: <3367141.XOMI5ldQnc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523018517-24121-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org> <1523018517-24121-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36DOsYQ012105

Hi Jacopo,

Thank you for the patch.

On Friday, 6 April 2018 15:41:57 EEST Jacopo Mondi wrote:
> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> output converter.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 212 +++++++++++++++++++++++++++++++
>  3 files changed, 219 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3aa65bd..42c9c2d 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -93,6 +93,12 @@ config DRM_SII9234
>  	  It is an I2C driver, that detects connection of MHL bridge
>  	  and starts encapsulation of HDMI signal.
> 
> +config DRM_THINE_THC63LVD1024
> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> +	depends on OF
> +	---help---
> +	  Thine THC63LVD1024 LVDS/parallel converter driver.
> +
>  config DRM_TOSHIBA_TC358767
>  	tristate "Toshiba TC358767 eDP bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile
> b/drivers/gpu/drm/bridge/Makefile index 373eb28..fd90b16 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c
> b/drivers/gpu/drm/bridge/thc63lvd1024.c new file mode 100644
> index 0000000..c8fad9c
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
> + *
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_panel.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>

You should include slab.h as you're using devm_kzalloc().

> +
> +enum thc63_ports {
> +	THC63_LVDS_IN0,
> +	THC63_LVDS_IN1,
> +	THC63_RGB_OUT0,
> +	THC63_RGB_OUT1,
> +};
> +
> +struct thc63_dev {
> +	struct device *dev;
> +
> +	struct regulator *vcc;
> +
> +	struct gpio_desc *pdwn;

pwdn ?

> +	struct gpio_desc *oe;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next;
> +};
> +
> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct thc63_dev, bridge);
> +}
> +
> +static int thc63_attach(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
> +}
> +
> +static void thc63_enable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	int ret;
> +
> +	ret = regulator_enable(thc63->vcc);
> +	if (ret) {
> +		dev_err(thc63->dev,
> +			"Failed to enable regulator \"vcc\": %d\n", ret);
> +		return;
> +	}
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 0);
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 1);

You don't need to check the gpio_desc pointers first, gpiod_set_value() is a 
no-op if the pointer is NULL.

> +}
> +
> +static void thc63_disable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	int ret;
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 0);
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 1);

Same here.

> +	ret = regulator_disable(thc63->vcc);
> +	if (ret)
> +		dev_err(thc63->dev,
> +			"Failed to disable regulator \"vcc\": %d\n", ret);
> +}
> +
> +static const struct drm_bridge_funcs thc63_bridge_func = {
> +	.attach	= thc63_attach,
> +	.enable = thc63_enable,
> +	.disable = thc63_disable,
> +};
> +
> +static int thc63_parse_dt(struct thc63_dev *thc63)
> +{
> +	struct device_node *thc63_out;
> +	struct device_node *remote;
> +
> +	thc63_out = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
> +						  THC63_RGB_OUT0, -1);
> +	if (!thc63_out) {
> +		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
> +			THC63_RGB_OUT0);
> +		return -ENODEV;
> +	}
> +
> +	remote = of_graph_get_remote_port_parent(thc63_out);
> +	of_node_put(thc63_out);
> +	if (!remote) {
> +		dev_err(thc63->dev, "Endpoint in port@%u unconnected\n",
> +			THC63_RGB_OUT0);
> +		return -ENODEV;
> +	}
> +
> +	if (!of_device_is_available(remote)) {
> +		dev_err(thc63->dev, "port@%u remote endpoint is disabled\n",
> +			THC63_RGB_OUT0);
> +		of_node_put(remote);
> +		return -ENODEV;
> +	}
> +
> +	thc63->next = of_drm_find_bridge(remote);
> +	if (!thc63->next) {
> +		of_node_put(remote);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thc63_gpio_init(struct thc63_dev *thc63)
> +{
> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "enable", GPIOD_OUT_LOW);

If you agree with my comment regarding the DT bindings, this should be "oe".

> +	if (IS_ERR(thc63->oe)) {
> +		dev_err(thc63->dev, "Unable to get \"enable-gpios\": %ld\n",
> +			PTR_ERR(thc63->oe));

And the message should be update here too.

With those small issues fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		return PTR_ERR(thc63->oe);
> +	}
> +
> +	thc63->pdwn = devm_gpiod_get_optional(thc63->dev, "powerdown",
> +					      GPIOD_OUT_HIGH);
> +	if (IS_ERR(thc63->pdwn)) {
> +		dev_err(thc63->dev, "Unable to get \"powerdown-gpios\": %ld\n",
> +			PTR_ERR(thc63->pdwn));
> +		return PTR_ERR(thc63->pdwn);
> +	}
> +
> +	return 0;
> +}
> +
> +static int thc63_probe(struct platform_device *pdev)
> +{
> +	struct thc63_dev *thc63;
> +	int ret;
> +
> +	thc63 = devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
> +	if (!thc63)
> +		return -ENOMEM;
> +
> +	thc63->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, thc63);
> +
> +	thc63->vcc = devm_regulator_get(thc63->dev, "vcc");
> +	if (IS_ERR(thc63->vcc)) {
> +		if (PTR_ERR(thc63->vcc) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		dev_err(thc63->dev, "Unable to get \"vcc\" supply: %ld\n",
> +			PTR_ERR(thc63->vcc));
> +		return PTR_ERR(thc63->vcc);
> +	}
> +
> +	ret = thc63_gpio_init(thc63);
> +	if (ret)
> +		return ret;
> +
> +	ret = thc63_parse_dt(thc63);
> +	if (ret)
> +		return ret;
> +
> +	thc63->bridge.driver_private = thc63;
> +	thc63->bridge.of_node = pdev->dev.of_node;
> +	thc63->bridge.funcs = &thc63_bridge_func;
> +
> +	drm_bridge_add(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +static int thc63_remove(struct platform_device *pdev)
> +{
> +	struct thc63_dev *thc63 = platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id thc63_match[] = {
> +	{ .compatible = "thine,thc63lvd1024", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, thc63_match);
> +
> +static struct platform_driver thc63_driver = {
> +	.probe	= thc63_probe,
> +	.remove	= thc63_remove,
> +	.driver	= {
> +		.name		= "thc63lvd1024",
> +		.of_match_table	= thc63_match,
> +	},
> +};
> +module_platform_driver(thc63_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
> +MODULE_LICENSE("GPL v2");

-- 
Regards,

Laurent Pinchart
