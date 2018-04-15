Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDOSG0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:06:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47475 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDOSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:06:22 -0400
Date: Sun, 15 Apr 2018 20:06:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 updates for 4.17 
Message-ID: <alpine.DEB.2.21.1804151950160.17929@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of fixes and updates for x86:

 - Address a swiotlb regression which was caused by the recent DMA rework
   and made driver fail because dma_direct_supported() returned false

 - Fix a signedness bug in the APIC ID validation which caused invalid APIC
   IDs to be detected as valid thereby bloating the CPU possible space.

 - Fix inconsisten config dependcy/select magic for the MFD_CS5535 driver.

 - Fix a corruption of the physical address space bits when encryption has
   reduced the address space and late cpuinfo updates overwrite the reduced
   bit information with the original value.

 - Dominiks syscall rework which consolidates the architecture specific
   syscall functions so all syscalls can be wrapped with the same
   macros. This allows to switch x86/64 to struct pt_regs based syscalls.
   Extend the clearing of user space controlled registers in the entry
   patch to the lower registers.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/olpc: Fix inconsistent MFD_CS5535 configuration

Christoph Hellwig (1):
      swiotlb: Use dma_direct_supported() for swiotlb_ops

Dominik Brodowski (10):
      syscalls/core: Introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
      syscalls/x86: Use 'struct pt_regs' based syscall calling convention for 64-bit syscalls
      syscalls/core: Prepare CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y for compat syscalls
      syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32
      syscalls/x86: Unconditionally enable 'struct pt_regs' based syscalls on x86_64
      syscalls/x86: Extend register clearing on syscall entry to lower registers
      syscalls/core, syscalls/x86: Clean up syscall stub naming convention
      syscalls/core, syscalls/x86: Clean up compat syscall stub naming convention
      syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()
      syscalls/x86: Adapt syscall_wrapper.h to the new syscall stub naming convention

Kirill A. Shutemov (2):
      x86/mm: Fix documentation of module mapping range with 4-level paging
      x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption

Li RongQing (1):
      x86/apic: Fix signedness bug in APIC ID validity checks

Linus Torvalds (1):
      x86/syscalls: Don't pointlessly reload the system call number

Ralf Ramsauer (1):
      x86/cpuid: Switch to 'static const' specifier


 Documentation/process/adding-syscalls.rst |   4 +-
 Documentation/x86/x86_64/mm.txt           |   2 +-
 arch/x86/Kconfig                          |   5 +-
 arch/x86/entry/calling.h                  |   2 +
 arch/x86/entry/common.c                   |  20 +-
 arch/x86/entry/entry_64.S                 |   3 +-
 arch/x86/entry/entry_64_compat.S          |   6 +
 arch/x86/entry/syscall_32.c               |  15 +-
 arch/x86/entry/syscall_64.c               |   6 +-
 arch/x86/entry/syscalls/syscall_32.tbl    | 723 +++++++++++++++---------------
 arch/x86/entry/syscalls/syscall_64.tbl    | 712 ++++++++++++++---------------
 arch/x86/entry/syscalls/syscalltbl.sh     |  14 +-
 arch/x86/entry/vsyscall/vsyscall_64.c     |  18 +-
 arch/x86/include/asm/apic.h               |   4 +-
 arch/x86/include/asm/syscall.h            |   4 +
 arch/x86/include/asm/syscall_wrapper.h    | 209 +++++++++
 arch/x86/include/asm/syscalls.h           |  17 +-
 arch/x86/kernel/acpi/boot.c               |  13 +-
 arch/x86/kernel/apic/apic_common.c        |   2 +-
 arch/x86/kernel/apic/apic_numachip.c      |   2 +-
 arch/x86/kernel/apic/x2apic.h             |   2 +-
 arch/x86/kernel/apic/x2apic_phys.c        |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c        |   2 +-
 arch/x86/kernel/cpu/common.c              |  32 +-
 arch/x86/kernel/cpu/cpuid-deps.c          |   2 +-
 arch/x86/xen/apic.c                       |   2 +-
 include/linux/compat.h                    |  51 ++-
 include/linux/syscalls.h                  |  42 +-
 init/Kconfig                              |  10 +
 kernel/sys_ni.c                           |  10 +
 kernel/time/posix-stubs.c                 |  10 +
 lib/swiotlb.c                             |   2 +-
 scripts/bloat-o-meter                     |   4 +-
 33 files changed, 1150 insertions(+), 802 deletions(-)
 create mode 100644 arch/x86/include/asm/syscall_wrapper.h

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 314c8bf6f2a2..0d4f29bc798b 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -360,7 +360,7 @@ First, the entry in ``arch/x86/entry/syscalls/syscall_32.tbl`` gets an extra
 column to indicate that a 32-bit userspace program running on a 64-bit kernel
 should hit the compat entry point::
 
-    380   i386     xyzzy     sys_xyzzy    compat_sys_xyzzy
+    380   i386     xyzzy     sys_xyzzy    __ia32_compat_sys_xyzzy
 
 Second, you need to figure out what should happen for the x32 ABI version of
 the new system call.  There's a choice here: the layout of the arguments
@@ -373,7 +373,7 @@ the compatibility wrapper::
 
     333   64       xyzzy     sys_xyzzy
     ...
-    555   x32      xyzzy     compat_sys_xyzzy
+    555   x32      xyzzy     __x32_compat_sys_xyzzy
 
 If no pointers are involved, then it is preferable to re-use the 64-bit system
 call for the x32 ABI (and consequently the entry in
diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index ea91cb61a602..5432a96d31ff 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -20,7 +20,7 @@ ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
 ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
 ... unused hole ...
 ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - [fixmap start]   (~1526 MB) module mapping space (variable)
+ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
 ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27fede438959..a29df2353da5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -29,6 +29,7 @@ config X86_64
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select X86_DEV_DMA_OPS
+	select ARCH_HAS_SYSCALL_WRAPPER
 
 #
 # Arch settings
@@ -2758,11 +2759,9 @@ config OLPC_XO1_RTC
 
 config OLPC_XO1_SCI
 	bool "OLPC XO-1 SCI extras"
-	depends on OLPC && OLPC_XO1_PM
+	depends on OLPC && OLPC_XO1_PM && GPIO_CS5535=y
 	depends on INPUT=y
 	select POWER_SUPPLY
-	select GPIO_CS5535
-	select MFD_CORE
 	---help---
 	  Add support for SCI-based features of the OLPC XO-1 laptop:
 	   - EC-driven system wakeups
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index be63330c5511..352e70cd33e8 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -114,7 +114,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
+	xorl	%edx, %edx	/* nospec   dx */
 	pushq   %rcx		/* pt_regs->cx */
+	xorl	%ecx, %ecx	/* nospec   cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	xorl	%r8d, %r8d	/* nospec   r8 */
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee15179..fbf6a6c3fd2d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -266,14 +266,13 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(struct pt_regs *regs)
+__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned long nr = regs->orig_ax;
+	struct thread_info *ti;
 
 	enter_from_user_mode();
 	local_irq_enable();
-
+	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
@@ -282,11 +281,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	 * table.  The only functional difference is the x32 bit in
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
-	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
-		regs->ax = sys_call_table[nr](
-			regs->di, regs->si, regs->dx,
-			regs->r10, regs->r8, regs->r9);
+	nr &= __SYSCALL_MASK;
+	if (likely(nr < NR_syscalls)) {
+		nr = array_index_nospec(nr, NR_syscalls);
+		regs->ax = sys_call_table[nr](regs);
 	}
 
 	syscall_return_slowpath(regs);
@@ -321,6 +319,9 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
+#ifdef CONFIG_IA32_EMULATION
+		regs->ax = ia32_sys_call_table[nr](regs);
+#else
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
@@ -331,6 +332,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 			(unsigned int)regs->bx, (unsigned int)regs->cx,
 			(unsigned int)regs->dx, (unsigned int)regs->si,
 			(unsigned int)regs->di, (unsigned int)regs->bp);
+#endif /* CONFIG_IA32_EMULATION */
 	}
 
 	syscall_return_slowpath(regs);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 936e19642eab..6cfe38665f3c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -233,7 +233,8 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
-	movq	%rsp, %rdi
+	movq	%rax, %rdi
+	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 08425c42f8b7..9af927e59d49 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -220,8 +220,11 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nospec   dx */
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
+	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
@@ -365,8 +368,11 @@ ENTRY(entry_INT80_compat)
 
 	pushq	(%rdi)			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nospec   dx */
 	pushq	%rcx			/* pt_regs->cx */
+	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 95c294963612..aa3336a7cb15 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -7,14 +7,23 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#ifdef CONFIG_IA32_EMULATION
+/* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
+#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+
+/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
+extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
+
+#else /* CONFIG_IA32_EMULATION */
+#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#endif /* CONFIG_IA32_EMULATION */
+
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
 #define __SYSCALL_I386(nr, sym, qual) [nr] = sym,
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index c176d2fab1da..d5252bc1e380 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -7,14 +7,14 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
+extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
 
-extern long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c58f75b088c5..d6b27dab1b30 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -4,390 +4,395 @@
 # The format is:
 # <number> <abi> <name> <entry point> <compat entry point>
 #
+# The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
+# sys_*() system calls and compat_sys_*() compat system calls if
+# IA32_EMULATION is defined, and expect struct pt_regs *regs as their only
+# parameter.
+#
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit
-2	i386	fork			sys_fork
-3	i386	read			sys_read
-4	i386	write			sys_write
-5	i386	open			sys_open			compat_sys_open
-6	i386	close			sys_close
-7	i386	waitpid			sys_waitpid
-8	i386	creat			sys_creat
-9	i386	link			sys_link
-10	i386	unlink			sys_unlink
-11	i386	execve			sys_execve			compat_sys_execve
-12	i386	chdir			sys_chdir
-13	i386	time			sys_time			compat_sys_time
-14	i386	mknod			sys_mknod
-15	i386	chmod			sys_chmod
-16	i386	lchown			sys_lchown16
+0	i386	restart_syscall		sys_restart_syscall		__ia32_sys_restart_syscall
+1	i386	exit			sys_exit			__ia32_sys_exit
+2	i386	fork			sys_fork			__ia32_sys_fork
+3	i386	read			sys_read			__ia32_sys_read
+4	i386	write			sys_write			__ia32_sys_write
+5	i386	open			sys_open			__ia32_compat_sys_open
+6	i386	close			sys_close			__ia32_sys_close
+7	i386	waitpid			sys_waitpid			__ia32_sys_waitpid
+8	i386	creat			sys_creat			__ia32_sys_creat
+9	i386	link			sys_link			__ia32_sys_link
+10	i386	unlink			sys_unlink			__ia32_sys_unlink
+11	i386	execve			sys_execve			__ia32_compat_sys_execve
+12	i386	chdir			sys_chdir			__ia32_sys_chdir
+13	i386	time			sys_time			__ia32_compat_sys_time
+14	i386	mknod			sys_mknod			__ia32_sys_mknod
+15	i386	chmod			sys_chmod			__ia32_sys_chmod
+16	i386	lchown			sys_lchown16			__ia32_sys_lchown16
 17	i386	break
-18	i386	oldstat			sys_stat
-19	i386	lseek			sys_lseek			compat_sys_lseek
-20	i386	getpid			sys_getpid
-21	i386	mount			sys_mount			compat_sys_mount
-22	i386	umount			sys_oldumount
-23	i386	setuid			sys_setuid16
-24	i386	getuid			sys_getuid16
-25	i386	stime			sys_stime			compat_sys_stime
-26	i386	ptrace			sys_ptrace			compat_sys_ptrace
-27	i386	alarm			sys_alarm
-28	i386	oldfstat		sys_fstat
-29	i386	pause			sys_pause
-30	i386	utime			sys_utime			compat_sys_utime
+18	i386	oldstat			sys_stat			__ia32_sys_stat
+19	i386	lseek			sys_lseek			__ia32_compat_sys_lseek
+20	i386	getpid			sys_getpid			__ia32_sys_getpid
+21	i386	mount			sys_mount			__ia32_compat_sys_mount
+22	i386	umount			sys_oldumount			__ia32_sys_oldumount
+23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
+24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
+25	i386	stime			sys_stime			__ia32_compat_sys_stime
+26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
+27	i386	alarm			sys_alarm			__ia32_sys_alarm
+28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
+29	i386	pause			sys_pause			__ia32_sys_pause
+30	i386	utime			sys_utime			__ia32_compat_sys_utime
 31	i386	stty
 32	i386	gtty
-33	i386	access			sys_access
-34	i386	nice			sys_nice
+33	i386	access			sys_access			__ia32_sys_access
+34	i386	nice			sys_nice			__ia32_sys_nice
 35	i386	ftime
-36	i386	sync			sys_sync
-37	i386	kill			sys_kill
-38	i386	rename			sys_rename
-39	i386	mkdir			sys_mkdir
-40	i386	rmdir			sys_rmdir
-41	i386	dup			sys_dup
-42	i386	pipe			sys_pipe
-43	i386	times			sys_times			compat_sys_times
+36	i386	sync			sys_sync			__ia32_sys_sync
+37	i386	kill			sys_kill			__ia32_sys_kill
+38	i386	rename			sys_rename			__ia32_sys_rename
+39	i386	mkdir			sys_mkdir			__ia32_sys_mkdir
+40	i386	rmdir			sys_rmdir			__ia32_sys_rmdir
+41	i386	dup			sys_dup				__ia32_sys_dup
+42	i386	pipe			sys_pipe			__ia32_sys_pipe
+43	i386	times			sys_times			__ia32_compat_sys_times
 44	i386	prof
-45	i386	brk			sys_brk
-46	i386	setgid			sys_setgid16
-47	i386	getgid			sys_getgid16
-48	i386	signal			sys_signal
-49	i386	geteuid			sys_geteuid16
-50	i386	getegid			sys_getegid16
-51	i386	acct			sys_acct
-52	i386	umount2			sys_umount
+45	i386	brk			sys_brk				__ia32_sys_brk
+46	i386	setgid			sys_setgid16			__ia32_sys_setgid16
+47	i386	getgid			sys_getgid16			__ia32_sys_getgid16
+48	i386	signal			sys_signal			__ia32_sys_signal
+49	i386	geteuid			sys_geteuid16			__ia32_sys_geteuid16
+50	i386	getegid			sys_getegid16			__ia32_sys_getegid16
+51	i386	acct			sys_acct			__ia32_sys_acct
+52	i386	umount2			sys_umount			__ia32_sys_umount
 53	i386	lock
-54	i386	ioctl			sys_ioctl			compat_sys_ioctl
-55	i386	fcntl			sys_fcntl			compat_sys_fcntl64
+54	i386	ioctl			sys_ioctl			__ia32_compat_sys_ioctl
+55	i386	fcntl			sys_fcntl			__ia32_compat_sys_fcntl64
 56	i386	mpx
-57	i386	setpgid			sys_setpgid
+57	i386	setpgid			sys_setpgid			__ia32_sys_setpgid
 58	i386	ulimit
-59	i386	oldolduname		sys_olduname
-60	i386	umask			sys_umask
-61	i386	chroot			sys_chroot
-62	i386	ustat			sys_ustat			compat_sys_ustat
-63	i386	dup2			sys_dup2
-64	i386	getppid			sys_getppid
-65	i386	getpgrp			sys_getpgrp
-66	i386	setsid			sys_setsid
-67	i386	sigaction		sys_sigaction			compat_sys_sigaction
-68	i386	sgetmask		sys_sgetmask
-69	i386	ssetmask		sys_ssetmask
-70	i386	setreuid		sys_setreuid16
-71	i386	setregid		sys_setregid16
-72	i386	sigsuspend		sys_sigsuspend
-73	i386	sigpending		sys_sigpending			compat_sys_sigpending
-74	i386	sethostname		sys_sethostname
-75	i386	setrlimit		sys_setrlimit			compat_sys_setrlimit
-76	i386	getrlimit		sys_old_getrlimit		compat_sys_old_getrlimit
-77	i386	getrusage		sys_getrusage			compat_sys_getrusage
-78	i386	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
-79	i386	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80	i386	getgroups		sys_getgroups16
-81	i386	setgroups		sys_setgroups16
-82	i386	select			sys_old_select			compat_sys_old_select
-83	i386	symlink			sys_symlink
-84	i386	oldlstat		sys_lstat
-85	i386	readlink		sys_readlink
-86	i386	uselib			sys_uselib
-87	i386	swapon			sys_swapon
-88	i386	reboot			sys_reboot
-89	i386	readdir			sys_old_readdir			compat_sys_old_readdir
-90	i386	mmap			sys_old_mmap			compat_sys_x86_mmap
-91	i386	munmap			sys_munmap
-92	i386	truncate		sys_truncate			compat_sys_truncate
-93	i386	ftruncate		sys_ftruncate			compat_sys_ftruncate
-94	i386	fchmod			sys_fchmod
-95	i386	fchown			sys_fchown16
-96	i386	getpriority		sys_getpriority
-97	i386	setpriority		sys_setpriority
+59	i386	oldolduname		sys_olduname			__ia32_sys_olduname
+60	i386	umask			sys_umask			__ia32_sys_umask
+61	i386	chroot			sys_chroot			__ia32_sys_chroot
+62	i386	ustat			sys_ustat			__ia32_compat_sys_ustat
+63	i386	dup2			sys_dup2			__ia32_sys_dup2
+64	i386	getppid			sys_getppid			__ia32_sys_getppid
+65	i386	getpgrp			sys_getpgrp			__ia32_sys_getpgrp
+66	i386	setsid			sys_setsid			__ia32_sys_setsid
+67	i386	sigaction		sys_sigaction			__ia32_compat_sys_sigaction
+68	i386	sgetmask		sys_sgetmask			__ia32_sys_sgetmask
+69	i386	ssetmask		sys_ssetmask			__ia32_sys_ssetmask
+70	i386	setreuid		sys_setreuid16			__ia32_sys_setreuid16
+71	i386	setregid		sys_setregid16			__ia32_sys_setregid16
+72	i386	sigsuspend		sys_sigsuspend			__ia32_sys_sigsuspend
+73	i386	sigpending		sys_sigpending			__ia32_compat_sys_sigpending
+74	i386	sethostname		sys_sethostname			__ia32_sys_sethostname
+75	i386	setrlimit		sys_setrlimit			__ia32_compat_sys_setrlimit
+76	i386	getrlimit		sys_old_getrlimit		__ia32_compat_sys_old_getrlimit
+77	i386	getrusage		sys_getrusage			__ia32_compat_sys_getrusage
+78	i386	gettimeofday		sys_gettimeofday		__ia32_compat_sys_gettimeofday
+79	i386	settimeofday		sys_settimeofday		__ia32_compat_sys_settimeofday
+80	i386	getgroups		sys_getgroups16			__ia32_sys_getgroups16
+81	i386	setgroups		sys_setgroups16			__ia32_sys_setgroups16
+82	i386	select			sys_old_select			__ia32_compat_sys_old_select
+83	i386	symlink			sys_symlink			__ia32_sys_symlink
+84	i386	oldlstat		sys_lstat			__ia32_sys_lstat
+85	i386	readlink		sys_readlink			__ia32_sys_readlink
+86	i386	uselib			sys_uselib			__ia32_sys_uselib
+87	i386	swapon			sys_swapon			__ia32_sys_swapon
+88	i386	reboot			sys_reboot			__ia32_sys_reboot
+89	i386	readdir			sys_old_readdir			__ia32_compat_sys_old_readdir
+90	i386	mmap			sys_old_mmap			__ia32_compat_sys_x86_mmap
+91	i386	munmap			sys_munmap			__ia32_sys_munmap
+92	i386	truncate		sys_truncate			__ia32_compat_sys_truncate
+93	i386	ftruncate		sys_ftruncate			__ia32_compat_sys_ftruncate
+94	i386	fchmod			sys_fchmod			__ia32_sys_fchmod
+95	i386	fchown			sys_fchown16			__ia32_sys_fchown16
+96	i386	getpriority		sys_getpriority			__ia32_sys_getpriority
+97	i386	setpriority		sys_setpriority			__ia32_sys_setpriority
 98	i386	profil
-99	i386	statfs			sys_statfs			compat_sys_statfs
-100	i386	fstatfs			sys_fstatfs			compat_sys_fstatfs
-101	i386	ioperm			sys_ioperm
-102	i386	socketcall		sys_socketcall			compat_sys_socketcall
-103	i386	syslog			sys_syslog
-104	i386	setitimer		sys_setitimer			compat_sys_setitimer
-105	i386	getitimer		sys_getitimer			compat_sys_getitimer
-106	i386	stat			sys_newstat			compat_sys_newstat
-107	i386	lstat			sys_newlstat			compat_sys_newlstat
-108	i386	fstat			sys_newfstat			compat_sys_newfstat
-109	i386	olduname		sys_uname
-110	i386	iopl			sys_iopl
-111	i386	vhangup			sys_vhangup
+99	i386	statfs			sys_statfs			__ia32_compat_sys_statfs
+100	i386	fstatfs			sys_fstatfs			__ia32_compat_sys_fstatfs
+101	i386	ioperm			sys_ioperm			__ia32_sys_ioperm
+102	i386	socketcall		sys_socketcall			__ia32_compat_sys_socketcall
+103	i386	syslog			sys_syslog			__ia32_sys_syslog
+104	i386	setitimer		sys_setitimer			__ia32_compat_sys_setitimer
+105	i386	getitimer		sys_getitimer			__ia32_compat_sys_getitimer
+106	i386	stat			sys_newstat			__ia32_compat_sys_newstat
+107	i386	lstat			sys_newlstat			__ia32_compat_sys_newlstat
+108	i386	fstat			sys_newfstat			__ia32_compat_sys_newfstat
+109	i386	olduname		sys_uname			__ia32_sys_uname
+110	i386	iopl			sys_iopl			__ia32_sys_iopl
+111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
 112	i386	idle
 113	i386	vm86old			sys_vm86old			sys_ni_syscall
-114	i386	wait4			sys_wait4			compat_sys_wait4
-115	i386	swapoff			sys_swapoff
-116	i386	sysinfo			sys_sysinfo			compat_sys_sysinfo
-117	i386	ipc			sys_ipc				compat_sys_ipc
-118	i386	fsync			sys_fsync
+114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
+115	i386	swapoff			sys_swapoff			__ia32_sys_swapoff
+116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
+117	i386	ipc			sys_ipc				__ia32_compat_sys_ipc
+118	i386	fsync			sys_fsync			__ia32_sys_fsync
 119	i386	sigreturn		sys_sigreturn			sys32_sigreturn
-120	i386	clone			sys_clone			compat_sys_x86_clone
-121	i386	setdomainname		sys_setdomainname
-122	i386	uname			sys_newuname
-123	i386	modify_ldt		sys_modify_ldt
-124	i386	adjtimex		sys_adjtimex			compat_sys_adjtimex
-125	i386	mprotect		sys_mprotect
-126	i386	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+120	i386	clone			sys_clone			__ia32_compat_sys_x86_clone
+121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
+122	i386	uname			sys_newuname			__ia32_sys_newuname
+123	i386	modify_ldt		sys_modify_ldt			__ia32_sys_modify_ldt
+124	i386	adjtimex		sys_adjtimex			__ia32_compat_sys_adjtimex
+125	i386	mprotect		sys_mprotect			__ia32_sys_mprotect
+126	i386	sigprocmask		sys_sigprocmask			__ia32_compat_sys_sigprocmask
 127	i386	create_module
-128	i386	init_module		sys_init_module
-129	i386	delete_module		sys_delete_module
+128	i386	init_module		sys_init_module			__ia32_sys_init_module
+129	i386	delete_module		sys_delete_module		__ia32_sys_delete_module
 130	i386	get_kernel_syms
-131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
-132	i386	getpgid			sys_getpgid
-133	i386	fchdir			sys_fchdir
-134	i386	bdflush			sys_bdflush
-135	i386	sysfs			sys_sysfs
-136	i386	personality		sys_personality
+131	i386	quotactl		sys_quotactl			__ia32_compat_sys_quotactl32
+132	i386	getpgid			sys_getpgid			__ia32_sys_getpgid
+133	i386	fchdir			sys_fchdir			__ia32_sys_fchdir
+134	i386	bdflush			sys_bdflush			__ia32_sys_bdflush
+135	i386	sysfs			sys_sysfs			__ia32_sys_sysfs
+136	i386	personality		sys_personality			__ia32_sys_personality
 137	i386	afs_syscall
-138	i386	setfsuid		sys_setfsuid16
-139	i386	setfsgid		sys_setfsgid16
-140	i386	_llseek			sys_llseek
-141	i386	getdents		sys_getdents			compat_sys_getdents
-142	i386	_newselect		sys_select			compat_sys_select
-143	i386	flock			sys_flock
-144	i386	msync			sys_msync
-145	i386	readv			sys_readv			compat_sys_readv
-146	i386	writev			sys_writev			compat_sys_writev
-147	i386	getsid			sys_getsid
-148	i386	fdatasync		sys_fdatasync
-149	i386	_sysctl			sys_sysctl			compat_sys_sysctl
-150	i386	mlock			sys_mlock
-151	i386	munlock			sys_munlock
-152	i386	mlockall		sys_mlockall
-153	i386	munlockall		sys_munlockall
-154	i386	sched_setparam		sys_sched_setparam
-155	i386	sched_getparam		sys_sched_getparam
-156	i386	sched_setscheduler	sys_sched_setscheduler
-157	i386	sched_getscheduler	sys_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield
-159	i386	sched_get_priority_max	sys_sched_get_priority_max
-160	i386	sched_get_priority_min	sys_sched_get_priority_min
-161	i386	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162	i386	nanosleep		sys_nanosleep			compat_sys_nanosleep
-163	i386	mremap			sys_mremap
-164	i386	setresuid		sys_setresuid16
-165	i386	getresuid		sys_getresuid16
+138	i386	setfsuid		sys_setfsuid16			__ia32_sys_setfsuid16
+139	i386	setfsgid		sys_setfsgid16			__ia32_sys_setfsgid16
+140	i386	_llseek			sys_llseek			__ia32_sys_llseek
+141	i386	getdents		sys_getdents			__ia32_compat_sys_getdents
+142	i386	_newselect		sys_select			__ia32_compat_sys_select
+143	i386	flock			sys_flock			__ia32_sys_flock
+144	i386	msync			sys_msync			__ia32_sys_msync
+145	i386	readv			sys_readv			__ia32_compat_sys_readv
+146	i386	writev			sys_writev			__ia32_compat_sys_writev
+147	i386	getsid			sys_getsid			__ia32_sys_getsid
+148	i386	fdatasync		sys_fdatasync			__ia32_sys_fdatasync
+149	i386	_sysctl			sys_sysctl			__ia32_compat_sys_sysctl
+150	i386	mlock			sys_mlock			__ia32_sys_mlock
+151	i386	munlock			sys_munlock			__ia32_sys_munlock
+152	i386	mlockall		sys_mlockall			__ia32_sys_mlockall
+153	i386	munlockall		sys_munlockall			__ia32_sys_munlockall
+154	i386	sched_setparam		sys_sched_setparam		__ia32_sys_sched_setparam
+155	i386	sched_getparam		sys_sched_getparam		__ia32_sys_sched_getparam
+156	i386	sched_setscheduler	sys_sched_setscheduler		__ia32_sys_sched_setscheduler
+157	i386	sched_getscheduler	sys_sched_getscheduler		__ia32_sys_sched_getscheduler
+158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
+159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
+160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
+161	i386	sched_rr_get_interval	sys_sched_rr_get_interval	__ia32_compat_sys_sched_rr_get_interval
+162	i386	nanosleep		sys_nanosleep			__ia32_compat_sys_nanosleep
+163	i386	mremap			sys_mremap			__ia32_sys_mremap
+164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
+165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
 166	i386	vm86			sys_vm86			sys_ni_syscall
 167	i386	query_module
-168	i386	poll			sys_poll
+168	i386	poll			sys_poll			__ia32_sys_poll
 169	i386	nfsservctl
-170	i386	setresgid		sys_setresgid16
-171	i386	getresgid		sys_getresgid16
-172	i386	prctl			sys_prctl
+170	i386	setresgid		sys_setresgid16			__ia32_sys_setresgid16
+171	i386	getresgid		sys_getresgid16			__ia32_sys_getresgid16
+172	i386	prctl			sys_prctl			__ia32_sys_prctl
 173	i386	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
-174	i386	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
-175	i386	rt_sigprocmask		sys_rt_sigprocmask
-176	i386	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
-178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-179	i386	rt_sigsuspend		sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			compat_sys_x86_pread
-181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
-182	i386	chown			sys_chown16
-183	i386	getcwd			sys_getcwd
-184	i386	capget			sys_capget
-185	i386	capset			sys_capset
-186	i386	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
-187	i386	sendfile		sys_sendfile			compat_sys_sendfile
+174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
+175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_sys_rt_sigprocmask
+176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
+177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait
+178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
+179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_sys_rt_sigsuspend
+180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
+181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
+182	i386	chown			sys_chown16			__ia32_sys_chown16
+183	i386	getcwd			sys_getcwd			__ia32_sys_getcwd
+184	i386	capget			sys_capget			__ia32_sys_capget
+185	i386	capset			sys_capset			__ia32_sys_capset
+186	i386	sigaltstack		sys_sigaltstack			__ia32_compat_sys_sigaltstack
+187	i386	sendfile		sys_sendfile			__ia32_compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork
-191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
-192	i386	mmap2			sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
-194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
-195	i386	stat64			sys_stat64			compat_sys_x86_stat64
-196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
-197	i386	fstat64			sys_fstat64			compat_sys_x86_fstat64
-198	i386	lchown32		sys_lchown
-199	i386	getuid32		sys_getuid
-200	i386	getgid32		sys_getgid
-201	i386	geteuid32		sys_geteuid
-202	i386	getegid32		sys_getegid
-203	i386	setreuid32		sys_setreuid
-204	i386	setregid32		sys_setregid
-205	i386	getgroups32		sys_getgroups
-206	i386	setgroups32		sys_setgroups
-207	i386	fchown32		sys_fchown
-208	i386	setresuid32		sys_setresuid
-209	i386	getresuid32		sys_getresuid
-210	i386	setresgid32		sys_setresgid
-211	i386	getresgid32		sys_getresgid
-212	i386	chown32			sys_chown
-213	i386	setuid32		sys_setuid
-214	i386	setgid32		sys_setgid
-215	i386	setfsuid32		sys_setfsuid
-216	i386	setfsgid32		sys_setfsgid
-217	i386	pivot_root		sys_pivot_root
-218	i386	mincore			sys_mincore
-219	i386	madvise			sys_madvise
-220	i386	getdents64		sys_getdents64
-221	i386	fcntl64			sys_fcntl64			compat_sys_fcntl64
+190	i386	vfork			sys_vfork			__ia32_sys_vfork
+191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
+192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
+193	i386	truncate64		sys_truncate64			__ia32_compat_sys_x86_truncate64
+194	i386	ftruncate64		sys_ftruncate64			__ia32_compat_sys_x86_ftruncate64
+195	i386	stat64			sys_stat64			__ia32_compat_sys_x86_stat64
+196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
+197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
+198	i386	lchown32		sys_lchown			__ia32_sys_lchown
+199	i386	getuid32		sys_getuid			__ia32_sys_getuid
+200	i386	getgid32		sys_getgid			__ia32_sys_getgid
+201	i386	geteuid32		sys_geteuid			__ia32_sys_geteuid
+202	i386	getegid32		sys_getegid			__ia32_sys_getegid
+203	i386	setreuid32		sys_setreuid			__ia32_sys_setreuid
+204	i386	setregid32		sys_setregid			__ia32_sys_setregid
+205	i386	getgroups32		sys_getgroups			__ia32_sys_getgroups
+206	i386	setgroups32		sys_setgroups			__ia32_sys_setgroups
+207	i386	fchown32		sys_fchown			__ia32_sys_fchown
+208	i386	setresuid32		sys_setresuid			__ia32_sys_setresuid
+209	i386	getresuid32		sys_getresuid			__ia32_sys_getresuid
+210	i386	setresgid32		sys_setresgid			__ia32_sys_setresgid
+211	i386	getresgid32		sys_getresgid			__ia32_sys_getresgid
+212	i386	chown32			sys_chown			__ia32_sys_chown
+213	i386	setuid32		sys_setuid			__ia32_sys_setuid
+214	i386	setgid32		sys_setgid			__ia32_sys_setgid
+215	i386	setfsuid32		sys_setfsuid			__ia32_sys_setfsuid
+216	i386	setfsgid32		sys_setfsgid			__ia32_sys_setfsgid
+217	i386	pivot_root		sys_pivot_root			__ia32_sys_pivot_root
+218	i386	mincore			sys_mincore			__ia32_sys_mincore
+219	i386	madvise			sys_madvise			__ia32_sys_madvise
+220	i386	getdents64		sys_getdents64			__ia32_sys_getdents64
+221	i386	fcntl64			sys_fcntl64			__ia32_compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid
-225	i386	readahead		sys_readahead			compat_sys_x86_readahead
-226	i386	setxattr		sys_setxattr
-227	i386	lsetxattr		sys_lsetxattr
-228	i386	fsetxattr		sys_fsetxattr
-229	i386	getxattr		sys_getxattr
-230	i386	lgetxattr		sys_lgetxattr
-231	i386	fgetxattr		sys_fgetxattr
-232	i386	listxattr		sys_listxattr
-233	i386	llistxattr		sys_llistxattr
-234	i386	flistxattr		sys_flistxattr
-235	i386	removexattr		sys_removexattr
-236	i386	lremovexattr		sys_lremovexattr
-237	i386	fremovexattr		sys_fremovexattr
-238	i386	tkill			sys_tkill
-239	i386	sendfile64		sys_sendfile64
-240	i386	futex			sys_futex			compat_sys_futex
-241	i386	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
-242	i386	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
-243	i386	set_thread_area		sys_set_thread_area
-244	i386	get_thread_area		sys_get_thread_area
-245	i386	io_setup		sys_io_setup			compat_sys_io_setup
-246	i386	io_destroy		sys_io_destroy
-247	i386	io_getevents		sys_io_getevents		compat_sys_io_getevents
-248	i386	io_submit		sys_io_submit			compat_sys_io_submit
-249	i386	io_cancel		sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			compat_sys_x86_fadvise64
+224	i386	gettid			sys_gettid			__ia32_sys_gettid
+225	i386	readahead		sys_readahead			__ia32_compat_sys_x86_readahead
+226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
+227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
+228	i386	fsetxattr		sys_fsetxattr			__ia32_sys_fsetxattr
+229	i386	getxattr		sys_getxattr			__ia32_sys_getxattr
+230	i386	lgetxattr		sys_lgetxattr			__ia32_sys_lgetxattr
+231	i386	fgetxattr		sys_fgetxattr			__ia32_sys_fgetxattr
+232	i386	listxattr		sys_listxattr			__ia32_sys_listxattr
+233	i386	llistxattr		sys_llistxattr			__ia32_sys_llistxattr
+234	i386	flistxattr		sys_flistxattr			__ia32_sys_flistxattr
+235	i386	removexattr		sys_removexattr			__ia32_sys_removexattr
+236	i386	lremovexattr		sys_lremovexattr		__ia32_sys_lremovexattr
+237	i386	fremovexattr		sys_fremovexattr		__ia32_sys_fremovexattr
+238	i386	tkill			sys_tkill			__ia32_sys_tkill
+239	i386	sendfile64		sys_sendfile64			__ia32_sys_sendfile64
+240	i386	futex			sys_futex			__ia32_compat_sys_futex
+241	i386	sched_setaffinity	sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
+242	i386	sched_getaffinity	sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
+243	i386	set_thread_area		sys_set_thread_area		__ia32_sys_set_thread_area
+244	i386	get_thread_area		sys_get_thread_area		__ia32_sys_get_thread_area
+245	i386	io_setup		sys_io_setup			__ia32_compat_sys_io_setup
+246	i386	io_destroy		sys_io_destroy			__ia32_sys_io_destroy
+247	i386	io_getevents		sys_io_getevents		__ia32_compat_sys_io_getevents
+248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
+249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
+250	i386	fadvise64		sys_fadvise64			__ia32_compat_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group
-253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
-254	i386	epoll_create		sys_epoll_create
-255	i386	epoll_ctl		sys_epoll_ctl
-256	i386	epoll_wait		sys_epoll_wait
-257	i386	remap_file_pages	sys_remap_file_pages
-258	i386	set_tid_address		sys_set_tid_address
-259	i386	timer_create		sys_timer_create		compat_sys_timer_create
-260	i386	timer_settime		sys_timer_settime		compat_sys_timer_settime
-261	i386	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
-262	i386	timer_getoverrun	sys_timer_getoverrun
-263	i386	timer_delete		sys_timer_delete
-264	i386	clock_settime		sys_clock_settime		compat_sys_clock_settime
-265	i386	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
-266	i386	clock_getres		sys_clock_getres		compat_sys_clock_getres
-267	i386	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
-268	i386	statfs64		sys_statfs64			compat_sys_statfs64
-269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-270	i386	tgkill			sys_tgkill
-271	i386	utimes			sys_utimes			compat_sys_utimes
-272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_x86_fadvise64_64
+252	i386	exit_group		sys_exit_group			__ia32_sys_exit_group
+253	i386	lookup_dcookie		sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
+254	i386	epoll_create		sys_epoll_create		__ia32_sys_epoll_create
+255	i386	epoll_ctl		sys_epoll_ctl			__ia32_sys_epoll_ctl
+256	i386	epoll_wait		sys_epoll_wait			__ia32_sys_epoll_wait
+257	i386	remap_file_pages	sys_remap_file_pages		__ia32_sys_remap_file_pages
+258	i386	set_tid_address		sys_set_tid_address		__ia32_sys_set_tid_address
+259	i386	timer_create		sys_timer_create		__ia32_compat_sys_timer_create
+260	i386	timer_settime		sys_timer_settime		__ia32_compat_sys_timer_settime
+261	i386	timer_gettime		sys_timer_gettime		__ia32_compat_sys_timer_gettime
+262	i386	timer_getoverrun	sys_timer_getoverrun		__ia32_sys_timer_getoverrun
+263	i386	timer_delete		sys_timer_delete		__ia32_sys_timer_delete
+264	i386	clock_settime		sys_clock_settime		__ia32_compat_sys_clock_settime
+265	i386	clock_gettime		sys_clock_gettime		__ia32_compat_sys_clock_gettime
+266	i386	clock_getres		sys_clock_getres		__ia32_compat_sys_clock_getres
+267	i386	clock_nanosleep		sys_clock_nanosleep		__ia32_compat_sys_clock_nanosleep
+268	i386	statfs64		sys_statfs64			__ia32_compat_sys_statfs64
+269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
+270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
+271	i386	utimes			sys_utimes			__ia32_compat_sys_utimes
+272	i386	fadvise64_64		sys_fadvise64_64		__ia32_compat_sys_x86_fadvise64_64
 273	i386	vserver
-274	i386	mbind			sys_mbind
-275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-276	i386	set_mempolicy		sys_set_mempolicy
-277	i386	mq_open			sys_mq_open			compat_sys_mq_open
-278	i386	mq_unlink		sys_mq_unlink
-279	i386	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
-280	i386	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
-281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
-282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
-284	i386	waitid			sys_waitid			compat_sys_waitid
+274	i386	mbind			sys_mbind			__ia32_sys_mbind
+275	i386	get_mempolicy		sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
+276	i386	set_mempolicy		sys_set_mempolicy		__ia32_sys_set_mempolicy
+277	i386	mq_open			sys_mq_open			__ia32_compat_sys_mq_open
+278	i386	mq_unlink		sys_mq_unlink			__ia32_sys_mq_unlink
+279	i386	mq_timedsend		sys_mq_timedsend		__ia32_compat_sys_mq_timedsend
+280	i386	mq_timedreceive		sys_mq_timedreceive		__ia32_compat_sys_mq_timedreceive
+281	i386	mq_notify		sys_mq_notify			__ia32_compat_sys_mq_notify
+282	i386	mq_getsetattr		sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
+283	i386	kexec_load		sys_kexec_load			__ia32_compat_sys_kexec_load
+284	i386	waitid			sys_waitid			__ia32_compat_sys_waitid
 # 285 sys_setaltroot
-286	i386	add_key			sys_add_key
-287	i386	request_key		sys_request_key
-288	i386	keyctl			sys_keyctl			compat_sys_keyctl
-289	i386	ioprio_set		sys_ioprio_set
-290	i386	ioprio_get		sys_ioprio_get
-291	i386	inotify_init		sys_inotify_init
-292	i386	inotify_add_watch	sys_inotify_add_watch
-293	i386	inotify_rm_watch	sys_inotify_rm_watch
-294	i386	migrate_pages		sys_migrate_pages
-295	i386	openat			sys_openat			compat_sys_openat
-296	i386	mkdirat			sys_mkdirat
-297	i386	mknodat			sys_mknodat
-298	i386	fchownat		sys_fchownat
-299	i386	futimesat		sys_futimesat			compat_sys_futimesat
-300	i386	fstatat64		sys_fstatat64			compat_sys_x86_fstatat
-301	i386	unlinkat		sys_unlinkat
-302	i386	renameat		sys_renameat
-303	i386	linkat			sys_linkat
-304	i386	symlinkat		sys_symlinkat
-305	i386	readlinkat		sys_readlinkat
-306	i386	fchmodat		sys_fchmodat
-307	i386	faccessat		sys_faccessat
-308	i386	pselect6		sys_pselect6			compat_sys_pselect6
-309	i386	ppoll			sys_ppoll			compat_sys_ppoll
-310	i386	unshare			sys_unshare
-311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
-312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-313	i386	splice			sys_splice
-314	i386	sync_file_range		sys_sync_file_range		compat_sys_x86_sync_file_range
-315	i386	tee			sys_tee
-316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
-317	i386	move_pages		sys_move_pages			compat_sys_move_pages
-318	i386	getcpu			sys_getcpu
-319	i386	epoll_pwait		sys_epoll_pwait
-320	i386	utimensat		sys_utimensat			compat_sys_utimensat
-321	i386	signalfd		sys_signalfd			compat_sys_signalfd
-322	i386	timerfd_create		sys_timerfd_create
-323	i386	eventfd			sys_eventfd
-324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
-325	i386	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
-326	i386	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
-327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
-328	i386	eventfd2		sys_eventfd2
-329	i386	epoll_create1		sys_epoll_create1
-330	i386	dup3			sys_dup3
-331	i386	pipe2			sys_pipe2
-332	i386	inotify_init1		sys_inotify_init1
-333	i386	preadv			sys_preadv			compat_sys_preadv
-334	i386	pwritev			sys_pwritev			compat_sys_pwritev
-335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-336	i386	perf_event_open		sys_perf_event_open
-337	i386	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
-338	i386	fanotify_init		sys_fanotify_init
-339	i386	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
-340	i386	prlimit64		sys_prlimit64
-341	i386	name_to_handle_at	sys_name_to_handle_at
-342	i386	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-343	i386	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
-344	i386	syncfs			sys_syncfs
-345	i386	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
-346	i386	setns			sys_setns
-347	i386	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
-348	i386	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
-349	i386	kcmp			sys_kcmp
-350	i386	finit_module		sys_finit_module
-351	i386	sched_setattr		sys_sched_setattr
-352	i386	sched_getattr		sys_sched_getattr
-353	i386	renameat2		sys_renameat2
-354	i386	seccomp			sys_seccomp
-355	i386	getrandom		sys_getrandom
-356	i386	memfd_create		sys_memfd_create
-357	i386	bpf			sys_bpf
-358	i386	execveat		sys_execveat			compat_sys_execveat
-359	i386	socket			sys_socket
-360	i386	socketpair		sys_socketpair
-361	i386	bind			sys_bind
-362	i386	connect			sys_connect
-363	i386	listen			sys_listen
-364	i386	accept4			sys_accept4
-365	i386	getsockopt		sys_getsockopt			compat_sys_getsockopt
-366	i386	setsockopt		sys_setsockopt			compat_sys_setsockopt
-367	i386	getsockname		sys_getsockname
-368	i386	getpeername		sys_getpeername
-369	i386	sendto			sys_sendto
-370	i386	sendmsg			sys_sendmsg			compat_sys_sendmsg
-371	i386	recvfrom		sys_recvfrom			compat_sys_recvfrom
-372	i386	recvmsg			sys_recvmsg			compat_sys_recvmsg
-373	i386	shutdown		sys_shutdown
-374	i386	userfaultfd		sys_userfaultfd
-375	i386	membarrier		sys_membarrier
-376	i386	mlock2			sys_mlock2
-377	i386	copy_file_range		sys_copy_file_range
-378	i386	preadv2			sys_preadv2			compat_sys_preadv2
-379	i386	pwritev2		sys_pwritev2			compat_sys_pwritev2
-380	i386	pkey_mprotect		sys_pkey_mprotect
-381	i386	pkey_alloc		sys_pkey_alloc
-382	i386	pkey_free		sys_pkey_free
-383	i386	statx			sys_statx
-384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+286	i386	add_key			sys_add_key			__ia32_sys_add_key
+287	i386	request_key		sys_request_key			__ia32_sys_request_key
+288	i386	keyctl			sys_keyctl			__ia32_compat_sys_keyctl
+289	i386	ioprio_set		sys_ioprio_set			__ia32_sys_ioprio_set
+290	i386	ioprio_get		sys_ioprio_get			__ia32_sys_ioprio_get
+291	i386	inotify_init		sys_inotify_init		__ia32_sys_inotify_init
+292	i386	inotify_add_watch	sys_inotify_add_watch		__ia32_sys_inotify_add_watch
+293	i386	inotify_rm_watch	sys_inotify_rm_watch		__ia32_sys_inotify_rm_watch
+294	i386	migrate_pages		sys_migrate_pages		__ia32_sys_migrate_pages
+295	i386	openat			sys_openat			__ia32_compat_sys_openat
+296	i386	mkdirat			sys_mkdirat			__ia32_sys_mkdirat
+297	i386	mknodat			sys_mknodat			__ia32_sys_mknodat
+298	i386	fchownat		sys_fchownat			__ia32_sys_fchownat
+299	i386	futimesat		sys_futimesat			__ia32_compat_sys_futimesat
+300	i386	fstatat64		sys_fstatat64			__ia32_compat_sys_x86_fstatat
+301	i386	unlinkat		sys_unlinkat			__ia32_sys_unlinkat
+302	i386	renameat		sys_renameat			__ia32_sys_renameat
+303	i386	linkat			sys_linkat			__ia32_sys_linkat
+304	i386	symlinkat		sys_symlinkat			__ia32_sys_symlinkat
+305	i386	readlinkat		sys_readlinkat			__ia32_sys_readlinkat
+306	i386	fchmodat		sys_fchmodat			__ia32_sys_fchmodat
+307	i386	faccessat		sys_faccessat			__ia32_sys_faccessat
+308	i386	pselect6		sys_pselect6			__ia32_compat_sys_pselect6
+309	i386	ppoll			sys_ppoll			__ia32_compat_sys_ppoll
+310	i386	unshare			sys_unshare			__ia32_sys_unshare
+311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
+312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
+313	i386	splice			sys_splice			__ia32_sys_splice
+314	i386	sync_file_range		sys_sync_file_range		__ia32_compat_sys_x86_sync_file_range
+315	i386	tee			sys_tee				__ia32_sys_tee
+316	i386	vmsplice		sys_vmsplice			__ia32_compat_sys_vmsplice
+317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
+318	i386	getcpu			sys_getcpu			__ia32_sys_getcpu
+319	i386	epoll_pwait		sys_epoll_pwait			__ia32_sys_epoll_pwait
+320	i386	utimensat		sys_utimensat			__ia32_compat_sys_utimensat
+321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
+322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
+323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
+324	i386	fallocate		sys_fallocate			__ia32_compat_sys_x86_fallocate
+325	i386	timerfd_settime		sys_timerfd_settime		__ia32_compat_sys_timerfd_settime
+326	i386	timerfd_gettime		sys_timerfd_gettime		__ia32_compat_sys_timerfd_gettime
+327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
+328	i386	eventfd2		sys_eventfd2			__ia32_sys_eventfd2
+329	i386	epoll_create1		sys_epoll_create1		__ia32_sys_epoll_create1
+330	i386	dup3			sys_dup3			__ia32_sys_dup3
+331	i386	pipe2			sys_pipe2			__ia32_sys_pipe2
+332	i386	inotify_init1		sys_inotify_init1		__ia32_sys_inotify_init1
+333	i386	preadv			sys_preadv			__ia32_compat_sys_preadv
+334	i386	pwritev			sys_pwritev			__ia32_compat_sys_pwritev
+335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
+336	i386	perf_event_open		sys_perf_event_open		__ia32_sys_perf_event_open
+337	i386	recvmmsg		sys_recvmmsg			__ia32_compat_sys_recvmmsg
+338	i386	fanotify_init		sys_fanotify_init		__ia32_sys_fanotify_init
+339	i386	fanotify_mark		sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
+340	i386	prlimit64		sys_prlimit64			__ia32_sys_prlimit64
+341	i386	name_to_handle_at	sys_name_to_handle_at		__ia32_sys_name_to_handle_at
+342	i386	open_by_handle_at	sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
+343	i386	clock_adjtime		sys_clock_adjtime		__ia32_compat_sys_clock_adjtime
+344	i386	syncfs			sys_syncfs			__ia32_sys_syncfs
+345	i386	sendmmsg		sys_sendmmsg			__ia32_compat_sys_sendmmsg
+346	i386	setns			sys_setns			__ia32_sys_setns
+347	i386	process_vm_readv	sys_process_vm_readv		__ia32_compat_sys_process_vm_readv
+348	i386	process_vm_writev	sys_process_vm_writev		__ia32_compat_sys_process_vm_writev
+349	i386	kcmp			sys_kcmp			__ia32_sys_kcmp
+350	i386	finit_module		sys_finit_module		__ia32_sys_finit_module
+351	i386	sched_setattr		sys_sched_setattr		__ia32_sys_sched_setattr
+352	i386	sched_getattr		sys_sched_getattr		__ia32_sys_sched_getattr
+353	i386	renameat2		sys_renameat2			__ia32_sys_renameat2
+354	i386	seccomp			sys_seccomp			__ia32_sys_seccomp
+355	i386	getrandom		sys_getrandom			__ia32_sys_getrandom
+356	i386	memfd_create		sys_memfd_create		__ia32_sys_memfd_create
+357	i386	bpf			sys_bpf				__ia32_sys_bpf
+358	i386	execveat		sys_execveat			__ia32_compat_sys_execveat
+359	i386	socket			sys_socket			__ia32_sys_socket
+360	i386	socketpair		sys_socketpair			__ia32_sys_socketpair
+361	i386	bind			sys_bind			__ia32_sys_bind
+362	i386	connect			sys_connect			__ia32_sys_connect
+363	i386	listen			sys_listen			__ia32_sys_listen
+364	i386	accept4			sys_accept4			__ia32_sys_accept4
+365	i386	getsockopt		sys_getsockopt			__ia32_compat_sys_getsockopt
+366	i386	setsockopt		sys_setsockopt			__ia32_compat_sys_setsockopt
+367	i386	getsockname		sys_getsockname			__ia32_sys_getsockname
+368	i386	getpeername		sys_getpeername			__ia32_sys_getpeername
+369	i386	sendto			sys_sendto			__ia32_sys_sendto
+370	i386	sendmsg			sys_sendmsg			__ia32_compat_sys_sendmsg
+371	i386	recvfrom		sys_recvfrom			__ia32_compat_sys_recvfrom
+372	i386	recvmsg			sys_recvmsg			__ia32_compat_sys_recvmsg
+373	i386	shutdown		sys_shutdown			__ia32_sys_shutdown
+374	i386	userfaultfd		sys_userfaultfd			__ia32_sys_userfaultfd
+375	i386	membarrier		sys_membarrier			__ia32_sys_membarrier
+376	i386	mlock2			sys_mlock2			__ia32_sys_mlock2
+377	i386	copy_file_range		sys_copy_file_range		__ia32_sys_copy_file_range
+378	i386	preadv2			sys_preadv2			__ia32_compat_sys_preadv2
+379	i386	pwritev2		sys_pwritev2			__ia32_compat_sys_pwritev2
+380	i386	pkey_mprotect		sys_pkey_mprotect		__ia32_sys_pkey_mprotect
+381	i386	pkey_alloc		sys_pkey_alloc			__ia32_sys_pkey_alloc
+382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
+383	i386	statx			sys_statx			__ia32_sys_statx
+384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5aef183e2f85..4dfe42666d0c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -4,379 +4,383 @@
 # The format is:
 # <number> <abi> <name> <entry point>
 #
+# The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
+#
 # The abi is "common", "64" or "x32" for this file.
 #
-0	common	read			sys_read
-1	common	write			sys_write
-2	common	open			sys_open
-3	common	close			sys_close
-4	common	stat			sys_newstat
-5	common	fstat			sys_newfstat
-6	common	lstat			sys_newlstat
-7	common	poll			sys_poll
-8	common	lseek			sys_lseek
-9	common	mmap			sys_mmap
-10	common	mprotect		sys_mprotect
-11	common	munmap			sys_munmap
-12	common	brk			sys_brk
-13	64	rt_sigaction		sys_rt_sigaction
-14	common	rt_sigprocmask		sys_rt_sigprocmask
-15	64	rt_sigreturn		sys_rt_sigreturn/ptregs
-16	64	ioctl			sys_ioctl
-17	common	pread64			sys_pread64
-18	common	pwrite64		sys_pwrite64
-19	64	readv			sys_readv
-20	64	writev			sys_writev
-21	common	access			sys_access
-22	common	pipe			sys_pipe
-23	common	select			sys_select
-24	common	sched_yield		sys_sched_yield
-25	common	mremap			sys_mremap
-26	common	msync			sys_msync
-27	common	mincore			sys_mincore
-28	common	madvise			sys_madvise
-29	common	shmget			sys_shmget
-30	common	shmat			sys_shmat
-31	common	shmctl			sys_shmctl
-32	common	dup			sys_dup
-33	common	dup2			sys_dup2
-34	common	pause			sys_pause
-35	common	nanosleep		sys_nanosleep
-36	common	getitimer		sys_getitimer
-37	common	alarm			sys_alarm
-38	common	setitimer		sys_setitimer
-39	common	getpid			sys_getpid
-40	common	sendfile		sys_sendfile64
-41	common	socket			sys_socket
-42	common	connect			sys_connect
-43	common	accept			sys_accept
-44	common	sendto			sys_sendto
-45	64	recvfrom		sys_recvfrom
-46	64	sendmsg			sys_sendmsg
-47	64	recvmsg			sys_recvmsg
-48	common	shutdown		sys_shutdown
-49	common	bind			sys_bind
-50	common	listen			sys_listen
-51	common	getsockname		sys_getsockname
-52	common	getpeername		sys_getpeername
-53	common	socketpair		sys_socketpair
-54	64	setsockopt		sys_setsockopt
-55	64	getsockopt		sys_getsockopt
-56	common	clone			sys_clone/ptregs
-57	common	fork			sys_fork/ptregs
-58	common	vfork			sys_vfork/ptregs
-59	64	execve			sys_execve/ptregs
-60	common	exit			sys_exit
-61	common	wait4			sys_wait4
-62	common	kill			sys_kill
-63	common	uname			sys_newuname
-64	common	semget			sys_semget
-65	common	semop			sys_semop
-66	common	semctl			sys_semctl
-67	common	shmdt			sys_shmdt
-68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
-71	common	msgctl			sys_msgctl
-72	common	fcntl			sys_fcntl
-73	common	flock			sys_flock
-74	common	fsync			sys_fsync
-75	common	fdatasync		sys_fdatasync
-76	common	truncate		sys_truncate
-77	common	ftruncate		sys_ftruncate
-78	common	getdents		sys_getdents
-79	common	getcwd			sys_getcwd
-80	common	chdir			sys_chdir
-81	common	fchdir			sys_fchdir
-82	common	rename			sys_rename
-83	common	mkdir			sys_mkdir
-84	common	rmdir			sys_rmdir
-85	common	creat			sys_creat
-86	common	link			sys_link
-87	common	unlink			sys_unlink
-88	common	symlink			sys_symlink
-89	common	readlink		sys_readlink
-90	common	chmod			sys_chmod
-91	common	fchmod			sys_fchmod
-92	common	chown			sys_chown
-93	common	fchown			sys_fchown
-94	common	lchown			sys_lchown
-95	common	umask			sys_umask
-96	common	gettimeofday		sys_gettimeofday
-97	common	getrlimit		sys_getrlimit
-98	common	getrusage		sys_getrusage
-99	common	sysinfo			sys_sysinfo
-100	common	times			sys_times
-101	64	ptrace			sys_ptrace
-102	common	getuid			sys_getuid
-103	common	syslog			sys_syslog
-104	common	getgid			sys_getgid
-105	common	setuid			sys_setuid
-106	common	setgid			sys_setgid
-107	common	geteuid			sys_geteuid
-108	common	getegid			sys_getegid
-109	common	setpgid			sys_setpgid
-110	common	getppid			sys_getppid
-111	common	getpgrp			sys_getpgrp
-112	common	setsid			sys_setsid
-113	common	setreuid		sys_setreuid
-114	common	setregid		sys_setregid
-115	common	getgroups		sys_getgroups
-116	common	setgroups		sys_setgroups
-117	common	setresuid		sys_setresuid
-118	common	getresuid		sys_getresuid
-119	common	setresgid		sys_setresgid
-120	common	getresgid		sys_getresgid
-121	common	getpgid			sys_getpgid
-122	common	setfsuid		sys_setfsuid
-123	common	setfsgid		sys_setfsgid
-124	common	getsid			sys_getsid
-125	common	capget			sys_capget
-126	common	capset			sys_capset
-127	64	rt_sigpending		sys_rt_sigpending
-128	64	rt_sigtimedwait		sys_rt_sigtimedwait
-129	64	rt_sigqueueinfo		sys_rt_sigqueueinfo
-130	common	rt_sigsuspend		sys_rt_sigsuspend
-131	64	sigaltstack		sys_sigaltstack
-132	common	utime			sys_utime
-133	common	mknod			sys_mknod
+0	common	read			__x64_sys_read
+1	common	write			__x64_sys_write
+2	common	open			__x64_sys_open
+3	common	close			__x64_sys_close
+4	common	stat			__x64_sys_newstat
+5	common	fstat			__x64_sys_newfstat
+6	common	lstat			__x64_sys_newlstat
+7	common	poll			__x64_sys_poll
+8	common	lseek			__x64_sys_lseek
+9	common	mmap			__x64_sys_mmap
+10	common	mprotect		__x64_sys_mprotect
+11	common	munmap			__x64_sys_munmap
+12	common	brk			__x64_sys_brk
+13	64	rt_sigaction		__x64_sys_rt_sigaction
+14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+16	64	ioctl			__x64_sys_ioctl
+17	common	pread64			__x64_sys_pread64
+18	common	pwrite64		__x64_sys_pwrite64
+19	64	readv			__x64_sys_readv
+20	64	writev			__x64_sys_writev
+21	common	access			__x64_sys_access
+22	common	pipe			__x64_sys_pipe
+23	common	select			__x64_sys_select
+24	common	sched_yield		__x64_sys_sched_yield
+25	common	mremap			__x64_sys_mremap
+26	common	msync			__x64_sys_msync
+27	common	mincore			__x64_sys_mincore
+28	common	madvise			__x64_sys_madvise
+29	common	shmget			__x64_sys_shmget
+30	common	shmat			__x64_sys_shmat
+31	common	shmctl			__x64_sys_shmctl
+32	common	dup			__x64_sys_dup
+33	common	dup2			__x64_sys_dup2
+34	common	pause			__x64_sys_pause
+35	common	nanosleep		__x64_sys_nanosleep
+36	common	getitimer		__x64_sys_getitimer
+37	common	alarm			__x64_sys_alarm
+38	common	setitimer		__x64_sys_setitimer
+39	common	getpid			__x64_sys_getpid
+40	common	sendfile		__x64_sys_sendfile64
+41	common	socket			__x64_sys_socket
+42	common	connect			__x64_sys_connect
+43	common	accept			__x64_sys_accept
+44	common	sendto			__x64_sys_sendto
+45	64	recvfrom		__x64_sys_recvfrom
+46	64	sendmsg			__x64_sys_sendmsg
+47	64	recvmsg			__x64_sys_recvmsg
+48	common	shutdown		__x64_sys_shutdown
+49	common	bind			__x64_sys_bind
+50	common	listen			__x64_sys_listen
+51	common	getsockname		__x64_sys_getsockname
+52	common	getpeername		__x64_sys_getpeername
+53	common	socketpair		__x64_sys_socketpair
+54	64	setsockopt		__x64_sys_setsockopt
+55	64	getsockopt		__x64_sys_getsockopt
+56	common	clone			__x64_sys_clone/ptregs
+57	common	fork			__x64_sys_fork/ptregs
+58	common	vfork			__x64_sys_vfork/ptregs
+59	64	execve			__x64_sys_execve/ptregs
+60	common	exit			__x64_sys_exit
+61	common	wait4			__x64_sys_wait4
+62	common	kill			__x64_sys_kill
+63	common	uname			__x64_sys_newuname
+64	common	semget			__x64_sys_semget
+65	common	semop			__x64_sys_semop
+66	common	semctl			__x64_sys_semctl
+67	common	shmdt			__x64_sys_shmdt
+68	common	msgget			__x64_sys_msgget
+69	common	msgsnd			__x64_sys_msgsnd
+70	common	msgrcv			__x64_sys_msgrcv
+71	common	msgctl			__x64_sys_msgctl
+72	common	fcntl			__x64_sys_fcntl
+73	common	flock			__x64_sys_flock
+74	common	fsync			__x64_sys_fsync
+75	common	fdatasync		__x64_sys_fdatasync
+76	common	truncate		__x64_sys_truncate
+77	common	ftruncate		__x64_sys_ftruncate
+78	common	getdents		__x64_sys_getdents
+79	common	getcwd			__x64_sys_getcwd
+80	common	chdir			__x64_sys_chdir
+81	common	fchdir			__x64_sys_fchdir
+82	common	rename			__x64_sys_rename
+83	common	mkdir			__x64_sys_mkdir
+84	common	rmdir			__x64_sys_rmdir
+85	common	creat			__x64_sys_creat
+86	common	link			__x64_sys_link
+87	common	unlink			__x64_sys_unlink
+88	common	symlink			__x64_sys_symlink
+89	common	readlink		__x64_sys_readlink
+90	common	chmod			__x64_sys_chmod
+91	common	fchmod			__x64_sys_fchmod
+92	common	chown			__x64_sys_chown
+93	common	fchown			__x64_sys_fchown
+94	common	lchown			__x64_sys_lchown
+95	common	umask			__x64_sys_umask
+96	common	gettimeofday		__x64_sys_gettimeofday
+97	common	getrlimit		__x64_sys_getrlimit
+98	common	getrusage		__x64_sys_getrusage
+99	common	sysinfo			__x64_sys_sysinfo
+100	common	times			__x64_sys_times
+101	64	ptrace			__x64_sys_ptrace
+102	common	getuid			__x64_sys_getuid
+103	common	syslog			__x64_sys_syslog
+104	common	getgid			__x64_sys_getgid
+105	common	setuid			__x64_sys_setuid
+106	common	setgid			__x64_sys_setgid
+107	common	geteuid			__x64_sys_geteuid
+108	common	getegid			__x64_sys_getegid
+109	common	setpgid			__x64_sys_setpgid
+110	common	getppid			__x64_sys_getppid
+111	common	getpgrp			__x64_sys_getpgrp
+112	common	setsid			__x64_sys_setsid
+113	common	setreuid		__x64_sys_setreuid
+114	common	setregid		__x64_sys_setregid
+115	common	getgroups		__x64_sys_getgroups
+116	common	setgroups		__x64_sys_setgroups
+117	common	setresuid		__x64_sys_setresuid
+118	common	getresuid		__x64_sys_getresuid
+119	common	setresgid		__x64_sys_setresgid
+120	common	getresgid		__x64_sys_getresgid
+121	common	getpgid			__x64_sys_getpgid
+122	common	setfsuid		__x64_sys_setfsuid
+123	common	setfsgid		__x64_sys_setfsgid
+124	common	getsid			__x64_sys_getsid
+125	common	capget			__x64_sys_capget
+126	common	capset			__x64_sys_capset
+127	64	rt_sigpending		__x64_sys_rt_sigpending
+128	64	rt_sigtimedwait		__x64_sys_rt_sigtimedwait
+129	64	rt_sigqueueinfo		__x64_sys_rt_sigqueueinfo
+130	common	rt_sigsuspend		__x64_sys_rt_sigsuspend
+131	64	sigaltstack		__x64_sys_sigaltstack
+132	common	utime			__x64_sys_utime
+133	common	mknod			__x64_sys_mknod
 134	64	uselib
-135	common	personality		sys_personality
-136	common	ustat			sys_ustat
-137	common	statfs			sys_statfs
-138	common	fstatfs			sys_fstatfs
-139	common	sysfs			sys_sysfs
-140	common	getpriority		sys_getpriority
-141	common	setpriority		sys_setpriority
-142	common	sched_setparam		sys_sched_setparam
-143	common	sched_getparam		sys_sched_getparam
-144	common	sched_setscheduler	sys_sched_setscheduler
-145	common	sched_getscheduler	sys_sched_getscheduler
-146	common	sched_get_priority_max	sys_sched_get_priority_max
-147	common	sched_get_priority_min	sys_sched_get_priority_min
-148	common	sched_rr_get_interval	sys_sched_rr_get_interval
-149	common	mlock			sys_mlock
-150	common	munlock			sys_munlock
-151	common	mlockall		sys_mlockall
-152	common	munlockall		sys_munlockall
-153	common	vhangup			sys_vhangup
-154	common	modify_ldt		sys_modify_ldt
-155	common	pivot_root		sys_pivot_root
-156	64	_sysctl			sys_sysctl
-157	common	prctl			sys_prctl
-158	common	arch_prctl		sys_arch_prctl
-159	common	adjtimex		sys_adjtimex
-160	common	setrlimit		sys_setrlimit
-161	common	chroot			sys_chroot
-162	common	sync			sys_sync
-163	common	acct			sys_acct
-164	common	settimeofday		sys_settimeofday
-165	common	mount			sys_mount
-166	common	umount2			sys_umount
-167	common	swapon			sys_swapon
-168	common	swapoff			sys_swapoff
-169	common	reboot			sys_reboot
-170	common	sethostname		sys_sethostname
-171	common	setdomainname		sys_setdomainname
-172	common	iopl			sys_iopl/ptregs
-173	common	ioperm			sys_ioperm
+135	common	personality		__x64_sys_personality
+136	common	ustat			__x64_sys_ustat
+137	common	statfs			__x64_sys_statfs
+138	common	fstatfs			__x64_sys_fstatfs
+139	common	sysfs			__x64_sys_sysfs
+140	common	getpriority		__x64_sys_getpriority
+141	common	setpriority		__x64_sys_setpriority
+142	common	sched_setparam		__x64_sys_sched_setparam
+143	common	sched_getparam		__x64_sys_sched_getparam
+144	common	sched_setscheduler	__x64_sys_sched_setscheduler
+145	common	sched_getscheduler	__x64_sys_sched_getscheduler
+146	common	sched_get_priority_max	__x64_sys_sched_get_priority_max
+147	common	sched_get_priority_min	__x64_sys_sched_get_priority_min
+148	common	sched_rr_get_interval	__x64_sys_sched_rr_get_interval
+149	common	mlock			__x64_sys_mlock
+150	common	munlock			__x64_sys_munlock
+151	common	mlockall		__x64_sys_mlockall
+152	common	munlockall		__x64_sys_munlockall
+153	common	vhangup			__x64_sys_vhangup
+154	common	modify_ldt		__x64_sys_modify_ldt
+155	common	pivot_root		__x64_sys_pivot_root
+156	64	_sysctl			__x64_sys_sysctl
+157	common	prctl			__x64_sys_prctl
+158	common	arch_prctl		__x64_sys_arch_prctl
+159	common	adjtimex		__x64_sys_adjtimex
+160	common	setrlimit		__x64_sys_setrlimit
+161	common	chroot			__x64_sys_chroot
+162	common	sync			__x64_sys_sync
+163	common	acct			__x64_sys_acct
+164	common	settimeofday		__x64_sys_settimeofday
+165	common	mount			__x64_sys_mount
+166	common	umount2			__x64_sys_umount
+167	common	swapon			__x64_sys_swapon
+168	common	swapoff			__x64_sys_swapoff
+169	common	reboot			__x64_sys_reboot
+170	common	sethostname		__x64_sys_sethostname
+171	common	setdomainname		__x64_sys_setdomainname
+172	common	iopl			__x64_sys_iopl/ptregs
+173	common	ioperm			__x64_sys_ioperm
 174	64	create_module
-175	common	init_module		sys_init_module
-176	common	delete_module		sys_delete_module
+175	common	init_module		__x64_sys_init_module
+176	common	delete_module		__x64_sys_delete_module
 177	64	get_kernel_syms
 178	64	query_module
-179	common	quotactl		sys_quotactl
+179	common	quotactl		__x64_sys_quotactl
 180	64	nfsservctl
 181	common	getpmsg
 182	common	putpmsg
 183	common	afs_syscall
 184	common	tuxcall
 185	common	security
-186	common	gettid			sys_gettid
-187	common	readahead		sys_readahead
-188	common	setxattr		sys_setxattr
-189	common	lsetxattr		sys_lsetxattr
-190	common	fsetxattr		sys_fsetxattr
-191	common	getxattr		sys_getxattr
-192	common	lgetxattr		sys_lgetxattr
-193	common	fgetxattr		sys_fgetxattr
-194	common	listxattr		sys_listxattr
-195	common	llistxattr		sys_llistxattr
-196	common	flistxattr		sys_flistxattr
-197	common	removexattr		sys_removexattr
-198	common	lremovexattr		sys_lremovexattr
-199	common	fremovexattr		sys_fremovexattr
-200	common	tkill			sys_tkill
-201	common	time			sys_time
-202	common	futex			sys_futex
-203	common	sched_setaffinity	sys_sched_setaffinity
-204	common	sched_getaffinity	sys_sched_getaffinity
+186	common	gettid			__x64_sys_gettid
+187	common	readahead		__x64_sys_readahead
+188	common	setxattr		__x64_sys_setxattr
+189	common	lsetxattr		__x64_sys_lsetxattr
+190	common	fsetxattr		__x64_sys_fsetxattr
+191	common	getxattr		__x64_sys_getxattr
+192	common	lgetxattr		__x64_sys_lgetxattr
+193	common	fgetxattr		__x64_sys_fgetxattr
+194	common	listxattr		__x64_sys_listxattr
+195	common	llistxattr		__x64_sys_llistxattr
+196	common	flistxattr		__x64_sys_flistxattr
+197	common	removexattr		__x64_sys_removexattr
+198	common	lremovexattr		__x64_sys_lremovexattr
+199	common	fremovexattr		__x64_sys_fremovexattr
+200	common	tkill			__x64_sys_tkill
+201	common	time			__x64_sys_time
+202	common	futex			__x64_sys_futex
+203	common	sched_setaffinity	__x64_sys_sched_setaffinity
+204	common	sched_getaffinity	__x64_sys_sched_getaffinity
 205	64	set_thread_area
-206	64	io_setup		sys_io_setup
-207	common	io_destroy		sys_io_destroy
-208	common	io_getevents		sys_io_getevents
-209	64	io_submit		sys_io_submit
-210	common	io_cancel		sys_io_cancel
+206	64	io_setup		__x64_sys_io_setup
+207	common	io_destroy		__x64_sys_io_destroy
+208	common	io_getevents		__x64_sys_io_getevents
+209	64	io_submit		__x64_sys_io_submit
+210	common	io_cancel		__x64_sys_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		sys_lookup_dcookie
-213	common	epoll_create		sys_epoll_create
+212	common	lookup_dcookie		__x64_sys_lookup_dcookie
+213	common	epoll_create		__x64_sys_epoll_create
 214	64	epoll_ctl_old
 215	64	epoll_wait_old
-216	common	remap_file_pages	sys_remap_file_pages
-217	common	getdents64		sys_getdents64
-218	common	set_tid_address		sys_set_tid_address
-219	common	restart_syscall		sys_restart_syscall
-220	common	semtimedop		sys_semtimedop
-221	common	fadvise64		sys_fadvise64
-222	64	timer_create		sys_timer_create
-223	common	timer_settime		sys_timer_settime
-224	common	timer_gettime		sys_timer_gettime
-225	common	timer_getoverrun	sys_timer_getoverrun
-226	common	timer_delete		sys_timer_delete
-227	common	clock_settime		sys_clock_settime
-228	common	clock_gettime		sys_clock_gettime
-229	common	clock_getres		sys_clock_getres
-230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
-232	common	epoll_wait		sys_epoll_wait
-233	common	epoll_ctl		sys_epoll_ctl
-234	common	tgkill			sys_tgkill
-235	common	utimes			sys_utimes
+216	common	remap_file_pages	__x64_sys_remap_file_pages
+217	common	getdents64		__x64_sys_getdents64
+218	common	set_tid_address		__x64_sys_set_tid_address
+219	common	restart_syscall		__x64_sys_restart_syscall
+220	common	semtimedop		__x64_sys_semtimedop
+221	common	fadvise64		__x64_sys_fadvise64
+222	64	timer_create		__x64_sys_timer_create
+223	common	timer_settime		__x64_sys_timer_settime
+224	common	timer_gettime		__x64_sys_timer_gettime
+225	common	timer_getoverrun	__x64_sys_timer_getoverrun
+226	common	timer_delete		__x64_sys_timer_delete
+227	common	clock_settime		__x64_sys_clock_settime
+228	common	clock_gettime		__x64_sys_clock_gettime
+229	common	clock_getres		__x64_sys_clock_getres
+230	common	clock_nanosleep		__x64_sys_clock_nanosleep
+231	common	exit_group		__x64_sys_exit_group
+232	common	epoll_wait		__x64_sys_epoll_wait
+233	common	epoll_ctl		__x64_sys_epoll_ctl
+234	common	tgkill			__x64_sys_tgkill
+235	common	utimes			__x64_sys_utimes
 236	64	vserver
-237	common	mbind			sys_mbind
-238	common	set_mempolicy		sys_set_mempolicy
-239	common	get_mempolicy		sys_get_mempolicy
-240	common	mq_open			sys_mq_open
-241	common	mq_unlink		sys_mq_unlink
-242	common	mq_timedsend		sys_mq_timedsend
-243	common	mq_timedreceive		sys_mq_timedreceive
-244	64	mq_notify		sys_mq_notify
-245	common	mq_getsetattr		sys_mq_getsetattr
-246	64	kexec_load		sys_kexec_load
-247	64	waitid			sys_waitid
-248	common	add_key			sys_add_key
-249	common	request_key		sys_request_key
-250	common	keyctl			sys_keyctl
-251	common	ioprio_set		sys_ioprio_set
-252	common	ioprio_get		sys_ioprio_get
-253	common	inotify_init		sys_inotify_init
-254	common	inotify_add_watch	sys_inotify_add_watch
-255	common	inotify_rm_watch	sys_inotify_rm_watch
-256	common	migrate_pages		sys_migrate_pages
-257	common	openat			sys_openat
-258	common	mkdirat			sys_mkdirat
-259	common	mknodat			sys_mknodat
-260	common	fchownat		sys_fchownat
-261	common	futimesat		sys_futimesat
-262	common	newfstatat		sys_newfstatat
-263	common	unlinkat		sys_unlinkat
-264	common	renameat		sys_renameat
-265	common	linkat			sys_linkat
-266	common	symlinkat		sys_symlinkat
-267	common	readlinkat		sys_readlinkat
-268	common	fchmodat		sys_fchmodat
-269	common	faccessat		sys_faccessat
-270	common	pselect6		sys_pselect6
-271	common	ppoll			sys_ppoll
-272	common	unshare			sys_unshare
-273	64	set_robust_list		sys_set_robust_list
-274	64	get_robust_list		sys_get_robust_list
-275	common	splice			sys_splice
-276	common	tee			sys_tee
-277	common	sync_file_range		sys_sync_file_range
-278	64	vmsplice		sys_vmsplice
-279	64	move_pages		sys_move_pages
-280	common	utimensat		sys_utimensat
-281	common	epoll_pwait		sys_epoll_pwait
-282	common	signalfd		sys_signalfd
-283	common	timerfd_create		sys_timerfd_create
-284	common	eventfd			sys_eventfd
-285	common	fallocate		sys_fallocate
-286	common	timerfd_settime		sys_timerfd_settime
-287	common	timerfd_gettime		sys_timerfd_gettime
-288	common	accept4			sys_accept4
-289	common	signalfd4		sys_signalfd4
-290	common	eventfd2		sys_eventfd2
-291	common	epoll_create1		sys_epoll_create1
-292	common	dup3			sys_dup3
-293	common	pipe2			sys_pipe2
-294	common	inotify_init1		sys_inotify_init1
-295	64	preadv			sys_preadv
-296	64	pwritev			sys_pwritev
-297	64	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
-298	common	perf_event_open		sys_perf_event_open
-299	64	recvmmsg		sys_recvmmsg
-300	common	fanotify_init		sys_fanotify_init
-301	common	fanotify_mark		sys_fanotify_mark
-302	common	prlimit64		sys_prlimit64
-303	common	name_to_handle_at	sys_name_to_handle_at
-304	common	open_by_handle_at	sys_open_by_handle_at
-305	common	clock_adjtime		sys_clock_adjtime
-306	common	syncfs			sys_syncfs
-307	64	sendmmsg		sys_sendmmsg
-308	common	setns			sys_setns
-309	common	getcpu			sys_getcpu
-310	64	process_vm_readv	sys_process_vm_readv
-311	64	process_vm_writev	sys_process_vm_writev
-312	common	kcmp			sys_kcmp
-313	common	finit_module		sys_finit_module
-314	common	sched_setattr		sys_sched_setattr
-315	common	sched_getattr		sys_sched_getattr
-316	common	renameat2		sys_renameat2
-317	common	seccomp			sys_seccomp
-318	common	getrandom		sys_getrandom
-319	common	memfd_create		sys_memfd_create
-320	common	kexec_file_load		sys_kexec_file_load
-321	common	bpf			sys_bpf
-322	64	execveat		sys_execveat/ptregs
-323	common	userfaultfd		sys_userfaultfd
-324	common	membarrier		sys_membarrier
-325	common	mlock2			sys_mlock2
-326	common	copy_file_range		sys_copy_file_range
-327	64	preadv2			sys_preadv2
-328	64	pwritev2		sys_pwritev2
-329	common	pkey_mprotect		sys_pkey_mprotect
-330	common	pkey_alloc		sys_pkey_alloc
-331	common	pkey_free		sys_pkey_free
-332	common	statx			sys_statx
+237	common	mbind			__x64_sys_mbind
+238	common	set_mempolicy		__x64_sys_set_mempolicy
+239	common	get_mempolicy		__x64_sys_get_mempolicy
+240	common	mq_open			__x64_sys_mq_open
+241	common	mq_unlink		__x64_sys_mq_unlink
+242	common	mq_timedsend		__x64_sys_mq_timedsend
+243	common	mq_timedreceive		__x64_sys_mq_timedreceive
+244	64	mq_notify		__x64_sys_mq_notify
+245	common	mq_getsetattr		__x64_sys_mq_getsetattr
+246	64	kexec_load		__x64_sys_kexec_load
+247	64	waitid			__x64_sys_waitid
+248	common	add_key			__x64_sys_add_key
+249	common	request_key		__x64_sys_request_key
+250	common	keyctl			__x64_sys_keyctl
+251	common	ioprio_set		__x64_sys_ioprio_set
+252	common	ioprio_get		__x64_sys_ioprio_get
+253	common	inotify_init		__x64_sys_inotify_init
+254	common	inotify_add_watch	__x64_sys_inotify_add_watch
+255	common	inotify_rm_watch	__x64_sys_inotify_rm_watch
+256	common	migrate_pages		__x64_sys_migrate_pages
+257	common	openat			__x64_sys_openat
+258	common	mkdirat			__x64_sys_mkdirat
+259	common	mknodat			__x64_sys_mknodat
+260	common	fchownat		__x64_sys_fchownat
+261	common	futimesat		__x64_sys_futimesat
+262	common	newfstatat		__x64_sys_newfstatat
+263	common	unlinkat		__x64_sys_unlinkat
+264	common	renameat		__x64_sys_renameat
+265	common	linkat			__x64_sys_linkat
+266	common	symlinkat		__x64_sys_symlinkat
+267	common	readlinkat		__x64_sys_readlinkat
+268	common	fchmodat		__x64_sys_fchmodat
+269	common	faccessat		__x64_sys_faccessat
+270	common	pselect6		__x64_sys_pselect6
+271	common	ppoll			__x64_sys_ppoll
+272	common	unshare			__x64_sys_unshare
+273	64	set_robust_list		__x64_sys_set_robust_list
+274	64	get_robust_list		__x64_sys_get_robust_list
+275	common	splice			__x64_sys_splice
+276	common	tee			__x64_sys_tee
+277	common	sync_file_range		__x64_sys_sync_file_range
+278	64	vmsplice		__x64_sys_vmsplice
+279	64	move_pages		__x64_sys_move_pages
+280	common	utimensat		__x64_sys_utimensat
+281	common	epoll_pwait		__x64_sys_epoll_pwait
+282	common	signalfd		__x64_sys_signalfd
+283	common	timerfd_create		__x64_sys_timerfd_create
+284	common	eventfd			__x64_sys_eventfd
+285	common	fallocate		__x64_sys_fallocate
+286	common	timerfd_settime		__x64_sys_timerfd_settime
+287	common	timerfd_gettime		__x64_sys_timerfd_gettime
+288	common	accept4			__x64_sys_accept4
+289	common	signalfd4		__x64_sys_signalfd4
+290	common	eventfd2		__x64_sys_eventfd2
+291	common	epoll_create1		__x64_sys_epoll_create1
+292	common	dup3			__x64_sys_dup3
+293	common	pipe2			__x64_sys_pipe2
+294	common	inotify_init1		__x64_sys_inotify_init1
+295	64	preadv			__x64_sys_preadv
+296	64	pwritev			__x64_sys_pwritev
+297	64	rt_tgsigqueueinfo	__x64_sys_rt_tgsigqueueinfo
+298	common	perf_event_open		__x64_sys_perf_event_open
+299	64	recvmmsg		__x64_sys_recvmmsg
+300	common	fanotify_init		__x64_sys_fanotify_init
+301	common	fanotify_mark		__x64_sys_fanotify_mark
+302	common	prlimit64		__x64_sys_prlimit64
+303	common	name_to_handle_at	__x64_sys_name_to_handle_at
+304	common	open_by_handle_at	__x64_sys_open_by_handle_at
+305	common	clock_adjtime		__x64_sys_clock_adjtime
+306	common	syncfs			__x64_sys_syncfs
+307	64	sendmmsg		__x64_sys_sendmmsg
+308	common	setns			__x64_sys_setns
+309	common	getcpu			__x64_sys_getcpu
+310	64	process_vm_readv	__x64_sys_process_vm_readv
+311	64	process_vm_writev	__x64_sys_process_vm_writev
+312	common	kcmp			__x64_sys_kcmp
+313	common	finit_module		__x64_sys_finit_module
+314	common	sched_setattr		__x64_sys_sched_setattr
+315	common	sched_getattr		__x64_sys_sched_getattr
+316	common	renameat2		__x64_sys_renameat2
+317	common	seccomp			__x64_sys_seccomp
+318	common	getrandom		__x64_sys_getrandom
+319	common	memfd_create		__x64_sys_memfd_create
+320	common	kexec_file_load		__x64_sys_kexec_file_load
+321	common	bpf			__x64_sys_bpf
+322	64	execveat		__x64_sys_execveat/ptregs
+323	common	userfaultfd		__x64_sys_userfaultfd
+324	common	membarrier		__x64_sys_membarrier
+325	common	mlock2			__x64_sys_mlock2
+326	common	copy_file_range		__x64_sys_copy_file_range
+327	64	preadv2			__x64_sys_preadv2
+328	64	pwritev2		__x64_sys_pwritev2
+329	common	pkey_mprotect		__x64_sys_pkey_mprotect
+330	common	pkey_alloc		__x64_sys_pkey_alloc
+331	common	pkey_free		__x64_sys_pkey_free
+332	common	statx			__x64_sys_statx
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation.
+# for native 64-bit operation. The __x32_compat_sys stubs are created
+# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
+# is defined.
 #
-512	x32	rt_sigaction		compat_sys_rt_sigaction
+512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
 513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
-514	x32	ioctl			compat_sys_ioctl
-515	x32	readv			compat_sys_readv
-516	x32	writev			compat_sys_writev
-517	x32	recvfrom		compat_sys_recvfrom
-518	x32	sendmsg			compat_sys_sendmsg
-519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve/ptregs
-521	x32	ptrace			compat_sys_ptrace
-522	x32	rt_sigpending		compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait
-524	x32	rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-525	x32	sigaltstack		compat_sys_sigaltstack
-526	x32	timer_create		compat_sys_timer_create
-527	x32	mq_notify		compat_sys_mq_notify
-528	x32	kexec_load		compat_sys_kexec_load
-529	x32	waitid			compat_sys_waitid
-530	x32	set_robust_list		compat_sys_set_robust_list
-531	x32	get_robust_list		compat_sys_get_robust_list
-532	x32	vmsplice		compat_sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
-534	x32	preadv			compat_sys_preadv64
-535	x32	pwritev			compat_sys_pwritev64
-536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		compat_sys_recvmmsg
-538	x32	sendmmsg		compat_sys_sendmmsg
-539	x32	process_vm_readv	compat_sys_process_vm_readv
-540	x32	process_vm_writev	compat_sys_process_vm_writev
-541	x32	setsockopt		compat_sys_setsockopt
-542	x32	getsockopt		compat_sys_getsockopt
-543	x32	io_setup		compat_sys_io_setup
-544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat/ptregs
-546	x32	preadv2			compat_sys_preadv64v2
-547	x32	pwritev2		compat_sys_pwritev64v2
+514	x32	ioctl			__x32_compat_sys_ioctl
+515	x32	readv			__x32_compat_sys_readv
+516	x32	writev			__x32_compat_sys_writev
+517	x32	recvfrom		__x32_compat_sys_recvfrom
+518	x32	sendmsg			__x32_compat_sys_sendmsg
+519	x32	recvmsg			__x32_compat_sys_recvmsg
+520	x32	execve			__x32_compat_sys_execve/ptregs
+521	x32	ptrace			__x32_compat_sys_ptrace
+522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
+525	x32	sigaltstack		__x32_compat_sys_sigaltstack
+526	x32	timer_create		__x32_compat_sys_timer_create
+527	x32	mq_notify		__x32_compat_sys_mq_notify
+528	x32	kexec_load		__x32_compat_sys_kexec_load
+529	x32	waitid			__x32_compat_sys_waitid
+530	x32	set_robust_list		__x32_compat_sys_set_robust_list
+531	x32	get_robust_list		__x32_compat_sys_get_robust_list
+532	x32	vmsplice		__x32_compat_sys_vmsplice
+533	x32	move_pages		__x32_compat_sys_move_pages
+534	x32	preadv			__x32_compat_sys_preadv64
+535	x32	pwritev			__x32_compat_sys_pwritev64
+536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+538	x32	sendmmsg		__x32_compat_sys_sendmmsg
+539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
+540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
+541	x32	setsockopt		__x32_compat_sys_setsockopt
+542	x32	getsockopt		__x32_compat_sys_getsockopt
+543	x32	io_setup		__x32_compat_sys_io_setup
+544	x32	io_submit		__x32_compat_sys_io_submit
+545	x32	execveat		__x32_compat_sys_execveat/ptregs
+546	x32	preadv2			__x32_compat_sys_preadv64v2
+547	x32	pwritev2		__x32_compat_sys_pwritev64v2
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index d71ef4bd3615..94fcd1951aca 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -25,15 +25,27 @@ emit() {
     nr="$2"
     entry="$3"
     compat="$4"
+    umlentry=""
 
     if [ "$abi" = "64" -a -n "$compat" ]; then
 	echo "a compat entry for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 
+    # For CONFIG_UML, we need to strip the __x64_sys prefix
+    if [ "$abi" = "64" -a "${entry}" != "${entry#__x64_sys}" ]; then
+	    umlentry="sys${entry#__x64_sys}"
+    fi
+
     if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
+	if [ -n "$entry" -a -z "$umlentry" ]; then
 	    syscall_macro "$abi" "$nr" "$entry"
+	elif [ -n "$umlentry" ]; then # implies -n "$entry"
+	    echo "#ifdef CONFIG_X86"
+	    syscall_macro "$abi" "$nr" "$entry"
+	    echo "#else /* CONFIG_UML */"
+	    syscall_macro "$abi" "$nr" "$umlentry"
+	    echo "#endif"
 	fi
     else
 	echo "#ifdef CONFIG_X86_32"
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 317be365bce3..70b7845434cb 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -127,6 +127,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	int vsyscall_nr, syscall_nr, tmp;
 	int prev_sig_on_uaccess_err;
 	long ret;
+	unsigned long orig_dx;
 
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
@@ -227,19 +228,22 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
-		ret = sys_gettimeofday(
-			(struct timeval __user *)regs->di,
-			(struct timezone __user *)regs->si);
+		/* this decodes regs->di and regs->si on its own */
+		ret = __x64_sys_gettimeofday(regs);
 		break;
 
 	case 1:
-		ret = sys_time((time_t __user *)regs->di);
+		/* this decodes regs->di on its own */
+		ret = __x64_sys_time(regs);
 		break;
 
 	case 2:
-		ret = sys_getcpu((unsigned __user *)regs->di,
-				 (unsigned __user *)regs->si,
-				 NULL);
+		/* while we could clobber regs->dx, we didn't in the past... */
+		orig_dx = regs->dx;
+		regs->dx = 0;
+		/* this decodes regs->di, regs->si and regs->dx on its own */
+		ret = __x64_sys_getcpu(regs);
+		regs->dx = orig_dx;
 		break;
 	}
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 40a3d3642f3a..08acd954f00e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,7 +313,7 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(int apicid);
+	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -486,7 +486,7 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
-extern int default_apic_id_valid(int apicid);
+extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 03eedc21246d..d653139857af 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -20,9 +20,13 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
+#ifdef CONFIG_X86_64
+typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
+#else
 typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
+#endif /* CONFIG_X86_64 */
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..e046a405743d
--- /dev/null
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - x86 specific wrappers to syscall definitions
+ */
+
+#ifndef _ASM_X86_SYSCALL_WRAPPER_H
+#define _ASM_X86_SYSCALL_WRAPPER_H
+
+/* Mapping of registers to parameters for syscalls on x86-64 and x32 */
+#define SC_X86_64_REGS_TO_ARGS(x, ...)					\
+	__MAP(x,__SC_ARGS						\
+		,,regs->di,,regs->si,,regs->dx				\
+		,,regs->r10,,regs->r8,,regs->r9)			\
+
+/* Mapping of registers to parameters for syscalls on i386 */
+#define SC_IA32_REGS_TO_ARGS(x, ...)					\
+	__MAP(x,__SC_ARGS						\
+	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
+	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
+	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+
+#ifdef CONFIG_IA32_EMULATION
+/*
+ * For IA32 emulation, we need to handle "compat" syscalls *and* create
+ * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
+ * ia32 regs in the proper order for shared or "common" syscalls. As some
+ * syscalls may not be implemented, we need to expand COND_SYSCALL in
+ * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
+ * case as well.
+ */
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
+	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
+	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+
+#define __IA32_SYS_STUBx(x, name, ...)					\
+	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
+	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
+	{								\
+		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}
+
+/*
+ * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
+ * named __ia32_sys_*()
+ */
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __x64_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
+	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);	\
+	asmlinkage long __x64_sys_##sname(void)
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(__x64_sys_##name);					\
+	cond_syscall(__ia32_sys_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
+	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_IA32_EMULATION */
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUBx(x, fullname, name, ...)
+#endif /* CONFIG_IA32_EMULATION */
+
+
+#ifdef CONFIG_X86_X32
+/*
+ * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
+ * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
+ * with x86_64 obviously do not need such care.
+ */
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
+	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
+	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+
+#else /* CONFIG_X86_X32 */
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#endif /* CONFIG_X86_X32 */
+
+
+#ifdef CONFIG_COMPAT
+/*
+ * Compat means IA32_EMULATION and/or X86_X32. As they use a different
+ * mapping of registers to parameters, we need to generate stubs for each
+ * of them.
+ */
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{									\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+	}									\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+/*
+ * As some compat syscalls may not be implemented, we need to expand
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
+ * kernel/time/posix-stubs.c to cover this case as well.
+ */
+#define COND_SYSCALL_COMPAT(name) 					\
+	cond_syscall(__ia32_compat_sys_##name);				\
+	cond_syscall(__x32_compat_sys_##name)
+
+#define COMPAT_SYS_NI(name)						\
+	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
+	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+
+#endif /* CONFIG_COMPAT */
+
+
+/*
+ * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
+ * struct pt_regs *regs as the only argument of the syscall stub named
+ * __x64_sys_*(). It decodes just the registers it needs and passes them on to
+ * the __se_sys_*() wrapper performing sign extension and then to the
+ * __do_sys_*() function doing the actual job. These wrappers and functions
+ * are inlined (at least in very most cases), meaning that the assembly looks
+ * as follows (slightly re-ordered for better readability):
+ *
+ * <__x64_sys_recv>:		<-- syscall with 4 parameters
+ *	callq	<__fentry__>
+ *
+ *	mov	0x70(%rdi),%rdi	<-- decode regs->di
+ *	mov	0x68(%rdi),%rsi	<-- decode regs->si
+ *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
+ *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
+ *
+ *	xor	%r9d,%r9d	<-- clear %r9
+ *	xor	%r8d,%r8d	<-- clear %r8
+ *
+ *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
+ *				    which takes 6 arguments
+ *
+ *	cltq			<-- extend return value to 64-bit
+ *	retq			<-- return
+ *
+ * This approach avoids leaking random user-provided register content down
+ * the call chain.
+ *
+ * If IA32_EMULATION is enabled, this macro generates an additional wrapper
+ * named __ia32_sys_*() which decodes the struct pt_regs *regs according
+ * to the i386 calling convention (bx, cx, dx, si, di, bp).
+ */
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	asmlinkage long __x64_sys##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__x64_sys##name, ERRNO);			\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __x64_sys##name(const struct pt_regs *regs)	\
+	{								\
+		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+/*
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
+ * hurt, we only need to re-define it here to keep the naming congruent to
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
+ * macros to work correctly.
+ */
+#ifndef SYSCALL_DEFINE0
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __x64_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
+	asmlinkage long __x64_sys_##sname(void)
+#endif
+
+#ifndef COND_SYSCALL
+#define COND_SYSCALL(name) cond_syscall(__x64_sys_##name)
+#endif
+
+#ifndef SYS_NI
+#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
+#endif
+
+
+/*
+ * For VSYSCALLS, we need to declare these three syscalls with the new
+ * pt_regs-based calling convention for in-kernel use.
+ */
+struct pt_regs;
+asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
+asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
+asmlinkage long __x64_sys_time(const struct pt_regs *regs);
+
+#endif /* _ASM_X86_SYSCALL_WRAPPER_H */
diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index ae6e05fdc24b..9fa979dd0d9d 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -18,6 +18,12 @@
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
+
+#ifdef CONFIG_X86_32
+/*
+ * These definitions are only valid on pure 32-bit systems; x86-64 uses a
+ * different syscall calling convention
+ */
 asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
 asmlinkage long sys_iopl(unsigned int);
 
@@ -32,7 +38,6 @@ asmlinkage long sys_set_thread_area(struct user_desc __user *);
 asmlinkage long sys_get_thread_area(struct user_desc __user *);
 
 /* X86_32 only */
-#ifdef CONFIG_X86_32
 
 /* kernel/signal.c */
 asmlinkage long sys_sigreturn(void);
@@ -42,15 +47,5 @@ struct vm86_struct;
 asmlinkage long sys_vm86old(struct vm86_struct __user *);
 asmlinkage long sys_vm86(unsigned long, unsigned long);
 
-#else /* CONFIG_X86_32 */
-
-/* X86_64 only */
-/* kernel/process_64.c */
-asmlinkage long sys_arch_prctl(int, unsigned long);
-
-/* kernel/sys_x86_64.c */
-asmlinkage long sys_mmap(unsigned long, unsigned long, unsigned long,
-			 unsigned long, unsigned long, unsigned long);
-
 #endif /* CONFIG_X86_32 */
 #endif /* _ASM_X86_SYSCALLS_H */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7a37d9357bc4..dde444f932c1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -200,7 +200,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
 #ifdef CONFIG_X86_X2APIC
-	int apic_id;
+	u32 apic_id;
 	u8 enabled;
 #endif
 
@@ -222,10 +222,13 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id) && enabled)
-		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-	else
-		acpi_register_lapic(apic_id, processor->uid, enabled);
+	if (!apic->apic_id_valid(apic_id)) {
+		if (enabled)
+			pr_warn(PREFIX "x2apic entry ignored\n");
+		return 0;
+	}
+
+	acpi_register_lapic(apic_id, processor->uid, enabled);
 #else
 	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index a360801779ae..02b4839478b1 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -40,7 +40,7 @@ int default_check_phys_apicid_present(int phys_apicid)
 	return physid_isset(phys_apicid, phys_cpu_present_map);
 }
 
-int default_apic_id_valid(int apicid)
+int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 134e04506ab4..78778b54f904 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigned int id)
 	return id << 24;
 }
 
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
 	/* Trust what bootloader passes in MADT */
 	return 1;
diff --git a/arch/x86/kernel/apic/x2apic.h b/arch/x86/kernel/apic/x2apic.h
index b107de381cb5..a49b3604027f 100644
--- a/arch/x86/kernel/apic/x2apic.h
+++ b/arch/x86/kernel/apic/x2apic.h
@@ -1,6 +1,6 @@
 /* Common bits for X2APIC cluster/physical modes. */
 
-int x2apic_apic_id_valid(int apicid);
+int x2apic_apic_id_valid(u32 apicid);
 int x2apic_apic_id_registered(void);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e2829bf40e4a..b5cf9e7b3830 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -101,7 +101,7 @@ static int x2apic_phys_probe(void)
 }
 
 /* Common x2apic functions, also used by x2apic_cluster */
-int x2apic_apic_id_valid(int apicid)
+int x2apic_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f11910b44638..efaf2d4f9c3c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -557,7 +557,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf4821240..2981bf287ef5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -848,18 +848,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = edx;
 	}
 
-	if (c->extended_cpuid_level >= 0x80000008) {
-		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-
-		c->x86_virt_bits = (eax >> 8) & 0xff;
-		c->x86_phys_bits = eax & 0xff;
-		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
-	}
-#ifdef CONFIG_X86_32
-	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
-		c->x86_phys_bits = 36;
-#endif
-
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
@@ -874,6 +862,23 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
+static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (c->extended_cpuid_level >= 0x80000008) {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+
+		c->x86_virt_bits = (eax >> 8) & 0xff;
+		c->x86_phys_bits = eax & 0xff;
+		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
+	}
+#ifdef CONFIG_X86_32
+	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
+		c->x86_phys_bits = 36;
+#endif
+}
+
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -965,6 +970,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
+		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 
 		if (this_cpu->c_early_init)
@@ -1097,6 +1103,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_cpu_cap(c);
 
+	get_cpu_address_sizes(c);
+
 	if (c->cpuid_level >= 0x00000001) {
 		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 904b0a3c4e53..2c0bd38a44ab 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -19,7 +19,7 @@ struct cpuid_dep {
  * called from cpu hotplug. It shouldn't do anything in this case,
  * but it's difficult to tell that to the init reference checker.
  */
-const static struct cpuid_dep cpuid_deps[] = {
+static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XSAVEOPT,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVEC,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVES,		X86_FEATURE_XSAVE     },
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 2163888497d3..5e53bfbe5823 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -112,7 +112,7 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
 	return xen_pv_domain();
 }
 
-static int xen_id_always_valid(int apicid)
+static int xen_id_always_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 9847c5a013c3..aca050aac7b6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -24,6 +24,17 @@
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+/*
+ * It may be useful for an architecture to override the definitions of the
+ * COMPAT_SYSCALL_DEFINE0 and COMPAT_SYSCALL_DEFINEx() macros, in particular
+ * to use a different calling convention for syscalls. To allow for that,
+ + the prototypes for the compat_sys_*() functions below will *not* be included
+ * if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
+ */
+#include <asm/syscall_wrapper.h>
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 #ifndef COMPAT_USE_64BIT_TIME
 #define COMPAT_USE_64BIT_TIME 0
 #endif
@@ -32,10 +43,12 @@
 #define __SC_DELOUSE(t,v) ((__force t)(unsigned long)(v))
 #endif
 
+#ifndef COMPAT_SYSCALL_DEFINE0
 #define COMPAT_SYSCALL_DEFINE0(name) \
 	asmlinkage long compat_sys_##name(void); \
 	ALLOW_ERROR_INJECTION(compat_sys_##name, ERRNO); \
 	asmlinkage long compat_sys_##name(void)
+#endif /* COMPAT_SYSCALL_DEFINE0 */
 
 #define COMPAT_SYSCALL_DEFINE1(name, ...) \
         COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
@@ -50,18 +63,25 @@
 #define COMPAT_SYSCALL_DEFINE6(name, ...) \
 	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
 
-#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
-		__attribute__((alias(__stringify(compat_SyS##name))));  \
-	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);	\
-	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));\
-	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
-	{								\
-		return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
-	}								\
-	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+/*
+ * The asmlinkage stub is aliased to a function named __se_compat_sys_*() which
+ * sign-extends 32-bit ints to longs whenever needed. The actual work is
+ * done within __do_compat_sys_*().
+ */
+#ifndef COMPAT_SYSCALL_DEFINEx
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
+	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{									\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+	}									\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* COMPAT_SYSCALL_DEFINEx */
 
 #ifndef compat_user_stack_pointer
 #define compat_user_stack_pointer() current_user_stack_pointer()
@@ -517,7 +537,12 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
  * Please note that these prototypes here are only provided for information
  * purposes, for static analysis, and for linking from the syscall table.
  * These functions should not be called elsewhere from kernel code.
+ *
+ * As the syscall calling convention may be different from the default
+ * for architectures overriding the syscall calling convention, do not
+ * include the prototypes if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
  */
+#ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p);
 asmlinkage long compat_sys_io_submit(compat_aio_context_t ctx_id, int nr,
 				     u32 __user *iocb);
@@ -955,6 +980,8 @@ asmlinkage long compat_sys_stime(compat_time_t __user *tptr);
 /* obsolete: net/socket.c */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b961184f597a..70fcda1a9049 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -81,6 +81,17 @@ union bpf_attr;
 #include <linux/key.h>
 #include <trace/syscall.h>
 
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+/*
+ * It may be useful for an architecture to override the definitions of the
+ * SYSCALL_DEFINE0() and __SYSCALL_DEFINEx() macros, in particular to use a
+ * different calling convention for syscalls. To allow for that, the prototypes
+ * for the sys_*() functions below will *not* be included if
+ * CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
+ */
+#include <asm/syscall_wrapper.h>
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 /*
  * __MAP - apply a macro to syscall arguments
  * __MAP(n, m, t1, a1, t2, a2, ..., tn, an) will expand to
@@ -91,7 +102,7 @@ union bpf_attr;
  * for SYSCALL_DEFINE<n>/COMPAT_SYSCALL_DEFINE<n>
  */
 #define __MAP0(m,...)
-#define __MAP1(m,t,a) m(t,a)
+#define __MAP1(m,t,a,...) m(t,a)
 #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
 #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
 #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
@@ -189,11 +200,13 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
+#ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
+#endif /* SYSCALL_DEFINE0 */
 
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
 #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
@@ -209,20 +222,28 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
+
+/*
+ * The asmlinkage stub is aliased to a function named __se_sys_*() which
+ * sign-extends 32-bit ints to longs whenever needed. The actual work is
+ * done within __do_sys_*().
+ */
+#ifndef __SYSCALL_DEFINEx
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
-		__attribute__((alias(__stringify(SyS##name))));		\
+		__attribute__((alias(__stringify(__se_sys##name))));	\
 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
-	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
-	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
-		long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
 		__MAP(x,__SC_TEST,__VA_ARGS__);				\
 		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
 		return ret;						\
 	}								\
-	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* __SYSCALL_DEFINEx */
 
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
@@ -252,7 +273,12 @@ static inline void addr_limit_user_check(void)
  * Please note that these prototypes here are only provided for information
  * purposes, for static analysis, and for linking from the syscall table.
  * These functions should not be called elsewhere from kernel code.
+ *
+ * As the syscall calling convention may be different from the default
+ * for architectures overriding the syscall calling convention, do not
+ * include the prototypes if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
  */
+#ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
@@ -1076,6 +1102,8 @@ asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
  */
 asmlinkage long sys_ni_syscall(void);
 
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/init/Kconfig b/init/Kconfig
index 2852692d7c9c..2dbc88051bde 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1923,3 +1923,13 @@ source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
+
+# It may be useful for an architecture to override the definitions of the
+# SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>
+# and the COMPAT_ variants in <linux/compat.h>, in particular to use a
+# different calling convention for syscalls. They can also override the
+# macros for not-implemented syscalls in kernel/sys_ni.c and
+# kernel/time/posix-stubs.c. All these overrides need to be available in
+# <asm/syscall_wrapper.h>.
+config ARCH_HAS_SYSCALL_WRAPPER
+	def_bool n
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 6cafc008f6db..9791364925dc 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -5,6 +5,11 @@
 
 #include <asm/unistd.h>
 
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+/* Architectures may override COND_SYSCALL and COND_SYSCALL_COMPAT */
+#include <asm/syscall_wrapper.h>
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 /*  we can't #include <linux/syscalls.h> here,
     but tell gcc to not warn with -Wmissing-prototypes  */
 asmlinkage long sys_ni_syscall(void);
@@ -17,8 +22,13 @@ asmlinkage long sys_ni_syscall(void)
 	return -ENOSYS;
 }
 
+#ifndef COND_SYSCALL
 #define COND_SYSCALL(name) cond_syscall(sys_##name)
+#endif /* COND_SYSCALL */
+
+#ifndef COND_SYSCALL_COMPAT
 #define COND_SYSCALL_COMPAT(name) cond_syscall(compat_sys_##name)
+#endif /* COND_SYSCALL_COMPAT */
 
 /*
  * This list is kept in the same order as include/uapi/asm-generic/unistd.h.
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b258bee13b02..69a937c3cd81 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -19,6 +19,11 @@
 #include <linux/posix-timers.h>
 #include <linux/compat.h>
 
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+/* Architectures may override SYS_NI and COMPAT_SYS_NI */
+#include <asm/syscall_wrapper.h>
+#endif
+
 asmlinkage long sys_ni_posix_timers(void)
 {
 	pr_err_once("process %d (%s) attempted a POSIX timer syscall "
@@ -27,8 +32,13 @@ asmlinkage long sys_ni_posix_timers(void)
 	return -ENOSYS;
 }
 
+#ifndef SYS_NI
 #define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
+#endif
+
+#ifndef COMPAT_SYS_NI
 #define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
+#endif
 
 SYS_NI(timer_create);
 SYS_NI(timer_gettime);
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..32aacd0d56a8 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1087,6 +1087,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
-	.dma_supported		= swiotlb_dma_supported,
+	.dma_supported		= dma_direct_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index d84a5674e95e..a923f05edb36 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -30,8 +30,8 @@ def getsizes(file, format):
             if type in format:
                 # strip generated symbols
                 if name.startswith("__mod_"): continue
-                if name.startswith("SyS_"): continue
-                if name.startswith("compat_SyS_"): continue
+                if name.startswith("__se_sys"): continue
+                if name.startswith("__se_compat_sys"): continue
                 if name == "linux_banner": continue
                 # statics and some other optimizations adds random .NUMBER
                 name = re_NUMBER.sub('', name)
