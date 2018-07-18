Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E14ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE092075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE092075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGRKMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:12:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44136 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeGRKMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:12:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D27D220938; Wed, 18 Jul 2018 11:35:43 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5138120904;
        Wed, 18 Jul 2018 11:35:23 +0200 (CEST)
Message-ID: <76279f0a265bfbe509074fcff3156a437e7091dd.camel@bootlin.com>
Subject: Re: [PATCH v2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com
Date:   Wed, 18 Jul 2018 11:35:23 +0200
In-Reply-To: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
References: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-i/O8cBmO5qR5vvxq0Rsp"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i/O8cBmO5qR5vvxq0Rsp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-07-18 at 11:29 +0200, Paul Kocialkowski wrote:
> Not all sunxi platforms with the first version of the Display Engine
> support an alpha component on the plane with the lowest z position
> (as in: lowest z-pos), that gets blended with the background color.
>=20
> In particular, the A13 is known to have this limitation. However, it was
> recently discovered that the A20 and A33 are capable of having alpha on
> their lowest plane.
>=20
> Thus, this introduces a specific quirk to indicate such support,
> per-platform. Since this was not tested on sun4i and sun6i platforms, a
> conservative approach is kept and this feature is not supported.

Woops, I forgot to include PATCH 1/2 from v1, which did not change.

Would it be preferable for me to send v2 again (and maybe call it v3)
for convenience?

Sorry about that,

Paul

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>=20
> Changes since v1:
> * reordered backend declaration;
> * updated comment to reflect that not all platforms are affected;
> * used num_alpha_planes_max variable instead of define, since it is now
>   dynamic;
> * reordered check to have quirk first in associated conditional.
>=20
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 40 +++++++++++++++++----------
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 -
>  2 files changed, 26 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4=
i/sun4i_backend.c
> index de0a76dfa1a2..eda9466b793b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -34,6 +34,8 @@
>  struct sun4i_backend_quirks {
>  	/* backend <-> TCON muxing selection done in backend */
>  	bool needs_output_muxing;
> +	/* alpha at the lowest z position is not always supported */
> +	bool supports_lowest_plane_alpha;
>  };
> =20
>  static const u32 sunxi_rgb2yuv_coef[12] =3D {
> @@ -463,12 +465,14 @@ static int sun4i_backend_atomic_check(struct sunxi_=
engine *engine,
>  				      struct drm_crtc_state *crtc_state)
>  {
>  	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] =3D { 0 =
};
> +	struct sun4i_backend *backend =3D engine_to_sun4i_backend(engine);
>  	struct drm_atomic_state *state =3D crtc_state->state;
>  	struct drm_device *drm =3D state->dev;
>  	struct drm_plane *plane;
>  	unsigned int num_planes =3D 0;
>  	unsigned int num_alpha_planes =3D 0;
>  	unsigned int num_frontend_planes =3D 0;
> +	unsigned int num_alpha_planes_max =3D 1;
>  	unsigned int num_yuv_planes =3D 0;
>  	unsigned int current_pipe =3D 0;
>  	unsigned int i;
> @@ -532,33 +536,39 @@ static int sun4i_backend_atomic_check(struct sunxi_=
engine *engine,
>  	 * the layer with the highest priority.
>  	 *
>  	 * The second step is the actual alpha blending, that takes
> -	 * the two pipes as input, and uses the eventual alpha
> +	 * the two pipes as input, and uses the potential alpha
>  	 * component to do the transparency between the two.
>  	 *
> -	 * This two steps scenario makes us unable to guarantee a
> +	 * This two-step scenario makes us unable to guarantee a
>  	 * robust alpha blending between the 4 layers in all
>  	 * situations, since this means that we need to have one layer
>  	 * with alpha at the lowest position of our two pipes.
>  	 *
> -	 * However, we cannot even do that, since the hardware has a
> -	 * bug where the lowest plane of the lowest pipe (pipe 0,
> -	 * priority 0), if it has any alpha, will discard the pixel
> -	 * entirely and just display the pixels in the background
> -	 * color (black by default).
> +	 * However, we cannot even do that on every platform, since the
> +	 * hardware has a bug where the lowest plane of the lowest pipe
> +	 * (pipe 0, priority 0), if it has any alpha, will discard the
> +	 * pixel data entirely and just display the pixels in the
> +	 * background color (black by default).
>  	 *
> -	 * This means that we effectively have only three valid
> -	 * configurations with alpha, all of them with the alpha being
> -	 * on pipe1 with the lowest position, which can be 1, 2 or 3
> -	 * depending on the number of planes and their zpos.
> +	 * This means that on the affected platforms, we effectively
> +	 * have only three valid configurations with alpha, all of them
> +	 * with the alpha being on pipe1 with the lowest position, which
> +	 * can be 1, 2 or 3 depending on the number of planes and their zpos.
>  	 */
> -	if (num_alpha_planes > SUN4I_BACKEND_NUM_ALPHA_LAYERS) {
> +
> +	/* For platforms that are not affected by the issue described above. */
> +	if (backend->quirks->supports_lowest_plane_alpha)
> +		num_alpha_planes_max++;
> +
> +	if (num_alpha_planes > num_alpha_planes_max) {
>  		DRM_DEBUG_DRIVER("Too many planes with alpha, rejecting...\n");
>  		return -EINVAL;
>  	}
> =20
>  	/* We can't have an alpha plane at the lowest position */
> -	if (plane_states[0]->fb->format->has_alpha ||
> -	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE))
> +	if (!backend->quirks->supports_lowest_plane_alpha &&
> +	    (plane_states[0]->fb->format->has_alpha ||
> +	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)))
>  		return -EINVAL;
> =20
>  	for (i =3D 1; i < num_planes; i++) {
> @@ -941,9 +951,11 @@ static const struct sun4i_backend_quirks sun6i_backe=
nd_quirks =3D {
> =20
>  static const struct sun4i_backend_quirks sun7i_backend_quirks =3D {
>  	.needs_output_muxing =3D true,
> +	.supports_lowest_plane_alpha =3D true,
>  };
> =20
>  static const struct sun4i_backend_quirks sun8i_a33_backend_quirks =3D {
> +	.supports_lowest_plane_alpha =3D true,
>  };
> =20
>  static const struct sun4i_backend_quirks sun9i_backend_quirks =3D {
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4=
i/sun4i_backend.h
> index 4caee0392fa4..c428952f3661 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
> @@ -167,7 +167,6 @@
>  #define SUN4I_BACKEND_PIPE_OFF(p)		(0x5000 + (0x400 * (p)))
> =20
>  #define SUN4I_BACKEND_NUM_LAYERS		4
> -#define SUN4I_BACKEND_NUM_ALPHA_LAYERS		1
>  #define SUN4I_BACKEND_NUM_FRONTEND_LAYERS	1
>  #define SUN4I_BACKEND_NUM_YUV_PLANES		1
> =20
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-i/O8cBmO5qR5vvxq0Rsp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAltPCdsACgkQ3cLmz3+f
v9F01wgAluKZT7j1PbZ79sF1BJ97PpJCVZV5IF6bv4VBb171DzuqH8l2JeBpU1Lm
2LYSXmB145qmN9WBSpwGlT/WJvNN8646mXyCJ/dcelIYi+fW0GKf8EaqwXDmQeXE
R+zToogHzBCd4PQ0Gvg1h3/SWXUMwCgIEuGGdrklE3cIU6SNfyNJfIyr6Rbwwaz9
fftKRu5M0xNbgWhqVk68QatRvE7EYmB6Im+sJJluTf+DX32mSI1gh53UZpa8V+67
gCwH/8ZnoWnmpPDKkHJdFrtwp0Rkn1KUGYHDtcaCqCw+OFsMH7XCB6I83yAKcI0E
+ilW8wzi5JwVz93n+woPNYMBKPZrKg==
=+kuv
-----END PGP SIGNATURE-----

--=-i/O8cBmO5qR5vvxq0Rsp--

