Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBWPJy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:09:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53162 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeBWPJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:09:51 -0500
Date: Fri, 23 Feb 2018 16:09:49 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 08/10] ARM: sunxi: smp: Move assembly code into a file
Message-ID: <20180223150949.ky4blpbc64tf44tt@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-9-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfhwlzw3mi3xnje6"
Content-Disposition: inline
In-Reply-To: <20180223133742.26044-9-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gfhwlzw3mi3xnje6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:37:40PM +0100, Myl=E8ne Josserand wrote:
> Move the assembly code for cluster cache enabling
> into an assembly file instead of having it directly in C code.
>=20
> Create a sunxi_boot entry that will perform a cluster cached
> enabling and called secondary_startup.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/Makefile  |  1 +
>  arch/arm/mach-sunxi/headsmp.S | 73 +++++++++++++++++++++++++++++++++++++=
++++
>  arch/arm/mach-sunxi/mc_smp.c  | 76 ++++---------------------------------=
------
>  3 files changed, 80 insertions(+), 70 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/headsmp.S
>=20
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 7de9cc286d53..d1a072b879ed 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -1,5 +1,6 @@
>  CFLAGS_mc_smp.o	+=3D -march=3Darmv7-a
> =20
>  obj-$(CONFIG_ARCH_SUNXI) +=3D sunxi.o
> +obj-$(CONFIG_ARCH_SUNXI) +=3D headsmp.o
>  obj-$(CONFIG_ARCH_SUNXI_MC_SMP) +=3D mc_smp.o
>  obj-$(CONFIG_SMP) +=3D platsmp.o
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> new file mode 100644
> index 000000000000..4f5957a6e188
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -0,0 +1,73 @@
> +/*
> + * SMP support for sunxi based systems with Cortex A7/A15
> + *
> + * Copyright (C) 2018 Bootlin

This is just a copy, and while you can claim that you are one of the
copyrights holder, you are not the sole one and the original author
should be there.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

You want to use SPDX there instead.

> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +ENTRY(sunxi_mc_smp_cluster_cache_enable)
> +	/*
> +	* Enable cluster-level coherency, in preparation for turning on the MMU.
> +	*
> +	* Also enable regional clock gating and L2 data latency settings for
> +	* Cortex-A15. These settings are from the vendor kernel.
> +	*/

The indentation is not correct there, the * should be aligned

> +	mrc	p15, 0, r1, c0, c0, 0
> +	movw	r2, #(0xff00fff0&0xffff)
> +	movt	r2, #(0xff00fff0>>16)

This used to be defines, we should keep them, and we should have
spaces around the operators as well.

> +	and	r1, r1, r2
> +	movw	r2, #(0x4100c0f0&0xffff)
> +	movt	r2, #(0x4100c0f0>>16)
> +	cmp	r1, r2
> +	bne	not_a15
> +
> +	/* The following is Cortex-A15 specific */
> +
> +	/* ACTLR2: Enable CPU regional clock gates */
> +	mrc p15, 1, r1, c15, c0, 4
> +	orr r1, r1, #(0x1<<31)
> +	mcr p15, 1, r1, c15, c0, 4
> +
> +	/* L2ACTLR */
> +	mrc p15, 1, r1, c15, c0, 0
> +	/* Enable L2, GIC, and Timer regional clock gates */
> +	orr r1, r1, #(0x1<<26)
> +	/* Disable clean/evict from being pushed to external */
> +	orr r1, r1, #(0x1<<3)
> +	mcr p15, 1, r1, c15, c0, 0
> +
> +	/* L2CTRL: L2 data RAM latency */
> +	mrc p15, 1, r1, c9, c0, 2
> +	bic r1, r1, #(0x7<<0)
> +	orr r1, r1, #(0x3<<0)
> +	mcr p15, 1, r1, c9, c0, 2
> +
> +	/* End of Cortex-A15 specific setup */
> +	not_a15:
> +
> +	/* Get value of sunxi_mc_smp_first_comer */
> +	adr	r1, first
> +	ldr	r0, [r1]
> +	ldr	r0, [r1, r0]
> +
> +	/* Skip cci_enable_port_for_self if not first comer */
> +	cmp	r0, #0
> +	bxeq	lr
> +	b	cci_enable_port_for_self
> +
> +	.align 2
> +	first: .word sunxi_mc_smp_first_comer - .
> +ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> +
> +#ifdef CONFIG_SMP

I guess that whole file should be compiled only if we have SMP
enabled.

> +ENTRY(sunxi_boot)
> +	bl	sunxi_mc_smp_cluster_cache_enable
> +	b	secondary_startup
> +ENDPROC(sunxi_boot)
> +#endif
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index f2c2cfca28cd..4e807cc11a0f 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -82,6 +82,9 @@ static void __iomem *prcm_base;
>  static void __iomem *sram_b_smp_base;
>  static bool is_sun9i;
> =20
> +extern void sunxi_boot(void);

Why did you change the name of that function? The older one made it
more obvious to tell what is going on.

> +extern void sunxi_cluster_cache_enable(void);

Is that used somewhere?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gfhwlzw3mi3xnje6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQLrwACgkQ0rTAlCFN
r3SXdg/+LWNbMXRJ+O5AVwLm6ab8rCOj97P4kvQ5zhhGXd/W2G+zqT4N+CoAA9Bt
JV/rSpiLHlvjWj+0SH5rWTYALZ2HsWxBmhUdlY/wEOS6xYoTLd5ozwFNcZDAgASZ
EbfhaQXXd4gqMRajPxMh4tJ8Un+uctFgZWiU8Y7hZ8t8IpA8eqPzKrGytiF9+Jvn
lX2aBkJ4/VfMt2eizbudl13xRCkbhO6TAkN9eSTP5v3fzJrUPNyDHhCvt0UeoTD8
H1qiK7CYpFx7cs0df5XwyWz9bnl6LRPF7RfIQoOh8NhbGJBz7Ysc/fO6zoSqPkgx
2+pFnZA36bn7/9TshsUOVbZV87kt7TW6k8IFDtPViMawCkQr8Pf84myAypWkrfcx
fZjD+pqpNEMSvKQi9LoM22IK/A6zwa4xVqP3wZzYNJJHNulkbl+09g9qN4M68aYd
G7EVbuW2MaJiL6jASZfJvRPTy5U4Q2N7bGFju5JvXyV6O+gntfP4uvlJJwxvOP7q
FYgPLiTHuFqFKEsUNyacjBJGejxHuK/MqMqhYGz5CCsZI9TQX383Q3ruPBlBjDMw
Wxjhoq40SMV41pEXNxJCCC6RiVaqE2V52WAUAtA8xFiWvsexbcAACJYilwT2xads
hjzAaeZ5XdXaQEmHlfFq3UO9kBmUntRfUsuJDoqfwvcB00IZ8DU=
=ZXm8
-----END PGP SIGNATURE-----

--gfhwlzw3mi3xnje6--
