Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E003DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2672081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2672081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeLDP3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:29:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38088 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDP3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:29:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 97B0320711; Tue,  4 Dec 2018 16:29:38 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 509E5206D8;
        Tue,  4 Dec 2018 16:29:28 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:29:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 06/21] drm/sun4i: frontend: Configure and enable YUV
 to RGB CSC when needed
Message-ID: <20181204152928.ola6ggxbatre54nd@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jx5x6yurcrnphq3c"
Content-Disposition: inline
In-Reply-To: <20181204142218.16284-7-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jx5x6yurcrnphq3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:03PM +0100, Paul Kocialkowski wrote:
> In prevision of adding support for YUV formats, set the YUV to RGB
> colorspace conversion coefficients if required and don't bypass the
> CSC engine when converting.
>=20
> The BT601 coefficients from the A33 BSP are copied over from the backend
> code. Because of module inter-dependency, we can't have the frontend use
> these coefficients from the backend directly.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 45 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index d0eca4b8784d..1737a4394401 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -48,6 +48,28 @@ static const u32 sun4i_frontend_horz_coef[64] =3D {
>  	0x03ff0000, 0x0000fd41, 0x01ff0000, 0x0000fe42,
>  };
> =20
> +/*
> + * These coefficients are taken from the A33 BSP from Allwinner.
> + *
> + * The first three values of each row are coded as 13-bit signed fixed-p=
oint
> + * numbers, with 10 bits for the fractional part. The fourth value is a
> + * constant coded as a 14-bit signed fixed-point number with 4 bits for =
the
> + * fractional part.
> + *
> + * The values in table order give the following colorspace translation:
> + * G =3D 1.164 * Y - 0.391 * U - 0.813 * V + 135
> + * R =3D 1.164 * Y + 1.596 * V - 222
> + * B =3D 1.164 * Y + 2.018 * U + 276
> + *
> + * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
> + * following the BT601 spec.
> + */
> +static const u32 sunxi_bt601_yuv2rgb_coef[12] =3D {
> +	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
> +	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
> +	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
> +};
> +

I'd really prefer not to duplicate that structure. IIRC, we already
have a dependency between the frontend and the backend (or the other
way around), maybe we should just move that structure to either so
that we don't have a circular dependency?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jx5x6yurcrnphq3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAadWAAKCRDj7w1vZxhR
xS9nAQD6l90xa8MmqOS2zOe6JbkarFaS3gzmacnmtgHCyUoq4AD/X2gxTruUk0Yd
NyOG3OHfNgQhfG/GiqLyDJMOVW+VvA8=
=1hp2
-----END PGP SIGNATURE-----

--jx5x6yurcrnphq3c--
