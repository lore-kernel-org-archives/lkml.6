Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeFDK1p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:27:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFDK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:27:43 -0400
Date: Mon, 4 Jun 2018 12:27:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] time/Y2038 updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041220480.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-2038-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-2038-for-linus

Another set of Y2038 updates:

  - Core infrastucture work for Y2038 to address the COMPAT
    interfaces. This is already part of the timers-core pull request and
    contained here as the Y2038 patches depend on it.

  - Consolidate SySV IPC UAPI headers

  - Convert SySV IPC to the new COMPAT_32BIT_TIME mechanism

  - Cleanup the core interfaces and standardize on the ktime_get_* naming
    convention.

  - Convert the X86 platform ops to timespec64

  - Remove the ugly temporary timespec64 hack

Thanks,

	tglx

------------------>
Arnd Bergmann (24):
      time: Add an asm-generic/compat.h file
      sparc: compat: Allow including asm/compat.h for 32-bit
      y2038: asm-generic: Extend sysvipc data structures
      y2038: x86: Extend sysvipc data structures
      y2038: alpha: Remove unneeded ipc uapi header files
      y2038: ia64: Remove unneeded ipc uapi header files
      y2038: s390: Remove unneeded ipc uapi header files
      y2038: arm64: Extend sysvipc compat data structures
      y2038: mips: Extend sysvipc data structures
      y2038: parisc: Extend sysvipc data structures
      y2038: sparc: Extend sysvipc data structures
      y2038: powerpc: Extend sysvipc data structures
      y2038: xtensa: Extend sysvipc data structures
      y2038: ipc: Use ktime_get_real_seconds consistently
      y2038: ipc: Report long times to user space
      y2038: ipc: Use __kernel_timespec
      y2038: ipc: Enable COMPAT_32BIT_TIME
      y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
      timekeeping: Remove timespec64 hack
      timekeeping: Clean up ktime_get_real_ts64
      timekeeping: Standardize on ktime_get_*() naming
      timekeeping: Add ktime_get_coarse_with_offset
      timekeeping: Add more coarse clocktai/boottime interfaces
      x86: Convert x86_platform_ops to timespec64

Deepa Dinamani (10):
      compat: Make compat helpers independent of CONFIG_COMPAT
      compat: Move compat_timespec/ timeval to compat_time.h
      compat: Enable compat_get/put_timespec64 always
      time: Introduce CONFIG_64BIT_TIME in architectures
      time: Introduce CONFIG_COMPAT_32BIT_TIME
      posix-timers: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME
      time: Add new y2038 safe __kernel_timespec
      time: Fix get_timespec64() for y2038 safe compat interfaces
      time: Change types to new y2038 safe __kernel_* types
      time: Change nanosleep to safe __kernel_* types


 arch/Kconfig                                 | 15 +++++
 arch/alpha/include/asm/Kbuild                |  1 +
 arch/alpha/include/uapi/asm/Kbuild           |  4 ++
 arch/alpha/include/uapi/asm/ipcbuf.h         |  2 -
 arch/alpha/include/uapi/asm/msgbuf.h         | 28 ---------
 arch/alpha/include/uapi/asm/sembuf.h         | 23 -------
 arch/alpha/include/uapi/asm/shmbuf.h         | 39 ------------
 arch/arc/include/asm/Kbuild                  |  1 +
 arch/arm/include/asm/Kbuild                  |  1 +
 arch/arm64/include/asm/compat.h              | 43 +++++--------
 arch/arm64/include/asm/stat.h                |  1 +
 arch/arm64/kernel/hw_breakpoint.c            |  1 -
 arch/arm64/kernel/perf_regs.c                |  2 +-
 arch/c6x/include/asm/Kbuild                  |  1 +
 arch/h8300/include/asm/Kbuild                |  1 +
 arch/hexagon/include/asm/Kbuild              |  1 +
 arch/ia64/include/asm/Kbuild                 |  1 +
 arch/ia64/include/uapi/asm/Kbuild            |  4 ++
 arch/ia64/include/uapi/asm/ipcbuf.h          |  2 -
 arch/ia64/include/uapi/asm/msgbuf.h          | 28 ---------
 arch/ia64/include/uapi/asm/sembuf.h          | 23 -------
 arch/ia64/include/uapi/asm/shmbuf.h          | 39 ------------
 arch/m68k/include/asm/Kbuild                 |  1 +
 arch/microblaze/include/asm/Kbuild           |  1 +
 arch/mips/include/asm/compat.h               | 51 +++++++---------
 arch/mips/include/uapi/asm/msgbuf.h          | 57 +++++++++++------
 arch/mips/include/uapi/asm/sembuf.h          | 15 ++++-
 arch/mips/include/uapi/asm/shmbuf.h          | 23 ++++++-
 arch/mips/kernel/signal32.c                  |  2 +-
 arch/nds32/include/asm/Kbuild                |  1 +
 arch/nios2/include/asm/Kbuild                |  1 +
 arch/openrisc/include/asm/Kbuild             |  1 +
 arch/parisc/include/asm/compat.h             | 43 +++++--------
 arch/parisc/include/uapi/asm/msgbuf.h        | 33 +++++-----
 arch/parisc/include/uapi/asm/sembuf.h        | 16 ++---
 arch/parisc/include/uapi/asm/shmbuf.h        | 19 +++---
 arch/powerpc/include/asm/compat.h            | 43 +++++--------
 arch/powerpc/include/uapi/asm/msgbuf.h       | 18 +++---
 arch/powerpc/include/uapi/asm/sembuf.h       | 14 ++---
 arch/powerpc/include/uapi/asm/shmbuf.h       | 19 +++---
 arch/powerpc/kernel/asm-offsets.c            |  2 +-
 arch/powerpc/oprofile/backtrace.c            |  1 +
 arch/s390/hypfs/hypfs_sprp.c                 |  1 -
 arch/s390/include/asm/compat.h               | 43 +++++--------
 arch/s390/include/asm/elf.h                  |  4 +-
 arch/s390/include/uapi/asm/Kbuild            |  3 +
 arch/s390/include/uapi/asm/msgbuf.h          | 38 ------------
 arch/s390/include/uapi/asm/sembuf.h          | 30 ---------
 arch/s390/include/uapi/asm/shmbuf.h          | 49 ---------------
 arch/s390/kvm/priv.c                         |  1 -
 arch/s390/pci/pci_clp.c                      |  1 -
 arch/sh/include/asm/Kbuild                   |  1 +
 arch/sparc/include/asm/compat.h              | 47 ++++++--------
 arch/sparc/include/uapi/asm/msgbuf.h         | 22 +++----
 arch/sparc/include/uapi/asm/sembuf.h         | 16 +++--
 arch/sparc/include/uapi/asm/shmbuf.h         | 21 +++----
 arch/um/include/asm/Kbuild                   |  1 +
 arch/unicore32/include/asm/Kbuild            |  1 +
 arch/x86/events/core.c                       |  2 +-
 arch/x86/include/asm/compat.h                | 43 +++++--------
 arch/x86/include/asm/ftrace.h                |  2 +-
 arch/x86/include/asm/intel_mid_vrtc.h        |  4 +-
 arch/x86/include/asm/mc146818rtc.h           |  4 +-
 arch/x86/include/asm/pvclock.h               |  2 +-
 arch/x86/include/asm/x86_init.h              |  6 +-
 arch/x86/include/uapi/asm/sembuf.h           | 11 +++-
 arch/x86/kernel/jailhouse.c                  |  2 +-
 arch/x86/kernel/kvmclock.c                   |  4 +-
 arch/x86/kernel/pvclock.c                    | 15 +++--
 arch/x86/kernel/rtc.c                        | 10 +--
 arch/x86/kernel/sys_x86_64.c                 |  2 +-
 arch/x86/platform/intel-mid/intel_mid_vrtc.c | 12 ++--
 arch/x86/xen/time.c                          | 10 +--
 arch/xtensa/include/asm/Kbuild               |  1 +
 arch/xtensa/include/uapi/asm/msgbuf.h        | 25 ++++----
 arch/xtensa/include/uapi/asm/sembuf.h        | 17 +++---
 arch/xtensa/include/uapi/asm/shmbuf.h        | 37 +++--------
 drivers/s390/block/dasd_ioctl.c              |  1 -
 drivers/s390/char/fs3270.c                   |  1 -
 drivers/s390/char/sclp_ctl.c                 |  1 -
 drivers/s390/char/vmcp.c                     |  1 -
 drivers/s390/cio/chsc_sch.c                  |  1 -
 drivers/s390/net/qeth_core_main.c            |  2 +-
 include/asm-generic/compat.h                 |  3 +
 include/linux/compat.h                       | 12 ++--
 include/linux/compat_time.h                  | 23 +++++++
 include/linux/restart_block.h                |  7 +--
 include/linux/syscalls.h                     | 19 +++---
 include/linux/time.h                         |  4 +-
 include/linux/time32.h                       | 18 +-----
 include/linux/time64.h                       | 17 +++---
 include/linux/timekeeping.h                  | 91 +++++++++++++++++++++++-----
 include/linux/timekeeping32.h                | 70 ++++-----------------
 include/uapi/asm-generic/msgbuf.h            | 27 ++++-----
 include/uapi/asm-generic/posix_types.h       |  1 +
 include/uapi/asm-generic/sembuf.h            | 26 +++++---
 include/uapi/asm-generic/shmbuf.h            | 41 ++++++-------
 include/uapi/linux/time.h                    |  7 +++
 ipc/mqueue.c                                 | 86 +++++++++++++-------------
 ipc/msg.c                                    | 20 ++++--
 ipc/sem.c                                    | 27 ++++++---
 ipc/shm.c                                    | 14 ++++-
 ipc/syscall.c                                | 13 +++-
 ipc/util.h                                   |  4 +-
 kernel/compat.c                              | 52 +++-------------
 kernel/time/hrtimer.c                        | 10 ++-
 kernel/time/posix-stubs.c                    | 12 ++--
 kernel/time/posix-timers.c                   | 24 +++++---
 kernel/time/time.c                           | 60 ++++++++++++++++--
 kernel/time/timekeeping.c                    | 73 +++++++++++-----------
 110 files changed, 834 insertions(+), 1044 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/sembuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/sembuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
 delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h
 create mode 100644 include/asm-generic/compat.h
 create mode 100644 include/linux/compat_time.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 75dd23acf133..e30c3fa343bd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -874,6 +874,21 @@ config OLD_SIGACTION
 config COMPAT_OLD_SIGACTION
 	bool
 
+config 64BIT_TIME
+	def_bool ARCH_HAS_64BIT_TIME
+	help
+	  This should be selected by all architectures that need to support
+	  new system calls with a 64-bit time_t. This is relevant on all 32-bit
+	  architectures, and 64-bit architectures as part of compat syscall
+	  handling.
+
+config COMPAT_32BIT_TIME
+	def_bool (!64BIT && 64BIT_TIME) || COMPAT
+	help
+	  This enables 32 bit time_t support in addition to 64 bit time_t support.
+	  This is relevant on all 32-bit architectures, and 64-bit architectures
+	  as part of compat syscall handling.
+
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 9b68790013e2..0580cb8c84b2 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 
+generic-y += compat.h
 generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 9afaba5e5503..1a5b75310cf4 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -2,4 +2,8 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += ipcbuf.h
+generic-y += msgbuf.h
 generic-y += poll.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
diff --git a/arch/alpha/include/uapi/asm/ipcbuf.h b/arch/alpha/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
--- a/arch/alpha/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/alpha/include/uapi/asm/msgbuf.h b/arch/alpha/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 8c5d4d8c1b16..000000000000
--- a/arch/alpha/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_MSGBUF_H
-#define _ALPHA_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for alpha architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _ALPHA_MSGBUF_H */
diff --git a/arch/alpha/include/uapi/asm/sembuf.h b/arch/alpha/include/uapi/asm/sembuf.h
deleted file mode 100644
index f28ffa668b2f..000000000000
--- a/arch/alpha/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_SEMBUF_H
-#define _ALPHA_SEMBUF_H
-
-/* 
- * The semid64_ds structure for alpha architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _ALPHA_SEMBUF_H */
diff --git a/arch/alpha/include/uapi/asm/shmbuf.h b/arch/alpha/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 7e041ca2eb40..000000000000
--- a/arch/alpha/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_SHMBUF_H
-#define _ALPHA_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for alpha architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ALPHA_SHMBUF_H */
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4bd5d4369e05..d51bc22e8795 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += bugs.h
+generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 873e3c189279..1d66db9c9db5 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compat.h
 generic-y += current.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index c00c62e1a4a3..1a037b94eba1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -34,7 +34,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -66,16 +65,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
@@ -192,10 +181,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -203,12 +192,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -221,12 +210,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index 15e35598ac40..eab738019707 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -20,6 +20,7 @@
 
 #ifdef CONFIG_COMPAT
 
+#include <linux/compat_time.h>
 #include <asm/compat.h>
 
 /*
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 74bb56f656ef..413dbe530da8 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -30,7 +30,6 @@
 #include <linux/smp.h>
 #include <linux/uaccess.h>
 
-#include <asm/compat.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 1d091d048d04..0bbac612146e 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/compat.h>
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index fd4c840de837..24037486317c 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += atomic.h
 generic-y += barrier.h
 generic-y += bugs.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 14bac06b7116..a5d0b2991f47 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += barrier.h
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index e9743f689fb8..dd2fd9c0d292 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 6dd867873364..557bbc8ba9f5 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compat.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index c0527cfc48f0..3982e673e967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,5 +2,9 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += ipcbuf.h
 generic-y += kvm_para.h
+generic-y += msgbuf.h
 generic-y += poll.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
diff --git a/arch/ia64/include/uapi/asm/ipcbuf.h b/arch/ia64/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
--- a/arch/ia64/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/ia64/include/uapi/asm/msgbuf.h b/arch/ia64/include/uapi/asm/msgbuf.h
deleted file mode 100644
index aa25df92d9dc..000000000000
--- a/arch/ia64/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_MSGBUF_H
-#define _ASM_IA64_MSGBUF_H
-
-/*
- * The msqid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _ASM_IA64_MSGBUF_H */
diff --git a/arch/ia64/include/uapi/asm/sembuf.h b/arch/ia64/include/uapi/asm/sembuf.h
deleted file mode 100644
index 6ed058760afc..000000000000
--- a/arch/ia64/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SEMBUF_H
-#define _ASM_IA64_SEMBUF_H
-
-/*
- * The semid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _ASM_IA64_SEMBUF_H */
diff --git a/arch/ia64/include/uapi/asm/shmbuf.h b/arch/ia64/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 6ef57cb70dee..000000000000
--- a/arch/ia64/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SHMBUF_H
-#define _ASM_IA64_SHMBUF_H
-
-/*
- * The shmid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ASM_IA64_SHMBUF_H */
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88a9d27df1ac..4d8d68c4e3dd 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += barrier.h
+generic-y += compat.h
 generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 3c80a5a308ed..fe6a6c6e5003 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += barrier.h
 generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
+generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 9a0fa66b81ac..78675f19440f 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -14,7 +14,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_suseconds_t;
 
@@ -38,24 +37,16 @@ typedef struct {
 typedef s32		compat_timer_t;
 typedef s32		compat_key_t;
 
+typedef s16		compat_short_t;
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
 typedef s64		compat_s64;
+typedef u16		compat_ushort_t;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	s32		st_pad1[3];
@@ -168,35 +159,35 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t	sem_otime;
-	compat_time_t	sem_ctime;
+	compat_ulong_t	sem_otime;
+	compat_ulong_t	sem_ctime;
 	compat_ulong_t	sem_nsems;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ulong_t	sem_otime_high;
+	compat_ulong_t	sem_ctime_high;
 };
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
-	compat_time_t	msg_stime;
+	compat_ulong_t	msg_stime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
-	compat_time_t	msg_rtime;
+	compat_ulong_t	msg_rtime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
-	compat_time_t	msg_ctime;
+	compat_ulong_t	msg_ctime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
 	compat_ulong_t	msg_cbytes;
 	compat_ulong_t	msg_qnum;
@@ -210,14 +201,16 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t	shm_segsz;
-	compat_time_t	shm_atime;
-	compat_time_t	shm_dtime;
-	compat_time_t	shm_ctime;
+	compat_ulong_t	shm_atime;
+	compat_ulong_t	shm_dtime;
+	compat_ulong_t	shm_ctime;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
 	compat_ulong_t	shm_nattch;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ushort_t	shm_atime_high;
+	compat_ushort_t	shm_dtime_high;
+	compat_ushort_t	shm_ctime_high;
+	compat_ushort_t	__unused2;
 };
 
 /* MIPS has unusual order of fields in stack_t */
diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index eb4d0f9d7364..46aa15b13e4e 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -9,33 +9,15 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - extension of time_t to 64-bit on 32-bitsystem to solve the y2038 problem
  * - 2 miscellaneous unsigned long values
  */
 
+#if defined(__mips64)
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused1;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused2;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused3;
-#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -44,5 +26,42 @@ struct msqid64_ds {
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
+#elif defined (__MIPSEB__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#elif defined (__MIPSEL__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#else
+#warning no endianess set
+#endif
 
 #endif /* _ASM_MSGBUF_H */
diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 2c0f507ab7d1..60c89e6cb25b 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -7,10 +7,11 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
+ * Pad space is left for 2 miscellaneous 64-bit values on mips64,
+ * but used for the upper 32 bit of the time values on mips32.
  */
 
+#ifdef __mips64
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 	__kernel_time_t sem_otime;		/* last semop time */
@@ -19,5 +20,15 @@ struct semid64_ds {
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
+#else
+struct semid64_ds {
+	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
+	unsigned long   sem_otime;		/* last semop time */
+	unsigned long   sem_ctime;		/* last change time */
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime_high;
+};
+#endif
 
 #endif /* _ASM_SEMBUF_H */
diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 379e6bca518b..9b9bba3401f2 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -7,10 +7,13 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 32-bit rsp. 64-bit values
+ * As MIPS was lacking proper padding after shm_?time, we use 48 bits
+ * of the padding at the end to store a few additional bits of the time.
+ * libc implementations need to take care to convert this into a proper
+ * data structure when moving to 64-bit time_t.
  */
 
+#ifdef __mips64
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
@@ -23,6 +26,22 @@ struct shmid64_ds {
 	unsigned long		__unused1;
 	unsigned long		__unused2;
 };
+#else
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned short		shm_atime_high;
+	unsigned short		shm_dtime_high;
+	unsigned short		shm_ctime_high;
+	unsigned short		__unused1;
+};
+#endif
 
 struct shminfo64 {
 	unsigned long	shmmax;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c4db910a8794..b5d9e1784aff 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -8,13 +8,13 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2016, Imagination Technologies Ltd.
  */
+#include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/syscalls.h>
 
-#include <asm/compat.h>
 #include <asm/compat-signal.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 06bdf8167f5a..d1b1f89d44f6 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += cmpxchg-local.h
+generic-y += compat.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d232da2cbb38..64ed3d656956 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += cmpxchg.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index f05c722a21f8..65964d390b10 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 57b8b2a2fd4e..ab8a54771507 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -13,7 +13,6 @@
 
 typedef u32	compat_size_t;
 typedef s32	compat_ssize_t;
-typedef s32	compat_time_t;
 typedef s32	compat_clock_t;
 typedef s32	compat_pid_t;
 typedef u32	__compat_uid_t;
@@ -40,16 +39,6 @@ typedef u32	compat_ulong_t;
 typedef u64	compat_u64;
 typedef u32	compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t		tv_sec;
-	s32			tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t		tv_sec;
-	s32			tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
 	compat_ino_t		st_ino;	/* 32 bits */
@@ -149,10 +138,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -160,12 +149,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -177,12 +166,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index b48b810e626b..6a2e9ab2ef8d 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -10,31 +10,30 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long msg_cbytes;	/* current number of bytes on queue */
-	unsigned long msg_qnum;		/* number of messages in queue */
-	unsigned long msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long __unused1;
-	unsigned long __unused2;
+#else
+	unsigned long	msg_stime_high;
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_ctime_high;
+	unsigned long	msg_ctime;	/* last change time */
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t	msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t	msg_lrpid;	/* last receive pid */
+	unsigned long	__unused1;
+	unsigned long	__unused2;
 };
 
 #endif /* _PARISC_MSGBUF_H */
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 746c5d86a9b1..3c31163b1241 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -10,21 +10,21 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;		/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad2;
-#endif
 	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long 	sem_nsems;		/* no. of semaphores in array */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index cd4dbce55d0b..c89b3dd8db21 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -10,25 +10,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned int		__pad4;
 #endif
 	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 62168e1158f1..85c8af2bb272 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -17,7 +17,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u32		__compat_uid_t;
@@ -45,16 +44,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
@@ -173,10 +162,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -184,12 +173,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -201,12 +190,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 65beb0942500..2b1b37797a47 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -10,18 +10,18 @@
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#ifndef __powerpc64__
-	unsigned int	__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __powerpc64__
-	unsigned int	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __powerpc64__
-	unsigned int	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 8f393d60f02d..3f60946f77e3 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -15,20 +15,20 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 32/64-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
 #ifndef __powerpc64__
-	unsigned long	__unused1;
-#endif
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;	/* last change time */
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
-#ifndef __powerpc64__
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
+#endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
 	unsigned long	__unused4;
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index deb1c3e503d3..b591c4d7e4c5 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -16,25 +16,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#ifndef __powerpc64__
-	unsigned long		__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __powerpc64__
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __powerpc64__
-	unsigned long		__unused3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __powerpc64__
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6bee65f3cfd3..a77528db474c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -42,7 +43,6 @@
 #include <asm/paca.h>
 #include <asm/lppaca.h>
 #include <asm/cache.h>
-#include <asm/compat.h>
 #include <asm/mmu.h>
 #include <asm/hvcall.h>
 #include <asm/xics.h>
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index ecc66d5f02c9..ad054dd0d666 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -7,6 +7,7 @@
  * 2 of the License, or (at your option) any later version.
 **/
 
+#include <linux/compat_time.h>
 #include <linux/oprofile.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index ae0ed8dd5f1b..5d85a039391c 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
-#include <asm/compat.h>
 #include <asm/diag.h>
 #include <asm/sclp.h>
 #include "hypfs.h"
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 9830fb6b076e..97db2fba546a 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -53,7 +53,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -97,16 +96,6 @@ typedef struct {
 	u32 gprs_high[NUM_GPRS];
 } s390_compat_regs_high;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	u16		__pad1;
@@ -243,10 +232,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __pad1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __pad2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused1;
 	compat_ulong_t __unused2;
@@ -254,12 +243,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t   msg_stime;
-	compat_ulong_t __pad1;
-	compat_time_t   msg_rtime;
-	compat_ulong_t __pad2;
-	compat_time_t   msg_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -272,12 +261,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __pad1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __pad2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 1a61b1b997f2..7d22a474a040 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -125,8 +125,9 @@
  * ELF register definitions..
  */
 
+#include <linux/compat.h>
+
 #include <asm/ptrace.h>
-#include <asm/compat.h>
 #include <asm/syscall.h>
 #include <asm/user.h>
 
@@ -136,7 +137,6 @@ typedef s390_regs elf_gregset_t;
 typedef s390_fp_regs compat_elf_fpregset_t;
 typedef s390_compat_regs compat_elf_gregset_t;
 
-#include <linux/compat.h>
 #include <linux/sched/mm.h>	/* for task_struct */
 #include <asm/mmu_context.h>
 
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index faef3f7e8353..e364873e0d10 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -9,9 +9,12 @@ generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
 generic-y += mman.h
+generic-y += msgbuf.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
 generic-y += sockios.h
 generic-y += swab.h
 generic-y += termbits.h
diff --git a/arch/s390/include/uapi/asm/msgbuf.h b/arch/s390/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 604f847cd68c..000000000000
--- a/arch/s390/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_MSGBUF_H
-#define _S390_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused3;
-#endif /* ! __s390x__ */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _S390_MSGBUF_H */
diff --git a/arch/s390/include/uapi/asm/sembuf.h b/arch/s390/include/uapi/asm/sembuf.h
deleted file mode 100644
index 3e917697b668..000000000000
--- a/arch/s390/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SEMBUF_H
-#define _S390_SEMBUF_H
-
-/* 
- * The semid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t	sem_ctime;		/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _S390_SEMBUF_H */
diff --git a/arch/s390/include/uapi/asm/shmbuf.h b/arch/s390/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 9cdce8d7ce60..000000000000
--- a/arch/s390/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SHMBUF_H
-#define _S390_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __s390x__
-	unsigned long		__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __s390x__
-	unsigned long		__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long		__unused3;
-#endif /* ! __s390x__ */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _S390_SHMBUF_H */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ebfa0442e569..a3bce0e84346 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -26,7 +26,6 @@
 #include <asm/gmap.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
-#include <asm/compat.h>
 #include <asm/sclp.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 93cd0f1ca12b..19b2d2a9b43d 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -19,7 +19,6 @@
 #include <linux/uaccess.h>
 #include <asm/pci_debug.h>
 #include <asm/pci_clp.h>
-#include <asm/compat.h>
 #include <asm/clp.h>
 #include <uapi/asm/clp.h>
 
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 1efcce74997b..46dd82ab2c29 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 615283e16f22..4eb51d2dae98 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -11,7 +11,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -39,16 +38,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
@@ -168,6 +157,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
+#ifdef CONFIG_COMPAT
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current_thread_info()->kregs;
@@ -184,6 +174,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 
 	return (void __user *) usp;
 }
+#endif
 
 struct compat_ipc64_perm {
 	compat_key_t key;
@@ -201,10 +192,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int	__pad1;
-	compat_time_t	sem_otime;
-	unsigned int	__pad2;
-	compat_time_t	sem_ctime;
+	unsigned int	sem_otime_high;
+	unsigned int	sem_otime;
+	unsigned int	sem_ctime_high;
+	unsigned int	sem_ctime;
 	u32		sem_nsems;
 	u32		__unused1;
 	u32		__unused2;
@@ -212,12 +203,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int	__pad1;
-	compat_time_t	msg_stime;
-	unsigned int	__pad2;
-	compat_time_t	msg_rtime;
-	unsigned int	__pad3;
-	compat_time_t	msg_ctime;
+	unsigned int	msg_stime_high;
+	unsigned int	msg_stime;
+	unsigned int	msg_rtime_high;
+	unsigned int	msg_rtime;
+	unsigned int	msg_ctime_high;
+	unsigned int	msg_ctime;
 	unsigned int	msg_cbytes;
 	unsigned int	msg_qnum;
 	unsigned int	msg_qbytes;
@@ -229,12 +220,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int	__pad1;
-	compat_time_t	shm_atime;
-	unsigned int	__pad2;
-	compat_time_t	shm_dtime;
-	unsigned int	__pad3;
-	compat_time_t	shm_ctime;
+	unsigned int	shm_atime_high;
+	unsigned int	shm_atime;
+	unsigned int	shm_dtime_high;
+	unsigned int	shm_dtime;
+	unsigned int	shm_ctime_high;
+	unsigned int	shm_ctime;
 	compat_size_t	shm_segsz;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
@@ -243,6 +234,7 @@ struct compat_shmid64_ds {
 	unsigned int	__unused2;
 };
 
+#ifdef CONFIG_COMPAT
 static inline int is_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
@@ -254,5 +246,6 @@ static inline bool in_compat_syscall(void)
 	return pt_regs_trap_type(current_pt_regs()) == 0x110;
 }
 #define in_compat_syscall in_compat_syscall
+#endif
 
 #endif /* _ASM_SPARC64_COMPAT_H */
diff --git a/arch/sparc/include/uapi/asm/msgbuf.h b/arch/sparc/include/uapi/asm/msgbuf.h
index b601c4f4d956..ffc46c211d6d 100644
--- a/arch/sparc/include/uapi/asm/msgbuf.h
+++ b/arch/sparc/include/uapi/asm/msgbuf.h
@@ -8,25 +8,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
-
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-	PADDING(__pad2)
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	PADDING(__pad3)
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long msg_stime_high;
+	unsigned long msg_stime;	/* last msgsnd time */
+	unsigned long msg_rtime_high;
+	unsigned long msg_rtime;	/* last msgrcv time */
+	unsigned long msg_ctime_high;
+	unsigned long msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -35,5 +32,4 @@ struct msqid64_ds {
 	unsigned long  __unused1;
 	unsigned long  __unused2;
 };
-#undef PADDING
 #endif /* _SPARC_MSGBUF_H */
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f49b0ffa0ab8..f3d309c2e1cd 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -8,25 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t	sem_otime;		/* last semop time */
-	PADDING(__pad2)
 	__kernel_time_t	sem_ctime;		/* last change time */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
-#undef PADDING
 
 #endif /* _SPARC64_SEMBUF_H */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index 286631db705c..06618b84822d 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -8,24 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t		shm_atime;	/* last attach time */
-	PADDING(__pad2)
 	__kernel_time_t		shm_dtime;	/* last detach time */
-	PADDING(__pad3)
 	__kernel_time_t		shm_ctime;	/* last change time */
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+#endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
@@ -46,6 +45,4 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
-#undef PADDING
-
 #endif /* _SPARC_SHMBUF_H */
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index bb5a196c3061..b10dde6cb793 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += barrier.h
 generic-y += bpf_perf_event.h
 generic-y += bug.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 6f70c76c81fc..bfc7abe77905 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += atomic.h
 generic-y += bugs.h
+generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 45b2b1c93d04..6e461fb1e0d4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2397,7 +2397,7 @@ static unsigned long get_segment_base(unsigned int segment)
 
 #ifdef CONFIG_IA32_EMULATION
 
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 static inline int
 perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index e1c8dab86670..fb97cf7c4137 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -17,7 +17,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -46,16 +45,6 @@ typedef u32		compat_u32;
 typedef u64 __attribute__((aligned(4))) compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	u16		__pad1;
@@ -145,10 +134,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -156,12 +145,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -174,12 +163,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index cc8f8fcf9b4a..c18ed65287d5 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -63,7 +63,7 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 #ifndef COMPILE_OFFSETS
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 /*
  * Because ia32 syscalls do not map to x86_64 syscall numbers
diff --git a/arch/x86/include/asm/intel_mid_vrtc.h b/arch/x86/include/asm/intel_mid_vrtc.h
index 35555016b1be..0b44b1abe4d9 100644
--- a/arch/x86/include/asm/intel_mid_vrtc.h
+++ b/arch/x86/include/asm/intel_mid_vrtc.h
@@ -4,7 +4,7 @@
 
 extern unsigned char vrtc_cmos_read(unsigned char reg);
 extern void vrtc_cmos_write(unsigned char val, unsigned char reg);
-extern void vrtc_get_time(struct timespec *now);
-extern int vrtc_set_mmss(const struct timespec *now);
+extern void vrtc_get_time(struct timespec64 *now);
+extern int vrtc_set_mmss(const struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 1775a32f7ea6..97198001e567 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -95,8 +95,8 @@ static inline unsigned char current_lock_cmos_reg(void)
 unsigned char rtc_cmos_read(unsigned char addr);
 void rtc_cmos_write(unsigned char val, unsigned char addr);
 
-extern int mach_set_rtc_mmss(const struct timespec *now);
-extern void mach_get_cmos_time(struct timespec *now);
+extern int mach_set_rtc_mmss(const struct timespec64 *now);
+extern void mach_get_cmos_time(struct timespec64 *now);
 
 #define RTC_IRQ 8
 
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index a7471dcd2205..b6033680d458 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -12,7 +12,7 @@ void pvclock_set_flags(u8 flags);
 unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
 			    struct pvclock_vcpu_time_info *vcpu,
-			    struct timespec *ts);
+			    struct timespec64 *ts);
 void pvclock_resume(void);
 
 void pvclock_touch_watchdogs(void);
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ce8b4da07e35..2d27236c16a3 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -170,7 +170,7 @@ struct x86_cpuinit_ops {
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
 };
 
-struct timespec;
+struct timespec64;
 
 /**
  * struct x86_legacy_devices - legacy x86 devices
@@ -264,8 +264,8 @@ struct x86_hyper_runtime {
 struct x86_platform_ops {
 	unsigned long (*calibrate_cpu)(void);
 	unsigned long (*calibrate_tsc)(void);
-	void (*get_wallclock)(struct timespec *ts);
-	int (*set_wallclock)(const struct timespec *ts);
+	void (*get_wallclock)(struct timespec64 *ts);
+	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
 	bool (*is_untracked_pat_range)(u64 start, u64 end);
 	void (*nmi_init)(void);
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index cabd7476bd6c..89de6cd9f0a7 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -8,15 +8,24 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
+ *
+ * x86_64 and x32 incorrectly added padding here, so the structures
+ * are still incompatible with the padding on x86.
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#ifdef __i386__
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
 	__kernel_ulong_t __unused1;
 	__kernel_time_t	sem_ctime;	/* last change time */
 	__kernel_ulong_t __unused2;
+#endif
 	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
 	__kernel_ulong_t __unused3;
 	__kernel_ulong_t __unused4;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index a15fe0e92cf9..108c48d0d40e 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -37,7 +37,7 @@ static uint32_t __init jailhouse_detect(void)
 	return jailhouse_cpuid_base();
 }
 
-static void jailhouse_get_wallclock(struct timespec *now)
+static void jailhouse_get_wallclock(struct timespec64 *now)
 {
 	memset(now, 0, sizeof(*now));
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8b26c9e01cc4..bf8d1eb7fca3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -53,7 +53,7 @@ static struct pvclock_wall_clock *wall_clock;
  * have elapsed since the hypervisor wrote the data. So we try to account for
  * that with system time
  */
-static void kvm_get_wallclock(struct timespec *now)
+static void kvm_get_wallclock(struct timespec64 *now)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
 	int low, high;
@@ -72,7 +72,7 @@ static void kvm_get_wallclock(struct timespec *now)
 	put_cpu();
 }
 
-static int kvm_set_wallclock(const struct timespec *now)
+static int kvm_set_wallclock(const struct timespec64 *now)
 {
 	return -ENODEV;
 }
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 761f6af6efa5..637982efecd8 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -123,28 +123,35 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 			    struct pvclock_vcpu_time_info *vcpu_time,
-			    struct timespec *ts)
+			    struct timespec64 *ts)
 {
 	u32 version;
 	u64 delta;
-	struct timespec now;
+	struct timespec64 now;
 
 	/* get wallclock at system boot */
 	do {
 		version = wall_clock->version;
 		rmb();		/* fetch version before time */
+		/*
+		 * Note: wall_clock->sec is a u32 value, so it can
+		 * only store dates between 1970 and 2106. To allow
+		 * times beyond that, we need to create a new hypercall
+		 * interface with an extended pvclock_wall_clock structure
+		 * like ARM has.
+		 */
 		now.tv_sec  = wall_clock->sec;
 		now.tv_nsec = wall_clock->nsec;
 		rmb();		/* fetch time before checking version */
 	} while ((wall_clock->version & 1) || (version != wall_clock->version));
 
 	delta = pvclock_clocksource_read(vcpu_time);	/* time since system boot */
-	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+	delta += now.tv_sec * NSEC_PER_SEC + now.tv_nsec;
 
 	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
 	now.tv_sec = delta;
 
-	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
 void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index f7b82ed7b5b5..586f718b8e95 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(rtc_lock);
  * jump to the next second precisely 500 ms later. Check the Motorola
  * MC146818A or Dallas DS12887 data sheet for details.
  */
-int mach_set_rtc_mmss(const struct timespec *now)
+int mach_set_rtc_mmss(const struct timespec64 *now)
 {
 	unsigned long long nowtime = now->tv_sec;
 	struct rtc_time tm;
@@ -60,7 +60,7 @@ int mach_set_rtc_mmss(const struct timespec *now)
 	return retval;
 }
 
-void mach_get_cmos_time(struct timespec *now)
+void mach_get_cmos_time(struct timespec64 *now)
 {
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
@@ -118,7 +118,7 @@ void mach_get_cmos_time(struct timespec *now)
 	} else
 		year += CMOS_YEARS_OFFS;
 
-	now->tv_sec = mktime(year, mon, day, hour, min, sec);
+	now->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	now->tv_nsec = 0;
 }
 
@@ -145,13 +145,13 @@ void rtc_cmos_write(unsigned char val, unsigned char addr)
 }
 EXPORT_SYMBOL(rtc_cmos_write);
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	return x86_platform.set_wallclock(&now);
 }
 
 /* not static: needed by APM */
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	x86_platform.get_wallclock(ts);
 }
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index a3f15ed545b5..6a78d4b36a79 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -19,7 +20,6 @@
 #include <linux/elf.h>
 
 #include <asm/elf.h>
-#include <asm/compat.h>
 #include <asm/ia32.h>
 #include <asm/syscalls.h>
 #include <asm/mpx.h>
diff --git a/arch/x86/platform/intel-mid/intel_mid_vrtc.c b/arch/x86/platform/intel-mid/intel_mid_vrtc.c
index 58024862a7eb..a52914aa3b6c 100644
--- a/arch/x86/platform/intel-mid/intel_mid_vrtc.c
+++ b/arch/x86/platform/intel-mid/intel_mid_vrtc.c
@@ -57,7 +57,7 @@ void vrtc_cmos_write(unsigned char val, unsigned char reg)
 }
 EXPORT_SYMBOL_GPL(vrtc_cmos_write);
 
-void vrtc_get_time(struct timespec *now)
+void vrtc_get_time(struct timespec64 *now)
 {
 	u8 sec, min, hour, mday, mon;
 	unsigned long flags;
@@ -83,18 +83,18 @@ void vrtc_get_time(struct timespec *now)
 	pr_info("vRTC: sec: %d min: %d hour: %d day: %d "
 		"mon: %d year: %d\n", sec, min, hour, mday, mon, year);
 
-	now->tv_sec = mktime(year, mon, mday, hour, min, sec);
+	now->tv_sec = mktime64(year, mon, mday, hour, min, sec);
 	now->tv_nsec = 0;
 }
 
-int vrtc_set_mmss(const struct timespec *now)
+int vrtc_set_mmss(const struct timespec64 *now)
 {
 	unsigned long flags;
 	struct rtc_time tm;
 	int year;
 	int retval = 0;
 
-	rtc_time_to_tm(now->tv_sec, &tm);
+	rtc_time64_to_tm(now->tv_sec, &tm);
 	if (!rtc_valid_tm(&tm) && tm.tm_year >= 72) {
 		/*
 		 * tm.year is the number of years since 1900, and the
@@ -110,8 +110,8 @@ int vrtc_set_mmss(const struct timespec *now)
 		vrtc_cmos_write(tm.tm_sec, RTC_SECONDS);
 		spin_unlock_irqrestore(&rtc_lock, flags);
 	} else {
-		pr_err("%s: Invalid vRTC value: write of %lx to vRTC failed\n",
-			__func__, now->tv_sec);
+		pr_err("%s: Invalid vRTC value: write of %llx to vRTC failed\n",
+			__func__, (s64)now->tv_sec);
 		retval = -EINVAL;
 	}
 	return retval;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 29163c43ebbd..e0f1bcf01d63 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -57,7 +57,7 @@ static u64 xen_clocksource_get_cycles(struct clocksource *cs)
 	return xen_clocksource_read();
 }
 
-static void xen_read_wallclock(struct timespec *ts)
+static void xen_read_wallclock(struct timespec64 *ts)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	struct pvclock_wall_clock *wall_clock = &(s->wc);
@@ -68,12 +68,12 @@ static void xen_read_wallclock(struct timespec *ts)
 	put_cpu_var(xen_vcpu);
 }
 
-static void xen_get_wallclock(struct timespec *now)
+static void xen_get_wallclock(struct timespec64 *now)
 {
 	xen_read_wallclock(now);
 }
 
-static int xen_set_wallclock(const struct timespec *now)
+static int xen_set_wallclock(const struct timespec64 *now)
 {
 	return -ENODEV;
 }
@@ -461,7 +461,7 @@ static void __init xen_time_init(void)
 {
 	struct pvclock_vcpu_time_info *pvti;
 	int cpu = smp_processor_id();
-	struct timespec tp;
+	struct timespec64 tp;
 
 	/* As Dom0 is never moved, no penalty on using TSC there */
 	if (xen_initial_domain())
@@ -479,7 +479,7 @@ static void __init xen_time_init(void)
 
 	/* Set initial system time with full resolution */
 	xen_read_wallclock(&tp);
-	do_settimeofday(&tp);
+	do_settimeofday64(&tp);
 
 	setup_force_cpu_cap(X86_FEATURE_TSC);
 
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 436b20337168..e5e1e61c538c 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += bug.h
+generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
diff --git a/arch/xtensa/include/uapi/asm/msgbuf.h b/arch/xtensa/include/uapi/asm/msgbuf.h
index 36e2e103ca38..d6915e9f071c 100644
--- a/arch/xtensa/include/uapi/asm/msgbuf.h
+++ b/arch/xtensa/include/uapi/asm/msgbuf.h
@@ -7,7 +7,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -21,19 +20,19 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __XTENSA_EB__
-	unsigned int	__unused1;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused3;
-	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
 #elif defined(__XTENSA_EL__)
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned int	__unused3;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
 #else
 # error processor byte order undefined!
 #endif
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index f61b6331a10c..09f348d643f1 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -14,7 +14,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  */
@@ -27,15 +26,15 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #ifdef __XTENSA_EL__
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;		/* last change time */
+	unsigned long	sem_ctime_high;
 #else
-	unsigned long	__unused1;
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused2;
-	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
 #endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 26550bdc8430..554a57a6a90f 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -4,10 +4,10 @@
  *
  * The shmid64_ds structure for Xtensa architecture.
  * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * between kernel and user space, but the padding is on the wrong
+ * side for big-endian xtensa, for historic reasons.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -20,42 +20,21 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
-#if defined (__XTENSA_EL__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
 	unsigned long		__unused4;
 	unsigned long		__unused5;
 };
-#elif defined (__XTENSA_EB__)
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-#else
-# error endian order not defined
-#endif
-
 
 struct shminfo64 {
 	unsigned long	shmmax;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7bdc6aaa0ba3..2016e0ed5865 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -18,7 +18,6 @@
 #include <linux/fs.h>
 #include <linux/blkpg.h>
 #include <linux/slab.h>
-#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/schid.h>
 #include <asm/cmb.h>
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 61822480a2a0..16a4e8528bbc 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index a78cea0c3a09..248b5db3eaa8 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/fs.h>
-#include <asm/compat.h>
 #include <asm/sclp_ctl.h>
 #include <asm/sclp.h>
 
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 17e411c57576..948ce82a7725 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -23,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/cma.h>
 #include <linux/mm.h>
-#include <asm/compat.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
 #include <asm/vmcp.h>
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 0015729d917d..8d9f36625ba5 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -16,7 +16,6 @@
 #include <linux/miscdevice.h>
 #include <linux/kernel_stat.h>
 
-#include <asm/compat.h>
 #include <asm/cio.h>
 #include <asm/chsc.h>
 #include <asm/isc.h>
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index dffd820731f2..f5a0d894d9ad 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -10,6 +10,7 @@
 #define KMSG_COMPONENT "qeth"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
@@ -32,7 +33,6 @@
 #include <asm/chpid.h>
 #include <asm/io.h>
 #include <asm/sysinfo.h>
-#include <asm/compat.h>
 #include <asm/diag.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
new file mode 100644
index 000000000000..28819451b6d1
--- /dev/null
+++ b/include/asm-generic/compat.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* This is an empty stub for 32-bit-only architectures */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 081281ad5772..cfc1b6383ae0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -7,8 +7,7 @@
  */
 
 #include <linux/types.h>
-
-#ifdef CONFIG_COMPAT
+#include <linux/compat_time.h>
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
@@ -21,8 +20,11 @@
 #include <linux/unistd.h>
 
 #include <asm/compat.h>
+
+#ifdef CONFIG_COMPAT
 #include <asm/siginfo.h>
 #include <asm/signal.h>
+#endif
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /*
@@ -83,6 +85,8 @@
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* COMPAT_SYSCALL_DEFINEx */
 
+#ifdef CONFIG_COMPAT
+
 #ifndef compat_user_stack_pointer
 #define compat_user_stack_pointer() current_user_stack_pointer()
 #endif
@@ -290,8 +294,6 @@ extern int compat_get_timespec(struct timespec *, const void __user *);
 extern int compat_put_timespec(const struct timespec *, void __user *);
 extern int compat_get_timeval(struct timeval *, const void __user *);
 extern int compat_put_timeval(const struct timeval *, void __user *);
-extern int compat_get_timespec64(struct timespec64 *, const void __user *);
-extern int compat_put_timespec64(const struct timespec64 *, void __user *);
 extern int get_compat_itimerspec64(struct itimerspec64 *its,
 			const struct compat_itimerspec __user *uits);
 extern int put_compat_itimerspec64(const struct itimerspec64 *its,
@@ -1016,7 +1018,9 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
+#ifndef in_compat_syscall
 static inline bool in_compat_syscall(void) { return false; }
+#endif
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
new file mode 100644
index 000000000000..31f2774f1994
--- /dev/null
+++ b/include/linux/compat_time.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_COMPAT_TIME_H
+#define _LINUX_COMPAT_TIME_H
+
+#include <linux/types.h>
+#include <linux/time64.h>
+
+typedef s32		compat_time_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+extern int compat_get_timespec64(struct timespec64 *, const void __user *);
+extern int compat_put_timespec64(const struct timespec64 *, void __user *);
+
+#endif /* _LINUX_COMPAT_TIME_H */
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bcfdb918cd81..5d83d0c1d06c 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/time64.h>
 
 struct timespec;
 struct compat_timespec;
@@ -15,9 +16,7 @@ struct pollfd;
 enum timespec_type {
 	TT_NONE		= 0,
 	TT_NATIVE	= 1,
-#ifdef CONFIG_COMPAT
 	TT_COMPAT	= 2,
-#endif
 };
 
 /*
@@ -40,10 +39,8 @@ struct restart_block {
 			clockid_t clockid;
 			enum timespec_type type;
 			union {
-				struct timespec __user *rmtp;
-#ifdef CONFIG_COMPAT
+				struct __kernel_timespec __user *rmtp;
 				struct compat_timespec __user *compat_rmtp;
-#endif
 			};
 			u64 expires;
 		} nanosleep;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 70fcda1a9049..b92cb79d38c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -536,7 +536,8 @@ asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
 /* kernel/hrtimer.c */
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp);
+asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
+			      struct __kernel_timespec __user *rmtp);
 
 /* kernel/itimer.c */
 asmlinkage long sys_getitimer(int which, struct itimerval __user *value);
@@ -567,14 +568,14 @@ asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				struct itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
-				const struct timespec __user *tp);
+				const struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_gettime(clockid_t which_clock,
-				struct timespec __user *tp);
+				struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_getres(clockid_t which_clock,
-				struct timespec __user *tp);
+				struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
-				const struct timespec __user *rqtp,
-				struct timespec __user *rmtp);
+				const struct __kernel_timespec __user *rqtp,
+				struct __kernel_timespec __user *rmtp);
 
 /* kernel/printk.c */
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
@@ -679,8 +680,8 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info);
 /* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
-asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
-asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
 
@@ -697,7 +698,7 @@ asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
-				const struct timespec __user *timeout);
+				const struct __kernel_timespec __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
 
diff --git a/include/linux/time.h b/include/linux/time.h
index 4b62a2c0a661..aed74463592d 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -10,9 +10,9 @@
 extern struct timezone sys_tz;
 
 int get_timespec64(struct timespec64 *ts,
-		const struct timespec __user *uts);
+		const struct __kernel_timespec __user *uts);
 int put_timespec64(const struct timespec64 *ts,
-		struct timespec __user *uts);
+		struct __kernel_timespec __user *uts);
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct itimerspec __user *uit);
 int put_itimerspec64(const struct itimerspec64 *it,
diff --git a/include/linux/time32.h b/include/linux/time32.h
index d2bcd4377b56..0b14f936100a 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -18,25 +18,14 @@
 /* timespec64 is defined as timespec here */
 static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
 {
-	return ts64;
+	return *(const struct timespec *)&ts64;
 }
 
 static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
 {
-	return ts;
+	return *(const struct timespec64 *)&ts;
 }
 
-# define timespec_equal			timespec64_equal
-# define timespec_compare		timespec64_compare
-# define set_normalized_timespec	set_normalized_timespec64
-# define timespec_add			timespec64_add
-# define timespec_sub			timespec64_sub
-# define timespec_valid			timespec64_valid
-# define timespec_valid_strict		timespec64_valid_strict
-# define timespec_to_ns			timespec64_to_ns
-# define ns_to_timespec			ns_to_timespec64
-# define timespec_add_ns		timespec64_add_ns
-
 #else
 static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
 {
@@ -55,6 +44,7 @@ static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
 	ret.tv_nsec = ts.tv_nsec;
 	return ret;
 }
+#endif
 
 static inline int timespec_equal(const struct timespec *a,
 				 const struct timespec *b)
@@ -159,8 +149,6 @@ static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
 	a->tv_nsec = ns;
 }
 
-#endif
-
 /**
  * time_to_tm - converts the calendar time to local broken-down time
  *
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 93d39499838e..0a7b2f79cec7 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -2,17 +2,20 @@
 #ifndef _LINUX_TIME64_H
 #define _LINUX_TIME64_H
 
-#include <uapi/linux/time.h>
 #include <linux/math64.h>
 
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
-#if __BITS_PER_LONG == 64
-/* this trick allows us to optimize out timespec64_to_timespec */
-# define timespec64 timespec
-#define itimerspec64 itimerspec
-#else
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timespec timespec
+#endif
+
+#include <uapi/linux/time.h>
+
 struct timespec64 {
 	time64_t	tv_sec;			/* seconds */
 	long		tv_nsec;		/* nanoseconds */
@@ -23,8 +26,6 @@ struct itimerspec64 {
 	struct timespec64 it_value;
 };
 
-#endif
-
 /* Parameters used to convert the timespec values: */
 #define MSEC_PER_SEC	1000L
 #define USEC_PER_MSEC	1000L
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 588a0e4b1ab9..86bc2026efce 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -19,27 +19,25 @@ extern void xtime_update(unsigned long ticks);
 extern int do_settimeofday64(const struct timespec64 *ts);
 extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
-/*
- * Kernel time accessors
- */
-struct timespec64 current_kernel_time64(void);
 
 /*
  * timespec64 based interfaces
  */
-struct timespec64 get_monotonic_coarse64(void);
-extern void getrawmonotonic64(struct timespec64 *ts);
+extern void ktime_get_raw_ts64(struct timespec64 *ts);
 extern void ktime_get_ts64(struct timespec64 *ts);
+extern void ktime_get_real_ts64(struct timespec64 *tv);
+extern void ktime_get_coarse_ts64(struct timespec64 *ts);
+extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+
+void getboottime64(struct timespec64 *ts);
+
+/*
+ * time64_t base interfaces
+ */
 extern time64_t ktime_get_seconds(void);
 extern time64_t __ktime_get_real_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
 
-extern int __getnstimeofday64(struct timespec64 *tv);
-extern void getnstimeofday64(struct timespec64 *tv);
-extern void getboottime64(struct timespec64 *ts);
-
-#define ktime_get_real_ts64(ts)	getnstimeofday64(ts)
-
 /*
  * ktime_t based interfaces
  */
@@ -53,6 +51,7 @@ enum tk_offsets {
 
 extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
@@ -65,6 +64,11 @@ static inline ktime_t ktime_get_real(void)
 	return ktime_get_with_offset(TK_OFFS_REAL);
 }
 
+static inline ktime_t ktime_get_coarse_real(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
+}
+
 /**
  * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
  *
@@ -76,6 +80,11 @@ static inline ktime_t ktime_get_boottime(void)
 	return ktime_get_with_offset(TK_OFFS_BOOT);
 }
 
+static inline ktime_t ktime_get_coarse_boottime(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
+}
+
 /**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
@@ -84,6 +93,11 @@ static inline ktime_t ktime_get_clocktai(void)
 	return ktime_get_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse_clocktai(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
@@ -123,18 +137,40 @@ extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
 /*
- * timespec64 interfaces utilizing the ktime based ones
+ * timespec64/time64_t interfaces utilizing the ktime based ones
+ * for API completeness, these could be implemented more efficiently
+ * if needed.
  */
-static inline void get_monotonic_boottime64(struct timespec64 *ts)
+static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_boottime());
 }
 
-static inline void timekeeping_clocktai64(struct timespec64 *ts)
+static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
+{
+	*ts = ktime_to_timespec64(ktime_get_coarse_boottime());
+}
+
+static inline time64_t ktime_get_boottime_seconds(void)
+{
+	return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
+}
+
+static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
 }
 
+static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
+{
+	*ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
+}
+
+static inline time64_t ktime_get_clocktai_seconds(void)
+{
+	return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
+}
+
 /*
  * RTC specific
  */
@@ -210,5 +246,30 @@ extern void read_persistent_clock64(struct timespec64 *ts);
 extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock64(struct timespec64 now);
 
+/*
+ * deprecated aliases, don't use in new code
+ */
+#define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
+#define get_monotonic_boottime64(ts)	ktime_get_boottime_ts64(ts)
+#define getrawmonotonic64(ts)		ktime_get_raw_ts64(ts)
+#define timekeeping_clocktai64(ts)	ktime_get_clocktai_ts64(ts)
+
+static inline struct timespec64 current_kernel_time64(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_real_ts64(&ts);
+
+	return ts;
+}
+
+static inline struct timespec64 get_monotonic_coarse64(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_ts64(&ts);
+
+	return ts;
+}
 
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 3616b4becb59..8762c2f45f8b 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -11,55 +11,13 @@ unsigned long get_seconds(void);
 
 static inline struct timespec current_kernel_time(void)
 {
-	struct timespec64 now = current_kernel_time64();
-
-	return timespec64_to_timespec(now);
-}
-
-#if BITS_PER_LONG == 64
-/**
- * Deprecated. Use do_settimeofday64().
- */
-static inline int do_settimeofday(const struct timespec *ts)
-{
-	return do_settimeofday64(ts);
-}
-
-static inline int __getnstimeofday(struct timespec *ts)
-{
-	return __getnstimeofday64(ts);
-}
-
-static inline void getnstimeofday(struct timespec *ts)
-{
-	getnstimeofday64(ts);
-}
-
-static inline void ktime_get_ts(struct timespec *ts)
-{
-	ktime_get_ts64(ts);
-}
-
-static inline void ktime_get_real_ts(struct timespec *ts)
-{
-	getnstimeofday64(ts);
-}
+	struct timespec64 ts64;
 
-static inline void getrawmonotonic(struct timespec *ts)
-{
-	getrawmonotonic64(ts);
-}
+	ktime_get_coarse_real_ts64(&ts64);
 
-static inline struct timespec get_monotonic_coarse(void)
-{
-	return get_monotonic_coarse64();
+	return timespec64_to_timespec(ts64);
 }
 
-static inline void getboottime(struct timespec *ts)
-{
-	return getboottime64(ts);
-}
-#else
 /**
  * Deprecated. Use do_settimeofday64().
  */
@@ -71,20 +29,11 @@ static inline int do_settimeofday(const struct timespec *ts)
 	return do_settimeofday64(&ts64);
 }
 
-static inline int __getnstimeofday(struct timespec *ts)
-{
-	struct timespec64 ts64;
-	int ret = __getnstimeofday64(&ts64);
-
-	*ts = timespec64_to_timespec(ts64);
-	return ret;
-}
-
 static inline void getnstimeofday(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getnstimeofday64(&ts64);
+	ktime_get_real_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
@@ -100,7 +49,7 @@ static inline void ktime_get_real_ts(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getnstimeofday64(&ts64);
+	ktime_get_real_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
@@ -108,13 +57,17 @@ static inline void getrawmonotonic(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getrawmonotonic64(&ts64);
+	ktime_get_raw_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
 static inline struct timespec get_monotonic_coarse(void)
 {
-	return timespec64_to_timespec(get_monotonic_coarse64());
+	struct timespec64 ts64;
+
+	ktime_get_coarse_ts64(&ts64);
+
+	return timespec64_to_timespec(ts64);
 }
 
 static inline void getboottime(struct timespec *ts)
@@ -124,7 +77,6 @@ static inline void getboottime(struct timespec *ts)
 	getboottime64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
-#endif
 
 /*
  * Timespec interfaces utilizing the ktime based ones
diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index fb306ebdb36f..9fe4881557cb 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -18,31 +18,30 @@
  * On big-endian systems, the padding is in the wrong place.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused3;
+#else
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_stime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_ctime;	/* last change time */
+	unsigned long	msg_ctime_high;
 #endif
-	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
-	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
-	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	 msg_qbytes;	/* max number of bytes on queue */
 	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
 	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	__kernel_ulong_t __unused4;
-	__kernel_ulong_t __unused5;
+	unsigned long	 __unused4;
+	unsigned long	 __unused5;
 };
 
 #endif /* __ASM_GENERIC_MSGBUF_H */
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index 5e6ea22bd525..f0733a26ebfc 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -87,6 +87,7 @@ typedef struct {
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
 typedef __kernel_long_t	__kernel_time_t;
+typedef long long __kernel_time64_t;
 typedef __kernel_long_t	__kernel_clock_t;
 typedef int		__kernel_timer_t;
 typedef int		__kernel_clockid_t;
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index cbf9cfe977d6..0bae010f1b64 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -13,23 +13,29 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
+ * 64 bit architectures use a 64-bit __kernel_time_t here, while
+ * 32 bit architectures have a pair of unsigned long values.
  * so they do not need the first two padding words.
- * On big-endian systems, the padding is in the wrong place.
  *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * On big-endian systems, the padding is in the wrong place for
+ * historic reasons, so user space has to reconstruct a time_t
+ * value using
+ *
+ * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
+ *		((long long)kernel_semid64_ds.sem_otime_high << 32)
+ *
+ * Pad space is left for 2 miscellaneous 32-bit values
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;	/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
+#else
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
 #endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2b6c3bb97f97..e504422fc501 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -19,42 +19,41 @@
  *
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused1;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused3;
+#else
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 #endif
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
-	__kernel_ulong_t	__unused4;
-	__kernel_ulong_t	__unused5;
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
 };
 
 struct shminfo64 {
-	__kernel_ulong_t	shmmax;
-	__kernel_ulong_t	shmmin;
-	__kernel_ulong_t	shmmni;
-	__kernel_ulong_t	shmseg;
-	__kernel_ulong_t	shmall;
-	__kernel_ulong_t	__unused1;
-	__kernel_ulong_t	__unused2;
-	__kernel_ulong_t	__unused3;
-	__kernel_ulong_t	__unused4;
+	unsigned long		shmmax;
+	unsigned long		shmmin;
+	unsigned long		shmmni;
+	unsigned long		shmseg;
+	unsigned long		shmall;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+	unsigned long		__unused3;
+	unsigned long		__unused4;
 };
 
 #endif /* __ASM_GENERIC_SHMBUF_H */
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 4c0338ea308a..fcf936656493 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,6 +42,13 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
+#ifndef __kernel_timespec
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif
+
 /*
  * legacy timeval structure, only embedded in structures that
  * traditionally used 'timeval' to pass time intervals (not absolute
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..c0d58f390c3b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -691,7 +691,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 	wake_up(&info->wait_q);
 }
 
-static int prepare_timeout(const struct timespec __user *u_abs_timeout,
+static int prepare_timeout(const struct __kernel_timespec __user *u_abs_timeout,
 			   struct timespec64 *ts)
 {
 	if (get_timespec64(ts, u_abs_timeout))
@@ -1128,7 +1128,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1142,7 +1142,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1420,6 +1420,47 @@ COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 	return do_mq_open(u_name, oflag, mode, p);
 }
 
+COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
+		       const struct compat_sigevent __user *, u_notification)
+{
+	struct sigevent n, *p = NULL;
+	if (u_notification) {
+		if (get_compat_sigevent(&n, u_notification))
+			return -EFAULT;
+		if (n.sigev_notify == SIGEV_THREAD)
+			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
+		p = &n;
+	}
+	return do_mq_notify(mqdes, p);
+}
+
+COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
+		       const struct compat_mq_attr __user *, u_mqstat,
+		       struct compat_mq_attr __user *, u_omqstat)
+{
+	int ret;
+	struct mq_attr mqstat, omqstat;
+	struct mq_attr *new = NULL, *old = NULL;
+
+	if (u_mqstat) {
+		new = &mqstat;
+		if (get_compat_mq_attr(new, u_mqstat))
+			return -EFAULT;
+	}
+	if (u_omqstat)
+		old = &omqstat;
+
+	ret = do_mq_getsetattr(mqdes, new, old);
+	if (ret || !old)
+		return ret;
+
+	if (put_compat_mq_attr(old, u_omqstat))
+		return -EFAULT;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 static int compat_prepare_timeout(const struct compat_timespec __user *p,
 				   struct timespec64 *ts)
 {
@@ -1459,45 +1500,6 @@ COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
-
-COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
-		       const struct compat_sigevent __user *, u_notification)
-{
-	struct sigevent n, *p = NULL;
-	if (u_notification) {
-		if (get_compat_sigevent(&n, u_notification))
-			return -EFAULT;
-		if (n.sigev_notify == SIGEV_THREAD)
-			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
-		p = &n;
-	}
-	return do_mq_notify(mqdes, p);
-}
-
-COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
-		       const struct compat_mq_attr __user *, u_mqstat,
-		       struct compat_mq_attr __user *, u_omqstat)
-{
-	int ret;
-	struct mq_attr mqstat, omqstat;
-	struct mq_attr *new = NULL, *old = NULL;
-
-	if (u_mqstat) {
-		new = &mqstat;
-		if (get_compat_mq_attr(new, u_mqstat))
-			return -EFAULT;
-	}
-	if (u_omqstat)
-		old = &omqstat;
-
-	ret = do_mq_getsetattr(mqdes, new, old);
-	if (ret || !old)
-		return ret;
-
-	if (put_compat_mq_attr(old, u_omqstat))
-		return -EFAULT;
-	return 0;
-}
 #endif
 
 static const struct inode_operations mqueue_dir_inode_operations = {
diff --git a/ipc/msg.c b/ipc/msg.c
index 56fd1c73eedc..3b6545302598 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -537,6 +537,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_stime  = msq->q_stime;
 	p->msg_rtime  = msq->q_rtime;
 	p->msg_ctime  = msq->q_ctime;
+#ifndef CONFIG_64BIT
+	p->msg_stime_high = msq->q_stime >> 32;
+	p->msg_rtime_high = msq->q_rtime >> 32;
+	p->msg_ctime_high = msq->q_ctime >> 32;
+#endif
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
@@ -646,9 +651,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		struct compat_msqid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.msg_perm, &in->msg_perm);
-		v.msg_stime = in->msg_stime;
-		v.msg_rtime = in->msg_rtime;
-		v.msg_ctime = in->msg_ctime;
+		v.msg_stime	 = lower_32_bits(in->msg_stime);
+		v.msg_stime_high = upper_32_bits(in->msg_stime);
+		v.msg_rtime	 = lower_32_bits(in->msg_rtime);
+		v.msg_rtime_high = upper_32_bits(in->msg_rtime);
+		v.msg_ctime	 = lower_32_bits(in->msg_ctime);
+		v.msg_ctime_high = upper_32_bits(in->msg_ctime);
 		v.msg_cbytes = in->msg_cbytes;
 		v.msg_qnum = in->msg_qnum;
 		v.msg_qbytes = in->msg_qbytes;
@@ -758,7 +766,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
-				msq->q_rtime = get_seconds();
+				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, msg);
@@ -859,7 +867,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	}
 
 	ipc_update_pid(&msq->q_lspid, task_tgid(current));
-	msq->q_stime = get_seconds();
+	msq->q_stime = ktime_get_real_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
 		/* no one is waiting for this message, enqueue it */
@@ -1087,7 +1095,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 
 			list_del(&msg->m_list);
 			msq->q_qnum--;
-			msq->q_rtime = get_seconds();
+			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..cfd94d48a9aa 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -70,6 +70,7 @@
  *   The worst-case behavior is nevertheless O(N^2) for N wakeups.
  */
 
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
@@ -104,7 +105,7 @@ struct sem {
 					/* that alter the semaphore */
 	struct list_head pending_const; /* pending single-sop operations */
 					/* that do not alter the semaphore*/
-	time_t	sem_otime;	/* candidate for sem_otime */
+	time64_t	 sem_otime;	/* candidate for sem_otime */
 } ____cacheline_aligned_in_smp;
 
 /* One sem_array data structure for each set of semaphores in the system. */
@@ -984,10 +985,10 @@ static int update_queue(struct sem_array *sma, int semnum, struct wake_q_head *w
 static void set_semotime(struct sem_array *sma, struct sembuf *sops)
 {
 	if (sops == NULL) {
-		sma->sems[0].sem_otime = get_seconds();
+		sma->sems[0].sem_otime = ktime_get_real_seconds();
 	} else {
 		sma->sems[sops[0].sem_num].sem_otime =
-							get_seconds();
+						ktime_get_real_seconds();
 	}
 }
 
@@ -1214,6 +1215,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1257,8 +1259,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	}
 
 	kernel_to_ipc64_perm(&sma->sem_perm, &semid64->sem_perm);
-	semid64->sem_otime = get_semotime(sma);
+	semotime = get_semotime(sma);
+	semid64->sem_otime = semotime;
 	semid64->sem_ctime = sma->sem_ctime;
+#ifndef CONFIG_64BIT
+	semid64->sem_otime_high = semotime >> 32;
+	semid64->sem_ctime_high = sma->sem_ctime >> 32;
+#endif
 	semid64->sem_nsems = sma->sem_nsems;
 
 	ipc_unlock_object(&sma->sem_perm);
@@ -1704,8 +1711,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		struct compat_semid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.sem_perm, &in->sem_perm);
-		v.sem_otime = in->sem_otime;
-		v.sem_ctime = in->sem_ctime;
+		v.sem_otime	 = lower_32_bits(in->sem_otime);
+		v.sem_otime_high = upper_32_bits(in->sem_otime);
+		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
+		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
 		return copy_to_user(buf, &v, sizeof(v));
 	} else {
@@ -2168,7 +2177,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
-		     unsigned int nsops, const struct timespec __user *timeout)
+		     unsigned int nsops, const struct __kernel_timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2180,12 +2189,12 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
-		unsigned int, nsops, const struct timespec __user *, timeout)
+		unsigned int, nsops, const struct __kernel_timespec __user *, timeout)
 {
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..0075990338f4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1002,6 +1002,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
+#ifndef CONFIG_64BIT
+	tbuf->shm_atime_high = shp->shm_atim >> 32;
+	tbuf->shm_dtime_high = shp->shm_dtim >> 32;
+	tbuf->shm_ctime_high = shp->shm_ctim >> 32;
+#endif
 	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
@@ -1233,9 +1238,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		struct compat_shmid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.shm_perm, &in->shm_perm);
-		v.shm_atime = in->shm_atime;
-		v.shm_dtime = in->shm_dtime;
-		v.shm_ctime = in->shm_ctime;
+		v.shm_atime	 = lower_32_bits(in->shm_atime);
+		v.shm_atime_high = upper_32_bits(in->shm_atime);
+		v.shm_dtime	 = lower_32_bits(in->shm_dtime);
+		v.shm_dtime_high = upper_32_bits(in->shm_dtime);
+		v.shm_ctime	 = lower_32_bits(in->shm_ctime);
+		v.shm_ctime_high = upper_32_bits(in->shm_ctime);
 		v.shm_segsz = in->shm_segsz;
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 77a883ef2eca..65d405f1ba0c 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -30,9 +30,14 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
 				       second, NULL);
 	case SEMTIMEDOP:
-		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
-				       second,
-				       (const struct timespec __user *)fifth);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			return ksys_semtimedop(first, ptr, second,
+			        (const struct __kernel_timespec __user *)fifth);
+		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return compat_ksys_semtimedop(first, ptr, second,
+			        (const struct compat_timespec __user *)fifth);
+		else
+			return -ENOSYS;
 
 	case SEMGET:
 		return ksys_semget(first, second, third);
@@ -130,6 +135,8 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		/* struct sembuf is the same on 32 and 64bit :)) */
 		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -ENOSYS;
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
diff --git a/ipc/util.h b/ipc/util.h
index acc5159e96d0..0aba3230d007 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -251,7 +251,7 @@ static inline int compat_ipc_parse_version(int *cmd)
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
-		     const struct timespec __user *timeout);
+		     const struct __kernel_timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
@@ -265,10 +265,10 @@ long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
-#ifdef CONFIG_COMPAT
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
+#ifdef CONFIG_COMPAT
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
diff --git a/kernel/compat.c b/kernel/compat.c
index 92d8c98c0f57..702aa846ddac 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -121,50 +121,6 @@ static int __compat_put_timespec(const struct timespec *ts, struct compat_timesp
 			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-static int __compat_get_timespec64(struct timespec64 *ts64,
-				   const struct compat_timespec __user *cts)
-{
-	struct compat_timespec ts;
-	int ret;
-
-	ret = copy_from_user(&ts, cts, sizeof(ts));
-	if (ret)
-		return -EFAULT;
-
-	ts64->tv_sec = ts.tv_sec;
-	ts64->tv_nsec = ts.tv_nsec;
-
-	return 0;
-}
-
-static int __compat_put_timespec64(const struct timespec64 *ts64,
-				   struct compat_timespec __user *cts)
-{
-	struct compat_timespec ts = {
-		.tv_sec = ts64->tv_sec,
-		.tv_nsec = ts64->tv_nsec
-	};
-	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
-}
-
-int compat_get_timespec64(struct timespec64 *ts, const void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_get_timespec64(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_get_timespec64);
-
-int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_put_timespec64(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_put_timespec64);
-
 int compat_get_timeval(struct timeval *tv, const void __user *utv)
 {
 	if (COMPAT_USE_64BIT_TIME)
@@ -368,6 +324,14 @@ COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
 	return ret;
 }
 
+/* Todo: Delete these extern declarations when get/put_compat_itimerspec64()
+ * are moved to kernel/time/time.c .
+ */
+extern int __compat_get_timespec64(struct timespec64 *ts64,
+				   const struct compat_timespec __user *cts);
+extern int __compat_put_timespec64(const struct timespec64 *ts64,
+				   struct compat_timespec __user *cts);
+
 int get_compat_itimerspec64(struct itimerspec64 *its,
 			const struct compat_itimerspec __user *uits)
 {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 14e858753d76..055a4a728c00 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1759,8 +1759,10 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	return ret;
 }
 
-SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 tu;
 
@@ -1775,7 +1777,9 @@ SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
-#ifdef CONFIG_COMPAT
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
 		       struct compat_timespec __user *, rmtp)
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 69a937c3cd81..26aa9569e24a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -59,7 +59,7 @@ SYS_NI(alarm);
  */
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		const struct timespec __user *, tp)
+		const struct __kernel_timespec __user *, tp)
 {
 	struct timespec64 new_tp;
 
@@ -90,7 +90,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
-		struct timespec __user *, tp)
+		struct __kernel_timespec __user *, tp)
 {
 	int ret;
 	struct timespec64 kernel_tp;
@@ -104,7 +104,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return 0;
 }
 
-SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct timespec __user *, tp)
+SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_timespec __user *, tp)
 {
 	struct timespec64 rtn_tp = {
 		.tv_sec = 0,
@@ -124,8 +124,8 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct timespec __us
 }
 
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
-		const struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+		const struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 t;
 
@@ -158,7 +158,9 @@ COMPAT_SYS_NI(timer_settime);
 COMPAT_SYS_NI(timer_gettime);
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
+#endif
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 10b7186d0638..e08ce3f27447 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1040,7 +1040,7 @@ void exit_itimers(struct signal_struct *sig)
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		const struct timespec __user *, tp)
+		const struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 new_tp;
@@ -1055,7 +1055,7 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
-		struct timespec __user *,tp)
+		struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 kernel_tp;
@@ -1096,7 +1096,7 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
-		struct timespec __user *, tp)
+		struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 rtn_tp;
@@ -1113,7 +1113,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
@@ -1148,6 +1148,10 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT
+
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct compat_timex __user *, utp)
 {
@@ -1172,6 +1176,10 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 	return err;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
 {
@@ -1203,8 +1211,8 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 }
 
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
-		const struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+		const struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 t;
@@ -1227,7 +1235,8 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 	return kc->nsleep(which_clock, flags, &t);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 		       struct compat_timespec __user *, rqtp,
 		       struct compat_timespec __user *, rmtp)
@@ -1252,6 +1261,7 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 
 	return kc->nsleep(which_clock, flags, &t);
 }
+
 #endif
 
 static const struct k_clock clock_realtime = {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 3044d48ebe56..6fa99213fc72 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -407,7 +407,6 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-#if __BITS_PER_LONG == 32
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *
@@ -468,7 +467,6 @@ struct timespec ns_to_timespec(const s64 nsec)
 	return ts;
 }
 EXPORT_SYMBOL(ns_to_timespec);
-#endif
 
 /**
  * ns_to_timeval - Convert nanoseconds to timeval
@@ -853,9 +851,9 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
 }
 
 int get_timespec64(struct timespec64 *ts,
-		   const struct timespec __user *uts)
+		   const struct __kernel_timespec __user *uts)
 {
-	struct timespec kts;
+	struct __kernel_timespec kts;
 	int ret;
 
 	ret = copy_from_user(&kts, uts, sizeof(kts));
@@ -863,6 +861,11 @@ int get_timespec64(struct timespec64 *ts,
 		return -EFAULT;
 
 	ts->tv_sec = kts.tv_sec;
+
+	/* Zero out the padding for 32 bit systems or in compat mode */
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
+		kts.tv_nsec &= 0xFFFFFFFFUL;
+
 	ts->tv_nsec = kts.tv_nsec;
 
 	return 0;
@@ -870,16 +873,61 @@ int get_timespec64(struct timespec64 *ts,
 EXPORT_SYMBOL_GPL(get_timespec64);
 
 int put_timespec64(const struct timespec64 *ts,
-		   struct timespec __user *uts)
+		   struct __kernel_timespec __user *uts)
 {
-	struct timespec kts = {
+	struct __kernel_timespec kts = {
 		.tv_sec = ts->tv_sec,
 		.tv_nsec = ts->tv_nsec
 	};
+
 	return copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
 
+int __compat_get_timespec64(struct timespec64 *ts64,
+				   const struct compat_timespec __user *cts)
+{
+	struct compat_timespec ts;
+	int ret;
+
+	ret = copy_from_user(&ts, cts, sizeof(ts));
+	if (ret)
+		return -EFAULT;
+
+	ts64->tv_sec = ts.tv_sec;
+	ts64->tv_nsec = ts.tv_nsec;
+
+	return 0;
+}
+
+int __compat_put_timespec64(const struct timespec64 *ts64,
+				   struct compat_timespec __user *cts)
+{
+	struct compat_timespec ts = {
+		.tv_sec = ts64->tv_sec,
+		.tv_nsec = ts64->tv_nsec
+	};
+	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
+}
+
+int compat_get_timespec64(struct timespec64 *ts, const void __user *uts)
+{
+	if (COMPAT_USE_64BIT_TIME)
+		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
+	else
+		return __compat_get_timespec64(ts, uts);
+}
+EXPORT_SYMBOL_GPL(compat_get_timespec64);
+
+int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
+{
+	if (COMPAT_USE_64BIT_TIME)
+		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
+	else
+		return __compat_put_timespec64(ts, uts);
+}
+EXPORT_SYMBOL_GPL(compat_put_timespec64);
+
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct itimerspec __user *uit)
 {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbceef5deb..4786df904c22 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -705,18 +705,19 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 }
 
 /**
- * __getnstimeofday64 - Returns the time of day in a timespec64.
+ * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
  *
- * Updates the time of day in the timespec.
- * Returns 0 on success, or -ve when suspended (timespec will be undefined).
+ * Returns the time of day in a timespec64 (WARN if suspended).
  */
-int __getnstimeofday64(struct timespec64 *ts)
+void ktime_get_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long seq;
 	u64 nsecs;
 
+	WARN_ON(timekeeping_suspended);
+
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
@@ -727,28 +728,8 @@ int __getnstimeofday64(struct timespec64 *ts)
 
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
-
-	/*
-	 * Do not bail out early, in case there were callers still using
-	 * the value, even in the face of the WARN_ON.
-	 */
-	if (unlikely(timekeeping_suspended))
-		return -EAGAIN;
-	return 0;
-}
-EXPORT_SYMBOL(__getnstimeofday64);
-
-/**
- * getnstimeofday64 - Returns the time of day in a timespec64.
- * @ts:		pointer to the timespec64 to be set
- *
- * Returns the time of day in a timespec64 (WARN if suspended).
- */
-void getnstimeofday64(struct timespec64 *ts)
-{
-	WARN_ON(__getnstimeofday64(ts));
 }
-EXPORT_SYMBOL(getnstimeofday64);
+EXPORT_SYMBOL(ktime_get_real_ts64);
 
 ktime_t ktime_get(void)
 {
@@ -814,6 +795,25 @@ ktime_t ktime_get_with_offset(enum tk_offsets offs)
 }
 EXPORT_SYMBOL_GPL(ktime_get_with_offset);
 
+ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	ktime_t base, *offset = offsets[offs];
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		base = ktime_add(tk->tkr_mono.base, *offset);
+
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return base;
+
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
+
 /**
  * ktime_mono_to_any() - convert mononotic time to any other time
  * @tmono:	time to convert.
@@ -1410,12 +1410,12 @@ int timekeeping_notify(struct clocksource *clock)
 }
 
 /**
- * getrawmonotonic64 - Returns the raw monotonic time in a timespec
+ * ktime_get_raw_ts64 - Returns the raw monotonic time in a timespec
  * @ts:		pointer to the timespec64 to be set
  *
  * Returns the raw monotonic time (completely un-modified by ntp)
  */
-void getrawmonotonic64(struct timespec64 *ts)
+void ktime_get_raw_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long seq;
@@ -1431,7 +1431,7 @@ void getrawmonotonic64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
 }
-EXPORT_SYMBOL(getrawmonotonic64);
+EXPORT_SYMBOL(ktime_get_raw_ts64);
 
 
 /**
@@ -2133,23 +2133,20 @@ unsigned long get_seconds(void)
 }
 EXPORT_SYMBOL(get_seconds);
 
-struct timespec64 current_kernel_time64(void)
+void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct timespec64 now;
 	unsigned long seq;
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		now = tk_xtime(tk);
+		*ts = tk_xtime(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	return now;
 }
-EXPORT_SYMBOL(current_kernel_time64);
+EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
-struct timespec64 get_monotonic_coarse64(void)
+void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 now, mono;
@@ -2162,12 +2159,10 @@ struct timespec64 get_monotonic_coarse64(void)
 		mono = tk->wall_to_monotonic;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	set_normalized_timespec64(&now, now.tv_sec + mono.tv_sec,
+	set_normalized_timespec64(ts, now.tv_sec + mono.tv_sec,
 				now.tv_nsec + mono.tv_nsec);
-
-	return now;
 }
-EXPORT_SYMBOL(get_monotonic_coarse64);
+EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
 /*
  * Must hold jiffies_lock
