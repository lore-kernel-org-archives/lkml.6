Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C638AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945D520863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeK2JOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:14:34 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50018 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeK2JOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:14:34 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0741572CC59;
        Thu, 29 Nov 2018 01:11:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id CF09A7CD0D7; Thu, 29 Nov 2018 01:11:25 +0300 (MSK)
Date:   Thu, 29 Nov 2018 01:11:25 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181128221125.GA2800@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20181128152346.GG28206@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 06:23:46PM +0300, Dmitry V. Levin wrote:
> On Wed, Nov 28, 2018 at 03:20:06PM +0100, Oleg Nesterov wrote:
> > On 11/28, Dmitry V. Levin wrote:
> > > On Wed, Nov 28, 2018 at 02:49:14PM +0100, Oleg Nesterov wrote:
> > > > On 11/28, Dmitry V. Levin wrote:
> > > > >
> > > > > +/*
> > > > > + * These values are stored in task->ptrace_message by tracehook_=
report_syscall_*
> > > > > + * to describe current syscall-stop.
> > > > > + *
> > > > > + * Values for these constants are chosen so that they do not app=
ear
> > > > > + * in task->ptrace_message by other means.
> > > > > + */
> > > > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> > > > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U
> > > >=20
> > > > Again, I do not really understand the comment... Why should we care=
 about
> > > > "do not appear in task->ptrace_message by other means" ?
> > > >=20
> > > > 2/2 should detect ptrace_report_syscall() case correctly, so we can=
 use any
> > > > numbers, say, 1 and 2?
> > > >=20
> > > > If debugger does PTRACE_GETEVENTMSG it should know how to interpet =
the value
> > > > anyway after wait(status).
> > >=20
> > > Given that without this patch the value returned by PTRACE_GETEVENTMSG
> > > during syscall stop is undefined, we need two different ptrace_message
> > > values that cannot be set by other ptrace events to enable reliable
> > > identification of syscall-enter-stop and syscall-exit-stop in userspa=
ce:
> > > if we make PTRACE_GETEVENTMSG return 0 or any other value routinely s=
et by
> > > other ptrace events, it would be hard for userspace to find out wheth=
er
> > > the kernel implements new semantics or not.
> >=20
> > Hmm, why? Debugger can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL), i=
f it
> > returns EIO then it is not implemented?
>=20
> The debugger that uses PTRACE_GET_SYSCALL_INFO does not need to call
> PTRACE_GETEVENTMSG for syscall stops.
> My concern here is the PTRACE_GETEVENTMSG interface itself.  If we use
> ptrace_message to implement PTRACE_GET_SYSCALL_INFO and expose
> PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} for regular PTRACE_GETEVENTMSG users,
> it should have clear semantics.

Since our implementation of PTRACE_GET_SYSCALL_INFO uses ptrace_message
to distinguish syscall-enter-stop from syscall-exit-stop, we could choose
one of the following approaches:

1. Do not document the values saved into ptrace_message during syscall
stops (and exposed via PTRACE_GETEVENTMSG) as a part of ptrace API,
leaving the value returned by PTRACE_GETEVENTMSG during syscall stops
as undefined.

2. Document these values chosen to avoid collisions with ptrace_message val=
ues
set by other ptrace events so that PTRACE_GETEVENTMSG users can easily tell
whether this new semantics is supported by the kernel or not.

The first approach was implemented in v2 of this series: the constants
were PT_SYSCALL_IS_{ENTERING,EXITING} defined in include/linux/ptrace.h.

The second approach was implemented in v3: the constants are
PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} defined in include/uapi/linux/ptrace.h,
they are also going to be documented in ptrace(2) man page.

Since the use of ptrace_message is exposed to PTRACE_GETEVENTMSG users
anyway, I do not see any reason to choose the first approach over the
second.


--=20
ldv

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb/xKNAAoJEAVFT+BVnCUIC/4P/AyxqHKhmX8UOWu89gp+4fAt
mgX9mEGH7Nfui/K1/VIU1xMtqCSznyNnMVkLOg304Q2T8RwZ4Pgw3QgclPxK3EZb
6iRO1lU2tdvdJBt0SE5FuIxONVnN0GjaBnNsOV0ZjevLvj7eWFCJg+WSB2Nu1klN
UrEdGLMLpk9Jhc9AskdYZ0rN3igtbyHZBljpsasiSbi6JUcQd/nXOgPmwE7zBSE8
0nOB9D7dL4yyC/WBCo4ICvNUZeG/N3ySyp8VSSPbyf6r2BEG0RSChB5zOgCzExYv
pPvV+Xn3owe4uqv7EEHJihExUs9bmzeA+1/0RSt67V0KTQolxiJyfIVX6gWz5waw
SsnrR/e9mp7H9gKTnMV0PUZEocBOrNltzGD09v4INTV3HN0c3TDDY2HjBJsGxhKg
mkPyE/WhbNWwyPKiydj5pxP/cCTqdSLeCcDF8ieDcyewOpVMFfurZyL0ULxrarEI
Rt2MxpkhbL1dXN3Cm6UQ+GJOxLrDWDYfoJBMc+lC6z2bjpSIGeRx3vPPdMP3kf/D
EGMp+h1R+qq1ZGb4caLt6P+SA2TQxsFP5pD/b/0a2VpVLnz7MCbjP8MtUFF+olwG
IEUv09Mq/lYDnN8146f1310Y8te6Oz9YVC/mt/zAh3EjCI5uNYDVK+HBMUH8+w04
5qwVcs8316KvDj5oufnF
=+TSj
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
