Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeERKBb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:01:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57035 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbeERKB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:01:28 -0400
Date: Fri, 18 May 2018 12:01:16 +0200
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
Subject: Re: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY
 clock parents
Message-ID: <20180518100116.4bf2qcffg7ekxa7u@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zoqlobbnga5srfsy"
Content-Disposition: inline
In-Reply-To: <20180518094536.17201-13-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zoqlobbnga5srfsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 03:15:22PM +0530, Jagan Teki wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Some SoCs with DW HDMI have multiple possible clock parents, like A64
> and R40.
>=20
> Expand HDMI PHY clock driver to support second clock parent.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
>=20
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  9 ++-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 33 ++++++++---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 89 ++++++++++++++++++++++--=
------
>  3 files changed, 96 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
> index 79154f0f674a..303189d6602c 100644
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
> @@ -146,7 +147,7 @@
>  struct sun8i_hdmi_phy;
> =20
>  struct sun8i_hdmi_phy_variant {
> -	bool has_phy_clk;
> +	int  phy_clk_num;
>  	void (*phy_init)(struct sun8i_hdmi_phy *phy);
>  	void (*phy_disable)(struct dw_hdmi *hdmi,
>  			    struct sun8i_hdmi_phy *phy);
> @@ -160,6 +161,7 @@ struct sun8i_hdmi_phy {
>  	struct clk			*clk_mod;
>  	struct clk			*clk_phy;
>  	struct clk			*clk_pll0;
> +	struct clk			*clk_pll1;
>  	unsigned int			rcal;
>  	struct regmap			*regs;
>  	struct reset_control		*rst_phy;
> @@ -188,6 +190,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi=
);
>  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
>  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
> =20
> -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
> +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> +			 int clk_num);
> =20
>  #endif /* _SUN8I_DW_HDMI_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
> index 5a52fc489a9d..0eadf087fc46 100644
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
> +			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> +			   pll_cfg1_init);
>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
>  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
>  			   pll_cfg2_init);
> @@ -232,7 +238,7 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi=
, void *data,
>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
>  			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
> =20
> -	if (phy->variant->has_phy_clk)
> +	if (phy->variant->phy_clk_num)
>  		clk_set_rate(phy->clk_phy, mode->crtc_clock * 1000);
> =20
>  	return phy->variant->phy_config(hdmi, phy, mode->crtc_clock * 1000);
> @@ -393,7 +399,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t=
_hdmi_phy =3D {
>  };
> =20
>  static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy =3D {
> -	.has_phy_clk =3D true,
> +	.phy_clk_num =3D 1,
>  	.phy_init =3D &sun8i_hdmi_phy_init_h3,
>  	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
>  	.phy_config =3D &sun8i_hdmi_phy_config_h3,
> @@ -464,7 +470,7 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, =
struct device_node *node)
>  		goto err_put_clk_bus;
>  	}
> =20
> -	if (phy->variant->has_phy_clk) {
> +	if (phy->variant->phy_clk_num) {
>  		phy->clk_pll0 =3D of_clk_get_by_name(node, "pll-0");
>  		if (IS_ERR(phy->clk_pll0)) {
>  			dev_err(dev, "Could not get pll-0 clock\n");
> @@ -472,7 +478,16 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,=
 struct device_node *node)
>  			goto err_put_clk_mod;
>  		}
> =20
> -		ret =3D sun8i_phy_clk_create(phy, dev);
> +		if (phy->variant->phy_clk_num) {
> +			phy->clk_pll1 =3D of_clk_get_by_name(node, "pll-1");
> +			if (IS_ERR(phy->clk_pll1)) {
> +				dev_err(dev, "Could not get pll-1 clock\n");
> +				ret =3D PTR_ERR(phy->clk_pll1);
> +				goto err_put_clk_mod;
> +			}
> +		}
> +

You have a bug here. If phy_clk_num =3D=3D 1, you'll still try to lookup
pll-1.

And this is a bit sloppy, since if phy_clk_num =3D=3D 3, you won't try to
lookup pll-2 either.

> +		ret =3D sun8i_phy_clk_create(phy, dev, phy->variant->phy_clk_num);
>  		if (ret) {
>  			dev_err(dev, "Couldn't create the PHY clock\n");
>  			goto err_put_clk_pll0;
> @@ -515,8 +530,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, =
struct device_node *node)
>  err_put_rst_phy:
>  	reset_control_put(phy->rst_phy);
>  err_put_clk_pll0:
> -	if (phy->variant->has_phy_clk)
> -		clk_put(phy->clk_pll0);
> +	clk_put(phy->clk_pll0);
> +	clk_put(phy->clk_pll1);
>  err_put_clk_mod:
>  	clk_put(phy->clk_mod);
>  err_put_clk_bus:
> @@ -536,8 +551,8 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
> =20
>  	reset_control_put(phy->rst_phy);
> =20
> -	if (phy->variant->has_phy_clk)
> -		clk_put(phy->clk_pll0);
> +	clk_put(phy->clk_pll0);
> +	clk_put(phy->clk_pll1);
>  	clk_put(phy->clk_mod);
>  	clk_put(phy->clk_bus);
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm=
/sun4i/sun8i_hdmi_phy_clk.c
> index faea449812f8..85b12fc96dbc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> @@ -22,29 +22,36 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw=
 *hw,
>  {
>  	unsigned long rate =3D req->rate;
>  	unsigned long best_rate =3D 0;
> -	struct clk_hw *parent;
> +	struct clk_hw *best_parent =3D NULL;
> +	struct clk_hw *parent =3D NULL;
>  	int best_div =3D 1;
> -	int i;
> +	int i, p;
> =20
> -	parent =3D clk_hw_get_parent(hw);
> -
> -	for (i =3D 1; i <=3D 16; i++) {
> -		unsigned long ideal =3D rate * i;
> -		unsigned long rounded;
> -
> -		rounded =3D clk_hw_round_rate(parent, ideal);
> -
> -		if (rounded =3D=3D ideal) {
> -			best_rate =3D rounded;
> -			best_div =3D i;
> -			break;
> -		}
> +	for (p =3D 0; p < clk_hw_get_num_parents(hw); p++) {
> +		parent =3D clk_hw_get_parent_by_index(hw, p);
> +		if (!parent)
> +			continue;
> =20
> -		if (!best_rate ||
> -		    abs(rate - rounded / i) <
> -		    abs(rate - best_rate / best_div)) {
> -			best_rate =3D rounded;
> -			best_div =3D i;
> +		for (i =3D 1; i <=3D 16; i++) {
> +			unsigned long ideal =3D rate * i;
> +			unsigned long rounded;
> +
> +			rounded =3D clk_hw_round_rate(parent, ideal);
> +
> +			if (rounded =3D=3D ideal) {
> +				best_rate =3D rounded;
> +				best_div =3D i;
> +				best_parent =3D parent;
> +				break;
> +			}
> +
> +			if (!best_rate ||
> +			    abs(rate - rounded / i) <
> +			    abs(rate - best_rate / best_div)) {
> +				best_rate =3D rounded;
> +				best_div =3D i;
> +				best_parent =3D parent;
> +			}
>  		}
>  	}
> =20
> @@ -95,22 +102,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw,=
 unsigned long rate,
>  	return 0;
>  }
> =20
> +static u8 sun8i_phy_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct sun8i_phy_clk *priv =3D hw_to_phy_clk(hw);
> +	u32 reg;
> +
> +	regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, &reg);
> +	reg =3D (reg & SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK) >>
> +	      SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT;
> +
> +	return reg;
> +}
> +
> +static int sun8i_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct sun8i_phy_clk *priv =3D hw_to_phy_clk(hw);
> +
> +	if (index > 1)
> +		return -EINVAL;
> +
> +	regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> +			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> +			   index << SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT);
> +
> +	return 0;
> +}
> +

The DT bindings changes and the clk changes should be part of separate
patches.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zoqlobbnga5srfsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+pGsACgkQ0rTAlCFN
r3Q1+A//fMLXXK+Z7g4qIZeTbsScpfq5bgUrIbnVvrBBPEXXiLa/BHxOr6/x2HIt
nEqDiTiyDKoImTloKn82k4bLyThBziJJIOLmTDME2zM+V/lOPZJloOwXudmdCo4i
eCqAAyFB2R/TfdweVOhGprXLxc2I+nxmHWiM90GOBh9U5ryuSbv/bquTBmpmoUL5
HktY+779Nlg+1xBk1v18Q6LVY16biHop17IvZrzs5SpNrfVBREjU585L3GQgmgEi
l89eFExm72JrKMBIqCDfYRxbgUKvbIZVmAGnA/iYY26169YxZ8JBIyk88+aKGNjx
nc361BXaZspsUjD+A3gBHWzAbQSS0GTIZmtH01S1B4Rkq/2/OQoK4dzuH2cDX/1n
/1Q9/Kat0Yn+Eno/UXC8Z8B9MoYX1pZUOZm/OUXMIyJPdjSQtoMa8b5qV9nXR+Te
e2DwRX9+YGA5w8SJuBqpL+U8mnEWGoynYr/MIEfnmwj9DY/SheVnWNZJgJSYJVCL
eb/vz7O4smUDw5PE7IPwwp3TIj/VauSTJBypeSc5aodR2s89X0/EiH0id4TLJ0Ad
v3t1da5iwRZ1w2z0neqrumxbTdjBXsbePhQeLcYATrOvPxwwtewCWWfUvLjH8ctc
JcU3eqllyX5g4T3x2AQpjuBgveoand683KNGmo1nDqLnsf2SoeY=
=h+jS
-----END PGP SIGNATURE-----

--zoqlobbnga5srfsy--
