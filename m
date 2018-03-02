Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428512AbeCBOKu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425035AbeCBOKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:10:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAB6214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 2 Mar 2018 14:10:38 +0000
From: James Hogan <jhogan@kernel.org>
To: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: Re: [PATCH v8 2/4] MIPS: Octeon: Automatically provision CVMSEG
 space.
Message-ID: <20180302141037.GA4197@saruman>
References: <20180222230716.21442-1-david.daney@cavium.com>
 <20180222230716.21442-3-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180222230716.21442-3-david.daney@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 03:07:14PM -0800, David Daney wrote:
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kc=
onfig
> index b5eee1a57d6c..a283b73b7fc6 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -11,21 +11,26 @@ config CAVIUM_CN63XXP1
>  	  non-CN63XXP1 hardware, so it is recommended to select "n"
>  	  unless it is known the workarounds are needed.
> =20
> -config CAVIUM_OCTEON_CVMSEG_SIZE
> -	int "Number of L1 cache lines reserved for CVMSEG memory"

This is set to 2 in cavium_octeon_defconfig, which can now be removed (I
presume the default of 0 for CAVIUM_OCTEON_EXTRA_CVMSEG is sufficient).

> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h=
 b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c38b38ce5a3d..cdcca60978a2 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -26,11 +26,18 @@
>  	# a3 =3D address of boot descriptor block
>  	.set push
>  	.set arch=3Docteon
> +	mfc0	v1, CP0_PRID_REG
> +	andi	v1, 0xff00
> +	li	v0, 0x9500		# cn78XX or later
> +	subu	v1, v1, v0
> +	li	t2, 2 + CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG
> +	bltz	v1, 1f
> +	addiu	t2, 1			# t2 has cvmseg_size

It'd be nice to clean up this PRID code one day to use the defines in
<asm/mipsregs.h> and <asm/cpu.h>. This is consistent with whats already
here though so it can be done later.

> +1:
>  	# Read the cavium mem control register
>  	dmfc0	v0, CP0_CVMMEMCTL_REG
>  	# Clear the lower 6 bits, the CVMSEG size
> -	dins	v0, $0, 0, 6
> -	ori	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
> +	dins	v0, t2, 0, 6
>  	dmtc0	v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
>  	dmfc0	v0, CP0_CVMCTL_REG	# Read the cavium control register
>  	# Disable unaligned load/store support but leave HW fixup enabled
> @@ -70,7 +77,7 @@
>  	# Flush dcache after config change
>  	cache	9, 0($0)
>  	# Zero all of CVMSEG to make sure parity is correct
> -	dli	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
> +	move	v0, t2
>  	dsll	v0, 7
>  	beqz	v0, 2f
>  1:	dsubu	v0, 8
> @@ -126,12 +133,7 @@
>  	LONG_L	sp, (t0)
>  	# Set the SP global variable to zero so the master knows we've started
>  	LONG_S	zero, (t0)
> -#ifdef __OCTEON__
> -	syncw
> -	syncw
> -#else

Is this directly related? I don't think I saw it mentioned anywhere.

>  	sync
> -#endif
>  	# Jump to the normal Linux SMP entry point
>  	j   smp_bootstrap
>  	nop
> @@ -148,6 +150,8 @@
> =20
>  #endif /* CONFIG_SMP */
>  octeon_main_processor:
> +	dla	v0, octeon_cvmseg_lines
> +	sw	t2, 0(v0)

You would get something equivalent (and slightly more efficient but
using $at) with this?
	sw	t2, octeon_cvmseg_lines

I.e.
lui     v0,0x8190	->	lui     at,0x8190
daddiu  v0,v0,-19688	->
sw      t2,0(v0)	->	sw      t2,-19688(at)

> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index 858752dac337..4e87e4f5247a 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1126,6 +1126,8 @@
>  #define FPU_CSR_RD	0x3	/* towards -Infinity */
> =20
> =20
> +#define CAVIUM_OCTEON_SCRATCH_OFFSET (2 * 128 - 16 - 32768)

This feels a bit out of place, since its effectively cavium specific
memory mapped scratch register addresses. Would tlbex.h or octeon.h be
more appropriate, or even tlbex.c if it isn't used elsewhere?

Otherwise this patch looks reasonable I think.

Cheers
James

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZW1gACgkQbAtpk944
dnpvTg//WBhphxnkeqOQpZyQlOvLfalZZn8QdWxoUFb1UqebUIDk0iSlnoHjBiPC
qHSCMj4UqRvwBeGkDwGUP5wmxMFnnhmNBPTxWKF4PIzBJ6tkj/6M434FjSLOVtKR
CMfiw7Gvd0ajXEHzGjvBRSYm45Q6wR5bkXeRMvEERHF72ion3i7Ki8GWwmkSJHuP
FoNqOk1znc/2BcfrKnAKTvQUWKVxLGRATLuTXYul3SMc2ZQ0IUn5+ttdaJw/06zj
16lLEjOS9r6WHHNM3gmA0ipJvR3LMsMVrgwEvMWHipHS/zeMpdj1T6dMx9PCfM0S
3T7Y5C2wKNSLP/xDGYxI73yI2E0vNla4yKTAx76tfwRjfzaq4j1oeNsrUeqmOgZQ
t7+9Y8C7sCUQzOTGZSiQowJeVrPkYQtQSXj+l83+7W3BgpE6RT0wWyZ38Fss/gk4
GJg2LeaIZeorFZFyh05CVM6dxT58H0STF7oZGER4NHiyHKpjGX9da5I2zDEWUXEM
qS7Sv5b7NeQS3o3OzoaRccmJoOdy47MaNtW0Vo33YDTOF3GDKQviaEELq7nmsw9K
75HALidbvqMVJW7l9QKimYqNcJb3PjHcnmYVmvl68P6t+gCKY9bCjkxZn9dyltye
uLkeOjpPAlF96gIYAfKCLXDrTpv+chv4gHEDIaWClDd8HYF1ljY=
=RGsd
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
