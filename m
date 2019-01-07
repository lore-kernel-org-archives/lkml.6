Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88158C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5361A218AD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAGO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:58:12 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41288 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfAGO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:58:11 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 96BB872CC71;
        Mon,  7 Jan 2019 17:58:09 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 86E608E5C3E; Mon,  7 Jan 2019 17:58:09 +0300 (MSK)
Date:   Mon, 7 Jan 2019 17:58:09 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 21/22] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20190107145809.GA10203@altlinux.org>
References: <20190107025455.GU1207@altlinux.org>
 <201901071534.VEFsJa9w%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <201901071534.VEFsJa9w%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Looks like we need help to overcome this alpha specific issue:

On Mon, Jan 07, 2019 at 03:05:23PM +0800, kbuild test robot wrote:
> Hi Elvira,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0-rc1]
> [cannot apply to next-20190103]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Dmitry-V-Levin/asm-gener=
ic-syscall-h-prepare-for-inclusion-by-other-files/20190107-115241
> config: alpha-allmodconfig (attached as .config)
> compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dalpha=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    kernel/ptrace.c: In function 'ptrace_get_syscall_info':
> >> kernel/ptrace.c:944:20: error: implicit declaration of function 'user_=
stack_pointer'; did you mean 'xa_tag_pointer'? [-Werror=3Dimplicit-function=
-declaration]
>       .stack_pointer =3D user_stack_pointer(regs),
>                        ^~~~~~~~~~~~~~~~~~
>                        xa_tag_pointer
>    In file included from arch/alpha/include/asm/syscall.h:6:0,
>                     from include/linux/audit.h:214,
>                     from kernel/ptrace.c:24:

The mandatory function
	static inline unsigned long user_stack_pointer(struct pt_regs *regs)
is not implemented on alpha, and I don't know how to implement it because
the relevant information is not available via struct pt_regs.
On alpha
	task_thread_info(task)->pcb.usp
is used to obtain the user stack pointer.


--=20
ldv

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcM2kBAAoJEAVFT+BVnCUIUcIP/i69kdILU+rcGYOw93YxkR7/
OHcJSJRjk/WgfhuKuoisl/SwRMElxZ21lSwlLVWDt0rOntFPoDH5IpPVOC9QqaXr
uprql6maH6bGTTXP1qdHOXb1bz9rqc2i7R40R1wVwLRGLU47off+/U1Rhtex98ce
U0tZ3o0LlmwacxfbEB6mTTMZDJhmJdU8qrXws+048YBh+Qh81kBeqfFuYinuohL6
1Wt+UyKi87KpmGJPYJNUkKe6KW6bek/girRf1HOZV7EXw5RlTCSnEcqnTNHAOID5
rq6oVJKgHQm+JogE5yewHUMkX8Zxc4unWC77uZnY0Ee+ouhIxupzRS3ehsOl0Vr5
1r2TTyRSYI5mUpEysqyebt0AuUjGeU2LhmMxMzGKWrae9LPEFTysuA/ObapPPm0p
uzgxUCZ5mlBH0Y8j7dgoG17ioNjuK1DxxX5nV2pgtS/fB/460uPKDl8dNY1eohDC
JDepKrMWxTA5utZGz3Okv4jyxqpvqnnvMp3lA6YqQ8t83ZtJldoJ8aGxHaHCnGBs
5BWwgusvs5mh2HTQ6II57DmMx8V3Rv12+jjPEeXn5wGzpIuAa47qj0kw1gWeDWNJ
Dd6tfUfDCJLi0ecitR/IvgQ2tVbwOwhkt4UDJpig2zCwfy6vqkmBzXjcuQ5hKTqE
u5l6aDkhtcFyN+CRixMj
=ESnS
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
