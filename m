Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeDMQ2p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:28:45 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60765 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeDMQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:28:44 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 13 Apr 2018 18:28:36 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Message-ID: <20180413162836.GD6666@w540>
References: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357590-3841-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <1523357590-3841-3-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
   small self review, as I've just noticed a trivial error.

On Tue, Apr 10, 2018 at 12:53:10PM +0200, Jacopo Mondi wrote:
> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> output converter.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 206 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
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
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Mak=
efile
> index 373eb28..fd90b16 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) +=3D parade-ps8622.o
>  obj-$(CONFIG_DRM_SIL_SII8620) +=3D sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) +=3D sii902x.o
>  obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) +=3D tc358767.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/brid=
ge/thc63lvd1024.c
> new file mode 100644
> index 0000000..aa1d650
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -0,0 +1,206 @@
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
> +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
> +}
> +
> +static void thc63_enable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> +	int ret;
> +
> +	ret =3D regulator_enable(thc63->vcc);
> +	if (ret) {
> +		dev_err(thc63->dev,
> +			"Failed to enable regulator \"vcc\": %d\n", ret);
> +		return;
> +	}
> +
> +	gpiod_set_value(thc63->pdwn, 0);
> +	gpiod_set_value(thc63->oe, 1);
> +}
> +
> +static void thc63_disable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> +	int ret;
> +
> +	gpiod_set_value(thc63->oe, 0);
> +	gpiod_set_value(thc63->pdwn, 1);
> +
> +	ret =3D regulator_disable(thc63->vcc);
> +	if (ret)
> +		dev_err(thc63->dev,
> +			"Failed to disable regulator \"vcc\": %d\n", ret);
> +}
> +
> +static const struct drm_bridge_funcs thc63_bridge_func =3D {
> +	.attach	=3D thc63_attach,
> +	.enable =3D thc63_enable,
> +	.disable =3D thc63_disable,
> +};
> +
> +static int thc63_parse_dt(struct thc63_dev *thc63)
> +{
> +	struct device_node *thc63_out;
> +	struct device_node *remote;
> +
> +	thc63_out =3D of_graph_get_endpoint_by_regs(thc63->dev->of_node,
> +						  THC63_RGB_OUT0, -1);
> +	if (!thc63_out) {
> +		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
> +			THC63_RGB_OUT0);
> +		return -ENODEV;
> +	}
> +
> +	remote =3D of_graph_get_remote_port_parent(thc63_out);
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
> +	thc63->next =3D of_drm_find_bridge(remote);
> +	if (!thc63->next) {
> +		of_node_put(remote);
> +		return -EPROBE_DEFER;
> +	}

the 'remote' OF node is only put in the error path.

If there are no other comments on this driver I can send a follow up
patch, or it's easier I can resend the series being it just two small
patches.

Thanks
   j


> +
> +	return 0;
> +}
> +
> +static int thc63_gpio_init(struct thc63_dev *thc63)
> +{
> +	thc63->oe =3D devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> +	if (IS_ERR(thc63->oe)) {
> +		dev_err(thc63->dev, "Unable to get \"oe-gpios\": %ld\n",
> +			PTR_ERR(thc63->oe));
> +		return PTR_ERR(thc63->oe);
> +	}
> +
> +	thc63->pdwn =3D devm_gpiod_get_optional(thc63->dev, "powerdown",
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
> +	thc63 =3D devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
> +	if (!thc63)
> +		return -ENOMEM;
> +
> +	thc63->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, thc63);
> +
> +	thc63->vcc =3D devm_regulator_get_optional(thc63->dev, "vcc");
> +	if (IS_ERR(thc63->vcc)) {
> +		if (PTR_ERR(thc63->vcc) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		dev_err(thc63->dev, "Unable to get \"vcc\" supply: %ld\n",
> +			PTR_ERR(thc63->vcc));
> +		return PTR_ERR(thc63->vcc);
> +	}
> +
> +	ret =3D thc63_gpio_init(thc63);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D thc63_parse_dt(thc63);
> +	if (ret)
> +		return ret;
> +
> +	thc63->bridge.driver_private =3D thc63;
> +	thc63->bridge.of_node =3D pdev->dev.of_node;
> +	thc63->bridge.funcs =3D &thc63_bridge_func;
> +
> +	drm_bridge_add(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +static int thc63_remove(struct platform_device *pdev)
> +{
> +	struct thc63_dev *thc63 =3D platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id thc63_match[] =3D {
> +	{ .compatible =3D "thine,thc63lvd1024", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, thc63_match);
> +
> +static struct platform_driver thc63_driver =3D {
> +	.probe	=3D thc63_probe,
> +	.remove	=3D thc63_remove,
> +	.driver	=3D {
> +		.name		=3D "thc63lvd1024",
> +		.of_match_table	=3D thc63_match,
> +	},
> +};
> +module_platform_driver(thc63_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa0Nq0AAoJEHI0Bo8WoVY8c3sP/Ah+NayP3xJtkqCvx6beuoWc
beAT2p/5LYlP7+2d8d12S59a5Bmr+q6vNrtzFufNTPBuNsDxeYZIu99HRCRdp0a1
mCJ26nSaFR2iC7XhJmRlbxUMt73A9vgTfmM3q2taDlCL0ihC+ZoJt8rak2ehEcLH
5yeYJt1lBYbpqB4NHk9sMINaLedGtVRgsaEHRQX+nJJCcjjI2iI2eFqix/ejhrB6
dJPQxknGE6nmG15zG5vwV1/NBT06WYlr4jfNnfNuoTlpFHsfH0Umq0kzyN+doIX5
/MpGVl0PGQgoexNbe/xbZiVFkln8fTs2xCyk+gUbodhnI0aztdCiWAtCQs9q16bR
0sllAsVDIN9EY51sT0bI+JAyllg3lWub7wBYeOjQepxMEHUTt5qRNvutgrYHAwPi
mQYCpfPH/P0KzVvx/mfwW861Gy5pn5JwMpq/EWecFYqHTvIeQxZNJ6XYANSS8GuU
nk4Nk/NXSsJaBB3BHlsBXmY7XTahDmPq5LYH2968SDDmPJji7q3Fec2PJq2jVe2u
TzQhilNb66Ne/N/btiENoKRUjc+5LP2xxdchpa2wZ7AEtB2n9EQcIySd845yXjku
z2xCHfncg5xhF96b5tQd5E7yAQ3luRolW5A2E3DTTNOk52w2wV0ZmFuT6A6xev4x
ZwzuDtg8Nuso8CaeGWqJ
=xNrT
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
