Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbeCEH0B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:26:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47044 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933146AbeCEH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:26:00 -0500
Date: Mon, 5 Mar 2018 08:25:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: move rgb mode_valid from connector to encoder
Message-ID: <20180305072558.ujxojkrm5r5rican@flea.lan>
References: <1520159870-41286-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a55r6y4227u2cxrb"
Content-Disposition: inline
In-Reply-To: <1520159870-41286-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a55r6y4227u2cxrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Sun, Mar 04, 2018 at 11:37:50AM +0100, Giulio Benetti wrote:
> mode_valid function must be connected to encoder, not connector.
> Otherwise it doesn't get called by drm.

That's not true, or rather, that's a big oversimplification. It
doesn't get called by DRM if you have a bridge instead of a panel
attached to the encoder.

> Move mode_valid function pointer to encoder helper functions,
> changing its prototype according to encoder helper function pointer.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 102 +++++++++++++++++++-------------=
------
>  1 file changed, 51 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/su=
n4i_rgb.c
> index b8da5a5..6539dcc 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -52,11 +52,59 @@ static int sun4i_rgb_get_modes(struct drm_connector *=
connector)
>  	return drm_panel_get_modes(tcon->panel);
>  }
> =20
> -static int sun4i_rgb_mode_valid(struct drm_connector *connector,
> -				struct drm_display_mode *mode)
> +static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs =3D {
> +	.get_modes	=3D sun4i_rgb_get_modes,
> +};
> +
> +static void
> +sun4i_rgb_connector_destroy(struct drm_connector *connector)
>  {
>  	struct sun4i_rgb *rgb =3D drm_connector_to_sun4i_rgb(connector);
>  	struct sun4i_tcon *tcon =3D rgb->tcon;
> +
> +	drm_panel_detach(tcon->panel);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs sun4i_rgb_con_funcs =3D {
> +	.fill_modes		=3D drm_helper_probe_single_connector_modes,
> +	.destroy		=3D sun4i_rgb_connector_destroy,
> +	.reset			=3D drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(encoder);
> +	struct sun4i_tcon *tcon =3D rgb->tcon;
> +
> +	DRM_DEBUG_DRIVER("Enabling RGB output\n");
> +
> +	if (!IS_ERR(tcon->panel)) {
> +		drm_panel_prepare(tcon->panel);
> +		drm_panel_enable(tcon->panel);
> +	}
> +}
> +
> +static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(encoder);
> +	struct sun4i_tcon *tcon =3D rgb->tcon;
> +
> +	DRM_DEBUG_DRIVER("Disabling RGB output\n");
> +
> +	if (!IS_ERR(tcon->panel)) {
> +		drm_panel_disable(tcon->panel);
> +		drm_panel_unprepare(tcon->panel);
> +	}
> +}
> +
> +static enum drm_mode_status sun4i_rgb_encoder_mode_valid(struct drm_enco=
der *crtc,
> +							 const struct drm_display_mode *mode)
> +{
> +	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(crtc);
> +	struct sun4i_tcon *tcon =3D rgb->tcon;
>  	u32 hsync =3D mode->hsync_end - mode->hsync_start;
>  	u32 vsync =3D mode->vsync_end - mode->vsync_start;
>  	unsigned long rate =3D mode->clock * 1000;
> @@ -106,58 +154,10 @@ static int sun4i_rgb_mode_valid(struct drm_connecto=
r *connector,
>  	return MODE_OK;
>  }
> =20
> -static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs =3D {
> -	.get_modes	=3D sun4i_rgb_get_modes,
> -	.mode_valid	=3D sun4i_rgb_mode_valid,
> -};
> -
> -static void
> -sun4i_rgb_connector_destroy(struct drm_connector *connector)
> -{
> -	struct sun4i_rgb *rgb =3D drm_connector_to_sun4i_rgb(connector);
> -	struct sun4i_tcon *tcon =3D rgb->tcon;
> -
> -	drm_panel_detach(tcon->panel);
> -	drm_connector_cleanup(connector);
> -}
> -
> -static const struct drm_connector_funcs sun4i_rgb_con_funcs =3D {
> -	.fill_modes		=3D drm_helper_probe_single_connector_modes,
> -	.destroy		=3D sun4i_rgb_connector_destroy,
> -	.reset			=3D drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
> -};
> -
> -static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
> -{
> -	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(encoder);
> -	struct sun4i_tcon *tcon =3D rgb->tcon;
> -
> -	DRM_DEBUG_DRIVER("Enabling RGB output\n");
> -
> -	if (!IS_ERR(tcon->panel)) {
> -		drm_panel_prepare(tcon->panel);
> -		drm_panel_enable(tcon->panel);
> -	}
> -}
> -
> -static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
> -{
> -	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(encoder);
> -	struct sun4i_tcon *tcon =3D rgb->tcon;
> -
> -	DRM_DEBUG_DRIVER("Disabling RGB output\n");
> -
> -	if (!IS_ERR(tcon->panel)) {
> -		drm_panel_disable(tcon->panel);
> -		drm_panel_unprepare(tcon->panel);
> -	}
> -}
> -
>  static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs =3D {
>  	.disable	=3D sun4i_rgb_encoder_disable,
>  	.enable		=3D sun4i_rgb_encoder_enable,
> +	.mode_valid	=3D sun4i_rgb_encoder_mode_valid,

The only thing you should be changing is that structure, the matching
connector structure, and the function prototype. This patch is way
bigger than it needs to be.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--a55r6y4227u2cxrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqc8QUACgkQ0rTAlCFN
r3RMYg//cpqPPwhysYwIHHHLbrCXj6ibSPyZ/u1CfQ2SpyI3oX3au6Iz+7q2L2aH
uMPNEjSIfbUoaJYNdGm8g1uqdE+hBjonS+/gyjDVvpLBCfIPxKU4vn91vtY7hX7Y
x+DOwQmXNipoI4k+lgcHBi/CZqFkk/rI9yyfwwt4qbAqe64VgGvpj076OEIgivSy
/MPXZnxVrtUAv2d/yVjciX9q3+sCw8A1K7dnIpTSJSg+bMMttH6599qVjr+GrtWX
LoEIKxTUvTyjHoxCr6mhSt+kYmyKennIDYBlBtkvltIDbrE2jT0MZ4OThmuM9TrZ
mAFUu53AbQWYRpgWtAXeXcCN9mP7HyZtA4c3YqX3ZbdTv6E+fjzpLz79RkvUllmo
9PObKHWqTTxzJQ75Nrf5INceSUSXds4M7SzF6bnNRtmvfmLV2MXDLN/NPl/B2L1X
+kmSbmzL8/Ccck/i6srjtiqM/ApIc/LPiaOQ24U2iX71LWyXDpA6tq3bOzgxDiwu
/u+n7A2NfelfQAcMwa+nRYyc3eb7P6bIK0RyYcNuTbZKyTAZ8iEmhwVbR/D+itpc
9KF3KWJHsEHx70ynTvxCDDx2xKWSs7NU9fCsOCNkaBUMz/i/qUATbD/W6tSDdLTj
e0ZBVC5+IPmNeGvmDiqTZi3Gu0y40911PHngWpYo9QY5ZASs9OY=
=64kH
-----END PGP SIGNATURE-----

--a55r6y4227u2cxrb--
