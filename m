Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032997AbeBNQvm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032793AbeBNQvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:51:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F922177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Feb 2018 16:51:35 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] MIPS: mscc: Add initial support for Microsemi
 MIPS SoCs
Message-ID: <20180214165135.GC3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-5-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-5-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 11:12:36AM +0100, Alexandre Belloni wrote:
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..a9db028a0338 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -527,6 +527,30 @@ config MIPS_MALTA
>  	  This enables support for the MIPS Technologies Malta evaluation
>  	  board.
> =20
> +config MSCC_OCELOT
> +	bool "Microsemi Ocelot architecture"
> +	select BOOT_RAW
> +	select CEVT_R4K
> +	select CSRC_R4K
> +	select IRQ_MIPS_CPU
> +	select DMA_NONCOHERENT
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_BIG_ENDIAN
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SYS_HAS_EARLY_PRINTK
> +	select USE_GENERIC_EARLY_PRINTK_8250
> +	select MSCC_OCELOT_IRQ
> +	select PINCTRL
> +	select GPIOLIB
> +	select COMMON_CLK
> +	select USE_OF
> +	select BUILTIN_DTB
> +	select LIBFDT

Please sort alphanumerically.

> +	help
> +	  This enables support for the Microsemi Ocelot architecture.
> +	  It builds a generic DT-based kernel image.
> +
>  config MACH_PIC32
>  	bool "Microchip PIC32 Family"
>  	help

=2E..

> diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
> new file mode 100644
> index 000000000000..9ae874c8f136
> --- /dev/null
> +++ b/arch/mips/mscc/Platform
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#
> +# Microsemi MIPS SoC support
> +#
> +# License: Dual MIT/GPL
> +# Copyright (c) 2017 Microsemi Corporation
> +
> +#
> +# Microsemi Ocelot board(s)
> +#
> +platform-$(CONFIG_MSCC_OCELOT) +=3D mscc/

Please use tabs to align

> +load-$(CONFIG_MSCC_OCELOT)	 +=3D 0x80100000

Please drop the space after the tab.

> diff --git a/arch/mips/mscc/setup.c b/arch/mips/mscc/setup.c
> new file mode 100644
> index 000000000000..77803edd7bfd
> --- /dev/null
> +++ b/arch/mips/mscc/setup.c
> @@ -0,0 +1,106 @@

=2E..

> +
> +#include <asm/time.h>
> +#include <asm/idle.h>
> +#include <asm/prom.h>
> +#include <asm/reboot.h>

Please sort these includes alphanumerically if possible.

> +
> +static void __init ocelot_earlyprintk_init(void)
> +{
> +	void __iomem *uart_base;
> +
> +	uart_base =3D ioremap_nocache(0x70100000, 0x0f);

Maybe these hex literals (the address at least) can use #defines.

0xf is an odd size when the 2 below indicates 32-bit registers.


> +	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
> +}

=2E..

> +extern void (*late_time_init)(void);

This is already declared in linux/init.h which you include, so I think
you can drop it.

> +void __init device_tree_init(void)
> +{
> +	if (!initial_boot_params)
> +		return;

I think flatten_and_copy_device_tree() already checks this (with a
warning), so this could be dropped.

Cheers
James

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEaRYACgkQbAtpk944
dnoUmRAAmSAfy9w+IUOo/+i9DvxR2NNyykOd/IMT+Gu60Mv9MTWo0YsgFNfAYvMT
LSov9zXoF4z7cC0BmWU8OJ5ai7NjtO0fQyKuLswUlWWVL8Nh3ez9TjwX2VgrJ6+6
4bvHpoJwDx48P9TyVPpk36hm7WpDGpoCFsxDkNe7PT5FkKLWlVh0io/oFCRCmEdC
c7dihRSXx/wGTSqvPGMzoC3FQQ6xJrQ9SsvpBBf34zcx3w9ibFeC3uwwg3D5YIeJ
mSLvD53vdkfgmRaBaDH6k2c40kSHDQQOrXTa1d4tobUvOwebiCF5xLsn+pW6UL+J
bBFOPaoxOw0do42ph8gbHQ2Zr3PxldQpkU3TclMODWFFYNsAm4gCbJZEscf9z0kT
IpeQQakRGaTeHpD2Rf3zs10PK7ARFKJV06ZfB4Ca4yuck/AJXVViVyITGkz8TgjF
sDbnSe443g46EQu7xegrRykx1iRhcAQc+Kdwb1ynFQzTQrZQy+9M24RffFGgyYyo
ddCWjr8nogQCVpXhX3vsVJHZQ9uh+7aFlqOLokIovHhmkRizbDcG9mANTzyPFKAC
xmsIa6ijLi+cgWILwEhiN317p/pEepPDgqRltas7MDstHJK+PzRTr4rRtF30RyfB
pibSrIBEbhde8EqN5W0pTfsTx/FGmLeq0s1G+7vZc9v8Gw4mh7I=
=a6Jb
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
