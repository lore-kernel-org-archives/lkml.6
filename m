Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F515C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559BF21A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfBPWmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:42:11 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53988 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfBPWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 17:42:10 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3C20972CCAE;
        Sun, 17 Feb 2019 01:42:07 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 210B67CC774; Sun, 17 Feb 2019 01:42:07 +0300 (MSK)
Date:   Sun, 17 Feb 2019 01:42:07 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parisc: Fix ptrace syscall number modification
Message-ID: <20190216224207.GA25554@altlinux.org>
References: <20190216024623.GA11910@altlinux.org>
 <20190216131039.GA18767@altlinux.org>
 <c41a211b-6f61-b2a5-0613-32df52bfd367@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <c41a211b-6f61-b2a5-0613-32df52bfd367@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2019 at 05:55:24PM +0100, Helge Deller wrote:
> On 16.02.19 14:10, Dmitry V. Levin wrote:
> > Commit 910cd32e552e ("parisc: Fix and enable seccomp filter support")
> > introduced a regression in ptrace-based syscall tampering: when tracer
> > changes syscall number to -1, the kernel fails to initialize %r28 with
> > -ENOSYS and subsequently fails to return the error code of the failed
> > syscall to userspace.
> >=20
> > This erroneous behaviour could be observed with a simple strace syscall
> > fault injection command which is expected to print something like this:
> >=20
> > $ strace -a0 -ewrite -einject=3Dwrite:error=3Denospc echo hello
> > write(1, "hello\n", 6) =3D -1 ENOSPC (No space left on device) (INJECTE=
D)
> > write(2, "echo: ", 6) =3D -1 ENOSPC (No space left on device) (INJECTED)
> > write(2, "write error", 11) =3D -1 ENOSPC (No space left on device) (IN=
JECTED)
> > write(2, "\n", 1) =3D -1 ENOSPC (No space left on device) (INJECTED)
> > +++ exited with 1 +++
> >=20
> > After commit 910cd32e552ea09caa89cdbe328e468979b030dd it loops printing
> > something like this instead:
> >=20
> > write(1, "hello\n", 6../strace: Failed to tamper with process 12345: un=
expectedly got no error (return value 0, error 0)
> > ) =3D 0 (INJECTED)
> >=20
> > This bug was found by strace test suite.
> >=20
> > Fixes: 910cd32e552e ("parisc: Fix and enable seccomp filter support")
> > Cc: stable@vger.kernel.org # v4.5+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>=20
> Thanks, the patch works as expected.
> You may add:
> Tested-by: Helge Deller <deller@gmx.de>
>=20
> There is an "out" label a few lines below, which should be removed as wel=
l.
> Otherwise you get this warning:
> arch/parisc/kernel/ptrace.c: In function =E2=80=98do_syscall_trace_enter=
=E2=80=99:
> arch/parisc/kernel/ptrace.c:357:1: warning: label =E2=80=98out=E2=80=99 d=
efined but not used [-Wunused-label]
>=20
> I've fixed it up locally and added the patch to my for-next tree.
> If it's ok for you, I'll push it through the parisc tree.

It's fine with me, thanks!


--=20
ldv

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcaJG+AAoJEAVFT+BVnCUIBiwQAKlNzLu+SAaOZPS/ERJXcYco
nMhe9FEDkJSPE9gidi+5XtKIjIiph+oR3B422oKU8K78h135OeyyxklJaiETjyvj
hWjBW9NhSlumDk6IRkOISqk0icXiaHy+9Sn9BYkmdzrY0FD5VZH11OJLMihqhKRw
idC47k6lD6Xqq5tMzJynx7okDSx+p24H27zetuE48LepGDQM6gW/UqiAYdaJ7/Rt
kw1ba3MHY1v/qA4aOMs1h6bqdyjx2I5Ap7mGe/WaSRYZgTYRYYuFG/0kCl6tsBZY
HXs1zlHd0YCwuMfuhPr9Kv7os00Q5FXM9hkg/ecPccLqGYPemey6JMpChUyB2UUA
agEyi9p55U0UVHi4F5gsbuWc7vtwKC7UAqmrTry4KIAfFQPR2ryNbHL9b83wFg19
46PEtodUIpHDJO5G7UKZw0Ac1oR0oNudoYlRmSThBN5MvtEwxT2odMVNHaKaZz1l
XOVZyrCmP8aXn34JaWI9dbiMVMbvb572vKehT1jOJsBTRSfAGeSYv3L0HC00yW7Y
tHtCe8rHrtEGIKX+3tUztuLmXX7zjLQU9PNrIu+3bET8nI/XWG8Fd4x7dzFCMbfr
9fEpm466WCDcC5/7Cj/OSZXM2YHYiO0YudmiDShDhZgUrgc5396KNkYrPcQ4kAZp
k4XQ4QGh29dyGPEL6eUO
=oZ8o
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
