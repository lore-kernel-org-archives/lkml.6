Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0CE204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0CE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbeKVKdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:33:16 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:32848 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKVKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:33:16 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EC8BD72CC66;
        Thu, 22 Nov 2018 02:56:34 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id DBA607CD20A; Thu, 22 Nov 2018 02:56:34 +0300 (MSK)
Date:   Thu, 22 Nov 2018 02:56:34 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181121235634.GA14146@altlinux.org>
References: <20181121165806.07da7c98@akathisia>
 <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> Please cc linux-api@vger.kernel.org for future versions.
>=20
> On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> >
> > struct ptrace_syscall_info {
> >         __u8 op; /* 0 for entry, 1 for exit */
>=20
> Can you add proper defines, like:
>=20
> #define PTRACE_SYSCALL_ENTRY 0
> #define PTRACE_SYSCALL_EXIT 1
> #define PTRACE_SYSCALL_SECCOMP 2
>=20
> and make seccomp work from the start?  I'd rather we don't merge an
> implementation that doesn't work for seccomp and then have to rework
> it later.

What's the difference between PTRACE_EVENT_SECCOMP and syscall-entry-stop
with regards to PTRACE_GET_SYSCALL_INFO request?  At least they have the
same entry_info to return.

As long as implementation (ab)uses ptrace_message to tell one kind of stop
=66rom another, it can distinguish syscall-entry-stop and syscall-exit-stop
=66rom each other and from many other kinds of stops, but it cannot
distinguish PTRACE_EVENT_SECCOMP from e.g. PTRACE_EVENT_EXIT.

> >         __u8 __pad0[7];
> >         union {
> >                 struct {
> >                         __s32 nr;
>=20
> __u64 please.  Syscall numbers are, as a practical matter, 64 bits.
> Admittedly, the actual effects of setting the high bits are unclear,
> and seccomp has issues with it, but let's not perpetuate the problem.

I agree.  Although the implementation uses syscall_get_nr()
which returns int, this could potentially be fixed in the future.

> >                         __u32 arch;
> >                         __u64 instruction_pointer;
> >                         __u64 args[6];
> >                 } entry_info;
> >                 struct {
> >                         __s64 rval;
> >                         __u8 is_error;
> >                         __u8 __pad1[7];
> >                 } exit_info;
> >         };
> > };
>=20
> Should seccomp events use entry_info or should they just literally
> supply seccomp_data?

It certainly can use entry_info.
I'd prefer to avoid using in uapi/linux/ptrace.h those types
that are defined in uapi/linux/seccomp.h.


--=20
ldv

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb9fCyAAoJEAVFT+BVnCUIR/MQAJiLtswHGxTJiT5szLMr+w0i
xrJIC9YutOPbqmk6AJYwu9qnuZnQrrIxbR11pFBBoObd2FXDyio51mgZSG9X1jzl
gumMCzMp0dr5yLyXOtKQGXzu6V35Qii3Nm+WGcfKaoTrFG+TgKj9tv38c14WWKlP
BaU9m6tqzJP8ocSzyi4rsRHpSfz3VlQlhtEYq+CMwFh7eRwQCgrkWn4tsIkk74yM
WFZwOALee1MbkgYpfAd6vy/PbNKgzN2K0RZTb4QCMXEQDLl25Xe+jJxiYiC9Ds+R
ODKLyL+mC+dQRiX1zxW5FORefZo8aRes900ENC5uZNDvEpzKzJ6Vo0udzqvYb12D
9bz3MyaL9CYd/El+WyTT6Sg160G5OPCIz5c+NKYA3tpp1BKz0CNyoX8X3JcG4ppn
FOZDFFlzl7M8uftC8eGj7hlczo9SZzSaHyQXXy7E/StlVw1LJ5higIkCTvF5U88e
wPW1+gQqP/LvEh4JlcI6O0gtDQAgHrPMxN5oipvcYQecwsFnzeH7z8DNvhr+v6+3
XW0Wr16hGrhbEdmyKkobhYeXeMrgTymSo4zeub39eW3SIBE5sBPFlgUVteRifsky
qinwVKlsrfdCIVuftnQpjjU3VSPtAwooZZnRhgVJR99A9idK+R8KEHvM7S7XcpMu
G9ExcYaNb7MbUET5Q+a/
=c4dx
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
