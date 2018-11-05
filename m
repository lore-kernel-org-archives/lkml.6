Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B66C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F0920819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeKESSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:18:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57208 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:18:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 80104207B0; Mon,  5 Nov 2018 09:59:37 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4E872206A1;
        Mon,  5 Nov 2018 09:59:27 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:59:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/7] drm/sun4i: tcon: Pass encoder instead of using
 panel for RGB setup
Message-ID: <20181105085927.tvg5vy3oyygw65z6@flea>
References: <20181101200045.6078-1-contact@paulk.fr>
 <20181101200045.6078-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uq6r4rci3segdv2m"
Content-Disposition: inline
In-Reply-To: <20181101200045.6078-2-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uq6r4rci3segdv2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2018 at 09:00:39PM +0100, Paul Kocialkowski wrote:
> Features such as dithering and pixel data edge configuration currently
> rely on the panel registered with the TCON driver. However, bridges are
> also supported in addition panels.
>=20
> Instead of retrieving the connector from the panel, pass the encoder
> from the calling function, as is done for other interfaces.
>=20
> The connector is then retrieved from the encoder with the dedicated
> helper. Even in the case of bridges, the connector is registered with
> the encoder from our driver and is accessible when iterating connectors.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index f949287d926c..262ffb6b0f82 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -478,8 +478,11 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_t=
con *tcon,
>  }
> =20
>  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> +				     const struct drm_encoder *encoder,
>  				     const struct drm_display_mode *mode)
>  {
> +	struct drm_connector *connector =3D sun4i_tcon_get_connector(encoder);
> +	struct drm_display_info display_info =3D connector->display_info;
>  	unsigned int bp, hsync, vsync;
>  	u8 clk_delay;
>  	u32 val =3D 0;
> @@ -491,8 +494,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tco=
n *tcon,
>  	sun4i_tcon0_mode_set_common(tcon, mode);
> =20
>  	/* Set dithering if needed */
> -	if (tcon->panel)
> -		sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
> +	sun4i_tcon0_mode_set_dithering(tcon, connector);
> =20
>  	/* Adjust clock delay */
>  	clk_delay =3D sun4i_tcon_get_clk_delay(mode, 0);
> @@ -556,17 +558,11 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_t=
con *tcon,
>  	 * Following code is a way to avoid quirks all around TCON
>  	 * and DOTCLOCK drivers.
>  	 */
> -	if (tcon->panel) {
> -		struct drm_panel *panel =3D tcon->panel;
> -		struct drm_connector *connector =3D panel->connector;
> -		struct drm_display_info display_info =3D connector->display_info;
> -
> -		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> -			clk_set_phase(tcon->dclk, 240);
> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> +		clk_set_phase(tcon->dclk, 240);
> =20
> -		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> -			clk_set_phase(tcon->dclk, 0);
> -	}
> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> +		clk_set_phase(tcon->dclk, 0);

You're doing multiple things here: you're changing the function API,
and then moving the display info checks outside of the tcon->panel
condition.

You should do two separate patches for that.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uq6r4rci3segdv2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AGbwAKCRDj7w1vZxhR
xTfPAP9AuTS4xuZD/oQ0LxkgVLv84/r1jr+R85CJsShxNcQrowD/YhDxft8w7Jre
9IEwuyC3xu9KfMTLSp04hjoRbBhPZg4=
=13tC
-----END PGP SIGNATURE-----

--uq6r4rci3segdv2m--
