Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeCOPte (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:49:34 -0400
Received: from relay0.mail.gandi.net ([217.70.178.220]:57657 "EHLO
        relay0-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932517AbeCOPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:49:32 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 15 Mar 2018 16:49:19 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Message-ID: <20180315154919.GG16424@w540>
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
 <CGME20180315112237epcas1p4fba95a534dc025679b054d5c58ce013d@epcas1p4.samsung.com>
 <1521111391-3515-3-git-send-email-jacopo+renesas@jmondi.org>
 <1d98d055-fb5b-3840-e9dd-6bb8f8251bb9@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <1d98d055-fb5b-3840-e9dd-6bb8f8251bb9@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,
    thanks for your patience in reviewing this series

On Thu, Mar 15, 2018 at 02:37:00PM +0100, Andrzej Hajda wrote:
> On 15.03.2018 11:56, Jacopo Mondi wrote:
> > Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> > output converter.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig        |   6 +
> >  drivers/gpu/drm/bridge/Makefile       |   1 +
> >  drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 262 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index 3b99d5a..5815a20 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -92,6 +92,12 @@ config DRM_SII9234
> >  	  It is an I2C driver, that detects connection of MHL bridge
> >  	  and starts encapsulation of HDMI signal.
> >
> > +config DRM_THINE_THC63LVD1024
> > +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> > +	depends on OF
> > +	---help---
> > +	  Thine THC63LVD1024 LVDS/parallel converter driver.
> > +
> >  config DRM_TOSHIBA_TC358767
> >  	tristate "Toshiba TC358767 eDP bridge"
> >  	depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index 373eb28..fd90b16 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) +=3D parade-ps8622.o
> >  obj-$(CONFIG_DRM_SIL_SII8620) +=3D sil-sii8620.o
> >  obj-$(CONFIG_DRM_SII902X) +=3D sii902x.o
> >  obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> > +obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358767) +=3D tc358767.o
> >  obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix/
> >  obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
> > diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/br=
idge/thc63lvd1024.c
> > new file mode 100644
> > index 0000000..067f231
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> > @@ -0,0 +1,255 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
> > + *
> > + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> > + */
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +enum {
> > +	THC63_LVDS_IN0,
> > +	THC63_LVDS_IN1,
> > +	THC63_DIGITAL_OUT0,
> > +	THC63_DIGITAL_OUT1,
> > +};
> > +
> > +static const char * const thc63_reg_names[] =3D {
> > +	"vcc", "lvcc", "pvcc", "cvcc",
> > +};
> > +
> > +struct thc63_dev {
> > +	struct device *dev;
> > +
> > +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
> > +
> > +	struct gpio_desc *pdwn;
> > +	struct gpio_desc *oe;
> > +
> > +	struct drm_bridge bridge;
> > +	struct drm_bridge *next;
> > +};
> > +
> > +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
> > +{
> > +	return container_of(bridge, struct thc63_dev, bridge);
> > +}
> > +
> > +static int thc63_attach(struct drm_bridge *bridge)
> > +{
> > +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> > +
> > +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
> > +}
> > +
> > +static void thc63_enable(struct drm_bridge *bridge)
> > +{
> > +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> > +	struct regulator *vcc;
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> > +		vcc =3D thc63->vccs[i];
> > +		if (!vcc)
> > +			continue;
> > +
> > +		if (regulator_enable(vcc))
> > +			goto error_vcc_enable;
> > +	}
> > +
> > +	if (thc63->pdwn)
> > +		gpiod_set_value(thc63->pdwn, 0);
> > +
> > +	if (thc63->oe)
> > +		gpiod_set_value(thc63->oe, 1);
> > +
> > +	return;
> > +
> > +error_vcc_enable:
> > +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
>
> It would be better to use supply or regulator name instead of index.
>

Yeah, now it's easy as I have the array with names in the driver
global scope...

> > +
> > +	for (i =3D i - 1; i >=3D 0; i--) {
> > +		vcc =3D thc63->vccs[i];
> > +		if (!vcc)
> > +			continue;
> > +
> > +		regulator_disable(vcc);
> > +	}
> > +}
> > +
> > +static void thc63_disable(struct drm_bridge *bridge)
> > +{
> > +	struct thc63_dev *thc63 =3D to_thc63(bridge);
> > +	struct regulator *vcc;
> > +	int i;
> > +
> > +	if (thc63->oe)
> > +		gpiod_set_value(thc63->oe, 0);
> > +
> > +	if (thc63->pdwn)
> > +		gpiod_set_value(thc63->pdwn, 1);
> > +
> > +	for (i =3D ARRAY_SIZE(thc63->vccs) - 1; i >=3D 0; i--) {
> > +		vcc =3D thc63->vccs[i];
> > +		if (!vcc)
> > +			continue;
> > +
> > +		if (regulator_disable(vcc))
> > +			dev_dbg(thc63->dev,
> > +				"Failed to disable regulator %u\n", i);
>
> ditto
>
> > +	}
> > +}
> > +
> > +struct drm_bridge_funcs thc63_bridge_func =3D {
> > +	.attach	=3D thc63_attach,
> > +	.enable =3D thc63_enable,
> > +	.disable =3D thc63_disable,
> > +};
> > +
> > +static int thc63_parse_dt(struct thc63_dev *thc63)
> > +{
> > +	struct device_node *thc63_out;
> > +	struct device_node *remote;
> > +	int ret =3D 0;
> > +
> > +	thc63_out =3D of_graph_get_endpoint_by_regs(thc63->dev->of_node,
> > +						  THC63_DIGITAL_OUT0, -1);
> > +	if (!thc63_out) {
> > +		dev_err(thc63->dev, "Missing endpoint in Port@%u\n",
> > +			THC63_DIGITAL_OUT0);
> > +		return -ENODEV;
> > +	}
> > +
> > +	remote =3D of_graph_get_remote_port_parent(thc63_out);
> > +	if (!remote) {
> > +		dev_err(thc63->dev, "Endpoint in Port@%u unconnected\n",
> > +			THC63_DIGITAL_OUT0);
> > +		ret =3D -ENODEV;
> > +		goto error_put_out_node;
> > +	}
> > +
> > +	if (!of_device_is_available(remote)) {
> > +		dev_err(thc63->dev, "Port@%u remote endpoint is disabled\n",
> > +			THC63_DIGITAL_OUT0);
> > +		ret =3D -ENODEV;
> > +		goto error_put_remote_node;
> > +	}
> > +
> > +	thc63->next =3D of_drm_find_bridge(remote);
> > +	if (!thc63->next)
> > +		ret =3D -EPROBE_DEFER;
> > +
> > +error_put_remote_node:
> > +	of_node_put(remote);
> > +error_put_out_node:
> > +	of_node_put(thc63_out);
> > +
> > +	return ret;
> > +}
> > +
> > +static int thc63_gpio_init(struct thc63_dev *thc63)
> > +{
> > +	thc63->oe =3D devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW=
);
> > +	if (IS_ERR(thc63->oe)) {
> > +		dev_err(thc63->dev, "Unable to get \"oe-gpios\"\n");
> > +		return PTR_ERR(thc63->oe);
> > +	}
> > +
> > +	thc63->pdwn =3D devm_gpiod_get_optional(thc63->dev, "pdwn",
> > +					      GPIOD_OUT_HIGH);
> > +	if (IS_ERR(thc63->pdwn)) {
> > +		dev_err(thc63->dev, "Unable to get \"pdwn-gpios\"\n");
> > +		return PTR_ERR(thc63->pdwn);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int thc63_regulator_init(struct thc63_dev *thc63)
> > +{
> > +	struct regulator **reg;
> > +	int i;
> > +
> > +	reg =3D &thc63->vccs[0];
> > +	for (i =3D 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
> > +		*reg =3D devm_regulator_get_optional(thc63->dev,
> > +						   thc63_reg_names[i]);
> > +		if (IS_ERR(*reg)) {
> > +			if (PTR_ERR(*reg) =3D=3D -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			*reg =3D NULL;
> > +		}
>
> You could use "if (!...) continue", to avoid nesting.

(unfortunately) regulator_get_optional() does not return NULL as
gpiod_get_optional() does (I'm sure there are good reasons) but
returns ERR_PTR(-ENODEV), instead of a dummy regulator returned by the
non _optional() version. If I got your comment right, I cannot simply
check for a NULL value here, but instead make sure the 'reg' pointer
is set to NULL so that I can skip it during enable/disable.

>
> With or without suggested changes:
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, v5 will have your Reviewed-by tag on all patches!

Thanks
   j
>
> =C2=A0--
> Regards
> Andrzej
>
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int thc63_probe(struct platform_device *pdev)
> > +{
> > +	struct thc63_dev *thc63;
> > +	int ret;
> > +
> > +	thc63 =3D devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
> > +	if (!thc63)
> > +		return -ENOMEM;
> > +
> > +	thc63->dev =3D &pdev->dev;
> > +	platform_set_drvdata(pdev, thc63);
> > +
> > +	ret =3D thc63_regulator_init(thc63);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D thc63_gpio_init(thc63);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D thc63_parse_dt(thc63);
> > +	if (ret)
> > +		return ret;
> > +
> > +	thc63->bridge.driver_private =3D thc63;
> > +	thc63->bridge.of_node =3D pdev->dev.of_node;
> > +	thc63->bridge.funcs =3D &thc63_bridge_func;
> > +
> > +	drm_bridge_add(&thc63->bridge);
> > +
> > +	return 0;
> > +}
> > +
> > +static int thc63_remove(struct platform_device *pdev)
> > +{
> > +	struct thc63_dev *thc63 =3D platform_get_drvdata(pdev);
> > +
> > +	drm_bridge_remove(&thc63->bridge);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id thc63_match[] =3D {
> > +	{ .compatible =3D "thine,thc63lvd1024", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, thc63_match);
> > +#endif
> > +
> > +static struct platform_driver thc63_driver =3D {
> > +	.probe	=3D thc63_probe,
> > +	.remove	=3D thc63_remove,
> > +	.driver	=3D {
> > +		.name		=3D "thc63lvd1024",
> > +		.of_match_table	=3D thc63_match,
> > +	},
> > +};
> > +module_platform_driver(thc63_driver);
> > +
> > +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> > +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver"=
);
> > +MODULE_LICENSE("GPL v2");
>
>

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaqpX/AAoJEHI0Bo8WoVY8J1wP/RdqhwDrDgWMv0kxCOCYUkXv
kEvIywC99qFYe6TJuJLp4nhotcu6daERp42kKnlU4WLHyDTmFsVscew/VtNIv5/W
1jGHOgN0Bw/1Xc4mB6brmIzlSvUQPesq6SOK3CTeWyBjB2hJ7pNZpcTQjk9O/8BM
F2GIlK4ZkM5fmosRX1VEqWZKbsvovvMRxHlbgQbTJq7A4x62m9D4tWuCFzZTRUBG
/7JmauXczSoKoTvcmLfs7rnGRG8UL8HlFyw8bbjUXakTyuNleA0XjX1cCKr3vbVs
+rVP37PyEzZDcUxr+sXjxw1u9K3DO5P4dzM2YvHL84MRm/dZOxVzQVg6gJxcw5+t
+Oz2vS/pPcJrlWQ0DmUr5YwZIBgXcduLPqiCsGo/iNiFKskhQMKYaSD6YaTvcfyB
byQU7aKzq/60v09n2bADI79X4si9rfT9rzjfNe7HplnS0BYTcNZC6T0PtfPyGuEe
VOhhsvnEiA8as9/QePXWR8U5ywESPFRJ3R8rMJyz3LIJfVhBLRRwZgajBY+1zTd4
+zsniJ6q/y9yxxxqykzFIMHB0U1J3O3tu7NqiBY+kDJWaZaOt7c64XblTIJn7te1
97ymgTCyk+jPUbFIdjCPTPW2VZthhzvulKDo6gBgfESsqZRugXr/McCrT6a1PNnv
nr0DnV+OvR522cHN2ymT
=+wLB
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
