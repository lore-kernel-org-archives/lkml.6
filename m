Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F722081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F722081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeK2Vjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:39:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36124 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeK2Vjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:39:32 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1A7D272CC59;
        Thu, 29 Nov 2018 13:34:37 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 055077CC6A7; Thu, 29 Nov 2018 13:34:36 +0300 (MSK)
Date:   Thu, 29 Nov 2018 13:34:36 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181129103436.GA11547@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
 <20181128221125.GA2800@altlinux.org>
 <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 03:17:49PM -0800, Andy Lutomirski wrote:
> On Wed, Nov 28, 2018 at 2:11 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 06:23:46PM +0300, Dmitry V. Levin wrote:
> > > On Wed, Nov 28, 2018 at 03:20:06PM +0100, Oleg Nesterov wrote:
> > > > On 11/28, Dmitry V. Levin wrote:
> > > > > On Wed, Nov 28, 2018 at 02:49:14PM +0100, Oleg Nesterov wrote:
> > > > > > On 11/28, Dmitry V. Levin wrote:
> > > > > > >
> > > > > > > +/*
> > > > > > > + * These values are stored in task->ptrace_message by traceh=
ook_report_syscall_*
> > > > > > > + * to describe current syscall-stop.
> > > > > > > + *
> > > > > > > + * Values for these constants are chosen so that they do not=
 appear
> > > > > > > + * in task->ptrace_message by other means.
> > > > > > > + */
> > > > > > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY        0x80000000U
> > > > > > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT 0x90000000U
> > > > > >
> > > > > > Again, I do not really understand the comment... Why should we =
care about
> > > > > > "do not appear in task->ptrace_message by other means" ?
> > > > > >
> > > > > > 2/2 should detect ptrace_report_syscall() case correctly, so we=
 can use any
> > > > > > numbers, say, 1 and 2?
> > > > > >
> > > > > > If debugger does PTRACE_GETEVENTMSG it should know how to inter=
pet the value
> > > > > > anyway after wait(status).
> > > > >
> > > > > Given that without this patch the value returned by PTRACE_GETEVE=
NTMSG
> > > > > during syscall stop is undefined, we need two different ptrace_me=
ssage
> > > > > values that cannot be set by other ptrace events to enable reliab=
le
> > > > > identification of syscall-enter-stop and syscall-exit-stop in use=
rspace:
> > > > > if we make PTRACE_GETEVENTMSG return 0 or any other value routine=
ly set by
> > > > > other ptrace events, it would be hard for userspace to find out w=
hether
> > > > > the kernel implements new semantics or not.
> > > >
> > > > Hmm, why? Debugger can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL=
), if it
> > > > returns EIO then it is not implemented?
> > >
> > > The debugger that uses PTRACE_GET_SYSCALL_INFO does not need to call
> > > PTRACE_GETEVENTMSG for syscall stops.
> > > My concern here is the PTRACE_GETEVENTMSG interface itself.  If we use
> > > ptrace_message to implement PTRACE_GET_SYSCALL_INFO and expose
> > > PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} for regular PTRACE_GETEVENTMSG u=
sers,
> > > it should have clear semantics.
> >
> > Since our implementation of PTRACE_GET_SYSCALL_INFO uses ptrace_message
> > to distinguish syscall-enter-stop from syscall-exit-stop, we could choo=
se
> > one of the following approaches:
> >
> > 1. Do not document the values saved into ptrace_message during syscall
> > stops (and exposed via PTRACE_GETEVENTMSG) as a part of ptrace API,
> > leaving the value returned by PTRACE_GETEVENTMSG during syscall stops
> > as undefined.
> >
> > 2. Document these values chosen to avoid collisions with ptrace_message=
 values
> > set by other ptrace events so that PTRACE_GETEVENTMSG users can easily =
tell
> > whether this new semantics is supported by the kernel or not.
>=20
> I don't like any of this at all.  Can we please choose a sensible API
> design and let the API drive the implementation instead of vice versa?

What are your concerns?  Do you see something wrong in exposing this
information via PTRACE_GETEVENTMSG?

Anyway, can we agree on the PTRACE_GET_SYSCALL_INFO API, please?

>  ISTM the correct solution is to add some new state to task_struct for
> this.
>=20
> If we're concerned about making task_struct bigger, I have a
> half-finished patch to factor all the ptrace tracee state into a
> separate struct.

This is refactoring of the kernel - a thing userspace people are not
the best equipped to do.  This part should rather be sorted out by kernel
people.


--=20
ldv

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb/8C8AAoJEAVFT+BVnCUIurcQAL/2HRQmF9Kp0QjlXLZaNXnZ
fUtK8nt3YH+JAs9JzDKlueo9cpiS5raMzi3bP4ZFm7lJoEVG/Rje7mih1sy7G6Ll
p5MG6swSBCnZtU5L9iP/VVvWqCxV2o97WGBTNNb8FF1SdSs30M0SRmpWXa10Whf2
Zn15q+YaphfIQcyZKQ+iW9U9hlfg6JHUqz0KCRTVANc0NSclP4kE5AZqVEm7h8s5
QVoLU7aKvdwVtb07FESrLAApKFCk6FMTJk4T6jLVFE1bQihzqDw0DRGYHJk4P9op
/fEPO/y/kl4BEoifoJBbech0lFbxZUrfpZnmCW3DtmcHIanMD8pvSlbozITajKSQ
zbd2+sxrg95le2YW6D4MGdA6FoDBNz46OWsl8uvICOQz5N7uArEU+SNfihUoLjAa
QkceNlp/e1IO3/sh3eU2ErdEs54dJmmDXVUkjhg26pDRj6beVFC4mSVlaE2Spqa0
G4UdgugeODXN3X5o9zEI57vkxKDVlqlcK5XqqBbbDh1Plesj4jc+l7Xt1rW0m6Hi
/UuApDFG57n/hEVH3HkonZudGs3wF4ccsgtX7csAh4Bx28WStyE2KOxHvhD74gV4
DJQ+bX3I9GvDSjfI4TWjNcE3+WFNosXDvvD7shTHVCcCKaHGAoJ23PdOvLBdkBC3
r8eb9XdMYUvi/Jd/gy2N
=9ekh
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
