Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeCOTHy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:07:54 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36298 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932678AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
Date: Thu, 15 Mar 2018 20:04:53 +0100
Message-Id: <20180315190529.20943-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a re-spin of the first set of patches which reduce the number of
syscall invocations from within the kernel; the RFC may be found at

The rationale for this change is described in patch 1 as follows:

	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
	through kernel entry points, but not from the kernel itself. This
	will allow cleanups and optimizations to the entry paths *and* to
	the parts of the kernel code which currently need to pretend to be
	userspace in order to make use of syscalls.

The whole series can be found at 

	https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next

and will be submitted for merging for the v4.17-rc1 cycle, probably together
with another batch of related patches I hope to send out tomorrow as a RFC.

Changes since the RFC / v1:

- rebase to v4.15-rc5; sys_ioperm already got its SYSCALL_DEFINE3
- add ACKs
- CC: -> Cc: (suggested by Ingo Molnar)
- update comment in include/linux/syscalls.h (suggested by Ingo Molnar and
	Andy Lutomirski)
- separate declarations from definitions with newlines in
	include/linux/syscalls.h; add comment on ksys_close() (suggested by
	Ingo Molnar)
- expand commit messages (suggested by Christoph Hellwig)
- include patch 36:
	fs: add ksys_open() wrapper; remove in-kernel calls to sys_open()
- do not worry about the following archs, as they are going away:
	cris, frv, metag, mn10300, score, tile
	(solving conflicts in -next)
- fix builds with CONFIG_FUTEX=n, CONFIG_ADVISE_SYSCALLS=n (solving issues
	found by Stephen Rothwell)

Thanks,
	Dominik


Dominik Brodowski (36):
  syscalls: define goal to not call sys_xyzzy() from within the kernel
  kernel: use kernel_wait4() instead of sys_wait4()
  mm: use do_futex() instead of sys_futex() in mm_release()
  kernel: add do_getpgid() helper; remove internal call to sys_getpgid()
  fs: add do_readlinkat() helper; remove internal call to
    sys_readlinkat()
  fs: add do_pipe2() helper; remove internal call to sys_pipe2()
  fs: add do_renameat2() helper; remove internal call to sys_renameat2()
  fs: add do_futimesat() helper; remove internal call to sys_futimesat()
  syscalls: add do_epoll_*() helpers; remove internal calls to
    sys_epoll_*()
  fs: add do_signalfd4() helper; remove internal calls to
    sys_signalfd4()
  fs: add do_eventfd() helper; remove internal call to sys_eventfd()
  kernel: open-code sys_rt_sigpending() in sys_sigpending()
  x86/ioport: add ksys_ioperm() helper; remove in-kernel calls to
    sys_ioperm()
  fs: add ksys_mount() helper; remove in-kernel calls to sys_mount()
  fs: add ksys_umount() helper; remove in-kernel call to sys_umount()
  fs: add ksys_dup{,3}() helper; remove in-kernel calls to sys_dup{,3}()
  fs: add ksys_chroot() helper; remove-in kernel calls to sys_chroot()
  fs: add ksys_write() helper; remove in-kernel calls to sys_write()
  kernel: add ksys_unshare() helper; remove in-kernel calls to
    sys_unshare()
  mm: add ksys_fadvise64_64() helper; remove in-kernel call to
    sys_fadvise64_64()
  mm: add ksys_mmap_pgoff() helper; remove in-kernel calls to
    sys_mmap_pgoff()
  fs: add ksys_chdir() helper; remove in-kernel calls to sys_chdir()
  fs: add ksys_sync_file_range helper(); remove in-kernel calls to
    syscall
  fs: add ksys_unlink() wrapper; remove in-kernel calls to sys_unlink()
  hostfs: rename do_rmdir() to hostfs_do_rmdir()
  fs: add ksys_rmdir() wrapper; remove in-kernel calls to sys_rmdir()
  fs: add do_mkdirat() helper and ksys_mkdir() wrapper; remove in-kernel
    calls to syscall
  fs: add do_symlinkat() helper and ksys_symlink() wrapper; remove
    in-kernel calls to syscall
  fs: add do_mknodat() helper and ksys_mknod() wrapper; remove in-kernel
    calls to syscall
  fs: add do_linkat() helper and ksys_link() wrapper; remove in-kernel
    calls to syscall
  fs: add ksys_fchmod() and do_fchmodat() helpers and ksys_chmod()
    wrapper; remove in-kernel calls to syscall
  fs: add do_faccessat() helper and ksys_access() wrapper; remove
    in-kernel calls to syscall
  fs: add ksys_ftruncate() wrapper; remove in-kernel calls to
    sys_ftruncate()
  fs: add do_fchownat(), ksys_fchown() helpers and ksys_{,l}chown()
    wrappers
  fs: add ksys_close() wrapper; remove in-kernel calls to sys_close()
  fs: add ksys_open() wrapper; remove in-kernel calls to sys_open()

 Documentation/process/adding-syscalls.rst |  14 ---
 arch/alpha/kernel/osf_sys.c               |   2 +-
 arch/arm/kernel/sys_arm.c                 |   2 +-
 arch/arm64/kernel/sys.c                   |   2 +-
 arch/ia64/kernel/sys_ia64.c               |   4 +-
 arch/m68k/kernel/sys_m68k.c               |   2 +-
 arch/microblaze/kernel/sys_microblaze.c   |   6 +-
 arch/mips/kernel/linux32.c                |  10 +-
 arch/mips/kernel/syscall.c                |   6 +-
 arch/parisc/kernel/sys_parisc.c           |  14 +--
 arch/powerpc/kernel/sys_ppc32.c           |   8 +-
 arch/powerpc/kernel/syscalls.c            |   6 +-
 arch/riscv/kernel/sys_riscv.c             |   4 +-
 arch/s390/kernel/compat_linux.c           |  23 ++---
 arch/s390/kernel/sys_s390.c               |   2 +-
 arch/sh/kernel/sys_sh.c                   |   4 +-
 arch/sh/kernel/sys_sh32.c                 |   8 +-
 arch/sparc/kernel/sys_sparc32.c           |  14 +--
 arch/sparc/kernel/sys_sparc_32.c          |   6 +-
 arch/sparc/kernel/sys_sparc_64.c          |   2 +-
 arch/um/kernel/syscall.c                  |   2 +-
 arch/x86/ia32/sys_ia32.c                  |  22 ++---
 arch/x86/include/asm/syscalls.h           |   1 +
 arch/x86/kernel/ioport.c                  |   7 +-
 arch/x86/kernel/sys_x86_64.c              |   2 +-
 arch/xtensa/kernel/syscall.c              |   2 +-
 drivers/base/devtmpfs.c                   |  11 ++-
 drivers/tty/vt/vt_ioctl.c                 |   6 +-
 fs/autofs4/dev-ioctl.c                    |   2 +-
 fs/binfmt_misc.c                          |   2 +-
 fs/eventfd.c                              |   9 +-
 fs/eventpoll.c                            |  23 +++--
 fs/file.c                                 |  17 +++-
 fs/hostfs/hostfs.h                        |   2 +-
 fs/hostfs/hostfs_kern.c                   |   2 +-
 fs/hostfs/hostfs_user.c                   |   2 +-
 fs/internal.h                             |  14 +++
 fs/namei.c                                |  61 +++++++++----
 fs/namespace.c                            |  19 +++-
 fs/open.c                                 |  68 ++++++++++----
 fs/pipe.c                                 |   9 +-
 fs/read_write.c                           |   9 +-
 fs/signalfd.c                             |  14 ++-
 fs/stat.c                                 |  12 ++-
 fs/sync.c                                 |  12 ++-
 fs/utimes.c                               |  13 ++-
 include/linux/futex.h                     |  13 ++-
 include/linux/syscalls.h                  | 146 +++++++++++++++++++++++++++++-
 init/do_mounts.c                          |  16 ++--
 init/do_mounts.h                          |   4 +-
 init/do_mounts_initrd.c                   |  38 ++++----
 init/do_mounts_md.c                       |  14 +--
 init/do_mounts_rd.c                       |  18 ++--
 init/initramfs.c                          |  48 +++++-----
 init/main.c                               |   9 +-
 init/noinitramfs.c                        |   6 +-
 kernel/exit.c                             |   2 +-
 kernel/fork.c                             |  11 ++-
 kernel/pid_namespace.c                    |   6 +-
 kernel/signal.c                           |  15 ++-
 kernel/sys.c                              |   9 +-
 kernel/uid16.c                            |   6 +-
 kernel/umh.c                              |   2 +-
 mm/fadvise.c                              |  10 +-
 mm/mmap.c                                 |  17 +++-
 mm/nommu.c                                |  17 +++-
 66 files changed, 614 insertions(+), 275 deletions(-)

-- 
2.16.2
