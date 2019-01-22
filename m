Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B06C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfAVJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:17:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56419 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfAVJR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:17:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1E1AE20898; Tue, 22 Jan 2019 10:17:27 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id E4E512078C;
        Tue, 22 Jan 2019 10:17:26 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:17:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Priit Laes <priit.laes@paf.com>
Subject: Re: [PATCH] drm/sun4i: hdmi: Fix usage of TMDS clock
Message-ID: <20190122091727.fksox7poqxvt5umu@flea>
References: <20190122073232.7240-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbdnwpdvvhkcqe7e"
Content-Disposition: inline
In-Reply-To: <20190122073232.7240-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbdnwpdvvhkcqe7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 09:32:32AM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
>=20
> Although TMDS clock is required for HDMI to properly function,
> nobody called clk_prepare_enable(). This fixes reference counting
> issues and makes sure clock is running when it needs to be running.
>=20
> Due to TDMS clock being parent clock for DDC clock, TDMS clock
> was turned on/off for each EDID probe, causing spurious failures
> for certain HDMI/DVI screens.
>=20
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
>=20
> Signed-off-by: Priit Laes <priit.laes@paf.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index 061d2e0d9011..25f4d676fd82 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -92,6 +92,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *enco=
der)
>  	val =3D readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>  	val &=3D ~SUN4I_HDMI_VID_CTRL_ENABLE;
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> +
> +	clk_disable_unprepare(hdmi->tmds_clk);
>  }
> =20
>  static void sun4i_hdmi_enable(struct drm_encoder *encoder)
> @@ -112,6 +114,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *enc=
oder)
>  		val |=3D SUN4I_HDMI_VID_CTRL_HDMI_MODE;
> =20
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> +
> +	clk_prepare_enable(hdmi->tmds_clk);

We'll probably need to enable that clock to send the infoframes as
well. I moved it earlier (and that allows the enable and disable
function to be symetric as well).

Thanks for figuring this out!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbdnwpdvvhkcqe7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEbfpwAKCRDj7w1vZxhR
xVD8AP4r8ZYtfTpNba2DWGmqkcY/4eSPc/nhzr/mi+rgHBBzxgD/bXaa18v4nZPA
1QuP3vO5DoJrfjiguCxTX+NGJJUvCw8=
=NJQt
-----END PGP SIGNATURE-----

--lbdnwpdvvhkcqe7e--
