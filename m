Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9320817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9320817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeKSSzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:55:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37238 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeKSSzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:55:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A8F6A20CFD; Mon, 19 Nov 2018 09:32:43 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 776612039F;
        Mon, 19 Nov 2018 09:32:43 +0100 (CET)
Date:   Mon, 19 Nov 2018 09:32:43 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 04/12] drm/sun4i: sun6i_mipi_dsi: Simplify drq set to
 support all modes
Message-ID: <20181119083243.4njj2p2sy2xf2zyf@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xic26kum5qm77vqt"
Content-Disposition: inline
In-Reply-To: <20181116163916.29621-5-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xic26kum5qm77vqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 10:09:08PM +0530, Jagan Teki wrote:
> Allwinner MIPI DSI DRQ set value can be varied with respective
> video modes.
> - burst mode the set value is always 0
> - video modes whose front porch greater than 20, the set value
>   can be computed based front porch and bpp.
> - video modes whose front porch is not greater than 20, the set value
>   is simply 0
>=20
> This patch simplifies existing drq set value code by grouping
> into sun6i_dsi_get_drq and support all video modes.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++----------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index efd08bfd0cb8..d60955880c43 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -363,6 +363,26 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *ds=
i,
>  		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
>  };
> =20
> +static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
> +			      struct drm_display_mode *mode)
> +{
> +	struct mipi_dsi_device *device =3D dsi->device;
> +	int drq =3D 0;

So, here, you declaring a variable called drq, set to 0.

> +	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +		return drq;

That you return here. You could just return 0, to be clearer.

> +	if ((mode->hsync_start - mode->hdisplay) > 20) {
> +		/* Maaaaaagic */
> +		u16 drq =3D (mode->hsync_start - mode->hdisplay) - 20;

You re-declare a variable with the same name here, but a different
type....

> +		drq *=3D mipi_dsi_pixel_format_to_bpp(device->format);
> +		drq /=3D 32;
> +	}
> +
> +	return drq;

And then return the first one? How is that even working?

> +
>  static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
>  				      struct drm_display_mode *mode, u16 hblk)
>  {
> @@ -478,21 +498,9 @@ static u16 sun6i_dsi_get_video_start_delay(struct su=
n6i_dsi *dsi,
>  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>  				  struct drm_display_mode *mode)
>  {
> -	struct mipi_dsi_device *device =3D dsi->device;
> -	u32 val =3D 0;
> -
> -	if ((mode->hsync_start - mode->hdisplay) > 20) {
> -		/* Maaaaaagic */
> -		u16 drq =3D (mode->hsync_start - mode->hdisplay) - 20;
> -
> -		drq *=3D mipi_dsi_pixel_format_to_bpp(device->format);
> -		drq /=3D 32;
> -
> -		val =3D (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> -		       SUN6I_DSI_TCON_DRQ_SET(drq));
> -	}
> -
> -	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> +	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
> +		     SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> +		     SUN6I_DSI_TCON_DRQ_SET(sun6i_dsi_get_drq(dsi, mode)));

On top of that, you now enable the DRQ stuff all the time, while it
was conditional before.

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xic26kum5qm77vqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/J1KwAKCRDj7w1vZxhR
xWZZAPwIptQE4vTx5lH3nECBMHT77qQdWrR5HLWWifK0PzUfswEA473gEJF8qMPR
aZD2c/c5xY4at4eU8jxNkiytdl/ENg4=
=dwiT
-----END PGP SIGNATURE-----

--xic26kum5qm77vqt--
