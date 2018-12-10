Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5884920880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeLJMlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:41:03 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:34530 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLJMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:41:02 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 21A1172CC66;
        Mon, 10 Dec 2018 15:41:00 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 03C087CF1BD; Mon, 10 Dec 2018 15:40:59 +0300 (MSK)
Date:   Mon, 10 Dec 2018 15:40:59 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181210124059.GA11942@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> Hi Dmitry,
>=20
> On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > syscall_get_* functions are required to be implemented on all
> > architectures in order to extend the generic ptrace API with
> > PTRACE_GET_SYSCALL_INFO request.
> >
> > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > and syscall_get_arch.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >
> > Notes:
> >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> >         and syscall_get_return_value
> >     v1: added syscall_get_arch
>=20
> > --- /dev/null
> > +++ b/arch/m68k/include/asm/syscall.h
> > @@ -0,0 +1,39 @@
>=20
> > +static inline void
> > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > +                     unsigned int i, unsigned int n, unsigned long *ar=
gs)
> > +{
> > +       BUG_ON(i + n > 6);
>=20
> Does this have to crash the kernel?

This is what most of other architectures do, but we could choose
a softer approach, e.g. use WARN_ON_ONCE instead.

> Perhaps you can return an error code instead?

That would be problematic given the signature of this function
and the nature of the potential bug which would most likely be a usage erro=
r.


--=20
ldv

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDl7bAAoJEAVFT+BVnCUIJYcQAK3wZnINhuc6q3TJFYwoQYm6
2bZHUCCDHtHICSEMGotwoBwpehNNHVlnvjP56qKwZxB0zicMJpgcK1FVmCPP40Es
BQDTVGbxPz3vkhoE75z0uCrXGxbrij8Ya+ZpvZRsn4/p1R7uu0GeIPpyCGbT15FZ
OWZ8VMm0bDRlHtkzzZfB5kXtHAGwfbpMvlzah5Jdq1ZaMmk3coTF8ei2a8qJWPtJ
MIvEi8oZpu0hIOTUDF5O4PMlMFBrip5nNdvbiqsZntX6kWagSoGQPZ/BKZgNh+3k
s464M6jXbgM+w11djOGyzuODu2DdV8rhA/dtOhiFQPKtG445izLzHFONnCfz7Xwz
yyedSthRi8p1UR2PUxPuhIDGtk3iIh8JfdaWFqSixdMhnSCnPX0oZSqOXBe8uSSD
BPT0NgAO0fRW0O+ZXbgYKVrGbUcpITqZHF+ZBvEb2ubgik0itFs6+KHNNQapPl6n
TOKzijz+4NbK17CEYv42oGMBM5x2jnRxe5bpJo6kuliNWhEOcgbGZliVHCwE0JHT
d1U9J0BGoa1fEWcPfSVvCxjnDInX9BsZZ63zq6CCfpwBdUzrDZfdfcg3rBAkL4jV
koGahDrTnj6lBDPfYSgfwjzLiRkEvQlULlNTao360HrRGNhuhqInnLLoc78exvjg
IL844P1patjQ1+V2enOJ
=I9DZ
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
