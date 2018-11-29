Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5318C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9F82146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9F82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeK3IRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:17:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39132 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3IRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:17:32 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 57C8C72CC66;
        Fri, 30 Nov 2018 00:10:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 47ECE7CC6A7; Fri, 30 Nov 2018 00:10:44 +0300 (MSK)
Date:   Fri, 30 Nov 2018 00:10:44 +0300
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
Message-ID: <20181129211044.GA20529@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
 <20181128221125.GA2800@altlinux.org>
 <20181129144742.GB10645@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20181129144742.GB10645@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 03:47:43PM +0100, Oleg Nesterov wrote:
> On 11/29, Dmitry V. Levin wrote:
> >
> > 2. Document these values
>=20
> sure, they should be documented and live in include/uapi/,
>=20
> > chosen to avoid collisions with ptrace_message values
> > set by other ptrace events
>=20
> this is what I can't understand. But to clarify, I don't really care and
> won't argue.
>=20
> If an application wants to use PTRACE_GETEVENTMSG to distinguish entry/ex=
it
> (without PTRACE_GET_SYSCALL_INFO) it needs to do wait(status) and check s=
tatus
> anyway, otherwise PTRACE_GETEVENTMSG is simply pointless (wrt syscall ent=
ry/
> exit). So we do not care if PTRACE_EVENTMSG_SYSCALL_ENTRY conflicts with,=
 say,
> SECCOMP_RET_DATA.

Yes, once the application has verified that the kernel implements this
feature, there is no risk of collision.

> > so that PTRACE_GETEVENTMSG users can easily tell
> > whether this new semantics is supported by the kernel or not.
>=20
> Yes. And how much this can help? Again, an application can trivially dete=
ct
> if this feature implemented or not, and it should do this anyway if it wa=
nts
> to (try to) use PTRACE_EVENTMSG_SYSCALL_ENTRY/EXIT ?

How an application can easily detect whether this feature is implemented?
By invoking PTRACE_GETEVENTMSG after the first syscall stop reported by
wait and checking whether the returned value is either
PTRACE_EVENTMSG_SYSCALL_ENTRY or PTRACE_EVENTMSG_SYSCALL_EXIT.

So the question is, how can this value be equal to one of these constants
when this feature is not implemented?  Can a value saved to ptrace_message
earlier by one of ptrace events be equal to one of these constants?

Imagine an application attaches to already existing process, enables
PTRACE_O_TRACESECCOMP, and a PTRACE_EVENT_SECCOMP arrives with
ptrace_message set to 1.  If this application then exits and a new invocati=
on
of the same application attaches to the same process, it will very likely s=
ee
this 1 returned by PTRACE_GETEVENTMSG if the feature is not implemented
in the kernel.

To avoid that kind of collisions, kernel should use different ptrace_message
values for syscall stops.

> Again, I won't reallly argue. But if you insist that these values must
> be unique then you probably need to add
>=20
> 	BUILD_BUG_ON(PTRACE_EVENTMSG_SYSCALL_ENTRY <=3D PID_MAX_LIMIT);

Yes, it's a good idea.  What is the proper place for this check?


--=20
ldv

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcAFXTAAoJEAVFT+BVnCUIq0EP/iPv5CJspwW70RTZ8yEMA722
hBqt/Nr57H6ry+3rj41yT5z7uoDkeKRvupl/gsShs0cnTUzGJxVT3sTdraf1tvC4
XF4lhCP5qJCBBllgohfFTFoxutALmVmuW1yr6xxhIBH+d3XC2eq4oOQnr/sPYFk4
dL7mvqSs78W6w3m3/od1l0cOnjxBGXKJZBR6xw5XousawvCR6cI8xX2wEWW/QFRo
WE8eDeXFJ0c85RfAWIztAcHi7JjxsSdEJXzl2s3Oz33kZR9GWmiF2ZburlENr5zR
QovCw2pv3KjNg/ijcim2trDTV4ij5LoSLMXnNXuWAqA38guQLAm5E9Wp+vLrb7xb
IRxIcT6K70l6ovcgzQBSOkxUzaQrTgBPua2hXXfC9yf8ls/pSI5VDCsEAX7DVRpn
zOphlMBbXtLopeQk9gHKG1TVluTHKAbu6D7+dPlTIOKwM2EMEBqVw07FQ1oToGK8
yWR11PvsmAa0RxjZHwOLQ00xfxaCbX6Wlk7OnNCVlR+ORS1BdW14tb7Hi0jJyG96
Eo3SqXVE3hMHFAZpPa4mO9q7RcN+O6UCRTVRii13X3Y0LClsCt1HqMXDT/9pHWJx
j15cFYcT8EwyP2TTu0fOS+g+sY1G000DNXNB6KQZh4518TH+VIGeZnOjwHpdk6Up
WW/+LWj82BIPeOgjAMDC
=dQ4k
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
