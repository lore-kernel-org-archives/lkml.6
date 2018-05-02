Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeEBLs7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:48:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47922 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeEBLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:48:56 -0400
Date: Wed, 2 May 2018 13:48:43 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 15/21] drm: sun4i: add support for HVCC regulator for DWC
 HDMI glue
Message-ID: <20180502114843.ou4qczp5eaigrdfo@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-16-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qato2boi6jl56g2"
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-16-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qato2boi6jl56g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 05:10:52PM +0530, Jagan Teki wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> Allwinner SoCs with DWC HDMI controller have a "HVCC" power pin for the
> HDMI part, and on some boards it's connected to a dedicated regulator
> rather than the main 3.3v.
>=20
> Add support for optional HVCC regulator. For boards that doesn't use a
> dedicated regulator to power it, the default dummy regulator is used.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 ++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
> index 9f40a44b456b..7c33faff7ad4 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -73,6 +73,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, stru=
ct device *master,
>  	if (encoder->possible_crtcs =3D=3D 0)
>  		return -EPROBE_DEFER;
> =20
> +	hdmi->vcc_hdmi =3D devm_regulator_get(dev, "hvcc");
> +	if (IS_ERR(hdmi->vcc_hdmi)) {
> +		dev_err(dev, "Could not get HDMI power supply\n");
> +		return PTR_ERR(hdmi->vcc_hdmi);
> +	}
> +

You're not making it optional here, unlike what your commit log
says. Not that I'm fine with both, but we need to be consistent :)

>  	hdmi->rst_ctrl =3D devm_reset_control_get(dev, "ctrl");
>  	if (IS_ERR(hdmi->rst_ctrl)) {
>  		dev_err(dev, "Could not get ctrl reset control\n");
> @@ -91,6 +97,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, stru=
ct device *master,
>  		return ret;
>  	}
> =20
> +	ret =3D regulator_enable(hdmi->vcc_hdmi);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable HDMI power supply\n");
> +		goto err_disable_vcc;
> +	}
> +
>  	ret =3D clk_prepare_enable(hdmi->clk_tmds);
>  	if (ret) {
>  		dev_err(dev, "Could not enable tmds clock\n");
> @@ -143,6 +155,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
>  	clk_disable_unprepare(hdmi->clk_tmds);
>  err_assert_ctrl_reset:
>  	reset_control_assert(hdmi->rst_ctrl);
> +err_disable_vcc:
> +	regulator_disable(hdmi->vcc_hdmi);


The err_disable_vcc label will disable the regulator, but if there's
an error in regulator_enable, it will disable it while it wasn't
enabled in the first place, which is not really something we want to
do.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2qato2boi6jl56g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrppZoACgkQ0rTAlCFN
r3SfbQ/9GCc6Fb0EnWhUiY1QiMTObhPJZBRTGIC0UDxaqHIdLq7+nTGi1+tni8le
uqvKkHrpsQ2qa2PFJlIBoKjZ3vpCBNipLu+H+pNjLFL+kKObSwl4Y0f+5Coc1fAb
0ghX6Pl4DDgKN11ZYMoV0M+gQYjbUaWQgrycIPS0mzVA/86WnHnl94Qy6Sr9LIEa
4rXnJtSMVPq5HlLZqs1eM5MA+hL52M/MzhLVg7EVQfin4XjitvdNHoMUbNK6IRzA
pkkoMIt+J7s61lr3jEyCUFQJnx9GxIvrRjtqZOCgrJsN17NpjT/ID8aeI1ahHJlo
hgUrxaHY/lAq3LFHUGzFeE9oUqYvYh5ezMwU0eGfilKH8Iyhpb2CZkT/BC3kIMw/
QP13gTkgX9Ke/2sGLVux9eX2ajDmAVUvYc2EjkuOKDKBKwg2bnB5ZYe7bFCCD9A5
R0pJg7tWWAdKgVUxb0isPPrVWAvaCV7dQWAHVADF3yXVlX1bQH6+MOdgkKSrv4sN
MsSLvHznqbIx1BACP8DmGvW7aaFSMe5w9JiaWZiQHLjsZnp60ph/KupkOyXrc9iO
KPwiBr3f4awlK+eo5HvRSclfwLiDS7rpiD9Y4aW2iPOBv0LzNAeHoRfccpfZYioj
j/AD5g7RGj1y/Nst3HhvfthUhaZ5iUG1Xs11tIHTyrnY7VJmf1Y=
=1tNl
-----END PGP SIGNATURE-----

--2qato2boi6jl56g2--
