Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC1CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A5E2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeLaBpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 20:45:20 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:42744 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeLaBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 20:45:19 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A1FF372CC6C;
        Mon, 31 Dec 2018 04:45:15 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 93530965869; Mon, 31 Dec 2018 04:45:15 +0300 (MSK)
Date:   Mon, 31 Dec 2018 04:45:15 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: fix page fault handling for r16-r18 targets
Message-ID: <20181231014515.GA13296@altlinux.org>
References: <20181230202312.7239-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20181230202312.7239-1-slyfox@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 30, 2018 at 08:23:12PM +0000, Sergei Trofimovich wrote:
> Fix page fault handling code to fixup r16-r18 registers.
> Before the patch code had off-by-two registers bug.
> This bug caused overwriting of ps,pc,gp registers instead
> of fixing intended r16,r17,r18 (see `struct pt_regs`).
>=20
> More details:
>=20
> Initially Dmitry noticed a kernel bug as a failure
> on strace test suite. Test passes unmapped userspace
> pointer to io_submit:
>=20
> ```c
>     #include <err.h>
>     #include <unistd.h>
>     #include <sys/mman.h>
>     #include <asm/unistd.h>
>     int main(void)
>     {
>         unsigned long ctx =3D 0;
>         if (syscall(__NR_io_setup, 1, &ctx))
>             err(1, "io_setup");
>         const size_t page_size =3D sysconf(_SC_PAGESIZE);
>         const size_t size =3D page_size * 2;
>         void *ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
>                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (MAP_FAILED =3D=3D ptr)
>             err(1, "mmap(%zu)", size);
>         if (munmap(ptr, size))
>             err(1, "munmap");
>         syscall(__NR_io_submit, ctx, 1, ptr + page_size);
>         syscall(__NR_io_destroy, ctx);
>         return 0;
>     }
> ```
>=20
> Running this test causes kernel to crash when handling page fault:
>=20
> ```
>     Unable to handle kernel paging request at virtual address fffffffffff=
f9468
>     CPU 3
>     aio(26027): Oops 0
>     pc =3D [<fffffc00004eddf8>]  ra =3D [<fffffc00004edd5c>]  ps =3D 0000=
    Not tainted
>     pc is at sys_io_submit+0x108/0x200
>     ra is at sys_io_submit+0x6c/0x200
>     v0 =3D fffffc00c58e6300  t0 =3D fffffffffffffff2  t1 =3D 000002000025=
e000
>     t2 =3D fffffc01f159fef8  t3 =3D fffffc0001009640  t4 =3D fffffc0000e0=
f6e0
>     t5 =3D 0000020001002e9e  t6 =3D 4c41564e49452031  t7 =3D fffffc01f159=
c000
>     s0 =3D 0000000000000002  s1 =3D 000002000025e000  s2 =3D 000000000000=
0000
>     s3 =3D 0000000000000000  s4 =3D 0000000000000000  s5 =3D ffffffffffff=
fff2
>     s6 =3D fffffc00c58e6300
>     a0 =3D fffffc00c58e6300  a1 =3D 0000000000000000  a2 =3D 000002000025=
e000
>     a3 =3D 00000200001ac260  a4 =3D 00000200001ac1e8  a5 =3D 000000000000=
0001
>     t8 =3D 0000000000000008  t9 =3D 000000011f8bce30  t10=3D 00000200001a=
c440
>     t11=3D 0000000000000000  pv =3D fffffc00006fd320  at =3D 000000000000=
0000
>     gp =3D 0000000000000000  sp =3D 00000000265fd174
>     Disabling lock debugging due to kernel taint
>     Trace:
>     [<fffffc0000311404>] entSys+0xa4/0xc0
> ```
>=20
> Here `gp` has invalid value. `gp is s overwritten by a fixup for the
> following page fault handler in `io_submit` syscall handler:
>=20
> ```
>     __se_sys_io_submit
>     ...
>         ldq     a1,0(t1)
>         bne     t0,4280 <__se_sys_io_submit+0x180>
> ```
>=20
> After a page fault `t0` should contain -EFALUT and `a1` is 0.
> Instead `gp` was overwritten in place of `a1`.
>=20
> This happens due to a off-by-two bug in `dpf_reg()` for `r16-r18`
> (aka `a0-a2`).
>=20
> I think the bug went unnoticed for a long time as `gp` is one
> of scratch registers. Any kernel function call would re-calculate `gp`.

Thanks, that's impressive!

According to the history git, the off-by-two bug was introduced in linux
2.1.32 when trap_a{0,1,2} fields were inserted into struct pt_regs on
alpha without an appropriate dpf_reg() update.

Before 2.1.32 (back to 2.1.7 when dpf_reg() was introduced)
there was another off-by-one bug in dpf_reg(): r16 was written
into struct pt_regs.r17.

In other words, the bug is quite old indeed.

You can add
Reported-and-reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: stable@vger.kernel.org # v2.1.32+

> CC: Dmitry V. Levin <gentoo.dl@altlinux.org>

This is a technical address, please remove it.

> CC: Richard Henderson <rth@twiddle.net>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> CC: Matt Turner <mattst88@gmail.com>
> CC: linux-alpha@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Reported-by: Dmitry V. Levin
> Bug: https://bugs.gentoo.org/672040
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  arch/alpha/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index d73dc473fbb9..188fc9256baf 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -78,7 +78,7 @@ __load_new_mm_context(struct mm_struct *next_mm)
>  /* Macro for exception fixup code to access integer registers.  */
>  #define dpf_reg(r)							\
>  	(((unsigned long *)regs)[(r) <=3D 8 ? (r) : (r) <=3D 15 ? (r)-16 :	\
> -				 (r) <=3D 18 ? (r)+8 : (r)-10])
> +				 (r) <=3D 18 ? (r)+10 : (r)-10])
> =20
>  asmlinkage void
>  do_page_fault(unsigned long address, unsigned long mmcsr,
> --=20
> 2.20.1

--=20
ldv

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcKXSrAAoJEAVFT+BVnCUI0J8P/j/xCYbqq6l7cMnZ2IEIZ1hG
fr5mV4+8JmL+gHoB3uGw3thvbk1sbXR22Dfn39VggnFgoAg9r0M9WAUXx7HJ0jwV
s7zEHePg3UQDHvPb4DlMgVnHrPqZbBmLUvQEIIXTqCZ8z3mZB3ROD28kspRxLCX1
xbvEpsvXdDfqAVhfAWSXA9NAEHRumDWPRsVaIcagrp9olwv6NI4A2vB5WRNcY2Bb
858VReUuam2TGQ8OyR2VkgTaFZAG5LSGe3JfGBDNgNE0ceRHEK+YA788Yr5gm6tv
Si+gyqFvjlmjK+CwGOES5jxIifG0a/pw4DfPec2u5mlGB7GjGVni+GGSbn+XD9pU
FSpyyc7/MS77H1W2Lu/l2ysz33N2J3FAMA4E8rpQEKmFfI0iRStWdqkh+CGp5seB
e2Iu/cJ3OuRMSG84S9Y2cJ7Fcs9vaKuJQ4gKO3y1y/F3U/g8ca8UbsuweWnLmY04
DdF9TRf/HjXaD6eh6GfQo6QnxvBbLPc/jD/499BI9EyHa49v7hGQiKtpSP76Xo0T
/ZycmcD+qeuXcKLuhpQyU64CpEbLZ10d4mbsajcne88Y7Ub0r/OChxBNB991XCT/
GaM66D9jkNNmLiy2d3z8z2fX9KtdcuF+K46MUknJRvpc0J64m9ITiWkDiSPA3M24
yEnKi9EuadAEuQRH5h/N
=3Aks
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
