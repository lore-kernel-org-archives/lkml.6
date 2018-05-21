Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeEUIN1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:13:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbeEUINY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:13:24 -0400
Date: Mon, 21 May 2018 10:12:53 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 12/15] drm/sun4i: Add support for second clock parent to
 DW HDMI PHY clk driver
Message-ID: <20180521081253.cmx2mvfbfybgmtlv@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-13-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5qhaxgfvy6rcsro3"
Content-Disposition: inline
In-Reply-To: <20180519183127.2718-13-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5qhaxgfvy6rcsro3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 08:31:24PM +0200, Jernej Skrabec wrote:
> Expand HDMI PHY clock driver to support second clock parent.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  6 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 29 ++++++-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++------
>  3 files changed, 98 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
> index 801a17222762..aadbe0a10b0c 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -98,7 +98,8 @@
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
> -#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
> +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
> +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
>  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
> @@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi=
);
>  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
>  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
> =20
> -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
> +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> +			 bool second_parent);
> =20
>  #endif /* _SUN8I_DW_HDMI_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
> index deba47ed69d8..7a911f0a3ae3 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *=
hdmi,
>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
>  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
> =20
> -	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
> +	/*
> +	 * NOTE: We have to be careful not to overwrite PHY parent
> +	 * clock selection bit and clock divider.
> +	 */
> +	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> +			   ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> +			   pll_cfg1_init);

It feels like it belongs in a separate patch.

>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
>  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
>  			   pll_cfg2_init);
> @@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi=
_phy *phy)
>  			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
>  			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
> =20
> +	/* reset PLL clock configuration */
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
> +

Ditto,

> +
> +		/*
> +		 * Even though HDMI PHY clock doesn't have enable/disable
> +		 * handlers, we have to enable it. Otherwise it could happen
> +		 * that parent PLL is not enabled by clock framework in a
> +		 * highly unlikely event when parent PLL is used solely for
> +		 * HDMI PHY clock.
> +		 */
> +		clk_prepare_enable(phy->clk_phy);

The implementation of the clock doesn't really matter in our API
usage. If we're using a clock, we have to call
clk_prepare_enable. That's documented everywhere, and mentionning how
the clock is implemented is an abstraction leakage and it's
irrelevant. I'd simply remove the comment here.

And it should be in a separate patch as well.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5qhaxgfvy6rcsro3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsCf4UACgkQ0rTAlCFN
r3TDRA//XTvxU6pRWK7ZWc69x00PC5asUxqZmAY2fR4fSrmZyHIsV+mlyK/I1c8C
cl/yvsRbuk5FAHdJQtJpsPjyT+wqUyy2LlX2bzj4cKR2Bignhh027eOtiko8onWe
HDCkgcLLIeqT1DhFTzpS5xoQ7C5WDvKdf2xXQ3RGTbg3xnRlChkfAnYtDqfrXWZ5
OTpEIJpWEBP7WJ50Xmri7utTbqy6ilxxURnr2p1XoSejb7K1/UwIXoMXzlLXOzUR
bbHr625wiqoKWB3q0ukPlrOLX8miF20B/0/1caRuGzUcCG3SEfzTY3kzbIF8bsro
YyAquTk+VczlKi4i1z1XwHgXscoNeOXiW+nXmMKTBn6mXdTks6yYQdcS+mtf7yWe
+YVau3E+eWy7VS0TSwY9t0OPFKl1b/Zaamr0ZKA1u6jeJmOTlVTVWjRLuLpIfyOC
JQ6vvrQqGm3xMSCNytZ4+s4nSxC6K+Al9RbCiHgTJps1q9LYp07RhoIgFF82nPnj
t91W4MbZHgc075PZTVf/3vg2R55NQnCGLWeH1fi/MtS9Ee4lLNQLydqyatjhMkt1
keS+Ww2aNoa0R+D08U9XcfXx3r+PtuxXUaE8Jlv1YgbUgcDc0yTiyUPrtxzLeWyd
Hb57WCJOE7JupKcwnShJHvLk4oeubb2QFsAKFGbCCf/bMWaDD4k=
=KxEv
-----END PGP SIGNATURE-----

--5qhaxgfvy6rcsro3--
