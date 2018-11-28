Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37120832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C37120832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeK2CZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:25:51 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52650 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:25:51 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F324D72CC59;
        Wed, 28 Nov 2018 18:23:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E531D7CD0D7; Wed, 28 Nov 2018 18:23:46 +0300 (MSK)
Date:   Wed, 28 Nov 2018 18:23:46 +0300
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
Message-ID: <20181128152346.GG28206@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20181128142006.GE30395@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 03:20:06PM +0100, Oleg Nesterov wrote:
> On 11/28, Dmitry V. Levin wrote:
> > On Wed, Nov 28, 2018 at 02:49:14PM +0100, Oleg Nesterov wrote:
> > > On 11/28, Dmitry V. Levin wrote:
> > > >
> > > > +/*
> > > > + * These values are stored in task->ptrace_message by tracehook_re=
port_syscall_*
> > > > + * to describe current syscall-stop.
> > > > + *
> > > > + * Values for these constants are chosen so that they do not appear
> > > > + * in task->ptrace_message by other means.
> > > > + */
> > > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> > > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U
> > >=20
> > > Again, I do not really understand the comment... Why should we care a=
bout
> > > "do not appear in task->ptrace_message by other means" ?
> > >=20
> > > 2/2 should detect ptrace_report_syscall() case correctly, so we can u=
se any
> > > numbers, say, 1 and 2?
> > >=20
> > > If debugger does PTRACE_GETEVENTMSG it should know how to interpet th=
e value
> > > anyway after wait(status).
> >=20
> > Given that without this patch the value returned by PTRACE_GETEVENTMSG
> > during syscall stop is undefined, we need two different ptrace_message
> > values that cannot be set by other ptrace events to enable reliable
> > identification of syscall-enter-stop and syscall-exit-stop in userspace:
> > if we make PTRACE_GETEVENTMSG return 0 or any other value routinely set=
 by
> > other ptrace events, it would be hard for userspace to find out whether
> > the kernel implements new semantics or not.
>=20
> Hmm, why? Debugger can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL), if =
it
> returns EIO then it is not implemented?

The debugger that uses PTRACE_GET_SYSCALL_INFO does not need to call
PTRACE_GETEVENTMSG for syscall stops.
My concern here is the PTRACE_GETEVENTMSG interface itself.  If we use
ptrace_message to implement PTRACE_GET_SYSCALL_INFO and expose
PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} for regular PTRACE_GETEVENTMSG users,
it should have clear semantics.


--=20
ldv

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb/rMCAAoJEAVFT+BVnCUIgEcP/RcxLjhnkybmCV8dd3Jp12rT
imBkH/MjrC44nXaZTNxoEs5HNRgZcKhuA54TAdpFFhdjfllBNRI7fyiHLjc0rUVx
AWTo1v0IkL0KmYcfV5Caeymp5p8UCpHbeNUrVzRa2BtoU+fDPRAsZ0ABDlNabDEX
Pf2Xt5xx52maOEm/G5Ja7FCdAA4an6si40FPrhFWuQNCSj7yrVx8kNsMV5uxUQ0q
izhhNx0fwO69QjwTaVcjVFYZDh2r+4fCE/dKy2iWS8qulCl0JEVVi/rtdHpfW3X3
Anf1ocMJlzqv7aCJa2q0xWtuBvdhh8/zGeJfa2B3e8davRQ4xjUCwfhpBjRgsejt
XBbkaVuybJltIE8X8kxP0kRxjKoHsmkPiJ0nM4LZUDY3KJhD6lLAN0Dq4oZ71tLp
4nnoHbK3Z3Q7sPiSdjmMPxHk+bA+GF65eY9fOVCJ06WEAWeBXQBbmXJxaz0kODFU
6mKFKpn0UBCxOTsqj4mepGTYMvTjO1qQzm7qTbU3h1nKY//UV25oVFwA2VN4RxlY
KoIfB9DrGB0V7+hMVNwJpcP57doCTJmphIelbHRITa3UvHljhE2xgRsFZw0LOj0V
S9xJ7/7h6EGTMMzyZjZc5h6Wc7blvDWzbdwotw5hWx4RQ70mu/msKmKhmucyTFU0
05kz+92R4JjwqyOhPxUK
=MBSI
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
