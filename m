Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeFDKUv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:20:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeFDKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:20:48 -0400
Date: Mon, 4 Jun 2018 12:20:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041210200.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

A set of updates for timers and timekeeping:

 - Core infrastucture work for Y2038 to address the COMPAT interfaces:

    - Add a new Y2038 safe __kernel_timespec and use it in the core code
    - Introduce config switches which allow to control the various compat
      mechanisms
    - Use the new config switch in the posix timer code to control the
      32bit compat syscall implementation.

 - Prevent bogus selection of CPU local clocksources which causes an
   endless reselection loop.

 - Remove the extra kthread in the clocksource code which has no value and
   just adds another level of indirection.

 - The usual bunch of trivial updates, cleanups and fixlets all over the
   place.
 
 - More SPDX conversions.

Thanks,

	tglx

------------------>
Arnd Bergmann (2):
      time: Add an asm-generic/compat.h file
      sparc: compat: Allow including asm/compat.h for 32-bit

Chen Lin (1):
      timer_list: Remove unused function pointer typedef

Chunyan Zhang (1):
      clocksource/drivers/sprd: Fix Kconfig dependency

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

Eugeniy Paltsev (1):
      clocksource/drivers/arc_timer: Add comments about locking while read GFRC

Fabio Estevam (4):
      clocksource/drivers/timer-imx-gpt: Remove outdated file path
      clocksource/drivers/timer-imx-gpt: Switch to SPDX identifier
      clocksource/drivers/timer-imx-tpm: Switch to SPDX identifier
      clocksource/drivers/mxs_timer: Switch to SPDX identifier

Mathieu Malaterre (1):
      clocksource: Move inline keyword to the beginning of function declarations

Matt Redfearn (1):
      clocksource/drivers/mips-gic-timer: Add pr_fmt and reword pr_* messages

Mauro Carvalho Chehab (1):
      timers: Adjust a kernel-doc comment

Peter Zijlstra (1):
      clocksource: Remove kthread

Sudeep Holla (1):
      tick: Prefer a lower rating device only if it's CPU local device


 arch/Kconfig                           | 15 +++++++++
 arch/alpha/include/asm/Kbuild          |  1 +
 arch/arc/include/asm/Kbuild            |  1 +
 arch/arm/include/asm/Kbuild            |  1 +
 arch/arm64/include/asm/compat.h        | 11 -------
 arch/arm64/include/asm/stat.h          |  1 +
 arch/arm64/kernel/hw_breakpoint.c      |  1 -
 arch/arm64/kernel/perf_regs.c          |  2 +-
 arch/c6x/include/asm/Kbuild            |  1 +
 arch/h8300/include/asm/Kbuild          |  1 +
 arch/hexagon/include/asm/Kbuild        |  1 +
 arch/ia64/include/asm/Kbuild           |  1 +
 arch/m68k/include/asm/Kbuild           |  1 +
 arch/microblaze/include/asm/Kbuild     |  1 +
 arch/mips/include/asm/compat.h         | 11 -------
 arch/mips/kernel/signal32.c            |  2 +-
 arch/nds32/include/asm/Kbuild          |  1 +
 arch/nios2/include/asm/Kbuild          |  1 +
 arch/openrisc/include/asm/Kbuild       |  1 +
 arch/parisc/include/asm/compat.h       | 11 -------
 arch/powerpc/include/asm/compat.h      | 11 -------
 arch/powerpc/kernel/asm-offsets.c      |  2 +-
 arch/powerpc/oprofile/backtrace.c      |  1 +
 arch/s390/hypfs/hypfs_sprp.c           |  1 -
 arch/s390/include/asm/compat.h         | 11 -------
 arch/s390/include/asm/elf.h            |  4 +--
 arch/s390/kvm/priv.c                   |  1 -
 arch/s390/pci/pci_clp.c                |  1 -
 arch/sh/include/asm/Kbuild             |  1 +
 arch/sparc/include/asm/compat.h        | 15 +++------
 arch/um/include/asm/Kbuild             |  1 +
 arch/unicore32/include/asm/Kbuild      |  1 +
 arch/x86/events/core.c                 |  2 +-
 arch/x86/include/asm/compat.h          | 11 -------
 arch/x86/include/asm/ftrace.h          |  2 +-
 arch/x86/kernel/sys_x86_64.c           |  2 +-
 arch/xtensa/include/asm/Kbuild         |  1 +
 drivers/clocksource/Kconfig            |  4 ++-
 drivers/clocksource/arc_timer.c        | 14 ++++++++
 drivers/clocksource/mips-gic-timer.c   | 18 ++++++-----
 drivers/clocksource/mxs_timer.c        | 28 ++++------------
 drivers/clocksource/timer-imx-gpt.c    | 28 ++++------------
 drivers/clocksource/timer-imx-tpm.c    | 13 +++-----
 drivers/s390/block/dasd_ioctl.c        |  1 -
 drivers/s390/char/fs3270.c             |  1 -
 drivers/s390/char/sclp_ctl.c           |  1 -
 drivers/s390/char/vmcp.c               |  1 -
 drivers/s390/cio/chsc_sch.c            |  1 -
 drivers/s390/net/qeth_core_main.c      |  2 +-
 include/asm-generic/compat.h           |  3 ++
 include/linux/compat.h                 | 12 ++++---
 include/linux/compat_time.h            | 23 ++++++++++++++
 include/linux/restart_block.h          |  7 ++--
 include/linux/syscalls.h               | 13 ++++----
 include/linux/time.h                   |  4 +--
 include/linux/time64.h                 | 10 +++++-
 include/uapi/asm-generic/posix_types.h |  1 +
 include/uapi/linux/time.h              |  7 ++++
 kernel/compat.c                        | 52 +++++-------------------------
 kernel/time/clocksource.c              | 35 +++++++-------------
 kernel/time/hrtimer.c                  | 10 ++++--
 kernel/time/posix-stubs.c              | 12 ++++---
 kernel/time/posix-timers.c             | 24 ++++++++++----
 kernel/time/tick-common.c              |  3 +-
 kernel/time/time.c                     | 58 +++++++++++++++++++++++++++++++---
 kernel/time/timer.c                    | 14 ++++----
 kernel/time/timer_list.c               |  2 --
 67 files changed, 266 insertions(+), 270 deletions(-)
 create mode 100644 include/asm-generic/compat.h
 create mode 100644 include/linux/compat_time.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..4377b0cec976 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -870,6 +870,21 @@ config OLD_SIGACTION
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
index c00c62e1a4a3..0030f79808b3 100644
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
index 9a0fa66b81ac..3e548ee99a2f 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -14,7 +14,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_suseconds_t;
 
@@ -46,16 +45,6 @@ typedef u32		compat_ulong_t;
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
index 57b8b2a2fd4e..0cdfec8857bd 100644
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
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 62168e1158f1..b4773c81f7d5 100644
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
index 9830fb6b076e..501aaff85304 100644
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
index 615283e16f22..1910c44521e3 100644
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
index a6006e7bb729..7a987e6c7c35 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2391,7 +2391,7 @@ static unsigned long get_segment_base(unsigned int segment)
 
 #ifdef CONFIG_IA32_EMULATION
 
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 static inline int
 perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index e1c8dab86670..7cd314b71c51 100644
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
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8e8a09755d10..dec0dd88ec15 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -450,8 +450,10 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if COMPILE_TEST
+	bool "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
+	depends on (ARCH_SPRD || COMPILE_TEST)
+	default ARCH_SPRD
 	select TIMER_OF
 	help
 	  Enables support for the Spreadtrum timer driver.
diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 471b428d8034..20da9b1d7f7d 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -61,6 +61,20 @@ static u64 arc_read_gfrc(struct clocksource *cs)
 	unsigned long flags;
 	u32 l, h;
 
+	/*
+	 * From a programming model pov, there seems to be just one instance of
+	 * MCIP_CMD/MCIP_READBACK however micro-architecturally there's
+	 * an instance PER ARC CORE (not per cluster), and there are dedicated
+	 * hardware decode logic (per core) inside ARConnect to handle
+	 * simultaneous read/write accesses from cores via those two registers.
+	 * So several concurrent commands to ARConnect are OK if they are
+	 * trying to access two different sub-components (like GFRC,
+	 * inter-core interrupt, etc...). HW also supports simultaneously
+	 * accessing GFRC by multiple cores.
+	 * That's why it is safe to disable hard interrupts on the local CPU
+	 * before access to GFRC instead of taking global MCIP spinlock
+	 * defined in arch/arc/kernel/mcip.c
+	 */
 	local_irq_save(flags);
 
 	__mcip_cmd(CMD_GFRC_READ_LO, 0);
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 986b6796b631..54f8a331b53a 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -5,6 +5,9 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+
+#define pr_fmt(fmt) "mips-gic-timer: " fmt
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -136,8 +139,7 @@ static int gic_clockevent_init(void)
 
 	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 	if (ret < 0) {
-		pr_err("GIC timer IRQ %d setup failed: %d\n",
-		       gic_timer_irq, ret);
+		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
 		return ret;
 	}
 
@@ -176,7 +178,7 @@ static int __init __gic_clocksource_init(void)
 
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
-		pr_warn("GIC: Unable to register clocksource\n");
+		pr_warn("Unable to register clocksource\n");
 
 	return ret;
 }
@@ -188,7 +190,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 
 	if (!mips_gic_present() || !node->parent ||
 	    !of_device_is_compatible(node->parent, "mti,gic")) {
-		pr_warn("No DT definition for the mips gic driver\n");
+		pr_warn("No DT definition\n");
 		return -ENXIO;
 	}
 
@@ -196,7 +198,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		ret = clk_prepare_enable(clk);
 		if (ret < 0) {
-			pr_err("GIC failed to enable clock\n");
+			pr_err("Failed to enable clock\n");
 			clk_put(clk);
 			return ret;
 		}
@@ -204,12 +206,12 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 		gic_frequency = clk_get_rate(clk);
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
-		pr_err("GIC frequency not specified.\n");
+		pr_err("Frequency not specified\n");
 		return -EINVAL;
 	}
 	gic_timer_irq = irq_of_parse_and_map(node, 0);
 	if (!gic_timer_irq) {
-		pr_err("GIC timer IRQ not specified.\n");
+		pr_err("IRQ not specified\n");
 		return -EINVAL;
 	}
 
@@ -220,7 +222,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	ret = gic_clockevent_init();
 	if (!ret && !IS_ERR(clk)) {
 		if (clk_notifier_register(clk, &gic_clk_nb) < 0)
-			pr_warn("GIC: Unable to register clock notifier\n");
+			pr_warn("Unable to register clock notifier\n");
 	}
 
 	/* And finally start the counter */
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index a03434e9fe8f..f6ddae30933f 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -1,24 +1,10 @@
-/*
- *  Copyright (C) 2000-2001 Deep Blue Solutions
- *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
- *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
- *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
- *  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  Copyright (C) 2000-2001 Deep Blue Solutions
+//  Copyright (C) 2002 Shane Nay (shane@minirl.com)
+//  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
+//  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
+//  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/err.h>
 #include <linux/interrupt.h>
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6ec6d79b237c..165fbbb1c9a0 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -1,25 +1,9 @@
-/*
- *  linux/arch/arm/plat-mxc/time.c
- *
- *  Copyright (C) 2000-2001 Deep Blue Solutions
- *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
- *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
- *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  Copyright (C) 2000-2001 Deep Blue Solutions
+//  Copyright (C) 2002 Shane Nay (shane@minirl.com)
+//  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
+//  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 6c8318470b48..b7aa2b817078 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -1,12 +1,7 @@
-/*
- * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2017 NXP
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2017 NXP
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
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
index 70fcda1a9049..c9a2a2601852 100644
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
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 93d39499838e..0d96887ba4e0 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -2,12 +2,20 @@
 #ifndef _LINUX_TIME64_H
 #define _LINUX_TIME64_H
 
-#include <uapi/linux/time.h>
 #include <linux/math64.h>
 
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timespec timespec
+#endif
+
+#include <uapi/linux/time.h>
+
 #if __BITS_PER_LONG == 64
 /* this trick allows us to optimize out timespec64_to_timespec */
 # define timespec64 timespec
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
diff --git a/kernel/compat.c b/kernel/compat.c
index 6d21894806b4..51a081b46832 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -120,50 +120,6 @@ static int __compat_put_timespec(const struct timespec *ts, struct compat_timesp
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
@@ -367,6 +323,14 @@ COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
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
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 84f37420fcf5..f89a78e2792b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -129,31 +129,19 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
 
-static int clocksource_watchdog_kthread(void *data);
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
-
 /*
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
 
-static void clocksource_watchdog_work(struct work_struct *work)
-{
-	/*
-	 * If kthread_run fails the next watchdog scan over the
-	 * watchdog_list will find the unstable clock again.
-	 */
-	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
-}
-
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
 	/*
-	 * If the clocksource is registered clocksource_watchdog_kthread() will
+	 * If the clocksource is registered clocksource_watchdog_work() will
 	 * re-rate and re-select.
 	 */
 	if (list_empty(&cs->list)) {
@@ -164,7 +152,7 @@ static void __clocksource_unstable(struct clocksource *cs)
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
-	/* kick clocksource_watchdog_kthread() */
+	/* kick clocksource_watchdog_work() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -174,7 +162,7 @@ static void __clocksource_unstable(struct clocksource *cs)
  * @cs:		clocksource to be marked unstable
  *
  * This function is called by the x86 TSC code to mark clocksources as unstable;
- * it defers demotion and re-selection to a kthread.
+ * it defers demotion and re-selection to a work.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -399,7 +387,9 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
 	}
 }
 
-static int __clocksource_watchdog_kthread(void)
+static void __clocksource_change_rating(struct clocksource *cs, int rating);
+
+static int __clocksource_watchdog_work(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
@@ -424,13 +414,12 @@ static int __clocksource_watchdog_kthread(void)
 	return select;
 }
 
-static int clocksource_watchdog_kthread(void *data)
+static void clocksource_watchdog_work(struct work_struct *work)
 {
 	mutex_lock(&clocksource_mutex);
-	if (__clocksource_watchdog_kthread())
+	if (__clocksource_watchdog_work())
 		clocksource_select();
 	mutex_unlock(&clocksource_mutex);
-	return 0;
 }
 
 static bool clocksource_is_watchdog(struct clocksource *cs)
@@ -449,12 +438,12 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 static void clocksource_select_watchdog(bool fallback) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
-static inline int __clocksource_watchdog_kthread(void) { return 0; }
+static inline int __clocksource_watchdog_work(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
-static void inline clocksource_watchdog_lock(unsigned long *flags) { }
-static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+static inline void clocksource_watchdog_lock(unsigned long *flags) { }
+static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
@@ -683,7 +672,7 @@ static int __init clocksource_done_booting(void)
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
-	__clocksource_watchdog_kthread();
+	__clocksource_watchdog_work();
 	clocksource_select();
 	mutex_unlock(&clocksource_mutex);
 	return 0;
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
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..78e598334007 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -277,7 +277,8 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	 */
 	return !curdev ||
 		newdev->rating > curdev->rating ||
-	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
+	       (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
+	        !tick_check_percpu(curdev, newdev, smp_processor_id()));
 }
 
 /*
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 3044d48ebe56..ccd751e95fcb 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -853,9 +853,9 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
 }
 
 int get_timespec64(struct timespec64 *ts,
-		   const struct timespec __user *uts)
+		   const struct __kernel_timespec __user *uts)
 {
-	struct timespec kts;
+	struct __kernel_timespec kts;
 	int ret;
 
 	ret = copy_from_user(&kts, uts, sizeof(kts));
@@ -863,6 +863,11 @@ int get_timespec64(struct timespec64 *ts,
 		return -EFAULT;
 
 	ts->tv_sec = kts.tv_sec;
+
+	/* Zero out the padding for 32 bit systems or in compat mode */
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
+		kts.tv_nsec &= 0xFFFFFFFFUL;
+
 	ts->tv_nsec = kts.tv_nsec;
 
 	return 0;
@@ -870,16 +875,61 @@ int get_timespec64(struct timespec64 *ts,
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
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4a4fd567fb26..cc2d23e6ff61 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1251,18 +1251,18 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  *
  * Note: For !irqsafe timers, you must not hold locks that are held in
  *   interrupt context while calling this function. Even if the lock has
- *   nothing to do with the timer in question.  Here's why:
+ *   nothing to do with the timer in question.  Here's why::
  *
  *    CPU0                             CPU1
  *    ----                             ----
- *                                   <SOFTIRQ>
- *                                   call_timer_fn();
- *                                     base->running_timer = mytimer;
- *  spin_lock_irq(somelock);
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer = mytimer;
+ *    spin_lock_irq(somelock);
  *                                     <IRQ>
  *                                        spin_lock(somelock);
- *  del_timer_sync(mytimer);
- *   while (base->running_timer == mytimer);
+ *    del_timer_sync(mytimer);
+ *    while (base->running_timer == mytimer);
  *
  * Now del_timer_sync() will never return and never release somelock.
  * The interrupt on the other CPU is waiting to grab somelock but
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 0ed768b56c60..ddc1d58f96c7 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -28,8 +28,6 @@ struct timer_list_iter {
 	u64 now;
 };
 
-typedef void (*print_fn_t)(struct seq_file *m, unsigned int *classes);
-
 /*
  * This allows printing both to /proc/timer_list and
  * to the console (on SysRq-Q):
