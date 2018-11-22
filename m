Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C4F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C4F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406669AbeKWFzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:55:51 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33018 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeKWFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:55:51 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BD6F772CC61;
        Thu, 22 Nov 2018 22:15:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id AB9ED7CD20A; Thu, 22 Nov 2018 22:15:04 +0300 (MSK)
Date:   Thu, 22 Nov 2018 22:15:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181122191504.GB27204@altlinux.org>
References: <20181121165806.07da7c98@akathisia>
 <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org>
 <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 06:55:29AM -0800, Andy Lutomirski wrote:
> On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin wrote:
> > On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> > > Please cc linux-api@vger.kernel.org for future versions.
> > >
> > > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> > > >
> > > > struct ptrace_syscall_info {
> > > >         __u8 op; /* 0 for entry, 1 for exit */
> > >
> > > Can you add proper defines, like:
> > >
> > > #define PTRACE_SYSCALL_ENTRY 0
> > > #define PTRACE_SYSCALL_EXIT 1
> > > #define PTRACE_SYSCALL_SECCOMP 2
> > >
> > > and make seccomp work from the start?  I'd rather we don't merge an
> > > implementation that doesn't work for seccomp and then have to rework
> > > it later.
> >
> > What's the difference between PTRACE_EVENT_SECCOMP and syscall-entry-st=
op
> > with regards to PTRACE_GET_SYSCALL_INFO request?  At least they have the
> > same entry_info to return.
>=20
> I'm not sure there's any material difference.

In that case we don't really need PTRACE_SYSCALL_SECCOMP: op field
describes the structure inside the union to use, not the ptrace stop.

> > As long as implementation (ab)uses ptrace_message to tell one kind of s=
top
> > from another, it can distinguish syscall-entry-stop and syscall-exit-st=
op
> > from each other and from many other kinds of stops, but it cannot
> > distinguish PTRACE_EVENT_SECCOMP from e.g. PTRACE_EVENT_EXIT.
>=20
> Hmm.  PTRACE_GET_SYSCALL_INFO should fail for PTRACE_EVENT_EXIT, I think.

Unless we can change PTRACE_EVENT_SECCOMP to set some higher bits of
ptrace_message (beyond SECCOMP_RET_DATA) which is very unlikely because
it would qualify as an ABI change, this would require an additional field
in struct task_struct because ptrace_message wouldn't be enough
to distinguish PTRACE_EVENT_SECCOMP from PTRACE_EVENT_EXIT.


--=20
ldv

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb9wA4AAoJEAVFT+BVnCUIVLMP/icSrrhNzO/EyX/hEjQCpTbX
OIG34L3Q21JqPle06kSa08WKJ0xsCsOcnnpEqhEOkdgLiYr78im4j0bY+QZEpWRK
jNcGizVI7DCuELvY23SspHxSEHkPaTpZZT5YyYhH2q00Jzlq1z4rQsT3MngJt7KC
a3W7N/VqyhLASqXUAvxpwBfqzeGb/AoYpsEyON8Yr67MOTeLR3Sh5xY9+NMpMCQx
QWexSPWGcsysbY9P4Om2VUjQpdtX41emK9h202PoLyDz4EDOc7RzwoGXPyhD8BAX
RzUV+/7va5uvBvzCF8VXGtTbEQ7QJREjjE10T1tUlnbXTvC1pEq5oS0im8MQfITB
6xlBdFB5xCIMyNoY6yQLOb3ZZX27a9M02xrDam21t2OopB4Mvb9ul0T8azX792g1
fvTovioaCgE7ZYf+CN9caNhcJx4BKg2NXb/Y0T+nv2QRc053UgrJSYXnDM8+QIA8
gB4/KSV1wKJLsErmCtDuK6BoWfQSo2mY2CpgxilZKfOYw/EdtPzs7FgbiyEgnZ1Q
XpQou0maYn8MXPge1uxerBm4JvXsRm22MvbZe0UZCtmBesvhR2dsyAxpitnkVW6z
s+6myE2pFXIZGY2AlrcKa3ffA9GpYBkbMSEHih4moi27f4C5IPPk0nqtB1KiQXu/
qGGm+zLYM3ZbaeyA2qWp
=grzk
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
