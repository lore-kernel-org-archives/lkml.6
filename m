Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADDC2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADDC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJZRmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:42:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37027 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:42:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9DB33808B1; Fri, 26 Oct 2018 11:05:42 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:05:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling
 when suspend cpu != resume cpu
Message-ID: <20181026090543.GC20200@amd>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20181022102026.40869-2-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-10-22 06:20:13, Sasha Levin wrote:
> From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>=20
> [ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]
>=20
> The resume code checks if the resume cpu is the same as the suspend cpu.
> If not, and if it is also not possible to switch to the suspend cpu, an
> error message should be printed and the resume process should be stopped
> by loading a disabled wait psw.
>=20
> The current logic is broken in multiple ways, the message is never printe=
d,
> and the disabled wait psw never loaded because the kernel panics before t=
hat:
> - sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will break
>   on the first 64bit instruction in sclp_early_printk().
> - The init stack should be used, but the stack pointer is not set up corr=
ectly
>   (missing aghi %r15,-STACK_FRAME_OVERHEAD).
> - __sclp_early_printk() checks the sclp_init_state. If it is not
>   sclp_init_state_uninitialized, it simply returns w/o printing anything.
>   In the resumed kernel however, sclp_init_state will never be uninitiali=
zed.

Stable patches should fix one bug, and one bug only.

									pavel
> ---
>  arch/s390/include/asm/sclp.h        |  3 ++-
>  arch/s390/kernel/early_printk.c     |  2 +-
>  arch/s390/kernel/swsusp.S           |  8 +++-----
>  drivers/s390/char/sclp_early_core.c | 11 ++++++++---
>  4 files changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index d3c1a8a2e3ad..d90a84770ce5 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -107,7 +107,8 @@ int sclp_early_get_core_info(struct sclp_core_info *i=
nfo);
>  void sclp_early_get_ipl_info(struct sclp_ipl_info *info);
>  void sclp_early_detect(void);
>  void sclp_early_printk(const char *s);
> -void __sclp_early_printk(const char *s, unsigned int len);
> +void sclp_early_printk_force(const char *s);
> +void __sclp_early_printk(const char *s, unsigned int len, unsigned int f=
orce);
> =20
>  int _sclp_get_core_info(struct sclp_core_info *info);
>  int sclp_core_configure(u8 core);
> diff --git a/arch/s390/kernel/early_printk.c b/arch/s390/kernel/early_pri=
ntk.c
> index 9431784d7796..40c1dfec944e 100644
> --- a/arch/s390/kernel/early_printk.c
> +++ b/arch/s390/kernel/early_printk.c
> @@ -10,7 +10,7 @@
> =20
>  static void sclp_early_write(struct console *con, const char *s, unsigne=
d int len)
>  {
> -	__sclp_early_printk(s, len);
> +	__sclp_early_printk(s, len, 0);
>  }
> =20
>  static struct console sclp_early_console =3D {
> diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
> index a049a7b9d6e8..c1a080b11ae9 100644
> --- a/arch/s390/kernel/swsusp.S
> +++ b/arch/s390/kernel/swsusp.S
> @@ -198,12 +198,10 @@ pgm_check_entry:
> =20
>  	/* Suspend CPU not available -> panic */
>  	larl	%r15,init_thread_union
> -	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
> +	aghi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
> +	aghi	%r15,-STACK_FRAME_OVERHEAD
>  	larl	%r2,.Lpanic_string
> -	lghi	%r1,0
> -	sam31
> -	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
> -	brasl	%r14,sclp_early_printk
> +	brasl	%r14,sclp_early_printk_force
>  	larl	%r3,.Ldisabled_wait_31
>  	lpsw	0(%r3)
>  4:
> diff --git a/drivers/s390/char/sclp_early_core.c b/drivers/s390/char/sclp=
_early_core.c
> index edeb2597b0b8..4daf797a6423 100644
> --- a/drivers/s390/char/sclp_early_core.c
> +++ b/drivers/s390/char/sclp_early_core.c
> @@ -188,11 +188,11 @@ static int sclp_early_setup(int disable, int *have_=
linemode, int *have_vt220)
>   * Output one or more lines of text on the SCLP console (VT220 and /
>   * or line-mode).
>   */
> -void __sclp_early_printk(const char *str, unsigned int len)
> +void __sclp_early_printk(const char *str, unsigned int len, unsigned int=
 force)
>  {
>  	int have_linemode, have_vt220;
> =20
> -	if (sclp_init_state !=3D sclp_init_state_uninitialized)
> +	if (!force && sclp_init_state !=3D sclp_init_state_uninitialized)
>  		return;
>  	if (sclp_early_setup(0, &have_linemode, &have_vt220) !=3D 0)
>  		return;
> @@ -205,5 +205,10 @@ void __sclp_early_printk(const char *str, unsigned i=
nt len)
> =20
>  void sclp_early_printk(const char *str)
>  {
> -	__sclp_early_printk(str, strlen(str));
> +	__sclp_early_printk(str, strlen(str), 0);
> +}
> +
> +void sclp_early_printk_force(const char *str)
> +{
> +	__sclp_early_printk(str, strlen(str), 1);
>  }

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS2OcACgkQMOfwapXb+vIZ0wCguIpVQeN2lRWaGkbVeIza//0/
je0AnjqVJ5PkubMO0vMvHHHwBIJA3Dpt
=l/ve
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
