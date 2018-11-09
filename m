Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514720818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B514720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeKJHNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:13:55 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56018 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJHNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:13:55 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7DE4F72CBF9;
        Sat, 10 Nov 2018 00:31:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 71F117CD1FF; Sat, 10 Nov 2018 00:31:28 +0300 (MSK)
Date:   Sat, 10 Nov 2018 00:31:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] riscv: define syscall_get_arch()
Message-ID: <20181109213128.GA1907@altlinux.org>
Mail-Followup-To: Palmer Dabbelt <palmer@sifive.com>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-riscv@lists.infradead.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <20181109031712.GL21511@altlinux.org>
 <mhng-2fa4cce8-2365-4f36-a07e-5f9ad61cfb88@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <mhng-2fa4cce8-2365-4f36-a07e-5f9ad61cfb88@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 10:45:54AM -0800, Palmer Dabbelt wrote:
> On Thu, 08 Nov 2018 19:17:13 PST (-0800), ldv@altlinux.org wrote:
> > syscall_get_arch() is required to be implemented on all architectures
> > that use tracehook_report_syscall_entry() in order to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/riscv/include/asm/syscall.h | 6 ++++++
> >  include/uapi/linux/audit.h       | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/=
syscall.h
> > index 8d25f8904c00..7e1e26ca7317 100644
> > --- a/arch/riscv/include/asm/syscall.h
> > +++ b/arch/riscv/include/asm/syscall.h
> > @@ -18,6 +18,7 @@
> >  #ifndef _ASM_RISCV_SYSCALL_H
> >  #define _ASM_RISCV_SYSCALL_H
> >
> > +#include <uapi/linux/audit.h>
> >  #include <linux/sched.h>
> >  #include <linux/err.h>
> >
> > @@ -99,4 +100,9 @@ static inline void syscall_set_arguments(struct task=
_struct *task,
> >  	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> >  }
> >
> > +static inline int syscall_get_arch(void)
> > +{
> > +	return AUDIT_ARCH_RISCV;
> > +}
> > +
> >  #endif	/* _ASM_RISCV_SYSCALL_H */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index c4c8b131af48..ad4105c602a1 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -405,6 +405,7 @@ enum {
> >  /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
> >  #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
> >  #define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_L=
E)
> > +#define AUDIT_ARCH_RISCV	(EM_RISCV|__AUDIT_ARCH_64BIT)
> >  #define AUDIT_ARCH_S390		(EM_S390)
> >  #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
> >  #define AUDIT_ARCH_SH		(EM_SH)
>=20
> I think this is incorrect: EM_RISCV has 32-bit and 64-bit variants, and i=
f I=20
> understand what's going on here this is marking all RISC-V targets as 64-=
bit. =20
> Since this is a userspace header, I think the right thing to switch on is=
=20
> __riscv_xlen, which will be defined to either 32 or 64 depending on the b=
ase=20
> ISA.
> We're also little endian.

OK, it means we need to introduce two different AUDIT_ARCH_ constants
for RISC-V.  Do you have any preferences for their names,
e.g. AUDIT_ARCH_RISCV and AUDIT_ARCH_RISCV64, or
AUDIT_ARCH_RISCV and AUDIT_ARCH_RISCV32, or
AUDIT_ARCH_RISCV64 and AUDIT_ARCH_RISCV32,
or anything else?


--=20
ldv

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb5fywAAoJEAVFT+BVnCUIr9oQAIvmhFu/M1spBsW47Mz/cNPM
ctjzYjvdEmyj5geJofM71utqHzvGI2mRX/Itd4wEzSXUDze6gFhMVjfS7cHr/icB
o6uMaj43skYZD5UvCvSW70bQAuStMbp5QldwGk5LhImsm+h3OJ2uwIPNtUEKBj40
oEVQ4eMtGmeawf7cPsKiW21NwgvDqkwCpcqWhyQydGVCXZ2B1jWUdKVRwAIrZXjN
TfaIT2t2GIeCyD8NGlYVpPVU5EtwxvXVPHzoe68qhUu7TrPGe18yoVjzOPXZDnqP
SGGzqDUlIxzMRL7wgsyHNnuWJHqu3/c+gHWOgGFxhzuTT7cukP7Mi4blML5p4x7b
R0HRegHeo4m7wiqnfrO19Kn4CmiX6x110O/waozrzO34CxPVIS7IhOlGEXZbCDsZ
pZLRWcjMJw+JUE1MRS3wysWP3ObG2MUCJkb6+PLQ4jTnbmHhq61gT0weNqqVsVPh
iPOKJJbgqP7fkkCnfksAtxyWXqdlqXl7OprGfa1N8allogWPs9N+sWdDKPDpX/oK
xQapRdY1Htf9E+UxBvrdOJRjHPFr66BJZBeT8lrRmEodmJ+MdIXhNdniWj4Dm5SF
in7blMkTLtuJphcZPOzzlkQ8KQBK/aoFaMjdMemaV5Sq0G0LdvVTv+r7bZxjyVlE
yQIco4ytuB+gRaGKt8aM
=5+xK
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
