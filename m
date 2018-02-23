Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeBWPMS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:12:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53370 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeBWPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:12:16 -0500
Date: Fri, 23 Feb 2018 16:12:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
Message-ID: <20180223151213.inrk7ghl6z3pbcol@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ulfzt5j6yrqtig2w"
Content-Disposition: inline
In-Reply-To: <20180223133742.26044-11-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulfzt5j6yrqtig2w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:37:42PM +0100, Myl=E8ne Josserand wrote:
> On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
>=20
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
>  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index d5c97e945e69..605896251927 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
>  	first: .word sunxi_mc_smp_first_comer - .
>  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> =20
> +ENTRY(sunxi_init_cntvoff)
> +	/*
> +	 * CNTVOFF has to be initialized either from non-secure Hypervisor
> +	 * mode or secure Monitor mode with SCR.NS=3D=3D1. If TrustZone is enab=
led
> +	 * then it should be handled by the secure code
> +	 */
> +	cps	#MON_MODE
> +	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
> +	orr	r0, r1, #1
> +	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
> +	instr_sync
> +	mov	r0, #0
> +	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF =3D 0 */
> +	instr_sync
> +	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
> +	instr_sync
> +	cps	#SVC_MODE
> +	ret	lr
> +ENDPROC(sunxi_init_cntvoff)
> +
>  #ifdef CONFIG_SMP
>  ENTRY(sunxi_boot)
>  	bl	sunxi_mc_smp_cluster_cache_enable
> +	bl	sunxi_init_cntvoff
>  	b	secondary_startup
>  ENDPROC(sunxi_boot)
> =20
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..4bb041492b54 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] =3D {
>  };
> =20
>  extern void __init sun6i_reset_init(void);
> +extern void sunxi_init_cntvoff(void);
> +
>  static void __init sun6i_timer_init(void)
>  {
> +	sunxi_init_cntvoff();
> +

This would deserve a comment explaining why this is needed in the
first place, and this is not correct. All the other SoCs listed in
that machine have their CNTVOFF setup correctly on CPU0, and since
Linux is booted in HYP, it's probably not even valid to do that.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ulfzt5j6yrqtig2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQL0wACgkQ0rTAlCFN
r3SspBAAi6rjoChO+AIbsyvs22zukl8PstofUuTy35osW5dX0s9aHc3XiZ8gUaRd
1IdxK8z7sn6aAnW4Y2DUMaLvE1/LhExRT/qKJMj0hPUYdU/h0NvabMhsMNkUH7XC
0FtcWWuEViSeJo60Ym92/9IFq1ueXYfDYJsBj3cr0B5AXzjwYIpz0FQdKnvcELG/
tYdtdnRLwvyM45BbEJLRGLxvxbIM6aCgTRHH0BY4bSCGe7fj7PP2Lub6Jb5QYT31
Oq3fyxkhb+WV+O+8+v2i6qLFdtz59jMyy3VUqVAZXIl4kH9wTFBnlZr3frJAkRj/
yQG0umjmUty4xSfv/qB5q91s5nqnAsqKaUuVLK+YK/kqYyHJ9RRaFwaIG960OoBr
J65D+MjWUlwpQqc18ttBcPFzSy6RLxU7kXnMoxjGF72vVE3E7QMjR8nXfUVGsSOV
aeuTuzueKe1tcBQtjAmPca+QOC8ZMZk2bWGndyOaXl0e1pfBoH3XYjd7pOrj1Pq8
SuUnCSZtGnftdysu+i42n9lR1PoEBCwINr601PIQFGoezRlCmrc2x5Ju3MF3QQu2
mPhc9onrwjFAgxWvLcgxyh5CxbPF8Y8IAUv31esv4aifq4eojZbLH3pW6V4Hl/DT
/nxB4M89ZjwzYxdD+ZVQUymkQk5TdyTYxL1BdnQVyFIcKlsc6/o=
=NQiv
-----END PGP SIGNATURE-----

--ulfzt5j6yrqtig2w--
