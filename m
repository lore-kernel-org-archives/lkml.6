Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC18C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA12620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLJQJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:09:46 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50242 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeLJQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:09:43 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4643A72CC66;
        Mon, 10 Dec 2018 19:09:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 392467CF2A6; Mon, 10 Dec 2018 19:09:40 +0300 (MSK)
Date:   Mon, 10 Dec 2018 19:09:40 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181210160940.GF14149@altlinux.org>
References: <20181210043126.GX6131@altlinux.org>
 <201812102200.snodXJSH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <201812102200.snodXJSH%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, things are getting too complicated and we need some advice how to deal
with this frame_pointer issue.

On Mon, Dec 10, 2018 at 10:26:50PM +0800, kbuild test robot wrote:
> Hi Elvira,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.20-rc6]
> [cannot apply to next-20181207]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Dmitry-V-Levin/ptrace-ad=
d-PTRACE_GET_SYSCALL_INFO-request/20181210-174745
> config: mips-malta_kvm_defconfig (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dmips=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    kernel/ptrace.c: In function 'ptrace_get_syscall_info':
> >> kernel/ptrace.c:942:20: error: implicit declaration of function 'frame=
_pointer'; did you mean 'trace_printk'? [-Werror=3Dimplicit-function-declar=
ation]
>       .frame_pointer =3D frame_pointer(regs)
>                        ^~~~~~~~~~~~~
>                        trace_printk
>    cc1: some warnings being treated as errors
>=20
> vim +942 kernel/ptrace.c
>=20
>    931=09
>    932	static int
>    933	ptrace_get_syscall_info(struct task_struct *child, unsigned long u=
ser_size,
>    934				void __user *datavp)
>    935	{
>    936		struct pt_regs *regs =3D task_pt_regs(child);
>    937		struct ptrace_syscall_info info =3D {
>    938			.op =3D PTRACE_SYSCALL_INFO_NONE,
>    939			.arch =3D syscall_get_arch(child),
>    940			.instruction_pointer =3D instruction_pointer(regs),
>    941			.stack_pointer =3D user_stack_pointer(regs),
>  > 942			.frame_pointer =3D frame_pointer(regs)
>    943		};
>    944		unsigned long actual_size =3D offsetof(struct ptrace_syscall_info=
, entry);
>    945		unsigned long write_size;
>    946=09
>    947		/*
>    948		 * This does not need lock_task_sighand() to access
>    949		 * child->last_siginfo because ptrace_freeze_traced()
>    950		 * called earlier by ptrace_check_attach() ensures that
>    951		 * the tracee cannot go away and clear its last_siginfo.
>    952		 */
>    953		switch (child->last_siginfo ? child->last_siginfo->si_code : 0) {
>    954		case SIGTRAP | 0x80:
>    955			switch (child->ptrace_message) {
>    956			case PTRACE_EVENTMSG_SYSCALL_ENTRY:
>    957				actual_size =3D ptrace_get_syscall_info_entry(child, regs,
>    958									    &info);
>    959				break;
>    960			case PTRACE_EVENTMSG_SYSCALL_EXIT:
>    961				actual_size =3D ptrace_get_syscall_info_exit(child, regs,
>    962									   &info);
>    963				break;
>    964			}
>    965			break;
>    966		case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
>    967			actual_size =3D ptrace_get_syscall_info_seccomp(child, regs,
>    968								      &info);
>    969			break;
>    970		}
>    971=09
>    972		write_size =3D min(actual_size, user_size);
>    973		return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual=
_size;
>    974	}
>    975=09

We decided to add .frame_pointer to struct ptrace_syscall_info just for
consistency with .instruction_pointer and .stack_pointer; I must have been
misled by comments in asm-generic/ptrace.h into thinking that
frame_pointer() is universally available across architectures.

Unlike .instruction_pointer and .stack_pointer that are actually needed
in strace, .frame_pointer is not used, so from strace PoV we don't really
need it.

So the question is, does anybody need a
struct ptrace_syscall_info.frame_pointer?

If yes, how can frame_pointer() be defined on MIPS?
Or should we just forget about making sense of frame_pointer() and remove
struct ptrace_syscall_info.frame_pointer from the proposed API?


--=20
ldv

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDo/DAAoJEAVFT+BVnCUICIgQAKh+d6RX34ftfTYO4197Q6II
6KMnUxcItqrc2welYp+xMCCiz831/STwqczpfeNNYtKnmaXKgcghjGleF0QFmRv3
0Y3zM9YzynIVIWwBH8lKYWasWTYoekNsT8bTf7uUP6ycD5kSVrLo0DgcuJV2n27s
TmJ9ez3AdpdleGRJQkmGeWTKvId+woQR3v+Ag0LcRmOtbEwm2PlQX3IxiV+SEr51
Fqy3FO56oDENuZjr2i16begsUPz7fHKlQHLvn65P+Hw43Dw6i50ywXBwsJmd1hFI
fA4udKAK4Zu6LfUrNA8EeEshSjMz4Scrq+5/d1vpDTN161TstFgLXtnae6FYIxms
d217pbktjP3Sy9Mge5jSHZosC0+rqJj5x/1iNGkchviJITfh8SjD1fofngycQyVA
ZbyQUPE7o9Rrr/Vrb0cD16E/Tg3FJEA0U61ZNJP57SsGeG7L3aQ0o3rHo4WnrnCQ
PNXnnduLI9Q/Zy9k3Jq6rYn5p/moPcR5HHday3klbrnvmdMtdX7i1dzZeyND3JpG
i0/bWgF597xWtwvt4sdWRry8P42oIxwL5iyFPGiC83IoekHz/o5WUuXgjWNY6YOI
XM8q5ctTLWEZF8KvdLOwwjmTeJ6gLXOfO2wQhDRhgFs3uCfnP8zokDynzF7EKf6C
ZEGfug6XU0R1J745wfue
=LBY1
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
