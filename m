Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965453AbeEXIuh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:50:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44918 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965305AbeEXIud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:50:33 -0400
Date: Thu, 24 May 2018 10:50:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Message-ID: <20180524085021.qto6266adjvpj6ai@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-7-jernej.skrabec@siol.net>
 <20180521080759.rgviuva65ijcfm2e@flea>
 <218132669.UY7RKz0VPx@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="65zcbqojrokwvtdf"
Content-Disposition: inline
In-Reply-To: <218132669.UY7RKz0VPx@jernej-laptop>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65zcbqojrokwvtdf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 07:27:46PM +0200, Jernej =C5=A0krabec wrote:
> Hi,
>=20
> Dne ponedeljek, 21. maj 2018 ob 10:07:59 CEST je Maxime Ripard napisal(a):
> > On Sat, May 19, 2018 at 08:31:18PM +0200, Jernej Skrabec wrote:
> > > If SoC has TCON TOP unit, it has to be configured from TCON, since it
> > > has all information needed. Additionally, if it is TCON TV, it must a=
lso
> > > enable bus gate inside TCON TOP unit.
> >=20
> > Why?
>=20
> I'll explain my design decision below.
>=20
> >=20
> > > Add support for such TCONs.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >=20
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  8 ++++++++
> > >  2 files changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..e0c562ce1c22
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device =
*dev,
> > >=20
> > >  		dev_err(dev, "Couldn't get the TCON bus clock\n");
> > >  		return PTR_ERR(tcon->clk);
> > >  =09
> > >  	}
> > >=20
> > > +
> > > +	if (tcon->quirks->needs_tcon_top && tcon->quirks->has_channel_1) {
> > > +		tcon->top_clk =3D devm_clk_get(dev, "tcon-top");
> > > +		if (IS_ERR(tcon->top_clk)) {
> > > +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> > > +			return PTR_ERR(tcon->top_clk);
> > > +		}
> > > +		clk_prepare_enable(tcon->top_clk);
> > > +	}
> > > +
> > >=20
> > >  	clk_prepare_enable(tcon->clk);
> > >  =09
> > >  	if (tcon->quirks->has_channel_0) {
> > >=20
> > > @@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *=
dev,
> > >=20
> > >  static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
> > >  {
> > > =20
> > >  	clk_disable_unprepare(tcon->clk);
> > >=20
> > > +	clk_disable_unprepare(tcon->top_clk);
> > >=20
> > >  }
> > > =20
> > >  static int sun4i_tcon_init_irq(struct device *dev,
> > >=20
> > > @@ -980,6 +991,23 @@ static int sun4i_tcon_bind(struct device *dev, s=
truct
> > > device *master,>=20
> > >  	tcon->id =3D engine->id;
> > >  	tcon->quirks =3D of_device_get_match_data(dev);
> > >=20
> > > +	if (tcon->quirks->needs_tcon_top) {
> > > +		struct device_node *np;
> > > +
> > > +		np =3D of_parse_phandle(dev->of_node, "allwinner,tcon-top", 0);
> > > +		if (np) {
> > > +			struct platform_device *pdev;
> > > +
> > > +			pdev =3D of_find_device_by_node(np);
> > > +			if (pdev)
> > > +				tcon->tcon_top =3D platform_get_drvdata(pdev);
> > > +			of_node_put(np);
> > > +
> > > +			if (!tcon->tcon_top)
> > > +				return -EPROBE_DEFER;
> > > +		}
> > > +	}
> > > +
> >=20
> > I might have missed it, but I've not seen the bindings additions for
> > that property. This shouldn't really be done that way anyway, instead
> > of using a direct phandle, you should be using the of-graph, with the
> > TCON-top sitting where it belongs in the flow of data.
>=20
> Just to answer to the first question, it did describe it in "[PATCH 07/15=
] dt-
> bindings: display: sun4i-drm: Add R40 HDMI pipeline".
>=20
> As why I designed it that way - HW representation could be described that=
 way=20
> (ASCII art makes sense when fixed width font is used to view it):
>=20
>                             / LCD0/LVDS0
>                 / TCON-LCD0
>                 |           \ MIPI DSI
> mixer0          |
>        \        / TCON-LCD1 - LCD1/LVDS1
>         TCON-TOP
>        /        \ TCON-TV0 - TVE0/RGB
> mixer1          |          \
>                 |           TCON-TOP - HDMI
>                 |          /
>                 \ TCON-TV1 - TVE1/RGB
>=20
> This is a bit simplified, since there is also TVE-TOP, which is responsib=
le=20
> for sharing 4 DACs between both TVE encoders. You can have two TV outs (P=
AL/
> NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It even seems that=
 you=20
> can arbitrarly choose which DAC is responsible for which signal, so there=
 is a=20
> ton of possible end combinations, but I'm not 100% sure.
>=20
> Even though I wrote TCON-TOP twice, this is same unit in HW. R40 manual=
=20
> suggest more possibilities, although some of them seem wrong, like RGB fe=
eding=20
> from LCD TCON. That is confirmed to be wrong when checking BSP code.=20
>=20
> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0, TVE1 and LCD=
1 for=20
> pin muxing, although I'm not sure why is that needed at all, since accord=
ing=20
> to R40 datasheet, TVE0 and TVE1 pins are dedicated and not on PORT D and =
PORT=20
> H, respectively, as TCON-TOP documentation suggest. However, HSYNC and PS=
YNC=20
> lines might be shared between TVE (when it works in RGB mode) and LCD. Bu=
t=20
> that is just my guess since I'm not really familiar with RGB and LCD=20
> interfaces.
>=20
> I'm really not sure what would be the best representation in OF-graph. Ca=
n you=20
> suggest one?

Rob might disagree on this one, but I don't see anything wrong with
having loops in the graph. If the TCON-TOP can be both the input and
output of the TCONs, then so be it, and have it described that way in
the graph.

The code is already able to filter out nodes that have already been
added to the list of devices we need to wait for in the component
framework, so that should work as well.

And we'd need to describe TVE-TOP as well, even though we don't have a
driver for it yet. That will simplify the backward compatibility later
on.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--65zcbqojrokwvtdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsGfMwACgkQ0rTAlCFN
r3SCcA/8CrFi6idZRisCkZLb258tJDpQzRd1oo5Wy0aTxku/w2NmGTNK797oZzx+
qQyOwZRI1e0feU8XAeavxRXaNg/EOvpYc/Rm9tJjgscZ0o6ePjFqSVRuK6ETgsjt
WTdos3kTWqGaG3KCXb9P6iwxXEDzECEkK2b8zJ2B1UDWuSLHuplycAMSPFs2Jkxd
L0f4eGbEsjBxnFMKScijtVZqKXQ/WiBr/5BMHnhwQ9ptbaZHn3FdWHOOI86cWWCX
F2BaIfcPdvzBvX1kCEB5h6dUfwHG6dxTmMvGLYiISKh0u0vxU8oBGPJjyuamNxmF
9w3QxDQYw7HwKdtwvN78DZ6zB0g/9JbkFQfm9JJwoNT/dflIx2E4xT2zFz1niz25
Thwpl6EGjghldp0e8dC8XPiIjeqLTiAySH/kSjTkLjIFVMj4sSCc2JwrxKNHVQQz
r1pv6pr9oPefjJQXC1nQUrUAYYdy1kQSD298/Tj/dfhGkj5dDcbq441UtCAi/onf
iThVVZNy+Y/mNff4die55EomeIzM2ivTyKgu2ULLPSXphAaOTIyID73S3Ht3/3qt
N15GlEm34Lt/gcXIRY5XzRzBCXMHwiwKa4pt7ll7JFFVQ82pwJbl+q8o51QB0TD0
U5Th5Zh0r504/msIgfzk22XF/geGsitFgQNGeVZLYTRNBikkJps=
=oltc
-----END PGP SIGNATURE-----

--65zcbqojrokwvtdf--
