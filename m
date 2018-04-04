Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeDDHpS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:45:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeDDHpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:45:16 -0400
Date: Wed, 4 Apr 2018 09:45:15 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180404074515.r6nbkpcyy6vfelbr@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-9-mylene.josserand@bootlin.com>
 <20180403091218.t6xuq6csjp4uyy5u@flea>
 <20180403220628.19c9acaf@dell-desktop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oka76lsnw6ugovnn"
Content-Disposition: inline
In-Reply-To: <20180403220628.19c9acaf@dell-desktop.home>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oka76lsnw6ugovnn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 10:06:28PM +0200, Myl=E8ne Josserand wrote:
> Hello,
>=20
> Thank you for the review.
>=20
> On Tue, 3 Apr 2018 11:12:18 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > On Tue, Apr 03, 2018 at 08:18:31AM +0200, Myl=E8ne Josserand wrote:
> > > Add the initialization of CNTVOFF for sun8i-a83t.
> > >=20
> > > For boot CPU, Create a new machine that handles this
> > > function's call in an "init_early" callback.
> > > For secondary CPUs, add this function into secondary_startup
> > > assembly entry.
> > >=20
> > > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> > > ---
> > >  arch/arm/mach-sunxi/headsmp.S |  1 +
> > >  arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
> > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/head=
smp.S
> > > index 79890fbe5613..b586b7cf803a 100644
> > > --- a/arch/arm/mach-sunxi/headsmp.S
> > > +++ b/arch/arm/mach-sunxi/headsmp.S
> > > @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> > > =20
> > >  ENTRY(sunxi_mc_smp_secondary_startup)
> > >  	bl	sunxi_mc_smp_cluster_cache_enable
> > > +	bl	smp_init_cntvoff
> > >  	b	secondary_startup
> > >  ENDPROC(sunxi_mc_smp_secondary_startup)
> > > =20
> > > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > > index 5e9602ce1573..090784108c0a 100644
> > > --- a/arch/arm/mach-sunxi/sunxi.c
> > > +++ b/arch/arm/mach-sunxi/sunxi.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/platform_device.h>
> > > =20
> > >  #include <asm/mach/arch.h>
> > > +#include <asm/smp_cntvoff.h>
> > > =20
> > >  static const char * const sunxi_board_dt_compat[] =3D {
> > >  	"allwinner,sun4i-a10",
> > > @@ -62,7 +63,6 @@ MACHINE_END
> > >  static const char * const sun8i_board_dt_compat[] =3D {
> > >  	"allwinner,sun8i-a23",
> > >  	"allwinner,sun8i-a33",
> > > -	"allwinner,sun8i-a83t",
> > >  	"allwinner,sun8i-h2-plus",
> > >  	"allwinner,sun8i-h3",
> > >  	"allwinner,sun8i-r40",
> > > @@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family=
")
> > >  	.dt_compat	=3D sun8i_board_dt_compat,
> > >  MACHINE_END
> > > =20
> > > +void __init sun8i_cntvoff_init(void)
> > > +{
> > > +	smp_init_cntvoff(); =20
> >=20
> > Can't this be moved to the SMP setup code?
>=20
> I tried to put it in the first lines of "sunxi_mc_smp_init" function
> but it did not work. I tried to find some callbacks to have an
> early "init" and I only found the "init_early"'s one. There is probably
> another way to handle that so do not hesitate to tell me any ideas.

It's hard to say without more context about why it doesn't work. Have
you checked the order between early_initcall, the timer initialization
function and init_early?

> > > +}
> > > +
> > > +static const char * const sun8i_cntvoff_board_dt_compat[] =3D {
> > > +	"allwinner,sun8i-a83t",
> > > +	NULL,
> > > +};
> > > +
> > > +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i boards needing c=
ntvoff") =20
> >=20
> > All of the SoCs need CNTVOFF, so that doesn't really make sense. Why
> > not just calling it for what it is: an A83t?
>=20
> Sure, I will update it.

Looking back at that code, I guess you want to change also the
smp_init_cntvoff function. It's not really related to SMP either.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--oka76lsnw6ugovnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEgooACgkQ0rTAlCFN
r3Rq+A//RAPf5bwK82NFgP/VFiRpC9mqJuh6gtx3jQGiRSS7wD0GUaWhjPVTp4CD
SujWxgVBKNcbJXThoMwfEmVOJaZAfcy+v+Oc5j0x5x2ARFSg/l3t3wVcocEsUZtP
vYYqotb5+nnLnSMLEnTCbvx2pM++FpsJbSoUjChDziU06nCd/r/nBGg3UfECV0AB
jWy2qdNNjctkdUXt2ZM0iZPcFmVBY4PcqUIqka7N+4WHc5YiVb8t9rrEn/NZLmat
SV1pgJsac8Q1rfgs9j3rlc9p+3rTwN9JgOZMT+3G6UAkPCBjH+vX60UBKVG/Rpab
VnwmIZ2GE4YvH+cC9/azd5wLzouIdE8QrivWUvpUb4BMYuepZGClRKZ+YwwgJNWs
+5HIIHMfi9aNKdSCILzwZHW5Fq3IjH/jGetJ7OOam7DVbiE24KzFgZk8eoBviIrj
qK71wNpCx1x4XY3x41I6P1/ivy6/D58xGy7B0aAqW3I3lcMVjy02CBem77u+dEGv
rPTQextWoNokosmkyoU1NVqZxFAxHNaNQXcUyS4E+P1KHHYDppVmnB4q/yWgAk22
5EIti+7UQCfy2gSIpQMU4UAMdxmGMdYhfz4fb1h+vv1+r0gnFu8yK9R6rh0INs4h
SB7107rn4is6arbfI4iGxdXbatrkSg/I59FxU+cRkcnKitB4/8U=
=B29i
-----END PGP SIGNATURE-----

--oka76lsnw6ugovnn--
