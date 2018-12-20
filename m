Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF87C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80183218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbeLTSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:02 -0500
Received: from anholt.net ([50.246.234.109]:49654 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeLTSdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 277A910A225E;
        Thu, 20 Dec 2018 10:33:01 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id jKQLOb0qYjo3; Thu, 20 Dec 2018 10:33:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0F0C810A08D6;
        Thu, 20 Dec 2018 10:33:00 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6F8F52FE36F2; Thu, 20 Dec 2018 10:32:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     afaerber@suse.de, agraf@suse.de,
        linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gordon Hollingworth <gordon@raspberrypi.org>
Subject: Re: [PATCH v2] drm/panel: rpi-touchscreen: Add backlight support
In-Reply-To: <20181219112033.31064-1-nsaenzjulienne@suse.de>
References: <20181219112033.31064-1-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 20 Dec 2018 10:32:55 -0800
Message-ID: <87tvj8dp60.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> This patch exposes backlight control into userspace by creating a
> backlight device instead of directly accessing the PWM registers.
>
> The backlight driver can't go on a separate file as it shares the I2C
> bus & address with the panel.

I remember some concerns from Gordon about exposing the backlight PWM.
Gordon, care to chime in on this?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> v1 -> v2:
>   - Add Kconfig dependency with BACKLIGHT_CLASS_DEVICE
>
>  drivers/gpu/drm/panel/Kconfig                 |  1 +
>  .../drm/panel/panel-raspberrypi-touchscreen.c | 33 +++++++++++++++++--
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 6020c30a33b3..1ce35483f342 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -112,6 +112,7 @@ config DRM_PANEL_PANASONIC_VVX10F034N00
>  config DRM_PANEL_RASPBERRYPI_TOUCHSCREEN
>  	tristate "Raspberry Pi 7-inch touchscreen panel"
>  	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
>  	help
>  	  Say Y here if you want to enable support for the Raspberry
>  	  Pi 7" Touchscreen.  To compile this driver as a module,
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/driv=
ers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index 2c9c9722734f..838b5c8767bc 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -52,6 +52,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/pm.h>
> +#include <linux/backlight.h>
>=20=20
>  #include <drm/drm_panel.h>
>  #include <drm/drmP.h>
> @@ -196,6 +197,7 @@ struct rpi_touchscreen {
>  	struct drm_panel base;
>  	struct mipi_dsi_device *dsi;
>  	struct i2c_client *i2c;
> +	struct backlight_device *backlight;
>  };
>=20=20
>  static const struct drm_display_mode rpi_touchscreen_modes[] =3D {
> @@ -256,7 +258,8 @@ static int rpi_touchscreen_disable(struct drm_panel *=
panel)
>  {
>  	struct rpi_touchscreen *ts =3D panel_to_ts(panel);
>=20=20
> -	rpi_touchscreen_i2c_write(ts, REG_PWM, 0);
> +	ts->backlight->props.brightness =3D 0;
> +	backlight_update_status(ts->backlight);
>=20=20
>  	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
>  	udelay(1);
> @@ -300,7 +303,8 @@ static int rpi_touchscreen_enable(struct drm_panel *p=
anel)
>  	msleep(100);
>=20=20
>  	/* Turn on the backlight. */
> -	rpi_touchscreen_i2c_write(ts, REG_PWM, 255);
> +	ts->backlight->props.brightness =3D 255;
> +	backlight_update_status(ts->backlight);
>=20=20
>  	/* Default to the same orientation as the closed source
>  	 * firmware used for the panel.  Runtime rotation
> @@ -358,12 +362,26 @@ static const struct drm_panel_funcs rpi_touchscreen=
_funcs =3D {
>  	.get_modes =3D rpi_touchscreen_get_modes,
>  };
>=20=20
> +static int raspberrypi_bl_update_status(struct backlight_device *bl)
> +{
> +	struct rpi_touchscreen *ts =3D bl_get_data(bl);
> +
> +	rpi_touchscreen_i2c_write(ts, REG_PWM, bl->props.brightness);
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops raspberrypi_bl_ops =3D {
> +	.update_status =3D raspberrypi_bl_update_status,
> +};
> +
>  static int rpi_touchscreen_probe(struct i2c_client *i2c,
>  				 const struct i2c_device_id *id)
>  {
>  	struct device *dev =3D &i2c->dev;
>  	struct rpi_touchscreen *ts;
>  	struct device_node *endpoint, *dsi_host_node;
> +	struct backlight_properties props;
>  	struct mipi_dsi_host *host;
>  	int ret, ver;
>  	struct mipi_dsi_device_info info =3D {
> @@ -398,6 +416,17 @@ static int rpi_touchscreen_probe(struct i2c_client *=
i2c,
>  	/* Turn off at boot, so we can cleanly sequence powering on. */
>  	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
>=20=20
> +	memset(&props, 0, sizeof(props));
> +	props.type =3D BACKLIGHT_RAW;
> +	props.max_brightness =3D 255;
> +	ts->backlight =3D devm_backlight_device_register(dev, dev_name(dev), de=
v,
> +						       ts, &raspberrypi_bl_ops,
> +						       &props);
> +	if (IS_ERR(ts->backlight)) {
> +		dev_err(dev, "Failed to create backlight device\n");
> +		return PTR_ERR(ts->backlight);
> +	}
> +
>  	/* Look up the DSI host.  It needs to probe before we do. */
>  	endpoint =3D of_graph_get_next_endpoint(dev->of_node, NULL);
>  	dsi_host_node =3D of_graph_get_remote_port_parent(endpoint);
> --=20
> 2.19.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwb4FcACgkQtdYpNtH8
nujAIg//dGp/W2ikWWcI/dpQkmbaDNJeCJJC3KzLlH/LczC1359djYs5QyySW30u
s/1izOt9sYU4G2WVtb+SBM39zjvzbc0DcyZHtMAoeBgCP2KD4i5fIKJIGjS4+lUZ
m0zp+hdJIFtHY0JHe9fMaHpfktyNXMl4+iFBVeJ02AyoIIACAweAW55c3akNWLsU
gVNwKcNU/fKB/BufCpS18pl8GkrcE1Myv/9ebDX/3njZ4KPAArpeczYMvqSFZ9rv
5grxI3plqUPoNh7g310Hm03fPaJeOh1WXDatRA6poxkKoVwkCMrmcDr4akPVId72
+rolF+pufjYRZWs+QX+rWPMQGuYg5kqZTWheZZZIP2Q6+EaWgBu8rWrMOlIVbHyK
0pIujtBoaTF3bAW0tUpi7Gp9IR/2aYMCP+jESrQm/WDtKr2ZkZZapLpS8uUQ4tlV
Q30O5IcEvDzr/23jLtdmVZqvGDUpsX8WzKxwelEwvIBonKaD8YlByXBOFVOvn8Zy
JnoM4rhKqH6VqDW5zHO3sbS1f0h+QP8+BrfcCpLPwa+dIyEYyinbx+R6Q5hzzI5Z
vir/3UORIj/vDQoqwr81Pn0LNwSRpUxeIcjmdp78ZxiKrpG+8YemsrDWtc/57AEb
LKR4IF0mdJWVfL8yPHEbPnauDZE5QLS9+KGUN42lrhyPLTXp1I0=
=VZBF
-----END PGP SIGNATURE-----
--=-=-=--
