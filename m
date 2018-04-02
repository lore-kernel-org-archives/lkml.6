Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeDBXXd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:23:33 -0400
Received: from ozlabs.org ([103.22.144.67]:52709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDBXXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:23:32 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 09:22:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with Linus' tree
Message-ID: <20180403092218.1de5bec1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4sGoDLzz+T_tswFGPHscXKC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4sGoDLzz+T_tswFGPHscXKC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  lib/Kconfig.debug

between commits:

  f07cbebb6daf ("locking/Kconfig: Add LOCK_DEBUGGING_SUPPORT to make it mor=
e readable")
  19193bcad8dc ("locking/Kconfig: Restructure the lock debugging menu")

from Linus' tree and commit:

  a687a5337063 ("treewide: simplify Kconfig dependencies for removed archs")

from the asm-generic tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/Kconfig.debug
index 40f45144320a,6927c6d8d185..000000000000
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -1107,80 -1164,6 +1104,80 @@@ config LOCK_STA
  	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
  	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
 =20
 +config DEBUG_RT_MUTEXES
 +	bool "RT Mutex debugging, deadlock detection"
 +	depends on DEBUG_KERNEL && RT_MUTEXES
 +	help
 +	 This allows rt mutex semantics violations and rt mutex related
 +	 deadlocks (lockups) to be detected and reported automatically.
 +
 +config DEBUG_SPINLOCK
 +	bool "Spinlock and rw-lock debugging: basic checks"
 +	depends on DEBUG_KERNEL
 +	select UNINLINE_SPIN_UNLOCK
 +	help
 +	  Say Y here and build SMP to catch missing spinlock initialization
 +	  and certain other kinds of spinlock errors commonly made.  This is
 +	  best used in conjunction with the NMI watchdog so that spinlock
 +	  deadlocks are also debuggable.
 +
 +config DEBUG_MUTEXES
 +	bool "Mutex debugging: basic checks"
 +	depends on DEBUG_KERNEL
 +	help
 +	 This feature allows mutex semantics violations to be detected and
 +	 reported.
 +
 +config DEBUG_WW_MUTEX_SLOWPATH
 +	bool "Wait/wound mutex debugging: Slowpath testing"
 +	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 +	select DEBUG_LOCK_ALLOC
 +	select DEBUG_SPINLOCK
 +	select DEBUG_MUTEXES
 +	help
 +	 This feature enables slowpath testing for w/w mutex users by
 +	 injecting additional -EDEADLK wound/backoff cases. Together with
 +	 the full mutex checks enabled with (CONFIG_PROVE_LOCKING) this
 +	 will test all possible w/w mutex interface abuse with the
 +	 exception of simply not acquiring all the required locks.
 +	 Note that this feature can introduce significant overhead, so
 +	 it really should not be enabled in a production or distro kernel,
 +	 even a debug kernel.  If you are a driver writer, enable it.  If
 +	 you are a distro, do not.
 +
 +config DEBUG_RWSEMS
 +	bool "RW Semaphore debugging: basic checks"
 +	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
 +	help
 +	  This debugging feature allows mismatched rw semaphore locks and unlocks
 +	  to be detected and reported.
 +
 +config DEBUG_LOCK_ALLOC
 +	bool "Lock debugging: detect incorrect freeing of live locks"
 +	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 +	select DEBUG_SPINLOCK
 +	select DEBUG_MUTEXES
 +	select DEBUG_RT_MUTEXES if RT_MUTEXES
 +	select LOCKDEP
 +	help
 +	 This feature will check whether any held lock (spinlock, rwlock,
 +	 mutex or rwsem) is incorrectly freed by the kernel, via any of the
 +	 memory-freeing routines (kfree(), kmem_cache_free(), free_pages(),
 +	 vfree(), etc.), whether a live lock is incorrectly reinitialized via
 +	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
 +	 held during task exit.
 +
 +config LOCKDEP
 +	bool
 +	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 +	select STACKTRACE
- 	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROB=
LAZE && !ARC && !SCORE && !X86
++	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROB=
LAZE && !ARC && !X86
 +	select KALLSYMS
 +	select KALLSYMS_ALL
 +
 +config LOCKDEP_SMALL
 +	bool
 +
  config DEBUG_LOCKDEP
  	bool "Lock dependency engine debugging"
  	depends on DEBUG_KERNEL && LOCKDEP

--Sig_/4sGoDLzz+T_tswFGPHscXKC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrCuyoACgkQAVBC80lX
0GxOUQf/eXA1Z0vil/ZJ12ruUiAMkyavF6bt5m5giv4Q0UM3H/R/eVEl7Or6axnp
DfehjzwGQ0otE6V8nKGFXUN1rrwU206h6R4SFVM5bYyMsgy3ru0CIInIEJQyV/fv
DlfoJxYMW58all4Vjs79IMXpPhU1huCBjvzHW4+VKwB2FP5qJYn9zp/NDhKxuEER
6rH7P5ugvZ5Nd44gIpp/ErC/5HObJxe/jgft+BIgltYMkBi4Ea4iJGnT9GZCvMXi
+lWMLZAcf12Yzp2HvYK/J855YfADPgtMibcv/oR0Tw8NVBGlJLGJHZohT7WozQLj
5ZJw1H3SJetlFdEo3w5O5HbQdxtdOA==
=jBOq
-----END PGP SIGNATURE-----

--Sig_/4sGoDLzz+T_tswFGPHscXKC--
