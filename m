Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48282075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48282075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGQObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:31:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41160 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbeGQObg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:31:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E4137206ED; Tue, 17 Jul 2018 15:58:45 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 992A6203EC;
        Tue, 17 Jul 2018 15:58:45 +0200 (CEST)
Message-ID: <a2a18893c1867f4fbb905da4f749a0e69f327103.camel@bootlin.com>
Subject: Re: [PATCH v2] drm/sun4i: sun8i: Avoid clearing blending order at
 each atomic commit
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Date:   Tue, 17 Jul 2018 15:58:45 +0200
In-Reply-To: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
References: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PF/DNJD3TfOi34/nuyCI"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PF/DNJD3TfOi34/nuyCI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-07-17 at 14:25 +0200, Paul Kocialkowski wrote:
> Blending order is set based on the z position of each DRM plane. The
> blending order register is currently cleared at each atomic DRM commit,
> with the intent that each committed plane will set the appropriate
> bits (based on its z-pos) when enabling the plane.
>=20
> However, it sometimes happens that a particular plane is left unchanged
> by an atomic commit and thus will not be configured again. In that
> scenario, blending order is cleared and only the bits relevant for the
> planes affected by the commit are set. This leaves the planes that did
> not change without their blending order set in the register, leading
> to that plane not being displayed.
>=20
> Instead of clearing the blending order register at every atomic commit,
> this change moves the register's initial clear at bind time and only
> clears the bits for a specific plane when disabling it or changing its
> zpos.
>=20
> This way, planes that are left untouched by a DRM atomic commit are
> no longer disabled.

This patch was rebased to apply on top of DRM misc. V1 had been based on
the first revision of the DE2 z-pos support patch, while a subsequent
revision of the patch made it to the kernel tree.

Cheers!

Paul

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++------------
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 24 ++++++++++++++++++++----
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 24 ++++++++++++++++++++----
>  3 files changed, 43 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 8e81c24d736e..12cb7183ce51 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -260,17 +260,6 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u=
32 format)
>  	return NULL;
>  }
> =20
> -static void sun8i_mixer_atomic_begin(struct sunxi_engine *engine,
> -				     struct drm_crtc_state *old_state)
> -{
> -	/*
> -	 * Disable all pipes at the beginning. They will be enabled
> -	 * again if needed in plane update callback.
> -	 */
> -	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> -}
> -
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -322,7 +311,6 @@ static struct drm_plane **sun8i_layers_init(struct dr=
m_device *drm,
>  }
> =20
>  static const struct sunxi_engine_ops sun8i_engine_ops =3D {
> -	.atomic_begin	=3D sun8i_mixer_atomic_begin,
>  	.commit		=3D sun8i_mixer_commit,
>  	.layers_init	=3D sun8i_layers_init,
>  };
> @@ -449,6 +437,9 @@ static int sun8i_mixer_bind(struct device *dev, struc=
t device *master,
>  		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
>  			     SUN8I_MIXER_BLEND_MODE_DEF);
> =20
> +	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> +
>  	return 0;
> =20
>  err_disable_bus_clk:
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 518e1921f47e..28c15c6ef1ef 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -27,7 +27,8 @@
>  #include "sun8i_ui_scaler.h"
> =20
>  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel=
,
> -				  int overlay, bool enable, unsigned int zpos)
> +				  int overlay, bool enable, unsigned int zpos,
> +				  unsigned int old_zpos)
>  {
>  	u32 val;
> =20
> @@ -43,6 +44,18 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *=
mixer, int channel,
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> =20
> +	if (!enable || zpos !=3D old_zpos) {
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> +				   0);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> +				   0);
> +	}
> +
>  	if (enable) {
>  		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> =20
> @@ -242,9 +255,11 @@ static void sun8i_ui_layer_atomic_disable(struct drm=
_plane *plane,
>  					  struct drm_plane_state *old_state)
>  {
>  	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> +	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
> +			      old_zpos);
>  }
> =20
>  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> @@ -252,11 +267,12 @@ static void sun8i_ui_layer_atomic_update(struct drm=
_plane *plane,
>  {
>  	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
>  	unsigned int zpos =3D plane->state->normalized_zpos;
> +	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
>  	if (!plane->state->visible) {
>  		sun8i_ui_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false, 0);
> +				      layer->overlay, false, 0, old_zpos);
>  		return;
>  	}
> =20
> @@ -267,7 +283,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_p=
lane *plane,
>  	sun8i_ui_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
>  	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> -			      true, zpos);
> +			      true, zpos, old_zpos);
>  }
> =20
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs =3D {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 17e0d00cfd8a..f4fe97813f94 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -21,7 +21,8 @@
>  #include "sun8i_vi_scaler.h"
> =20
>  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel=
,
> -				  int overlay, bool enable, unsigned int zpos)
> +				  int overlay, bool enable, unsigned int zpos,
> +				  unsigned int old_zpos)
>  {
>  	u32 val;
> =20
> @@ -37,6 +38,18 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *=
mixer, int channel,
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> =20
> +	if (!enable || zpos !=3D old_zpos) {
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> +				   0);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> +				   0);
> +	}
> +
>  	if (enable) {
>  		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> =20
> @@ -270,9 +283,11 @@ static void sun8i_vi_layer_atomic_disable(struct drm=
_plane *plane,
>  					  struct drm_plane_state *old_state)
>  {
>  	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> +	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
> +			      old_zpos);
>  }
> =20
>  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> @@ -280,11 +295,12 @@ static void sun8i_vi_layer_atomic_update(struct drm=
_plane *plane,
>  {
>  	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
>  	unsigned int zpos =3D plane->state->normalized_zpos;
> +	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
>  	if (!plane->state->visible) {
>  		sun8i_vi_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false, 0);
> +				      layer->overlay, false, 0, old_zpos);
>  		return;
>  	}
> =20
> @@ -295,7 +311,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_p=
lane *plane,
>  	sun8i_vi_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
>  	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> -			      true, zpos);
> +			      true, zpos, old_zpos);
>  }
> =20
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs =3D {
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-PF/DNJD3TfOi34/nuyCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAltN9hUACgkQ3cLmz3+f
v9GYMwf4+pP7YWmAVJr1eB2s85h+YiGmqYNOXz+KJWVKLGyctetFWzGqh5cXgq6W
NfZ31SJcNacl68939owVcQ6He9WbzcZrdQaiZwObGKrMI439LqxCS2a6HOIyip3O
a65GxjscPlGtTRtfgLNED3USxAYT//11g5tcBQKqvNDfs2oVq1TAmT2mcdPc3B5C
TFvP9/h90yud09SbrZC5sVH91d5gD4cOemFnepKl+6aeQPBKCaap7uOdFxXfSEI1
y/07fHUXfE8KSRNsB9PIboDodTkOVIBNIoC6e9obLHzDgPROgaN9HUDohOYeNRoB
pBSk11nFL3bFMyHRZE259Jwu2XOD
=zUHO
-----END PGP SIGNATURE-----

--=-PF/DNJD3TfOi34/nuyCI--

