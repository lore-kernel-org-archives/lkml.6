Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D86721773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBQWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:15:29 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50308 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:15:26 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3F12572CCAE;
        Mon, 18 Feb 2019 01:15:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 31B297CC774; Mon, 18 Feb 2019 01:15:24 +0300 (MSK)
Date:   Mon, 18 Feb 2019 01:15:24 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Niklas =?utf-8?Q?Hamb=C3=BCchen?= <mail@nh2.me>
Cc:     mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        cleverca22@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH] ptrace.2: Improve clarity for multi-threaded tracers
Message-ID: <20190217221523.GA9233@altlinux.org>
References: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me>
 <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 17, 2019 at 05:34:46PM +0100, Niklas Hamb=C3=BCchen wrote:
> Until now, the man page said:
>=20
>     Attachment and subsequent commands are per thread:
>     in a multi=E2=80=90 threaded process, every thread can be individuall=
y attached to a
>     (potentially different) tracer, or left not attached and thus not deb=
ugged.
>     Therefore, "tracee" always means "(one) thread", never "a (possibly
>     multithreaded) process".
>=20
> While the first sentence "Attachment ... [is] per thread" might be interp=
reted
> as holding for both tracer and tracee, the rest talks only about the
> multi-threadedness of the *tracee*, leaving some uncertainty in the reade=
r on
> whether the tracer may issue `ptrace()` from different threads.
>=20
> This patch adds more explicitness, removing any doubt.

Thanks for making an attempt to remove any doubt.

Yes, ptrace'ing is per task_struct on both sides.

> Relevant resources:
>=20
> * LKML thread https://marc.info/?l=3Dlinux-kernel&m=3D155036848808748&w=
=3D2
>   "ptrace() with multithreaded tracer"
>   where I asked about this behaviour, in case anybody disagrees with my
>   understanding
> * https://stackoverflow.com/questions/18737866/can-a-thread-trace-a-proce=
ss/
>   where the previous ambiguity of the man page confused some users, and w=
here
>   and example program is given that confirms the behaviour I mention in t=
his
>   patch
> * A program of mine, in which I have independently confirmed that using
>   `ptrace()` from a thread that's not the tracer thread (a sibling thread=
 in
>   the process is the tracer instead) results in `ESRCH`
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/ptrace.c?id=3D96d4f267e40f9509e8a66e2b39e8b95655617693#n207
>   where the comment on `ptrace_check_attach()` talks about `%current`, wh=
ich
>   is a thread
>=20
> Signed-off-by: Niklas Hamb=C3=BCchen <mail@nh2.me>
> ---
>  man2/ptrace.2 | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/man2/ptrace.2 b/man2/ptrace.2
> index 3b6b6ea84..4058abe94 100644
> --- a/man2/ptrace.2
> +++ b/man2/ptrace.2
> @@ -122,12 +122,18 @@ It is primarily used to implement breakpoint debugg=
ing and system
>  call tracing.
>  .PP
>  A tracee first needs to be attached to the tracer.
> -Attachment and subsequent commands are per thread:
> -in a multithreaded process,
> +Attachment and subsequent commands are per thread,
> +on both the tracer and tracee side.
> +Issuing a tracing command from a thread that is not the tracer of the gi=
ven
> +.I pid
> +will result in an
> +.B ESRCH
> +error.

This is confusing.  What do you mean by a tracing command?
Is PTRACE_TRACEME a tracing command?  PTRACE_ATTACH?  PTRACE_SEIZE?

I suggest leaving the explanation of ptrace return code to "ERRORS"
section.

> +In a multithreaded process to be traced,
>  every thread can be individually attached to a
>  (potentially different) tracer,
>  or left not attached and thus not debugged.
> -Therefore, "tracee" always means "(one) thread",
> +Therefore, "tracer" or "tracee" always mean "(one) thread",
>  never "a (possibly multithreaded) process".
>  Ptrace commands are always sent to
>  a specific tracee using a call of the form
> @@ -2259,7 +2265,7 @@ or (on kernels before 2.6.26) be
>  .TP
>  .B ESRCH
>  The specified process does not exist, or is not currently being traced
> -by the caller, or is not stopped
> +by the calling thread, or is not stopped
>  (for requests that require a stopped tracee).
>  .SH CONFORMING TO
>  SVr4, 4.3BSD.

I agree the current text can be made more clear on the subject,
but, unfortunately, proposed change makes the description more confusing.


--=20
ldv

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcadz7AAoJEAVFT+BVnCUIDrcP/3dgjqHOr3EgIUXMV6AiC12n
Gp7OtjbDO4DDsTJC4GR/4GZEx9NZQFr712XZIGgxmOIphikJ3wzvGilnzUyg1TDe
sE0zN1hgFHMbHDwzpPGFT/ysB1hEr2fJtK+QwbNjLjqaUljEjSzaBihz1lFN0zDj
f0SJdHqW/R+SjUF1uixR9j19IUzyL6TxL6AqkPjBKndIr8bVXrdSn1XMROxJIejv
0rdsnW9474N2Ki4mKiZ6eqOjSFLrIuL1IgGdOf35scQUm85UcOmO9AcChWXGaRcE
tQuQ6yEAYYn1Q7DcGfiBunoD7/+J87stywlkmdEgTvYMsnJ3Cm5GutSEfK9GLrUT
Puk60YfqeZH6Pfr+pA6/fcZo3nUFwzemfHUsTXcG7m2l9M8H12tAmgGuf62Kobrg
wqs2yiVkL2I2iWir00b/pJ6ebpHyZ/dKPKhVV0dd7W3EIdSL20FM93mQAnvM7/z7
FW0RpOn1fDTX9AqMW4gyK6DwTPw6lJ9bCkFilbqocGJTiiVyT3rZIRHqFuVDS22B
2XI2YnGpUrEVr6+8eGk44wIMSG9tFcJeL7NIqGcLbL0XZTxoesHPRl+Ij4KE09Yq
WDhyqaVVheU7fRiZ0vbuZejY3AHjf1jFaTOHqevkZZTZ7JJLpu6yQiNUF5L+eqF/
wai+x8lr3iGgjtXfxMhw
=5uSA
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
