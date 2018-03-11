Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeCKLCP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:02:15 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54290 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbeCKK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:51 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 00/35] remove in-kernel syscall invocations
Date: Sun, 11 Mar 2018 11:55:22 +0100
Message-Id: <20180311105557.20807-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a first set of patches which reduce the number of syscall invocations
from within the kernel.

The rationale for this change is described in patch 1 as follows:

	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
	through kernel entry points, but not from the kernel itself. This
	will allow cleanups and optimizations to the entry paths *and* to
	the parts of the kernel code which currently need to pretend to be
	userspace in order to make use of syscalls.

Two patches make use of existing kernel functions which can be used instead
of sys_xyzzy():

	syscalls: use kernel_wait4() instead of sys_wait4()
	syscalls: mm_release(): use do_futex() instead of sys_futex()

Another set of patches is closely limited in scope, as all callers were in
the same file:

	syscalls: do not call sys_getpgid() within the kernel
	syscalls: do not call sys_readlinkat() within the kernel
	syscalls: do not call sys_pipe2() within the kernel
	syscalls: do not call sys_renameat2() within the kernel
	syscalls: do not call sys_futimesat() within the kernel
	syscalls: do not call sys_epoll_*() within the kernel
	syscalls: do not call sys_signalfd4() within the kernel
	syscalls: do not call sys_eventfd2() within the kernel

A few special cases:

	syscalls: do not call sys_rt_sigpending() within the kernel
	syscalls: do not call sys_ioperm() within the kernel
	hostfs: rename do_rmdir() to hostfs_do_rmdir()

Then, a few patches are simple wrappers/indirections, with ksys_xyzzy() to
be called within the kernel.

	syscalls: do not call sys_mount() within the kernel
	syscalls: do not call sys_umount() within the kernel
	syscalls: do not call sys_dup{,3}() within the kernel
	syscalls: do not call sys_chroot() within the kernel
	syscalls: do not call sys_write() within the kernel
	syscalls: do not call sys_unshare() within the kernel
	syscalls: do not call sys_fadvise64{,_64}() within the kernel
	syscalls: do not call sys_mmap_pgoff() within the kernel
	syscalls: do not call sys_chdir() within the kernel
	syscalls: do not call sys_sync_file_range() within the kernel

I'm a bit more unsure about these remaining patches. They use inline stubs
named ksys_xyzzy() which (mostly) call fs-internal functions. Another
alternative would be to define these in fs/*, but then we'd get more and
more indirections.

	syscalls: do not call sys_unlink() within the kernel
	syscalls: do not call sys_rmdir() within the kernel
	syscalls: do not call sys_mkdir{,at}() within the kernel
	syscalls: do not call sys_symlink{,at}() within the kernel
	syscalls: do not call sys_mknod{,at}() within the kernel
	syscalls: do not call sys_link{,at}() within the kernel
	syscalls: do not call sys_{f,}chmod{at,}() within the kernel
	syscalls: do not call sys_{f,}access{,at}() within the kernel
	syscalls: do not call sys_ftruncate() within the kernel
	syscalls: do not call sys_{,l,f}chown() within the kernel
	syscalls: do not call sys_close() within the kernel

Thanks,
	Dominik

Dominik Brodowski (35):
  syscalls: define goal to not call sys_xyzzy() from within the kernel
  syscalls: use kernel_wait4() instead of sys_wait4()
  syscalls: mm_release(): use do_futex() instead of sys_futex()
  syscalls: do not call sys_getpgid() within the kernel
  syscalls: do not call sys_readlinkat() within the kernel
  syscalls: do not call sys_pipe2() within the kernel
  syscalls: do not call sys_renameat2() within the kernel
  syscalls: do not call sys_futimesat() within the kernel
  syscalls: do not call sys_epoll_*() within the kernel
  syscalls: do not call sys_signalfd4() within the kernel
  syscalls: do not call sys_eventfd2() within the kernel
  syscalls: do not call sys_rt_sigpending() within the kernel
  syscalls: do not call sys_ioperm() within the kernel
  syscalls: do not call sys_mount() within the kernel
  syscalls: do not call sys_umount() within the kernel
  syscalls: do not call sys_dup{,3}() within the kernel
  syscalls: do not call sys_chroot() within the kernel
  syscalls: do not call sys_write() within the kernel
  syscalls: do not call sys_unshare() within the kernel
  syscalls: do not call sys_fadvise64{,_64}() within the kernel
  syscalls: do not call sys_mmap_pgoff() within the kernel
  syscalls: do not call sys_chdir() within the kernel
  syscalls: do not call sys_sync_file_range() within the kernel
  syscalls: do not call sys_unlink() within the kernel
  hostfs: rename do_rmdir() to hostfs_do_rmdir()
  syscalls: do not call sys_rmdir() within the kernel
  syscalls: do not call sys_mkdir{,at}() within the kernel
  syscalls: do not call sys_symlink{,at}() within the kernel
  syscalls: do not call sys_mknod{,at}() within the kernel
  syscalls: do not call sys_link{,at}() within the kernel
  syscalls: do not call sys_{f,}chmod{at,}() within the kernel
  syscalls: do not call sys_{f,}access{,at}() within the kernel
  syscalls: do not call sys_ftruncate() within the kernel
  syscalls: do not call sys_{,l,f}chown() within the kernel
  syscalls: do not call sys_close() within the kernel

 Documentation/process/adding-syscalls.rst |  14 ----
 arch/alpha/kernel/osf_sys.c               |   2 +-
 arch/arm/kernel/sys_arm.c                 |   2 +-
 arch/arm64/kernel/sys.c                   |   2 +-
 arch/cris/kernel/sys_cris.c               |   2 +-
 arch/frv/kernel/sys_frv.c                 |   4 +-
 arch/ia64/kernel/sys_ia64.c               |   4 +-
 arch/m68k/kernel/sys_m68k.c               |   2 +-
 arch/metag/kernel/sys_metag.c             |   8 +--
 arch/microblaze/kernel/sys_microblaze.c   |   6 +-
 arch/mips/kernel/linux32.c                |  10 +--
 arch/mips/kernel/syscall.c                |   6 +-
 arch/mn10300/kernel/sys_mn10300.c         |   3 +-
 arch/parisc/kernel/sys_parisc.c           |  14 ++--
 arch/powerpc/kernel/sys_ppc32.c           |   8 +--
 arch/powerpc/kernel/syscalls.c            |   6 +-
 arch/riscv/kernel/sys_riscv.c             |   4 +-
 arch/s390/kernel/compat_linux.c           |  23 ++++---
 arch/s390/kernel/sys_s390.c               |   2 +-
 arch/score/kernel/sys_score.c             |   5 +-
 arch/sh/kernel/sys_sh.c                   |   4 +-
 arch/sh/kernel/sys_sh32.c                 |   8 +--
 arch/sparc/kernel/sys_sparc32.c           |  14 ++--
 arch/sparc/kernel/sys_sparc_32.c          |   6 +-
 arch/sparc/kernel/sys_sparc_64.c          |   2 +-
 arch/tile/kernel/compat.c                 |   4 +-
 arch/tile/kernel/sys.c                    |  12 ++--
 arch/um/kernel/syscall.c                  |   2 +-
 arch/x86/ia32/sys_ia32.c                  |  22 +++---
 arch/x86/include/asm/syscalls.h           |   1 +
 arch/x86/kernel/ioport.c                  |   7 +-
 arch/x86/kernel/sys_x86_64.c              |   2 +-
 arch/xtensa/kernel/syscall.c              |   2 +-
 drivers/base/devtmpfs.c                   |  11 +--
 drivers/tty/vt/vt_ioctl.c                 |   6 +-
 fs/autofs4/dev-ioctl.c                    |   2 +-
 fs/binfmt_misc.c                          |   2 +-
 fs/eventfd.c                              |   9 ++-
 fs/eventpoll.c                            |  23 +++++--
 fs/file.c                                 |  17 ++++-
 fs/hostfs/hostfs.h                        |   2 +-
 fs/hostfs/hostfs_kern.c                   |   2 +-
 fs/hostfs/hostfs_user.c                   |   2 +-
 fs/internal.h                             |  14 ++++
 fs/namei.c                                |  61 ++++++++++++-----
 fs/namespace.c                            |  19 ++++--
 fs/open.c                                 |  67 ++++++++++++++----
 fs/pipe.c                                 |   9 ++-
 fs/read_write.c                           |   9 ++-
 fs/signalfd.c                             |  14 ++--
 fs/stat.c                                 |  12 +++-
 fs/sync.c                                 |  12 +++-
 fs/utimes.c                               |  13 +++-
 include/linux/syscalls.h                  | 109 +++++++++++++++++++++++++++++-
 init/do_mounts.c                          |  12 ++--
 init/do_mounts.h                          |   4 +-
 init/do_mounts_initrd.c                   |  34 +++++-----
 init/do_mounts_md.c                       |   8 +--
 init/do_mounts_rd.c                       |  12 ++--
 init/initramfs.c                          |  42 ++++++------
 init/main.c                               |   7 +-
 init/noinitramfs.c                        |   6 +-
 kernel/exit.c                             |   2 +-
 kernel/fork.c                             |  11 ++-
 kernel/pid_namespace.c                    |   6 +-
 kernel/signal.c                           |  13 +++-
 kernel/sys.c                              |   9 ++-
 kernel/uid16.c                            |   6 +-
 kernel/umh.c                              |   2 +-
 mm/fadvise.c                              |  10 ++-
 mm/mmap.c                                 |  17 +++--
 mm/nommu.c                                |  17 +++--
 72 files changed, 572 insertions(+), 274 deletions(-)

-- 
2.16.2
