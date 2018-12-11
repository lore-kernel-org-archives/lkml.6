Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E377C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeLKQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:23:12 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48318 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeLKQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:23:09 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 94A9872CC6C;
        Tue, 11 Dec 2018 19:23:05 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 7C9EB7CFA6D; Tue, 11 Dec 2018 19:23:05 +0300 (MSK)
Date:   Tue, 11 Dec 2018 19:23:05 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181211162305.GA480@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043126.GX6131@altlinux.org>
 <20181210141107.GB4177@redhat.com>
 <20181210162131.GG14149@altlinux.org>
 <20181211152953.GA8504@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20181211152953.GA8504@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 04:29:54PM +0100, Oleg Nesterov wrote:
> On 12/10, Dmitry V. Levin wrote:
> > On Mon, Dec 10, 2018 at 03:11:07PM +0100, Oleg Nesterov wrote:
> > > On 12/10, Dmitry V. Levin wrote:
> > > >
> > > > +struct ptrace_syscall_info {
> > > > +	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> > > > +	__u8 __pad0[3];
> > > > +	__u32 arch;
> > > > +	__u64 instruction_pointer;
> > > > +	__u64 stack_pointer;
> > > > +	__u64 frame_pointer;
> > > > +	union {
> > > > +		struct {
> > > > +			__u64 nr;
> > > > +			__u64 args[6];
> > > > +		} entry;
> > > > +		struct {
> > > > +			__s64 rval;
> > > > +			__u8 is_error;
> > > > +			__u8 __pad1[7];
> > > > +		} exit;
> > > > +		struct {
> > > > +			__u64 nr;
> > > > +			__u64 args[6];
> > > > +			__u32 ret_data;
> > > > +			__u8 __pad2[4];
> > > > +		} seccomp;
> > > > +	};
> > > > +};
> > >
> > > Could you explain why ptrace_syscall_info needs __pad{0,1,2} ? I simp=
ly can't
> > > understand why...
> >
> > I suppose the idea behind the use of these pads was to make the structu=
re
> > arch-independent.
>=20
> Still can't understand... are you saying that without (say) __pad2[4]
> sizeof(ptrace_syscall_info) or offsetofend(ptrace_syscall_info, seccomp)
> will depend on arch? Or what? I am just curious.

Yes, without padding these sizes will depend on architecture:

$ cat t.c
#include <linux/types.h>
int main() {
	struct s {
		__u64 nr;
		__u64 args[6];
		__u32 ret_data;
	};
	return sizeof(struct s);
}

$ gcc -m64 -Wall -O2 t.c && ./a.out; echo $?
64
$ gcc -m32 -Wall -O2 t.c && ./a.out; echo $?
60

This happens because __u64 has 32-bit alignment on some 32-bit
architectures like x86.

There is also m68k where __u32 has 16-bit alignment.

> > I don't think we really need to keep it exactly the same on all
> > architectures - the only practical requirement is to avoid any compat
> > issues, but I don't mind keeping the structure arch-independent.
>=20
> OK, but may be you can add a short comment to explain these pads.

Alternatively, we could use __attribute__((aligned(N))), e.g.

struct ptrace_syscall_info {
	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
	__u32 arch __attribute__((aligned(4)));
	__u64 instruction_pointer;
	__u64 stack_pointer;
	union {
		struct {
			__u64 nr __attribute__((aligned(8)));
			__u64 args[6];
		} entry;
		struct {
			__s64 rval __attribute__((aligned(8)));
			__u8 is_error;
		} exit;
		struct {
			__u64 nr __attribute__((aligned(8)));
			__u64 args[6];
			__u32 ret_data;
		} seccomp;
	};
};

Do you prefer __attribute__((aligned(N))) to padding?


--=20
ldv

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcD+RpAAoJEAVFT+BVnCUIcBAQAIk2DIaVO8win99bfrthySyg
4qzAMo2GFFPBGMrOaj8q+9FcfOS+atOy6twMOyuBahMHzUZ4FCfBWfMwmKKlmqlN
fRaj8nnwyISEhR8pcV2qRgqrdYw+kB//81GoY9OALju+H6jP+xuJ58aV+O1D1aiM
PiuwWBvScc6fgAo/fRac9UKMwDMfxfdw0CJ99VmnJz3AhbKp2e19Vo1nzw6Jqp41
Tx11Tvd97+qIT9E2NdRH+7kt8APthvZW0lo+8fqnGxJu49ulS2oRh8Vk5K6ZjXKe
x9sRyfWz1rMSyS4P/KaDE8cX4wk4c6n158EeYK8al/McUeIz9hATmdGjOv8vsQFJ
OniRAY3sTYnMX63pY7sIENM+1uILbBZQbyXsHm6haB6Cpog8wZjiTfL0GuvfNY3u
eo5xHeAxMEVOQegHDOY7Q2WdrsdY2TzjM3FWzDm4ZTRr7MW16eQZXtHKryIe4pTC
rfxwfvgtbVDtkfk9mpjnL/7+P6ATGzecSAlzT10zyinTnnX0qElau7k+RHCUTczZ
wztUiTvLzPbMaDVf23anqO5YYt5OBEPOAn3e0xX2h85QpFC2nEaUIWEK9hHDgwKB
mhz6ga7Iup10vckeP/b/qau4tWYMwMGCUqVobFSa+bcmIl6U3293uHHEpcZsKCzZ
LVQwqcKiPj4ANJ4TkiMj
=H7Ic
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
