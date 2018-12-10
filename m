Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48845C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDBB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDBB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeLJMxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:53:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50630 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:53:18 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1809472CC66;
        Mon, 10 Dec 2018 15:53:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 082A17CF1D0; Mon, 10 Dec 2018 15:53:15 +0300 (MSK)
Date:   Mon, 10 Dec 2018 15:53:15 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oleg@redhat.com, Andrew Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, esyr@redhat.com,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 19/25] xtensa: define syscall_get_* functions
Message-ID: <20181210125315.GB11942@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043041.GS6131@altlinux.org>
 <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 09, 2018 at 09:02:50PM -0800, Max Filippov wrote:
> Hello,
>=20
> On Sun, Dec 9, 2018 at 8:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > syscall_get_* functions are required to be implemented on all
> > architectures in order to extend the generic ptrace API with
> > PTRACE_GET_SYSCALL_INFO request.
> >
> > This adds all 5 syscall_get_* functions on xtensa as documented
> > in asm-generic/syscall.h: syscall_get_nr, syscall_get_arguments,
> > syscall_get_error, syscall_get_return_value, and syscall_get_arch.
>=20
> I have this set of functions plus syscall_set_arguments implemented
> for syscall tracing here:
>   https://github.com/jcmvbkbc/linux-xtensa/commit/0023f56298cc92ce47e61b1=
b5dd1038f7be4f826

Good, but we also need syscall_get_arch for PTRACE_GET_SYSCALL_INFO.

> How should we synchronize our changes?

No problem, I can revert to the previous edition of this patch
that just adds syscall_get_arch.
Alternatively, you can just take that couple of patches (v5 18/25
and v2 15/15) into your tree.

> > diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/as=
m/syscall.h
> > index 3673ff1f1bc5..d529c855a144 100644
> > --- a/arch/xtensa/include/asm/syscall.h
> > +++ b/arch/xtensa/include/asm/syscall.h
>=20
> [...]
>=20
> > +static inline void
> > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > +                     unsigned int i, unsigned int n, unsigned long *ar=
gs)
> > +{
> > +       switch (i) {
> > +       case 0:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[6];
> > +               /* fall through */
> > +       case 1:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[3];
> > +               /* fall through */
> > +       case 2:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[4];
> > +               /* fall through */
> > +       case 3:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[5];
> > +               /* fall through */
> > +       case 4:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[8];
> > +               /* fall through */
> > +       case 5:
> > +               if (!n--)
> > +                       break;
> > +               *args++ =3D regs->areg[9];
> > +               /* fall through */
> > +       case 6:
> > +               if (!n--)
> > +                       break;
> > +               /* fall through */
> > +       default:
> > +               BUG();
>=20
> A WARN should be enough.

This is what most of other architectures do in syscall_get_arguments,
but I agree that a WARN_ON_ONCE should be enough.


--=20
ldv

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDmG7AAoJEAVFT+BVnCUIhGIP/32iKpH8RLMA1WrbXALNOCuh
wcxCW0Mzb/aRijNYBqQyOhTeAwcBPWp/+aRgqLsFCRWU7iyDsyD1qUv2hFYemAi1
EqfeOV4DJZLAIlz2ROH8rdaKQQs6L3HPbWDxNsRAk5jgmN/r8nv4+6POW9UQRkOI
oFwdUq5YzP3X/tZsG6+rprhQZrGZOr5DHPgz/2C5k3o/TKJdjufbapP149Peaj0W
ctY4SreEn5uLTWidJ731ICJDD9qx2zTIOYfUXuMscgDbR4wKzzmIotDorw96txYM
JUlQAfNiAUNqbpUfXvlq55Lbz2/rYOaYEuysgSuVpoWmHk1FvE747gKGH8R66d+I
ou+oifi9d3B6GF7CidVuNRL62QA+Aa65kA5Wuc0Evmcr6oALd6csL3cnPZQbpnGn
ZVPtuRiBO1qVzhCKXJwP0/sTAFaklpI0/HCQmw2xR50QpB/RvACMGX70nLeOKPgb
CCw3eomqe4u+ZwrTMfPIjygWhZpbkU/9+5jCkr0LTajco4Wrv8mh4TTCQuSxzVah
UKaiwCPKOx9FQbwc9U8it7oOCdIgZhjobEva3H7EO/7s4zz5ZjMFuOV7na2rNsup
7xs/eCWSfg3E747YMgxAmLjg3/2hK8qX7No0YiOzniJasAeLuBnrEQD+UM4I8qVk
JTd5EE/RQ6VRdbbyJitp
=ILNw
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
