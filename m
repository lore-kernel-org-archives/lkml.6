Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EA5C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BF52175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nXQXQnay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfBMCmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:42:45 -0500
Received: from ozlabs.org ([203.11.71.1]:44301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389383AbfBMCly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zkLh2bzcz9sNj;
        Wed, 13 Feb 2019 13:41:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550025710;
        bh=m/BFBgAmgTBMaBynxIIcl231S3Ugph5nvUhsthnrxHU=;
        h=Date:From:To:Cc:Subject:From;
        b=nXQXQnayQe1bHbtG90LA2ttXAZanIpx0aYL5+lGiR2tyWnk4jypE9xlGDShTUbkZj
         xi0J0H8K2JMhVhBsmVcVog4xzQZvRL0oAikUVb9AFgx7c6VMCju9bjFXTJhCSQafgr
         UTar8SVo7eEKFj+4EChkPyVyHvWWJyqWK7dqr7ISRDkQ423AZKXwZf7cW/lBfrqf0P
         hs9E9QsxDx5ilAEgauFXPXhi+2Wnud7nmOyJgVRYZLIyW6yHSmG83jRIO+Ft+39gdd
         eauwk4mmKTPfq9eoP6SIj1ZKp6Xr39Zu1FXWHWsJrA1zJRGuFc1gvmSkZSyjCC0AM3
         f8H+p7s+Cb9JA==
Date:   Wed, 13 Feb 2019 13:41:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the tip tree with the block tree
Message-ID: <20190213134145.48903adf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/waRyAvyCkth3vx0O_p=2EAA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/waRyAvyCkth3vx0O_p=2EAA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  arch/x86/entry/syscalls/syscall_32.tbl
  arch/x86/entry/syscalls/syscall_64.tbl
  include/uapi/asm-generic/unistd.h

between commits:

  1690d3ffa284 ("Add io_uring IO interface")
  0e5d5b5a94c8 ("io_uring: add support for pre-mapped user IO buffers")

from the block tree and commits:

  0d6040d46817 ("arch: add split IPC system calls where needed")

and folloing ones

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index 2eefd2a7c1ce,955ab6a3b61f..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -396,8 -396,36 +396,39 @@@
  382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
  383	i386	statx			sys_statx			__ia32_sys_statx
  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
- 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
+ 385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pge=
tevents
  386	i386	rseq			sys_rseq			__ia32_sys_rseq
+ # don't use numbers 387 through 392, add new calls at the end
+ 393	i386	semget			sys_semget    			__ia32_sys_semget
+ 394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
+ 395	i386	shmget			sys_shmget    			__ia32_sys_shmget
+ 396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
+ 397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
+ 398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
+ 399	i386	msgget			sys_msgget    			__ia32_sys_msgget
+ 400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
+ 401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
+ 402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
+ 403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
+ 404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
+ 405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
+ 406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
+ 407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nan=
osleep
+ 408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
+ 409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
+ 410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
+ 411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
+ 412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
+ 413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
+ 414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
+ 416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
+ 417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
+ 418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
+ 419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedr=
eceive
+ 420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
+ 421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt=
_sigtimedwait_time64
+ 422	i386	futex_time64		sys_futex			__ia32_sys_futex
+ 423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sy=
s_sched_rr_get_interval
 +425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 +426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 +427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_reg=
ister
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 65c026185e61,2ae92fddb6d5..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -343,9 -343,8 +343,11 @@@
  332	common	statx			__x64_sys_statx
  333	common	io_pgetevents		__x64_sys_io_pgetevents
  334	common	rseq			__x64_sys_rseq
+ # don't use numbers 387 through 423, add new calls after the last
+ # 'common' entry
 +425	common	io_uring_setup		__x64_sys_io_uring_setup
 +426	common	io_uring_enter		__x64_sys_io_uring_enter
 +427	common	io_uring_register	__x64_sys_io_uring_register
 =20
  #
  # x32-specific system call numbers start at 512 to avoid cache impact
diff --cc include/uapi/asm-generic/unistd.h
index d346229a1eb0,acf9a07ab2ff..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -740,15 -740,52 +740,58 @@@ __SC_COMP_3264(__NR_io_pgetevents, sys_
  __SYSCALL(__NR_rseq, sys_rseq)
  #define __NR_kexec_file_load 294
  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+ /* 295 through 402 are unassigned to sync up with generic numbers, don't =
use */
+ #if __BITS_PER_LONG =3D=3D 32
+ #define __NR_clock_gettime64 403
+ __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+ #define __NR_clock_settime64 404
+ __SYSCALL(__NR_clock_settime64, sys_clock_settime)
+ #define __NR_clock_adjtime64 405
+ __SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+ #define __NR_clock_getres_time64 406
+ __SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+ #define __NR_clock_nanosleep_time64 407
+ __SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+ #define __NR_timer_gettime64 408
+ __SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+ #define __NR_timer_settime64 409
+ __SYSCALL(__NR_timer_settime64, sys_timer_settime)
+ #define __NR_timerfd_gettime64 410
+ __SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+ #define __NR_timerfd_settime64 411
+ __SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+ #define __NR_utimensat_time64 412
+ __SYSCALL(__NR_utimensat_time64, sys_utimensat)
+ #define __NR_pselect6_time64 413
+ __SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+ #define __NR_ppoll_time64 414
+ __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+ #define __NR_io_pgetevents_time64 416
+ __SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+ #define __NR_recvmmsg_time64 417
+ __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+ #define __NR_mq_timedsend_time64 418
+ __SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+ #define __NR_mq_timedreceive_time64 419
+ __SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+ #define __NR_semtimedop_time64 420
+ __SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+ #define __NR_rt_sigtimedwait_time64 421
+ __SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt=
_sigtimedwait_time64)
+ #define __NR_futex_time64 422
+ __SYSCALL(__NR_futex_time64, sys_futex)
+ #define __NR_sched_rr_get_interval_time64 423
+ __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+ #endif
 +#define __NR_io_uring_setup 425
 +__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 +#define __NR_io_uring_enter 426
 +__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 +#define __NR_io_uring_register 427
 +__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 =20
  #undef __NR_syscalls
 -#define __NR_syscalls 424
 +#define __NR_syscalls 428
 =20
  /*
   * 32 bit systems traditionally used different

--Sig_/waRyAvyCkth3vx0O_p=2EAA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjg+kACgkQAVBC80lX
0GzutQf/SxFsrvVPkBJ3Em4r+OE9Fnt5BurlSeLDNU7aYv3hskk/NgmAi/gl4Axk
WYQcaBjxuiaWDz7316tYMnOicRsXAwlfmhThKRjbucjkyTHEWMFRpSzeAXgTprVh
ajgn6LImLO6weys2fAbdI9TSuU3NRKkayDkVzvIrHyeIJx0SbSEmg/plGXtPRWhP
vWiyZD/iO3abHQ6rwq15Ix7wPoifaJcOjYrSmYH33OF8JZU+CZEQkIwQuUJHk24p
eBhgY/3lGnzY6pEzc+bPEMNd3sGT6eYARx5Db8O9BsV3MIUfDfOO3DtkpcrgEI4o
1ysTyaWE4rnIYgAGyXAovQoHnHrXLQ==
=v93I
-----END PGP SIGNATURE-----

--Sig_/waRyAvyCkth3vx0O_p=2EAA--
