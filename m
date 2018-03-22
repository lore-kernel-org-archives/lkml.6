Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbeCVNn6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbeCVNnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:43:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B28F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Mar 2018 13:43:50 +0000
From: James Hogan <jhogan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Introduce has_cpu_mips*_user in cpu-features.h
Message-ID: <20180322134349.GH13126@saruman>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 10:53:03PM +0800, Jiaxun Yang wrote:
> Some processors support user mode instructions ISA level witch is

nit: s/witch/which/ here, below, and in the comment.

Otherwise it doesn't look unreasonable.

Cheers
James

> different with the ISA level it should be treated in kernel, such
> as Loongson 3A1000 3B1000 3A1500 3B1500 support all mips64r2 user
> mode instructions however, they should be treated as mips64r1 in
> kernel.
>=20
> So we introduce has_cpu_mips*_user to decide witch level should be
> displayed in cpuinfo to prevent misleading userspace programs.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/cpu-features.h | 39 ++++++++++++++++++++++++++++++=
++++++
>  arch/mips/kernel/proc.c              | 22 ++++++++++----------
>  2 files changed, 50 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm=
/cpu-features.h
> index 721b698bfe3c..0eff1956e229 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -251,6 +251,45 @@
>  # define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
>  #endif
> =20
> +/*
> + * For the CPU that has a user mode instructions ISA level witch is diff=
erent
> + * from the ISA level it should be treated in kernel, this ISA level will
> + * be displayed in cpuinfo as a reference for userspace programs.
> + */
> +#ifndef cpu_has_mips_1_user
> +# define cpu_has_mips_1_user		(cpu_has_mips_1)
> +#endif
> +#ifndef cpu_has_mips_2_user
> +# define cpu_has_mips_2_user		(cpu_has_mips_2)
> +#endif
> +#ifndef cpu_has_mips_3_user
> +# define cpu_has_mips_3_user		(cpu_has_mips_3)
> +#endif
> +#ifndef cpu_has_mips_4_user
> +# define cpu_has_mips_4_user		(cpu_has_mips_4)
> +#endif
> +#ifndef cpu_has_mips_5_user
> +# define cpu_has_mips_5_user		(cpu_has_mips_5)
> +#endif
> +#ifndef cpu_has_mips32r1_user
> +# define cpu_has_mips32r1_user	(cpu_has_mips32r1)
> +#endif
> +#ifndef cpu_has_mips32r2_user
> +# define cpu_has_mips32r2_user	(cpu_has_mips32r2)
> +#endif
> +#ifndef cpu_has_mips32r6_user
> +# define cpu_has_mips32r6_user	(cpu_has_mips32r6)
> +#endif
> +#ifndef cpu_has_mips64r1_user
> +# define cpu_has_mips64r1_user	(cpu_has_mips64r1)
> +#endif
> +#ifndef cpu_has_mips64r2_user
> +# define cpu_has_mips64r2_user	(cpu_has_mips64r2)
> +#endif
> +#ifndef cpu_has_mips64r6_user
> +# define cpu_has_mips64r6_user	(cpu_has_mips64r6)
> +#endif
> +
>  /*
>   * Shortcuts ...
>   */
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index b2de408a259e..65a9a695af3c 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -84,27 +84,27 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	}
> =20
>  	seq_printf(m, "isa\t\t\t:");=20
> -	if (cpu_has_mips_1)
> +	if (cpu_has_mips_1_user)
>  		seq_printf(m, " mips1");
> -	if (cpu_has_mips_2)
> +	if (cpu_has_mips_2_user)
>  		seq_printf(m, "%s", " mips2");
> -	if (cpu_has_mips_3)
> +	if (cpu_has_mips_3_user)
>  		seq_printf(m, "%s", " mips3");
> -	if (cpu_has_mips_4)
> +	if (cpu_has_mips_4_user)
>  		seq_printf(m, "%s", " mips4");
> -	if (cpu_has_mips_5)
> +	if (cpu_has_mips_5_user)
>  		seq_printf(m, "%s", " mips5");
> -	if (cpu_has_mips32r1)
> +	if (cpu_has_mips32r1_user)
>  		seq_printf(m, "%s", " mips32r1");
> -	if (cpu_has_mips32r2)
> +	if (cpu_has_mips32r2_user)
>  		seq_printf(m, "%s", " mips32r2");
> -	if (cpu_has_mips32r6)
> +	if (cpu_has_mips32r6_user)
>  		seq_printf(m, "%s", " mips32r6");
> -	if (cpu_has_mips64r1)
> +	if (cpu_has_mips64r1_user)
>  		seq_printf(m, "%s", " mips64r1");
> -	if (cpu_has_mips64r2)
> +	if (cpu_has_mips64r2_user)
>  		seq_printf(m, "%s", " mips64r2");
> -	if (cpu_has_mips64r6)
> +	if (cpu_has_mips64r6_user)
>  		seq_printf(m, "%s", " mips64r6");
>  	seq_printf(m, "\n");
> =20
> --=20
> 2.16.2
>=20

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqzsxUACgkQbAtpk944
dnqBRhAAubYgpNXw24biKwFQIzA/cyVOxzfSwUzxvkASpRHDKOMYlXN8/EMjKzI2
JGi+6HhFI30CVNc3KWR3laRFamrGjnwwOQdiObV4jbgjzKnS4sooH8CIUxWK03Sv
qY6R42ND4v+8v/xaKuGFAg+Pv01HWkPCV5py0Nw1PukWFWFp/PIKYq8GQV6Ew1UY
89XWZHpsjJHRIaj16PfLgfR8GLhdluzYEiOowqs0r3IWKywAPo21Rp14trv6Uz9x
PBo53r2tzzr2wgIp39SoSPLVzVi7kRnOo/icHNcAB2yPiFnBr2EGbHarkAkTf399
Sx9W/qDoF6k8kWttUKGToJD6reXBGMPOTkZ8UIhQpd4F55wcFzb29WX5O46ixD2f
3khUoAf3MugHzOmRL3vjqJh21R71GcQ3wAdMFaecULm7uX7sxP/3+gSPqZ6GFiRT
1E0E4PGDg1VNtn8fOBZXGSqy9WPMKOYvi7ZeoFViV7LIfxqeSO6q3ns6nuo4EcFm
3i+2eSWqQzL3jOlAmOrUQd8vgKeRfQrrLBi0TPoTlSoy9owA0NT8lEin+vGwDzcA
RpkofbhE86nLeaaenqSGyMCARMJBNF7pOopI1q3BQpuVnQJ+Ckhx94CUGmFDLQif
uTje1R64T54Egt9d/JwCODXPaSf+5K72wAHnKWyv0KJnS/DH1YE=
=/fgC
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
