Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeDWIQQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:16:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56558 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754045AbeDWIQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:16:11 -0400
Date: Mon, 23 Apr 2018 10:16:09 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/11] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180423081609.dirsitco3aeaqztx@flea>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
 <20180420211022.11759-7-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qoatix34pogn6m2"
Content-Disposition: inline
In-Reply-To: <20180420211022.11759-7-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qoatix34pogn6m2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:10:17PM +0200, Myl=E8ne Josserand wrote:
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
> index 5e9602ce1573..ddc439f6269b 100644
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
> +void __init sun8i_cntvoff_init(void)
> +{
> +#ifdef CONFIG_SMP
> +	secure_cntvoff_init();
> +#endif
> +}
> +
> +static const char * const sun8i_cntvoff_board_dt_compat[] =3D {
> +	"allwinner,sun8i-a83t",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i-a83t board")

This name still doesn't really make much sense. It's an A83t, that's
it.

Apart from the other minor comment I had, and once that name has been
fixed:
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7qoatix34pogn6m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdlkgACgkQ0rTAlCFN
r3RsNg/+IIHUgmXY1d9Txs9BLjRMCA5npo2bVo0roi54Xp/YirIfVf4NyeJrRuit
aT7e7Rjo0JH4KbvAP08eWxqueQfbDJG+uSqdfCG2rudc2QnwfH5vVJLi/ubcDQ8u
JrAZaYQOZ7d57rDdsHXu2UdItI7baoxbKpoaYTAqRca2xp9BL5m1igsPot9gBCo+
g3opiV5pRMp0MrRzWgxAfz6RocSVlqsHCCrmRy4ePRAfAv1hs7EgzUmoCYhrX0rN
XHR6cl/mzcZvsQHfnHgIGtBGQmZnLslqReWlXV3v3IDyrwA+huuvl/7ITNElMAb7
djPmqOQZCZaRtErZKWSOiOpjRwG0n0cQl9l/iZcn3HDZjTW1VRXEoOmnmW07iBki
25TUk61qHzaDetAvW1EUfpfKNB8HUnVYL3v4p9pL0rGPJ+Ys/peZHbe4mCMH+2t5
39VUdIY4S7lM01WGppz52BqA1hnSpPvSezN4XrFZ2MRKAPycv2jwiKVvGDYxpMCN
vQw5WywK5jmqwV/9iqfbAyYhZ4IThJYE8SVjKL2lzzxj2ZmIbSRjnzT+L5YppSvT
yqq/PMcS2Dy9F+Y20FblEkTrdSF4tC1WqAU+R9iEsNoxP51FC1DAoZ2pumcyZI0e
bkZTx0u7iW/Qlo+98akag3WsVhnIP+DYdlOiiP/kMRWpKfveeEA=
=Imj8
-----END PGP SIGNATURE-----

--7qoatix34pogn6m2--
