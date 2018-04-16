Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDPObp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:31:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56418 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeDPObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:31:42 -0400
Date: Mon, 16 Apr 2018 16:31:30 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow
 getting syscon regmap from device
Message-ID: <20180416143130.tls6xtcq3hsv7u7f@flea>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-4-icenowy@aosc.io>
 <20180412145628.iaaeue2imiijwx5d@flea>
 <A027702A-F3F7-4896-B2B8-E024DA521661@aosc.io>
 <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsodokbge3zfjolf"
Content-Disposition: inline
In-Reply-To: <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fsodokbge3zfjolf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 11:23:30PM +0800, Chen-Yu Tsai wrote:
> On Thu, Apr 12, 2018 at 11:11 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > =E4=BA=8E 2018=E5=B9=B44=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8810:56:28, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >>On Wed, Apr 11, 2018 at 10:16:39PM +0800, Icenowy Zheng wrote:
> >>> From: Chen-Yu Tsai <wens@csie.org>
> >>>
> >>> On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
> >>> address space; on the A64 SoC this register is in the SRAM controller
> >>> address space, and with a different offset.
> >>>
> >>> To access the register from another device and hide the internal
> >>> difference between the device, let it register a regmap named
> >>> "emac-clock". We can then get the device from the phandle, and
> >>> retrieve the regmap with dev_get_regmap(); in this situation the
> >>> regmap_field will be set up to access the only register in the
> >>regmap.
> >>>
> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>> [Icenowy: change to use regmaps with single register, change commit
> >>>  message]
> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >>> ---
> >>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 48
> >>++++++++++++++++++++++-
> >>>  1 file changed, 46 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>> index 1037f6c78bca..b61210c0d415 100644
> >>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>> @@ -85,6 +85,13 @@ const struct reg_field old_syscon_reg_field =3D {
> >>>      .msb =3D 31,
> >>>  };
> >>>
> >>> +/* Specially exported regmap which contains only EMAC register */
> >>> +const struct reg_field single_reg_field =3D {
> >>> +    .reg =3D 0,
> >>> +    .lsb =3D 0,
> >>> +    .msb =3D 31,
> >>> +};
> >>> +
> >>
> >>I'm not sure this would be wise. If we ever need some other register
> >>exported through the regmap, will have to change all the calling sites
> >>everywhere in the kernel, which will be a pain and will break
> >>bisectability.
> >
> > In this situation the register can be exported as another
> >  regmap. Currently the code will access a regmap with name
> > "emac-clock" for this register.
> >
> >>
> >>Chen-Yu's (or was it yours?) initial solution with a custom writeable
> >>hook only allowing a single register seemed like a better one.
> >
> > But I remember you mentioned that you want it to hide the
> > difference inside the device.
>=20
> The idea is that a device can export multiple regmaps. This one,
> the one named "gmac" (in my soon to come v2) or "emac-clock" here,
> is but one of many possible regmaps, and it only exports the register
> needed by the GMAC/EMAC.

I'm not sure this would be wise either. There's a single register map,
and as far as I know we don't have a binding to express this in the
DT. This means that the customer and provider would have to use the
same name, but without anything actually enforcing it aside from
"someone in the community knows it".

This is not a really good design, and I was actually preferring your
first option. We shouldn't rely on any undocumented rule. This will be
easy to break and hard to maintain.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fsodokbge3zfjolf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrUs8EACgkQ0rTAlCFN
r3TmKBAAhGCGS0TTlKTW7StN4+6CaJw5r6ydjVBrDS6IZeZI+cxFDn9HChUwjg6M
P2eh/O7L3QuOmqWy+OkcvM5sNI+ukBReVZTb+9WS572KfiHodgDpd1hp/olkHifb
9pH+hmmjb4thLzPlud0AWnApGIT80C7mj17OHdwIDpjzeiGkXc5oHUFF044BJQZ2
yPWEPZ77IETSbFn6OC5iP/Teb+KBFiyBNKmOJ5v5ZrI22eshGcSx9LGqjOR3Hj43
svSUyJfljJZ6oxwAK4EsgNVHS2Xd6xKTqRStrujE2XrkUF0ltl607SNJ4JTv8flU
KlXA+NJg2cdf1VyW4gErLgc/NeYJ83KV4dCgcmSAdO6WWyKy5KJfh+h3OoBEaSpd
hPCgy8Qi2fAuPyDd0fyxDoZHN6uwbE3ITmMyYMvEAz6/9aE6eAwwdlZ3uMBUDBJb
+zsI+gFEGbLB8uZg1xT9eO72lGpD+0cdYPu3aqGvmZs06+D9fEq8GFYH7zoUXrLm
81ncCwntiPoRNXP4psppjUhb9Z7GOzXpnu2Gptxtwu8XP8jX80pFo7vb1PmFe13q
FlIc33OvPB2I9EX3UEF2QjIJFCTGg7VxvltX4A77cWFqbeataMO0gn8mADyconga
x/QKZvakQg1yq1FA+eTtKOq8nC9689rC/9lFSVqYODjDMVDsqZU=
=3qhi
-----END PGP SIGNATURE-----

--fsodokbge3zfjolf--
