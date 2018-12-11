Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B626C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAEE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAEE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLKU1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:27:14 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41112 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:27:13 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E820C72CC6C;
        Tue, 11 Dec 2018 23:27:09 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D9D6C7CFBE2; Tue, 11 Dec 2018 23:27:09 +0300 (MSK)
Date:   Tue, 11 Dec 2018 23:27:09 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181211202709.GA3839@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043126.GX6131@altlinux.org>
 <20181210141107.GB4177@redhat.com>
 <20181210162131.GG14149@altlinux.org>
 <20181211152953.GA8504@redhat.com>
 <20181211162305.GA480@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20181211162305.GA480@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 07:23:05PM +0300, Dmitry V. Levin wrote:
> On Tue, Dec 11, 2018 at 04:29:54PM +0100, Oleg Nesterov wrote:
> > On 12/10, Dmitry V. Levin wrote:
> > > On Mon, Dec 10, 2018 at 03:11:07PM +0100, Oleg Nesterov wrote:
> > > > On 12/10, Dmitry V. Levin wrote:
> > > > >
> > > > > +struct ptrace_syscall_info {
> > > > > +	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> > > > > +	__u8 __pad0[3];
> > > > > +	__u32 arch;
> > > > > +	__u64 instruction_pointer;
> > > > > +	__u64 stack_pointer;
> > > > > +	__u64 frame_pointer;
> > > > > +	union {
> > > > > +		struct {
> > > > > +			__u64 nr;
> > > > > +			__u64 args[6];
> > > > > +		} entry;
> > > > > +		struct {
> > > > > +			__s64 rval;
> > > > > +			__u8 is_error;
> > > > > +			__u8 __pad1[7];
> > > > > +		} exit;
> > > > > +		struct {
> > > > > +			__u64 nr;
> > > > > +			__u64 args[6];
> > > > > +			__u32 ret_data;
> > > > > +			__u8 __pad2[4];
> > > > > +		} seccomp;
> > > > > +	};
> > > > > +};
> > > >
> > > > Could you explain why ptrace_syscall_info needs __pad{0,1,2} ? I si=
mply can't
> > > > understand why...
> > >
> > > I suppose the idea behind the use of these pads was to make the struc=
ture
> > > arch-independent.
> >=20
> > Still can't understand... are you saying that without (say) __pad2[4]
> > sizeof(ptrace_syscall_info) or offsetofend(ptrace_syscall_info, seccomp)
> > will depend on arch? Or what? I am just curious.
>=20
> Yes, without padding these sizes will depend on architecture:
>=20
> $ cat t.c
> #include <linux/types.h>
> int main() {
> 	struct s {
> 		__u64 nr;
> 		__u64 args[6];
> 		__u32 ret_data;
> 	};
> 	return sizeof(struct s);
> }
>=20
> $ gcc -m64 -Wall -O2 t.c && ./a.out; echo $?
> 64
> $ gcc -m32 -Wall -O2 t.c && ./a.out; echo $?
> 60
>=20
> This happens because __u64 has 32-bit alignment on some 32-bit
> architectures like x86.
>=20
> There is also m68k where __u32 has 16-bit alignment.

Said that, I think it would be better if PTRACE_GET_SYSCALL_INFO
did not take these trailing pads into account, e.g.

-       return offsetofend(struct ptrace_syscall_info, seccomp);
+       return offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
=2E..
-       return offsetofend(struct ptrace_syscall_info, exit);
+       return offsetofend(struct ptrace_syscall_info, exit.is_error);

The reason is that it would allow to fill these trailing pads with
something useful in the future.


--=20
ldv

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEB2dAAoJEAVFT+BVnCUIJ84QAOfJ5fXfvifiGBZCU6BShuZt
byv2O2D/UqiXyLRPJ9xHxXzaI/3mMOe+M6zjrTmZuac4o/AIp6AecW+kKU7/9Q8h
3x/CS5TXCEn1np+Dg1a7hK3h1GRta+N4sOtl3T67t/NnCaAcUSjx+liRLmQMbc/k
9yNjcGNPGbnqE01zQYxMrrr9e+YSZapyFJTpKFPDokwrKoPbRWp3bqDgOgU4dHAs
tNHlwT1oT/ZFZCZqpyRagtB1RQbCUuwMgxsCAOr4FgmgFJTN/6+INbeg38EW7Wk2
SX8yddqbAmPuUxDfnCrcfrU/oQrAS9JZNITxQmEFgzIkCm7pazXJE+rUTFzrXeW7
cCbjsALXEQcVpP28K2muEhHuGky3qRQ12k/bc9bUOvvfUmfYm+S0vGG+ahFoKhcV
hpumhBRXnwnOgMOKr90DyCWxnABSciUfaJdOuzcO+zWwztdvP/ZwbxovkkDbF68C
b6Y1NBaBkEzwpDMrO9giCrcRvz2popcsye4zzHAPebmShzri2C+iJrlbUo0osGz+
+r7n5wO5qOtsM2kEOwn/Eopwiv4kZ3HrkMleLSn3Fit6dZXQEuWvUcRodM5Kr6Pw
xR1ZeY2TiDiLh1+Hjyiy2hXGu/EAOYzC9057fKhJUE8Kk5NtSBsjZjFbWy8a0+T/
ufWPiKdmiEeuYxn4Vfs5
=yQae
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
