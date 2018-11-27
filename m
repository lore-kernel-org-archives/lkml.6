Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13799C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B18208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B18208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeK0T5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:57:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58252 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0T5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:57:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A73AA207BC; Tue, 27 Nov 2018 10:00:37 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 72C2520DC6;
        Tue, 27 Nov 2018 10:00:27 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:00:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 27/43] drm/sun4i: frontend: Add support for
 semi-planar YUV input formats
Message-ID: <20181127090027.mezxdx4s77ylj762@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-28-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxfwkkzihqxp66re"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-28-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxfwkkzihqxp66re
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:59AM +0100, Paul Kocialkowski wrote:
> Semi-planar YUV formats use two distinct planes, one for luminance and
> one for chrominance. To add support for them, we need to configure the
> second line stride and buffer address registers to setup the second YUV
> plane.
>=20
> New definitions are introduced to configure the input format register
> for the YUV420 and YUV422 semi-planar formats.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 52 +++++++++++++++++++++++---
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 +++
>  drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 ++
>  3 files changed, 57 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index f443e8e1d8ec..e31438e5cabd 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -118,11 +118,23 @@ void sun4i_frontend_update_buffer(struct sun4i_fron=
tend *frontend,
>  	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
>  		     fb->pitches[0]);
> =20
> +	if (fb->format->num_planes > 1)
> +		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
> +			     fb->pitches[1]);
> +
>  	/* Set the physical address of the buffer in memory */
>  	paddr =3D drm_fb_cma_get_gem_addr(fb, state, 0);
>  	paddr -=3D PHYS_OFFSET;
> -	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
> +	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
>  	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
> +
> +	if (fb->format->num_planes > 1) {
> +		paddr =3D drm_fb_cma_get_gem_addr(fb, state, 1);
> +		paddr -=3D PHYS_OFFSET;
> +		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
> +		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
> +			     paddr);
> +	}
>  }
>  EXPORT_SYMBOL(sun4i_frontend_update_buffer);
> =20
> @@ -130,6 +142,8 @@ static int sun4i_frontend_drm_format_to_input_fmt(uin=
t32_t fmt, u32 *val)
>  {
>  	if (!drm_format_is_yuv(fmt))
>  		*val =3D SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
> +	else if (drm_format_is_yuv_sampling_420(fmt))
> +		*val =3D SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
>  	else if (drm_format_is_yuv_sampling_422(fmt))
>  		*val =3D SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
>  	else
> @@ -140,12 +154,20 @@ static int sun4i_frontend_drm_format_to_input_fmt(u=
int32_t fmt, u32 *val)
> =20
>  static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *va=
l)
>  {
> -	if (drm_format_num_planes(fmt) =3D=3D 1)
> +	int num_planes =3D drm_format_num_planes(fmt);
> +
> +	switch (num_planes) {
> +	case 1:

You seem to use either the helper or retrieve the structure field
directly to access the number of planes. I'm fine either way, but this
should be consistent.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vxfwkkzihqxp66re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0HqwAKCRDj7w1vZxhR
xbL+AP0YNFEOwKION6NLQar+VdHTyGaMgjc7CSU4sydadCOxpgEAhnJA3+6VKTWP
QarWr/1yP6h2jgabeVhxvLTLu0qykwg=
=BeQR
-----END PGP SIGNATURE-----

--vxfwkkzihqxp66re--
