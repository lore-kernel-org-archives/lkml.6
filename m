Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965135AbeEXI1Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43821 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964864AbeEXI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:27:13 -0400
Date: Thu, 24 May 2018 10:27:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: linux-sunxi@googlegroups.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 12/15] drm/sun4i: Add support for
 second clock parent to DW HDMI PHY clk driver
Message-ID: <20180524082701.q5lr6adjnjdseq6o@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-13-jernej.skrabec@siol.net>
 <20180521081253.cmx2mvfbfybgmtlv@flea>
 <4018914.loHx9iTxYh@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a3afohr5y5usfzsz"
Content-Disposition: inline
In-Reply-To: <4018914.loHx9iTxYh@jernej-laptop>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a3afohr5y5usfzsz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 05:02:23PM +0200, Jernej =C5=A0krabec wrote:
> Hi,
>=20
> Dne ponedeljek, 21. maj 2018 ob 10:12:53 CEST je Maxime Ripard napisal(a):
> > On Sat, May 19, 2018 at 08:31:24PM +0200, Jernej Skrabec wrote:
> > > Expand HDMI PHY clock driver to support second clock parent.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >=20
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  6 +-
> > >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 29 ++++++-
> > >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++----=
--
> > >  3 files changed, 98 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 801a17222762..aadbe0a10=
b0c
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > @@ -98,7 +98,8 @@
> > >=20
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
> > >=20
> > > -#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
> > > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
> > > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
> > >=20
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
> > >=20
> > > @@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi
> > > *hdmi);
> > >=20
> > >  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
> > >  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
> > >=20
> > > -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *=
dev);
> > > +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *=
dev,
> > > +			 bool second_parent);
> > >=20
> > >  #endif /* _SUN8I_DW_HDMI_H_ */
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index deba47ed69d8..7a911f0a=
3ae3
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > @@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hd=
mi
> > > *hdmi,>=20
> > >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
> > >  =09
> > >  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
> > >=20
> > > -	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
> > > +	/*
> > > +	 * NOTE: We have to be careful not to overwrite PHY parent
> > > +	 * clock selection bit and clock divider.
> > > +	 */
> > > +	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> > > +			   ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> > > +			   pll_cfg1_init);
> >=20
> > It feels like it belongs in a separate patch.
>=20
> Why? clk_set_rate() on HDMI PHY clock is called before this function, so=
=20
> SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL bit is already set to correct value. Ori=
ginal=20
> code doesn't take this into account and sets it to 0 here in all cases, w=
hich=20
> obviously is not right.
>=20
> If you insist on splitting this in new patch, it has to be applied before=
=20
> clock changes. It would also need to include "reset PLL clock configurati=
on"=20
> chunk (next change in this patch), otherwise other SoCs with only one par=
ent=20
> could get 1 there, which is obviously wrong. Note that I didn't really te=
sted=20
> if default value of this bit is 0 or 1, but I wouldn't really like to dep=
end=20
> on default values.

I don't have a strong feeling about this, but to me, the fact that you
don't want to overwrite the muxing bit because the clock might use it
is sensible in itself, disregarding the fact that the clock *will* use
it.

>=20
> >=20
> > >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
> > >  =09
> > >  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
> > >  			   pll_cfg2_init);
> > >=20
> > > @@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct
> > > sun8i_hdmi_phy *phy)>=20
> > >  			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
> > >  			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
> > >=20
> > > +	/* reset PLL clock configuration */
> > > +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
> > > +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
> > > +
> >=20
> > Ditto,
> >=20
> > > +
> > > +		/*
> > > +		 * Even though HDMI PHY clock doesn't have enable/disable
> > > +		 * handlers, we have to enable it. Otherwise it could happen
> > > +		 * that parent PLL is not enabled by clock framework in a
> > > +		 * highly unlikely event when parent PLL is used solely for
> > > +		 * HDMI PHY clock.
> > > +		 */
> > > +		clk_prepare_enable(phy->clk_phy);
> >=20
> > The implementation of the clock doesn't really matter in our API
> > usage. If we're using a clock, we have to call
> > clk_prepare_enable. That's documented everywhere, and mentionning how
> > the clock is implemented is an abstraction leakage and it's
> > irrelevant. I'd simply remove the comment here.
> >=20
> > And it should be in a separate patch as well.
>=20
> OK. Should I add Fixes tag, since current code obviously is not by the sp=
ecs?=20
> It could still get in 4.17...

Yep!

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--a3afohr5y5usfzsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsGdz4ACgkQ0rTAlCFN
r3RMUw//UYKkkVPdpNYcYjvpWBDixWbgpr3EA5kW6/Lyu41bWPNcdlvcXPggjV0F
7mQwpNTgGW0ftQpNrt00uMnYuVzKnnnr9ItsKtfmBojQW66aYmXGBU4EyFaZwpEh
9921X0MUimtMDph5/abfP+mVzjC+93QK9swAXQKAaNsxbGNCX/HO6GbJC0KhYsf1
hDeG6nPXzvl+seoh/PdKzp9vw3tC5YYmzbf1Qt5k1Cw1itIuSi9xDmERoIPVVznl
mggcCGtgASS8ORXyHyoNuEYTPxAl9et72KH6JfVcJIfM5gKN1EfUaWnKrzD6HHSl
Y7sr4Vt41rh7CxwPz8t6wqaAArM7g5nULyOOtw9zBljpIzVIt2pZFNARXpwBZxRN
zXSuT1/4h9X2RlpOtLbGxtCc6YevLMEOnllbw+ENBLNGrry3c7pNZcb1nqcQePw4
0DgFeS790cT4sl0GH7w4ChDs+TBHiciqqMwNQ7Rgr2jKLUNbAx3e9+PgxPLvkqna
QaFqEWtgnVw7KGPuwd1jO/VTJ1toAD5DAB5BFwuytrxE6R4iABAebGD0ykuC9z95
LxXiIUhej5dGG4681Bu2Et/p1hPJUxMTrrQP0odrsQc3087nFcn1sV3Y1Lqn8tBk
o8IGMxFyvOQR58nHFy5jPLZ49fMpIyUze6RZ80Nv3i14Rc7Qmxw=
=HC2i
-----END PGP SIGNATURE-----

--a3afohr5y5usfzsz--
