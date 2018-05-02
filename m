Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEBNIs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:08:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50935 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBNIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:08:45 -0400
Date: Wed, 2 May 2018 15:08:42 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/12] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180502130842.pecjwahxrvx5addq@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-8-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qomsyjim3m7utmym"
Content-Disposition: inline
In-Reply-To: <20180501123131.7738-8-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qomsyjim3m7utmym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 02:31:26PM +0200, Myl=E8ne Josserand wrote:
> Add the initialization of CNTVOFF for sun8i-a83t.
>=20
> For boot CPU, create a new machine that handles this
> function's call in an "init_early" callback. We need to initialize
> CNTVOFF before the arch timer's initialization otherwise, it will
> not be taken into account and fails to boot correctly.
> Because of that, this function can't be called in SMP's early_initcall
> function which is called after timer's init.
>=20
> For secondary CPUs, add this function into secondary_startup
> assembly entry.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S |  1 +
>  arch/arm/mach-sunxi/sunxi.c   | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index 37dc772701f3..32d76be98541 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> =20
>  ENTRY(sunxi_mc_smp_secondary_startup)
>  	bl	sunxi_mc_smp_cluster_cache_enable
> +	bl	secure_cntvoff_init
>  	b	secondary_startup
>  ENDPROC(sunxi_mc_smp_secondary_startup)
> =20
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..2770a31a9278 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <asm/mach/arch.h>
> +#include <asm/secure_cntvoff.h>
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
> @@ -75,6 +75,24 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
>  	.dt_compat	=3D sun8i_board_dt_compat,
>  MACHINE_END
> =20
> +void __init sun8i_a83t_cntvoff_init(void)
> +{
> +#ifdef CONFIG_SMP
> +	secure_cntvoff_init();
> +#endif
> +}
> +
> +static const char * const sun8i_a83t_cntvoff_board_dt_compat[] =3D {
> +	"allwinner,sun8i-a83t",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i-a83t board")

I put my Acked-by on the condition that you would fix this. And you
still didn't.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--qomsyjim3m7utmym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpuFkACgkQ0rTAlCFN
r3TppA//Y3aBrB8/M8v7Uwy8P1GV1q7jpBYBddtAbbq6NfGAF4yDXuQ6bhy7Bq7U
Gz1+TQuGoCmksq+RwXXLo43X0BtL8iBtDXGA06kMQGZvEDk4BlU7QPhaLzskHDAG
pvZweyq0wAKzRzlPuZX5PsBsh8vKqR/vKZqPYpV3dGwx/oGd9wJel88So+A7HbCX
lSV0/wc31h57Zl+2Oe2ZusHBOgchs/AU/3bRA9pYgBSKKulyxwmYiEFb72xnnGnX
VBtbeW81MvZG4brKdtS4DeerP+oCfrsPdGIpgYp7prUYQ+PgHrUd/uWSuZdf04gL
KNdxXkPof9Eyak3jECKHbx2lgcH5Jfbodd+BVfJiaGqi7H2C0E8EtYVlz7ECIN2p
P7E5Otm94jEncBxNm4Ha/XSmy35IV8pUmWQRO1yHGWFKMEl+15fAP/F9NQXSenJ3
jLoUBCVGe58PLp2Uc5Ni4hXNT6oQJdCEIap9IdOooBTtiqqsOfA0/vMhkvAMSWBb
5hB+EvpVWPctdSVZBoUXpE3BeS1sPaEcow9Zz9PEEyMfTYL24FZ6UnHtA5z7+DNE
A9AaIKB6Vqt7MKWeoQz/HGPM3U1npAK5dlBZ9SBfL8hrY7WvHg30Kc232gsSLdCO
L5LYfTyBtNGsvzctqmDVCzuIzI4vXdfgeInjcFN7iNcze9A2cZo=
=5fSi
-----END PGP SIGNATURE-----

--qomsyjim3m7utmym--
