Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A67C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF92082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEF92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeKCHZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:25:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40877 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeKCHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:25:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 586108080A; Fri,  2 Nov 2018 23:16:49 +0100 (CET)
Date:   Fri, 2 Nov 2018 23:16:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] ARM: mmp/mmp2: use cpu_is_pj4() instead of cpu_is_mmp2()
Message-ID: <20181102221651.GE5322@amd>
References: <20180910121314.168636-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <20180910121314.168636-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-10 14:13:14, Lubomir Rintel wrote:
> The MMP2 platform uses the PJ4 CPU. The cpu_is_mmp2() macro is thus
> actually not useful at all and moreover gives the wrong result on
> MACH_MMP2_DT.
>=20
> The actual problem I aim to fix is that on a device-tree enabled system,
> the timer ends up being initialized incorrectly. In fact, it ticks like
> at rate that's 1/100 slower or so.
>=20
> Perhaps the other cpu_is_mmp2() uses are more benign, but still useless.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
> index 446edaeb78a7..405dbbbbbcdd 100644
> --- a/arch/arm/mach-mmp/cputype.h
> +++ b/arch/arm/mach-mmp/cputype.h
> @@ -44,13 +44,4 @@ static inline int cpu_is_pxa910(void)
>  #define cpu_is_pxa910()	(0)
>  #endif
> =20
> -#ifdef CONFIG_CPU_MMP2
> -static inline int cpu_is_mmp2(void)
> -{
> -	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58);
> -}
> -#else
> -#define cpu_is_mmp2()	(0)
> -#endif
> -
>  #endif /* __ASM_MACH_CPUTYPE_H */
> diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
> index afba5460cdaf..b670fafedeac 100644
> --- a/arch/arm/mach-mmp/mmp2.c
> +++ b/arch/arm/mach-mmp/mmp2.c
> @@ -104,7 +104,7 @@ void __init mmp2_init_irq(void)
> =20
>  static int __init mmp2_init(void)
>  {
> -	if (cpu_is_mmp2()) {
> +	if (cpu_is_pj4()) {
>  #ifdef CONFIG_CACHE_TAUROS2
>  		tauros2_init(0);
>  #endif
> diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
> index 17699be3bc3d..bcd5111ffb37 100644
> --- a/arch/arm/mach-mmp/pm-mmp2.c
> +++ b/arch/arm/mach-mmp/pm-mmp2.c
> @@ -220,7 +220,7 @@ static int __init mmp2_pm_init(void)
>  {
>  	uint32_t apcr;
> =20
> -	if (!cpu_is_mmp2())
> +	if (!cpu_is_pj4())
>  		return -EIO;
> =20
>  	suspend_set_ops(&mmp2_pm_ops);
> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 96ad1db0b04b..0f49ac579a17 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -163,7 +163,7 @@ static void __init timer_config(void)
> =20
>  	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
> =20
> -	ccr &=3D (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
> +	ccr &=3D (cpu_is_pj4()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
>  		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
>  	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvczNMACgkQMOfwapXb+vK5ugCfVe+pdda0TnaLL5fYCW3yA56f
ZcoAn1x19d7bzso0Dvw1p7uoTHh9d4X+
=I9Rk
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
