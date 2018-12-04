Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79789C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D4A2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D4A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLDPeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:34:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38774 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbeLDPeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:34:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A46DE2071D; Tue,  4 Dec 2018 16:34:15 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5EC3D20701;
        Tue,  4 Dec 2018 16:34:05 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:34:05 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 12/21] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
Message-ID: <20181204153405.n5qvznkcrh7n3xej@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-13-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="idpip5xwsigx4kmw"
Content-Disposition: inline
In-Reply-To: <20181204142218.16284-13-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idpip5xwsigx4kmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:09PM +0100, Paul Kocialkowski wrote:
> This introduces stride and offset configuration for the VPU tiling mode.
> Stride is calculated differently than it is for linear formats and an
> offset is calculated, for which new register definitions are introduced.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 60 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  8 ++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 3dcb05147e41..151b78d3c02e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -125,21 +125,75 @@ void sun4i_frontend_update_buffer(struct sun4i_fron=
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

It'd be better if that comment was next to the macro definition where
the code is.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--idpip5xwsigx4kmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAaebQAKCRDj7w1vZxhR
xdVyAQDVOCk1gnFQ9fahKa2wpltM2OL7Uhyxyb6anXKqdxBUDAD+PDFjkVj+Tl4l
y/4+AA3NQBPX5VWUKBA4R8DAhLyWkAQ=
=nuNs
-----END PGP SIGNATURE-----

--idpip5xwsigx4kmw--
