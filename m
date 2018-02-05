Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeBEOLZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbeBEOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:11:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11638217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 5 Feb 2018 14:11:11 +0000
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] MIPS: Generic: Support GIC in EIC mode
Message-ID: <20180205141110.GC8479@saruman>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <1515148270-9391-4-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <1515148270-9391-4-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 10:31:07AM +0000, Matt Redfearn wrote:
> The GIC supports running in External Interrupt Controller (EIC) mode,
> and will signal this via cpu_has_veic if enabled in hardware. Currently
> the generic kernel will panic if cpu_has_veic is set - but the GIC can
> legitimately set this flag if either configured to boot in EIC mode, or
> if the GIC driver enables this mode. Make the kernel not panic in this
> case, and instead just check if the GIC is present. If so, use it's CPU
> local interrupt routing functions. If an EIC is present, but it is not
> the GIC, then the kernel does not know how to get the VIRQ for the CPU
> local interrupts and should panic. Support for alternative EICs being
> present is needed here for the generic kernel to support them.
>=20
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Applied for 4.16,

Thanks
James

> ---
>=20
>  arch/mips/generic/irq.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
> index 394f8161e462..cb7fdaeef426 100644
> --- a/arch/mips/generic/irq.c
> +++ b/arch/mips/generic/irq.c
> @@ -22,10 +22,10 @@ int get_c0_fdc_int(void)
>  {
>  	int mips_cpu_fdc_irq;
> =20
> -	if (cpu_has_veic)
> -		panic("Unimplemented!");
> -	else if (mips_gic_present())
> +	if (mips_gic_present())
>  		mips_cpu_fdc_irq =3D gic_get_c0_fdc_int();
> +	else if (cpu_has_veic)
> +		panic("Unimplemented!");
>  	else if (cp0_fdc_irq >=3D 0)
>  		mips_cpu_fdc_irq =3D MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
>  	else
> @@ -38,10 +38,10 @@ int get_c0_perfcount_int(void)
>  {
>  	int mips_cpu_perf_irq;
> =20
> -	if (cpu_has_veic)
> -		panic("Unimplemented!");
> -	else if (mips_gic_present())
> +	if (mips_gic_present())
>  		mips_cpu_perf_irq =3D gic_get_c0_perfcount_int();
> +	else if (cpu_has_veic)
> +		panic("Unimplemented!");
>  	else if (cp0_perfcount_irq >=3D 0)
>  		mips_cpu_perf_irq =3D MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
>  	else
> @@ -54,10 +54,10 @@ unsigned int get_c0_compare_int(void)
>  {
>  	int mips_cpu_timer_irq;
> =20
> -	if (cpu_has_veic)
> -		panic("Unimplemented!");
> -	else if (mips_gic_present())
> +	if (mips_gic_present())
>  		mips_cpu_timer_irq =3D gic_get_c0_compare_int();
> +	else if (cpu_has_veic)
> +		panic("Unimplemented!");
>  	else
>  		mips_cpu_timer_irq =3D MIPS_CPU_IRQ_BASE + cp0_compare_irq;
> =20
> --=20
> 2.7.4
>=20
>=20

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp4Zf4ACgkQbAtpk944
dnpmqRAAgGyAzHlWAHXSmt3JsBdhMG6TDEiC45tPdIp9aoieDRduQYtyPnf4t094
XCZ1w0kOnTn7rEPYX5+sN776jf0vhZbBZRHwBqaqJ1IWl5uOIrFJ76FeVBsWMu4f
vGSG5HbsmB+3bN/qN9eRqHag87w/bacok3GYHZSh+IY5pVsrTJ94c9jNbwcstrMb
NAQwEN/mg+rUmxsqqWBs0HEvESpMQu2DEars03R77SoxiT/1uAcoUqzG9MtqxlgM
2DFq2LZyPcvV2/MN2MW33sggoft2qhJFWXVCgYXfstujBXCjQ/ejpBQz/mVoPJH6
4c9/ZHgjmlNozSQFYJihIiX/5wotkj0F9uPmL6sJkgNk09XjhYTuGFHEMPeM2wij
aa7wtvws+u9irEpmCG+HyayresjEf80LLYCsLtgv0QKLF6KT7w2Oyw2j2b/ryjzo
0zoXHDHoUm5AJGvRiEAaqvFgqQL8mW6DWQ+6YfHxaChnoucxBPsVvpF5WD4mWqMj
HuAMIGeQNbX7foxrG7jj/whxuAWxZA3UixYjReFYMZ585v0czTtOUumjbkUBN/2L
m1qryQ99U/uZrhl8G8aKrx5JTFFegkd7zOj1Y6oL2sXfSiISSKPP4BKU/t/vo4yn
tCoRSDaa4yt/rFxvgvtieTY1/Czj7OP5RWkGOJJiOBNCnqL+NNk=
=yjFj
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
