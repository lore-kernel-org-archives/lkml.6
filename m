Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeDCJMW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:12:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41364 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753441AbeDCJMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:12:20 -0400
Date: Tue, 3 Apr 2018 11:12:18 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180403091218.t6xuq6csjp4uyy5u@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-9-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4m3zop5wrmxfi2tg"
Content-Disposition: inline
In-Reply-To: <20180403061836.3926-9-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4m3zop5wrmxfi2tg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 08:18:31AM +0200, Myl=E8ne Josserand wrote:
> Add the initialization of CNTVOFF for sun8i-a83t.
>=20
> For boot CPU, Create a new machine that handles this
> function's call in an "init_early" callback.
> For secondary CPUs, add this function into secondary_startup
> assembly entry.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S |  1 +
>  arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index 79890fbe5613..b586b7cf803a 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> =20
>  ENTRY(sunxi_mc_smp_secondary_startup)
>  	bl	sunxi_mc_smp_cluster_cache_enable
> +	bl	smp_init_cntvoff
>  	b	secondary_startup
>  ENDPROC(sunxi_mc_smp_secondary_startup)
> =20
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..090784108c0a 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <asm/mach/arch.h>
> +#include <asm/smp_cntvoff.h>
> =20
>  static const char * const sunxi_board_dt_compat[] =3D {
>  	"allwinner,sun4i-a10",
> @@ -62,7 +63,6 @@ MACHINE_END
>  static const char * const sun8i_board_dt_compat[] =3D {
>  	"allwinner,sun8i-a23",
>  	"allwinner,sun8i-a33",
> -	"allwinner,sun8i-a83t",
>  	"allwinner,sun8i-h2-plus",
>  	"allwinner,sun8i-h3",
>  	"allwinner,sun8i-r40",
> @@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
>  	.dt_compat	=3D sun8i_board_dt_compat,
>  MACHINE_END
> =20
> +void __init sun8i_cntvoff_init(void)
> +{
> +	smp_init_cntvoff();

Can't this be moved to the SMP setup code?

> +}
> +
> +static const char * const sun8i_cntvoff_board_dt_compat[] =3D {
> +	"allwinner,sun8i-a83t",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i boards needing cntvo=
ff")

All of the SoCs need CNTVOFF, so that doesn't really make sense. Why
not just calling it for what it is: an A83t?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4m3zop5wrmxfi2tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDRXEACgkQ0rTAlCFN
r3QFoA/9ENYIhzJJ4IrJXS0ndHyFQXwOquqJryc9vPyTtguGBoVDeuN+IuIdfsEP
ybg42BWa7uTa3arB7kmxaqijKX7m3E3ijYljedwBFLzLe4TzFtmzI214CKNPaTWu
uC1hY35SXgr8dTbFYPvhe9YXZHZTKaQ77Dhel7JegtwnnfmR8lHR9TBLnmnxNlaL
W1bsyc4A2E9zABwSS8Ahpg1oCQX+iIurK2H1YT0YAd/SzVNu5jfbk46UXbe7nWOP
QeWAfuKgU9v8Z+ilDDn1nDV6zgLu+czNkWyqOqWDE22F7ovZoUqnFAZSojOg6fnr
ZfzS4X0rsMO0etV+u44buAFX3+r7j5mNU39ZLJvaRf+D1Gy14nQS1DMeWAYXX/fO
zuiCQJfQ4k/q+RFLEeNr/J7ZMpv5XXIeCJhXWamcctFTSOPnXqnLjfSU0sY1ulg9
39opb9Zkso+Ncg9EOjWMF4PW/3wybdFJGmvIQTKOig8ytz1dzuV7hqknfTMFFW4A
JyMMVzLx7lKcWp467no+axkjWbSRrUU1CktPmMF/WUdjY7MOIVaw8LIru7X7rmcE
g+WJaNub0q1ck/XEnb6Zj20GbpFMHayKCjC/rN7D2ihYaFVtpebR+BleFvYpqdG4
PkzjYHEa+xJwCOeB2d0o2arAs16n9PFH6B2enigYu1UaVBH1Aek=
=NLuM
-----END PGP SIGNATURE-----

--4m3zop5wrmxfi2tg--
