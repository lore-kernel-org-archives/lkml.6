Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14232086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14232086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeK0UV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:21:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59717 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbeK0UV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:21:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4BAA620D29; Tue, 27 Nov 2018 10:24:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B242207BC;
        Tue, 27 Nov 2018 10:24:28 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:24:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 34/43] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
Message-ID: <20181127092428.z7p4mxnf3jxuqcv7@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ye4sybml6mlbbvnl"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ye4sybml6mlbbvnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:25:06AM +0100, Paul Kocialkowski wrote:
> This introduces stride and offset configuration for the VPU tiling mode.
> Stride is calculated differently than it is for linear formats and an
> offset is calculated, for which new register definitions are introduced.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  7 ++++
>  2 files changed, 58 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index efa1ff0802bd..3f76a5572449 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -125,21 +125,69 @@ void sun4i_frontend_update_buffer(struct sun4i_fron=
tend *frontend,
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	struct drm_framebuffer *fb =3D state->fb;
> +	unsigned int strides[3] =3D {};
> +
>  	dma_addr_t paddr;
>  	bool swap;
> =20
> +	if (fb->modifier =3D=3D DRM_FORMAT_MOD_ALLWINNER_TILED) {
> +		unsigned int width =3D state->src_w >> 16;
> +		unsigned int offset;
> +
> +		/*
> +		 * In MB32 tiled mode, the stride is defined as the distance
> +		 * between the start of the end line of the current tile and
> +		 * the start of the first line in the next vertical tile.
> +		 *
> +		 * Tiles are represented in row-major order, thus the end line
> +		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
> +		 * the next vertical tile starts at: 32-bit-aligned-width * 32
> +		 * and the distance is: 32 * (32-bit-aligned-width - 31).
> +		 */
> +
> +		strides[0] =3D (fb->pitches[0] - 31) * 32;
> +
> +		/* Offset of the bottom-right point in the end tile. */
> +		offset =3D (width + (32 - 1)) & (32 - 1);

Those computations are a bit obscure. I guess adding a bunch of
defines, and using the round_up / _down and ALIGN macros would help

> +		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
> +			     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +
> +		if (fb->format->num_planes > 1) {
> +			strides[1] =3D (fb->pitches[1] - 31) * 32;
> +
> +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
> +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +		}
> +
> +		if (fb->format->num_planes > 2) {
> +			strides[2] =3D (fb->pitches[2] - 31) * 32;
> +
> +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
> +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +		}

I guess we could fall in a situation where this is not cleared when
moving from a format with 3 planes to one with 2 for example. Would
that break anything?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ye4sybml6mlbbvnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0NTAAKCRDj7w1vZxhR
xcGdAQDivzXPr0I7Y577y/ngObZxAdo8ujal8s5ve4mRcQ6tegEA/2UwWHJOpsMl
fDAegr3MhUtJylM6OLT1IYP0Zv04dAw=
=e1Jw
-----END PGP SIGNATURE-----

--ye4sybml6mlbbvnl--
