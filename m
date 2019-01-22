Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DFCC282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EB02085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LvJ36mw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfAVDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:10:32 -0500
Received: from ozlabs.org ([203.11.71.1]:46393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfAVDKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:10:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kD1w2XNLz9s1l;
        Tue, 22 Jan 2019 14:10:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548126628;
        bh=H8H25G9IoocJEf3aZ3mfveIez6jB1Mb/0xRKKkDAVjU=;
        h=Date:From:To:Cc:Subject:From;
        b=LvJ36mw3YKx4+YAIfws/3FY0JDHjGqEAsBzNJI3Hgfft1eV1lu+kSsoo6M0aOlLMt
         /E4cGS/J/stf1h4DVQ6omfLvgKnftI4/6bod9tiZr01xckCJ7lG8Q5lgq+spnq7KCB
         JrzNtbU3VcfBbG0WdHOH6vN4ghKFuCYnl4cHhRgeXmi3B70/5pmQS4DpJzzBbOYBTD
         FenyiFm1oylFkty1h2Wo3jrqvDdG1uYQh838YLNHqnUX7a9tu/OLbj78QRsuRfA8qk
         V92lMuJmWqW3pQf6lrwGTW0mp89nkRv3s98RwCBfa1E0PLO0n7A7hxY1uP8rlEGRm4
         ChaRKhO4HWOcw==
Date:   Tue, 22 Jan 2019 14:10:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122141027.70cd9166@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zYc/Rs75.ZysOvqrP2lxt6X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zYc/Rs75.ZysOvqrP2lxt6X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got conflicts in:

  arch/x86/entry/syscalls/syscall_32.tbl
  arch/x86/entry/syscalls/syscall_64.tbl
  include/uapi/asm-generic/unistd.h

between commits:

  63a96220ad45 ("arch: add split IPC system calls where needed")
  0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectu=
res")

from the y2038 tree and commit:

  3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")

from the pidfd tree.

I fixed it up (I hope this resolution is better - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index 955ab6a3b61f,6804c1e84b36..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -396,36 -396,6 +396,37 @@@
  382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
  383	i386	statx			sys_statx			__ia32_sys_statx
  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 -385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 +385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pge=
tevents
  386	i386	rseq			sys_rseq			__ia32_sys_rseq
 -387	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_s=
ignal
 +# don't use numbers 387 through 392, add new calls at the end
 +393	i386	semget			sys_semget    			__ia32_sys_semget
 +394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
 +395	i386	shmget			sys_shmget    			__ia32_sys_shmget
 +396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
 +397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
 +398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
 +399	i386	msgget			sys_msgget    			__ia32_sys_msgget
 +400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
 +401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
 +402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
 +403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
 +404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
 +405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
 +406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
 +407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nan=
osleep
 +408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
 +409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
 +410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
 +411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
 +412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
 +413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
 +414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
 +416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
 +417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
 +418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
 +419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedr=
eceive
 +420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
 +421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt=
_sigtimedwait_time64
 +422	i386	futex_time64		sys_futex			__ia32_sys_futex
 +423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sy=
s_sched_rr_get_interval
++424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_s=
ignal
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 2ae92fddb6d5,aa4b858fa0f1..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -343,8 -343,7 +343,9 @@@
  332	common	statx			__x64_sys_statx
  333	common	io_pgetevents		__x64_sys_io_pgetevents
  334	common	rseq			__x64_sys_rseq
 -335	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
 +# don't use numbers 387 through 423, add new calls after the last
 +# 'common' entry
++424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
 =20
  #
  # x32-specific system call numbers start at 512 to avoid cache impact
diff --cc include/uapi/asm-generic/unistd.h
index acf9a07ab2ff,b77538af7aca..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -740,52 -740,11 +740,54 @@@ __SC_COMP_3264(__NR_io_pgetevents, sys_
  __SYSCALL(__NR_rseq, sys_rseq)
  #define __NR_kexec_file_load 294
  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 -#define __NR_pidfd_send_signal 295
 +/* 295 through 402 are unassigned to sync up with generic numbers, don't =
use */
 +#if __BITS_PER_LONG =3D=3D 32
 +#define __NR_clock_gettime64 403
 +__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
 +#define __NR_clock_settime64 404
 +__SYSCALL(__NR_clock_settime64, sys_clock_settime)
 +#define __NR_clock_adjtime64 405
 +__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
 +#define __NR_clock_getres_time64 406
 +__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
 +#define __NR_clock_nanosleep_time64 407
 +__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
 +#define __NR_timer_gettime64 408
 +__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
 +#define __NR_timer_settime64 409
 +__SYSCALL(__NR_timer_settime64, sys_timer_settime)
 +#define __NR_timerfd_gettime64 410
 +__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
 +#define __NR_timerfd_settime64 411
 +__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
 +#define __NR_utimensat_time64 412
 +__SYSCALL(__NR_utimensat_time64, sys_utimensat)
 +#define __NR_pselect6_time64 413
 +__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 +#define __NR_ppoll_time64 414
 +__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 +#define __NR_io_pgetevents_time64 416
 +__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
 +#define __NR_recvmmsg_time64 417
 +__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 +#define __NR_mq_timedsend_time64 418
 +__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
 +#define __NR_mq_timedreceive_time64 419
 +__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
 +#define __NR_semtimedop_time64 420
 +__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
 +#define __NR_rt_sigtimedwait_time64 421
 +__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt=
_sigtimedwait_time64)
 +#define __NR_futex_time64 422
 +__SYSCALL(__NR_futex_time64, sys_futex)
 +#define __NR_sched_rr_get_interval_time64 423
 +__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 +#endif
++#define __NR_pidfd_send_signal 424
+ __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
 =20
  #undef __NR_syscalls
- #define __NR_syscalls 424
 -#define __NR_syscalls 296
++#define __NR_syscalls 425
 =20
  /*
   * 32 bit systems traditionally used different

--Sig_/zYc/Rs75.ZysOvqrP2lxt6X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxGiaMACgkQAVBC80lX
0GxQNAgAmF409fuGYsAFwKEcZ85DUpo/XRHJreQ+mE5K4lI1uuIID/0x6Ii3ylzk
/B7qc2/LdJEHb4MnvxRoW/yRgSu7+Erq6TfZ1n7Iyyi1ZPqZ+j7jJO8Z5te9qs2x
MeTMtiijdp4Jm4UT3lftiBfhDbJjKhqaemCTPZQuCPX1xluKa0GnVKjCBw9d3gbV
8jD7faWn8hlFB2IawIgLi3JaFzTJfTYF3TwLebkC5s0cYedQ2mkse1r3oj0VQBU4
i8ICppghV6i1giPwgNhlvnzYPXIIfznxANi2UYUYuhu1sRwcnKBtYOH5jqn16s6q
fNoWZNX3+jRJZ9dS5DENazqljOtnoA==
=GtWb
-----END PGP SIGNATURE-----

--Sig_/zYc/Rs75.ZysOvqrP2lxt6X--
