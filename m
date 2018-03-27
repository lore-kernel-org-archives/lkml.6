Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeC0H1J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:27:09 -0400
Received: from ozlabs.org ([103.22.144.67]:33333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeC0H1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:27:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 27 Mar 2018 18:26:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the y2038 tree
Message-ID: <20180327182619.745e28b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_bPO/pHG2AGpxZj7AkK4wis"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_bPO/pHG2AGpxZj7AkK4wis
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

After merging the y2038 tree, today's linux-next build (sparc defconfig)
failed like this:

In file included from include/linux/compat.h:22:0,
                 from arch/sparc/kernel/systbls.h:7,
                 from arch/sparc/kernel/sys_sparc_32.c:30:
arch/sparc/include/asm/compat.h: In function 'arch_compat_alloc_user_space':
arch/sparc/include/asm/compat.h:162:46: error: 'struct thread_info' has no =
member named 'kregs'
  struct pt_regs *regs =3D current_thread_info()->kregs;
                                              ^~
arch/sparc/include/asm/compat.h:165:6: error: implicit declaration of funct=
ion 'test_thread_64bit_stack'; did you mean 'setup_thread_stack'? [-Werror=
=3Dimplicit-function-declaration]
  if (test_thread_64bit_stack(usp))
      ^~~~~~~~~~~~~~~~~~~~~~~
      setup_thread_stack
In file included from include/asm-generic/preempt.h:5:0,
                 from ./arch/sparc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:81,
                 from include/linux/rcupdate.h:40,
                 from include/linux/rculist.h:11,
                 from include/linux/sched/signal.h:5,
                 from arch/sparc/kernel/sys_sparc_32.c:11:
arch/sparc/include/asm/compat.h:168:23: error: 'TIF_32BIT' undeclared (firs=
t use in this function); did you mean 'MAP_32BIT'?
  if (test_thread_flag(TIF_32BIT))
                       ^
include/linux/thread_info.h:91:45: note: in definition of macro 'test_threa=
d_flag'
  test_ti_thread_flag(current_thread_info(), flag)
                                             ^~~~
arch/sparc/include/asm/compat.h:168:23: note: each undeclared identifier is=
 reported only once for each function it appears in
  if (test_thread_flag(TIF_32BIT))
                       ^
include/linux/thread_info.h:91:45: note: in definition of macro 'test_threa=
d_flag'
  test_ti_thread_flag(current_thread_info(), flag)
                                             ^~~~
arch/sparc/include/asm/compat.h: In function 'is_compat_task':
arch/sparc/include/asm/compat.h:237:26: error: 'TIF_32BIT' undeclared (firs=
t use in this function); did you mean 'MAP_32BIT'?
  return test_thread_flag(TIF_32BIT);
                          ^
include/linux/thread_info.h:91:45: note: in definition of macro 'test_threa=
d_flag'
  test_ti_thread_flag(current_thread_info(), flag)
                                             ^~~~
In file included from include/linux/compat.h:22:0,
                 from arch/sparc/kernel/systbls.h:7,
                 from arch/sparc/kernel/sys_sparc_32.c:30:
arch/sparc/include/asm/compat.h: In function 'in_compat_syscall':
arch/sparc/include/asm/compat.h:243:9: error: implicit declaration of funct=
ion 'pt_regs_trap_type'; did you mean 'resource_type'? [-Werror=3Dimplicit-=
function-declaration]
  return pt_regs_trap_type(current_pt_regs()) =3D=3D 0x110;
         ^~~~~~~~~~~~~~~~~
         resource_type

and lots more :-(

I suspect it is caused by commit

  d1a353a4a8cc ("compat: add an asm-generic/compat.h file")

It looks like the sparc asm/compat.h does not expect to be included in
32 bit builds?

I have reverted the entire y2038 tree merge for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_bPO/pHG2AGpxZj7AkK4wis
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq58hsACgkQAVBC80lX
0GyP8wf9Euk2d8wNufrRxMl5o04ZRVuFY1GXEv94czR0ERQHJ2AS0zr6Q2PowIXE
rrEFDngIQJMMFCFP4Fqoa4RqzOHkjli12EssrNQtN4hFRSqi40Q07/Obz8gT6IQK
n6Y3QviPeIEN3FhwU02RUOdWDo6tLW0H+WYvUxzhC1v3gOI7Ub0+pndSotWnmoQV
yOFRYOCwte5aqOgsdMlOfUp0BJTHO133jFI3DjieBtjW5MNQOC+dxAhTibDB5sVq
2GCW3dqMLqoVxJhRaRfKEsH0EzjSLUk/EKDEgpfPC6Ia/BzY52AvrsBxcVtwV/bg
vtXLRwrk1aChIKGOYRKJKaqCixZn/A==
=CzDR
-----END PGP SIGNATURE-----

--Sig_/_bPO/pHG2AGpxZj7AkK4wis--
