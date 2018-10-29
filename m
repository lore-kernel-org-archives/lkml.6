Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982A320851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982A320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeJ2SSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:18:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56303 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbeJ2SSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:18:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 213EE2097B; Mon, 29 Oct 2018 10:30:15 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id D8D1D20901;
        Mon, 29 Oct 2018 10:30:04 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:30:05 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 15/25] drm/sun4i: sun6i_mipi_dsi: Set proper vblk
 timing calculation
Message-ID: <20181029093005.6kg7pc5z63gi6lzb@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-16-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5odkxjnn5rkvxze"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-16-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5odkxjnn5rkvxze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:34PM +0530, Jagan Teki wrote:
> Unlike hblk, the vblk timings should follow an equation to compute
> the desired value for lane 4 devices and rest of devices it would be 0.
>=20
> BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> tmp =3D (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> dsi_vblk =3D (lane-tmp%lane);
>=20
> So, update the vblk timing calculation accordingly.
>=20
> Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
>=20
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 20e330186b7f..42bd7506abaf 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -511,8 +511,19 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi=
 *dsi,
>  	 * Allwinner BSP is using a rather convoluted calculation
>  	 * there only for 4 lanes. However, using 0 (the !4 lanes
>  	 * case) even with a 4 lanes screen seems to work...

Since you're adding the support for 2 lanes DSI displays, that should
be removed.

> +	 *
> +	 * The vertical blank is set using a blanking packet (4 bytes +
> +	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
>  	 */
> -	vblk =3D 0;
> +#define VBLK_PACKET_OVERHEAD	6
> +	if (device->lanes =3D=3D 4) {
> +		int tmp;
> +
> +		tmp =3D (mode->htotal * Bpp) * mode->vtotal - (hblk + VBLK_PACKET_OVER=
HEAD);
> +		vblk =3D(device->lanes - tmp % device->lanes);

This generates a checkpatch warning. You should run all your patches
through checkpatch before sending them.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b5odkxjnn5rkvxze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bTHQAKCRDj7w1vZxhR
xRWAAP9JWRTAm8RZAs7kJwQAWkqMXb0F/THZam8BAwbfcJLEcwD9Gfhyz4Y3DnUg
iyihVtXXwRnGsWxQDXFHDNia+lAgkAI=
=xbRn
-----END PGP SIGNATURE-----

--b5odkxjnn5rkvxze--
