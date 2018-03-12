Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeCLJVP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:21:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39565 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeCLJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:21:14 -0400
X-Google-Smtp-Source: AG47ELthMKV++Y8R0LNRTw2pAk0tNuFvrqGQvJS+HRe4qYtWhRlbsJwWmQkE1jULZwmmvgMFYNvkHg==
Date: Mon, 12 Mar 2018 10:21:10 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lin Huang <hl@rock-chips.com>
Cc: emil.l.velikov@gmail.com, briannorris@chromium.org, robh+dt@kernel.org,
        zyw@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com
Subject: Re: [RESEND PATCH v3 1/3] drm/panel: refactor INNOLUX P079ZCA panel
 driver
Message-ID: <20180312092110.GC15972@ulmo>
References: <1512371870-15350-1-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <1512371870-15350-1-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 03:17:48PM +0800, Lin Huang wrote:
> Refactor Innolux P079ZCA panel driver, let it support
> multi panel.
>=20
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - Change regulator property name to meet the panel datasheet=20
> Changes in v3:
> - this patch only refactor P079ZCA panel to support multi panel, support =
P097PFG panel in another patch=20
>=20
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 147 ++++++++++++++++++--=
------
>  1 file changed, 105 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/=
drm/panel/panel-innolux-p079zca.c
> index 6ba9344..1597744 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -20,12 +20,32 @@
> =20
>  #include <video/mipi_display.h>
> =20
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned int bpc;
> +	struct {
> +		unsigned int width;
> +		unsigned int height;
> +	} size;
> +};
> +
> +struct panel_desc_dsi {
> +	struct panel_desc desc;
> +
> +	unsigned long flags;
> +	enum mipi_dsi_pixel_format format;
> +	unsigned int lanes;
> +};

There's no need for the two layers here. Just move everything from
struct panel_desc_dsi into struct panel_desc.

> +
>  struct innolux_panel {
>  	struct drm_panel base;
>  	struct mipi_dsi_device *link;
> +	const struct panel_desc_dsi *dsi_desc;

And then this can just become:

	const struct panel_desc *desc;

The _dsi suffix is redundant because this driver is exclusively for DSI
devices.

> -static int innolux_panel_add(struct innolux_panel *innolux)
> +static int innolux_panel_add(struct mipi_dsi_device *dsi,
> +			     const struct panel_desc_dsi *desc)
>  {
> -	struct device *dev =3D &innolux->link->dev;
> +	struct innolux_panel *innolux;
> +	struct device *dev =3D &dsi->dev;
>  	struct device_node *np;
>  	int err;
> =20
> -	innolux->supply =3D devm_regulator_get(dev, "power");
> -	if (IS_ERR(innolux->supply))
> -		return PTR_ERR(innolux->supply);
> +	innolux =3D devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
> +	if (!innolux)
> +		return -ENOMEM;
> +
> +	innolux->dsi_desc =3D desc;
> +	innolux->vddi =3D devm_regulator_get(dev, "power");
> +	if (IS_ERR(innolux->vddi))
> +		return PTR_ERR(innolux->vddi);
> +
> +	innolux->avdd =3D devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(innolux->avdd))
> +		return PTR_ERR(innolux->avdd);
> +
> +	innolux->avee =3D devm_regulator_get(dev, "avee");
> +	if (IS_ERR(innolux->avee))
> +		return PTR_ERR(innolux->avee);

According to the device tree bindings these regulators are all optional.
Now devm_regulator_get() will return a dummy regulator if one has not
been specified in DT, so this seems like it should work fine, even for
existing DTBs that don't have the avdd and avee regulators. However, the
DT bindings seem to be wrong, because these are in fact required
regulators.

> =20
>  	innolux->enable_gpio =3D devm_gpiod_get_optional(dev, "enable",
>  						       GPIOD_OUT_HIGH);
> @@ -243,14 +306,16 @@ static int innolux_panel_add(struct innolux_panel *=
innolux)
> =20
>  	drm_panel_init(&innolux->base);
>  	innolux->base.funcs =3D &innolux_panel_funcs;
> -	innolux->base.dev =3D &innolux->link->dev;
> +	innolux->base.dev =3D dev;
> =20
>  	err =3D drm_panel_add(&innolux->base);
>  	if (err < 0)
>  		goto put_backlight;
> =20
> -	return 0;
> +	dev_set_drvdata(dev, innolux);
> +	innolux->link =3D dsi;
> =20
> +	return 0;
>  put_backlight:
>  	put_device(&innolux->backlight->dev);
> =20
> @@ -267,28 +332,25 @@ static void innolux_panel_del(struct innolux_panel =
*innolux)
> =20
>  static int innolux_panel_probe(struct mipi_dsi_device *dsi)
>  {
> -	struct innolux_panel *innolux;
> -	int err;
> =20
> -	dsi->lanes =3D 4;
> -	dsi->format =3D MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULS=
E |
> -			  MIPI_DSI_MODE_LPM;
> -
> -	innolux =3D devm_kzalloc(&dsi->dev, sizeof(*innolux), GFP_KERNEL);
> -	if (!innolux)
> -		return -ENOMEM;
> +	const struct panel_desc_dsi *dsi_desc;
> +	const struct of_device_id *id;
> +	int err;
> =20
> -	mipi_dsi_set_drvdata(dsi, innolux);
> +	id =3D of_match_node(innolux_of_match, dsi->dev.of_node);
> +	if (!id)
> +		return -ENODEV;
> =20
> -	innolux->link =3D dsi;
> +	dsi_desc =3D id->data;
> +	dsi->mode_flags =3D dsi_desc->flags;
> +	dsi->format =3D dsi_desc->format;
> +	dsi->lanes =3D dsi_desc->lanes;
> =20
> -	err =3D innolux_panel_add(innolux);
> +	err =3D innolux_panel_add(dsi, dsi_desc);
>  	if (err < 0)
>  		return err;
> =20
> -	err =3D mipi_dsi_attach(dsi);
> -	return err;
> +	return mipi_dsi_attach(dsi);
>  }
> =20
>  static int innolux_panel_remove(struct mipi_dsi_device *dsi)
> @@ -326,7 +388,7 @@ static void innolux_panel_shutdown(struct mipi_dsi_de=
vice *dsi)
> =20
>  static struct mipi_dsi_driver innolux_panel_driver =3D {
>  	.driver =3D {
> -		.name =3D "panel-innolux-p079zca",
> +		.name =3D "panel-innolux-dsi",

No need to change that. Also, probably a bad idea to change it because
there are (or will be) likely other DSI panels from Innolux that are not
compatible with this driver.

Thierry

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmRoQACgkQ3SOs138+
s6FGxQ//aPmKYEZ62rc52+gn4EEdRgFykVErPQMkpmLwjszJ9zwzWki9uzfDe8Bq
lLKaJ2lqmUXazijDb1W/DWZYiVUnYhwF+6Zrs1BYTziM4GK2EdfV0Xdu7cJQ4ZVE
ICj3+9SlGbvW6h2b4ed+ocJv9T4h10S0GV/w9sQ36ym/DxEswzDietyhDkETBnG8
kop7Lsn+C9rhF2X3VNtv+3Mf3DRd2PxldBsJ/xZ4b5hb/910arhXnuQOOvuEp9q3
TiSTlvCspziS8f+pEF7w2HrmULEA1OPYZAEEFxU5tylvilvBtKkyNck9rrZuARh0
wEzTr+VTWwP6XbKUP7gm92Ckz4QiEO0w7sTIRz9iWsHTZedMQe5ngVc5b+h9Kk1m
aNohrQYpOVmeYuh1VXcB12qf89w8Zrs/dbr0zKP8DwGFhVVQV4E0l9ZQZwqYhEso
ENouxSPjLiK0a0lZcm6ARpWv2KXnP8KIOPwOAZRL+H8+sQznWF0hSpFa0HRplZLM
cTFaercuKlbMRdPeC6ZqpQXdP2xDpJWE0ZIo4J43z/HekA/TvbADoeQa65R20BJp
maTzHpN+Qw51lbbf9yfZ0xkRWc6dhxw7ZJmxwKlnGTRen4Agj30Cc/BKKD59mzyT
5Ryogp8gsnzhUOxieGfznYgFJY330W9bq9Um26sVEEBKfhdTBLE=
=k0H1
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
