Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64991C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA724AE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA724AE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGCPnS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:43:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44254 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932254AbeGCPnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:43:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8318F207AB; Tue,  3 Jul 2018 17:43:14 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37E17203D9;
        Tue,  3 Jul 2018 17:43:14 +0200 (CEST)
Message-ID: <933590049d8979ed2665b41fb065f8008a70a1ef.camel@bootlin.com>
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        maxime.ripard@bootlin.com, wens@csie.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Tue, 03 Jul 2018 17:43:14 +0200
In-Reply-To: <20180627164514.4777-1-jernej.skrabec@siol.net>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-R4RZCfclmGv2eopvnTqJ"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-R4RZCfclmGv2eopvnTqJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-27 at 18:45 +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
>=20
> Expand implementation with configurable zpos property.

Thanks for adding support for this! Tested with the Sunxi-Cedrus VPU
driver on H3 with:
https://github.com/free-electrons/cedrus-frame-test/commit/9f46aa83cae1b9fa=
4d4901d3d2999c8d41265532

Tested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++--
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  4 +++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 45 ++++++++++++++++----------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 45 ++++++++++++++++----------
>  4 files changed, 72 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index ee8febb25903..0747a9a69654 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -260,6 +260,17 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u=
32 format)
>  	return NULL;
>  }
> =20
> +static void sun8i_mixer_atomic_begin(struct sunxi_engine *engine,
> +				     struct drm_crtc_state *old_state)
> +{
> +	/*
> +	 * Disable all pipes at the beginning. They will be enabled
> +	 * again if needed in plane update callback.
> +	 */
> +	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> +}
> +
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -311,6 +322,7 @@ static struct drm_plane **sun8i_layers_init(struct dr=
m_device *drm,
>  }
> =20
>  static const struct sunxi_engine_ops sun8i_engine_ops =3D {
> +	.atomic_begin	=3D sun8i_mixer_atomic_begin,
>  	.commit		=3D sun8i_mixer_commit,
>  	.layers_init	=3D sun8i_layers_init,
>  };
> @@ -432,9 +444,6 @@ static int sun8i_mixer_bind(struct device *dev, struc=
t device *master,
>  	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
>  		     SUN8I_MIXER_BLEND_COLOR_BLACK);
> =20
> -	/* Fixed zpos for now */
> -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
> -
>  	plane_cnt =3D mixer->cfg->vi_num + mixer->cfg->ui_num;
>  	for (i =3D 0; i < plane_cnt; i++)
>  		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
> index f34e70c42adf..406c42e752d7 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -44,6 +44,7 @@
>  #define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
>  #define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
> =20
> +#define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
>  /* colors are always in AARRGGBB format */
> @@ -51,6 +52,9 @@
>  /* The following numbers are some still unknown magic numbers */
>  #define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
> =20
> +#define SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(n)	(0xf << ((n) << 2))
> +#define SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(n)	((n) << 2)
> +
>  #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
> =20
>  #define SUN8I_MIXER_FBFMT_ARGB8888	0
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 9a540330cb79..518e1921f47e 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -27,7 +27,7 @@
>  #include "sun8i_ui_scaler.h"
> =20
>  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel=
,
> -				  int overlay, bool enable)
> +				  int overlay, bool enable, unsigned int zpos)
>  {
>  	u32 val;
> =20
> @@ -43,18 +43,24 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer =
*mixer, int channel,
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> =20
> -	if (enable)
> -		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
> -	else
> -		val =3D 0;
> +	if (enable) {
> +		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> =20
> -	regmap_update_bits(mixer->engine.regs,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
> +
> +		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> +				   val);
> +	}
>  }
> =20
>  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int ch=
annel,
> -				       int overlay, struct drm_plane *plane)
> +				       int overlay, struct drm_plane *plane,
> +				       unsigned int zpos)
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	u32 src_w, src_h, dst_w, dst_h;
> @@ -137,10 +143,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
>  			 state->dst.x1, state->dst.y1);
>  	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
>  		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
>  		     outsize);
> =20
>  	return 0;
> @@ -238,28 +244,30 @@ static void sun8i_ui_layer_atomic_disable(struct dr=
m_plane *plane,
>  	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
>  }
> =20
>  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  					 struct drm_plane_state *old_state)
>  {
>  	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> +	unsigned int zpos =3D plane->state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
>  	if (!plane->state->visible) {
>  		sun8i_ui_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false);
> +				      layer->overlay, false, 0);
>  		return;
>  	}
> =20
>  	sun8i_ui_layer_update_coord(mixer, layer->channel,
> -				    layer->overlay, plane);
> +				    layer->overlay, plane, zpos);
>  	sun8i_ui_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_ui_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, true);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> +			      true, zpos);
>  }
> =20
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs =3D {
> @@ -307,6 +315,7 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct=
 drm_device *drm,
>  	enum drm_plane_type type =3D DRM_PLANE_TYPE_OVERLAY;
>  	int channel =3D mixer->cfg->vi_num + index;
>  	struct sun8i_ui_layer *layer;
> +	unsigned int plane_cnt;
>  	int ret;
> =20
>  	layer =3D devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
> @@ -327,8 +336,10 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struc=
t drm_device *drm,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	/* fixed zpos for now */
> -	ret =3D drm_plane_create_zpos_immutable_property(&layer->plane, channel=
);
> +	plane_cnt =3D mixer->cfg->ui_num + mixer->cfg->vi_num;
> +
> +	ret =3D drm_plane_create_zpos_property(&layer->plane, channel,
> +					     0, plane_cnt - 1);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't add zpos property\n");
>  		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 5877f8ef5895..17e0d00cfd8a 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -21,7 +21,7 @@
>  #include "sun8i_vi_scaler.h"
> =20
>  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel=
,
> -				  int overlay, bool enable)
> +				  int overlay, bool enable, unsigned int zpos)
>  {
>  	u32 val;
> =20
> @@ -37,18 +37,24 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer =
*mixer, int channel,
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> =20
> -	if (enable)
> -		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
> -	else
> -		val =3D 0;
> +	if (enable) {
> +		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> =20
> -	regmap_update_bits(mixer->engine.regs,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
> +
> +		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> +				   val);
> +	}
>  }
> =20
>  static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int ch=
annel,
> -				       int overlay, struct drm_plane *plane)
> +				       int overlay, struct drm_plane *plane,
> +				       unsigned int zpos)
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	const struct drm_format_info *format =3D state->fb->format;
> @@ -130,10 +136,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
>  			 state->dst.x1, state->dst.y1);
>  	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
>  		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
>  		     outsize);
> =20
>  	return 0;
> @@ -266,28 +272,30 @@ static void sun8i_vi_layer_atomic_disable(struct dr=
m_plane *plane,
>  	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
>  }
> =20
>  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  					 struct drm_plane_state *old_state)
>  {
>  	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> +	unsigned int zpos =3D plane->state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
>  	if (!plane->state->visible) {
>  		sun8i_vi_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false);
> +				      layer->overlay, false, 0);
>  		return;
>  	}
> =20
>  	sun8i_vi_layer_update_coord(mixer, layer->channel,
> -				    layer->overlay, plane);
> +				    layer->overlay, plane, zpos);
>  	sun8i_vi_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_vi_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, true);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> +			      true, zpos);
>  }
> =20
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs =3D {
> @@ -351,6 +359,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct=
 drm_device *drm,
>  					       int index)
>  {
>  	struct sun8i_vi_layer *layer;
> +	unsigned int plane_cnt;
>  	int ret;
> =20
>  	layer =3D devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
> @@ -368,8 +377,10 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struc=
t drm_device *drm,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	/* fixed zpos for now */
> -	ret =3D drm_plane_create_zpos_immutable_property(&layer->plane, index);
> +	plane_cnt =3D mixer->cfg->ui_num + mixer->cfg->vi_num;
> +
> +	ret =3D drm_plane_create_zpos_property(&layer->plane, index,
> +					     0, plane_cnt - 1);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't add zpos property\n");
>  		return ERR_PTR(ret);
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-R4RZCfclmGv2eopvnTqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAls7mZMACgkQ3cLmz3+f
v9Gdkgf/S3JwAmuk2KXisIn6C8uFe0KUARbvcQpYhl3nUyIDa2ifICYrxCMv3YSr
VXpoT902HpOay2T6V9WPkGAXyl0+lUBcZiTmw+b7MPBWtIshmcgB27srAjJ19cxd
ew8It9yTLEDVdrtqqndV1ndWvL97QZwX4n3wV3CIBak1t1fHquYMNdhUkoT2u2al
nNF/8CEJmlVNoxzLvwNQOtMpCn0s9F/YyWH1iQ/1E2z0VWkpl1j6M87XcnwTCJfH
G14BAfrcvlxTAQL6DlUZdus9c2SNTg23iRs4GQGcb+i9XEHK+KdOof9Rd6to0h17
1R55RUZuXeYQT7pgzfwYA4J3iDdKCQ==
=YPFJ
-----END PGP SIGNATURE-----

--=-R4RZCfclmGv2eopvnTqJ--

