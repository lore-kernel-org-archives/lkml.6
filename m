Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE7C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E54F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E54F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeJ2STp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:19:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56512 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbeJ2STp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:19:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BD225208B0; Mon, 29 Oct 2018 10:31:52 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 874F020711;
        Mon, 29 Oct 2018 10:31:42 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:31:42 +0100
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
Subject: Re: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for
 VCC-DSI voltage regulator
Message-ID: <20181029093142.hgn4q6o7q32voutf@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-17-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c44lc6ofhu4n4dbs"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-17-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c44lc6ofhu4n4dbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:35PM +0530, Jagan Teki wrote:
> Some boards have VCC-DSI pin connected to voltage regulator which may
> not be turned on by default.
>=20
> Add support for such boards by adding voltage regulator handling code to
> MIPI DSI driver.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
>=20
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 42bd7506abaf..bc57343592e0 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, struct=
 device *master,
> =20
>  	dsi->drv =3D drv;
> =20
> +	ret =3D regulator_enable(dsi->regulator);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable regulator\n");
> +		return ret;
> +	}
> +

The regulator should be enabled only when the device is in use.

>  	drm_encoder_helper_add(&dsi->encoder,
>  			       &sun6i_dsi_enc_helper_funcs);
>  	ret =3D drm_encoder_init(drm,
> @@ -980,6 +986,7 @@ static int sun6i_dsi_bind(struct device *dev, struct =
device *master,
> =20
>  err_cleanup_connector:
>  	drm_encoder_cleanup(&dsi->encoder);
> +	regulator_disable(dsi->regulator);
>  	return ret;
>  }
> =20
> @@ -989,6 +996,7 @@ static void sun6i_dsi_unbind(struct device *dev, stru=
ct device *master,
>  	struct sun6i_dsi *dsi =3D dev_get_drvdata(dev);
> =20
>  	drm_panel_detach(dsi->panel);
> +	regulator_disable(dsi->regulator);
>  }
> =20
>  static const struct component_ops sun6i_dsi_ops =3D {
> @@ -1022,6 +1030,12 @@ static int sun6i_dsi_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(base);
>  	}
> =20
> +	dsi->regulator =3D devm_regulator_get(dev, "vcc-dsi");
> +	if (IS_ERR(dsi->regulator)) {
> +		dev_err(dev, "Couldn't get regulator\n");
> +		return PTR_ERR(dsi->regulator);
> +	}
> +

You haven't updated the DT bindings accordingly.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c44lc6ofhu4n4dbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bTfgAKCRDj7w1vZxhR
xafeAQC/hk+cR3NR/oeGrMutYm3CO/ddSYmfepkr5BAd0Qg4YAEAn8uF6TFtcbAX
akK7hkY59vjG9MdW7yEzdyHdpeNZjgU=
=z4E+
-----END PGP SIGNATURE-----

--c44lc6ofhu4n4dbs--
