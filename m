Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELuj0hIWklVn/WfdCpNu15OtQ+rZC8bybX/5R1CDP/k0JSnGiEg3RoTOKAU+7df960PFxgVt
ARC-Seal: i=1; a=rsa-sha256; t=1520785574; cv=none;
        d=google.com; s=arc-20160816;
        b=c67CMZedaNNTQNYdwsAsIF6AArRS3ZSdinN7E9q8Gek1cnZJsVW8V2LpgXytYZpC3j
         EaxTDVvv9AMGpu5Pd1M4o95BRQbGwiHcFus17NHswyT0Fk7+J3BFGoQDDwRuQCRYXPid
         C2SCI0sulW7amJsxr0sfPyJHxggKCMgSgHqnexshuhCRFtj0G65UKyglmHgP1LzINQbf
         2xFvlIcCed5mkvmpKQE11PMyQP4RK5Hu8YPLyF2xXYzDARmiZdaKUMnOnKvixmabcssC
         7wtJ9gBm0zEyeNCzpFgvv5TNuN3bmb52BZuP2Cyd+gg0jYMDNWEVNpgsxYuNt7FlzzRh
         0LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=J1+HxYFa0ohKGNcaCBSy3AjfecuncdRBMhPUSQfVswU=;
        b=c3A7qeZblw4jDsG51iAydcRW6nGrf9M56z7l5h+jEY2w8Bm6/FNrhOcLjpCxSO1qR5
         +nZsH6oA1MJkbX/Coikuiru0Xxi55njWiQvR36BB0w2ZH5byZ4/abXyEyBEcwblGNAoM
         pwvbHcIXrOHJia2aO86dIAyeTDkI+1H7H2B1OPp5wvMZDL1G69N7J3KL7dYL1UK0zLnq
         hnrgwtRZ5Voza8JIpt3lg3DSbMjGDemucWGgrNq7Ahvkc9whHwP3ma+UVyojhDbyejjB
         KHVmCnwwdVP5NayGDD+hjN4MyIBcapVvMyhaCBb7LqAH5wVYCGelswPKCFC754qB1m9/
         2UiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 11 Mar 2018 09:26:03 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    Greg KH <gregkh@linuxfoundation.org>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [GIT pull] x86/pti updates for 4.16
Message-ID: <alpine.DEB.2.21.1803110919510.3841@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594659254368136142?=
X-GMAIL-MSGID: =?utf-8?q?1594659254368136142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Yet another pile of melted spectrum related updates:

  - Drop native vsyscall support finally as it causes more trouble than
    benefit.

  - Make microcode loading more robust. There were a few issues especially
    related to late loading which are new surfacing because late loading of
    the IB* microcodes addressing spectre issues has become more widely used.

  - Simplfy and robistify the syscall handling in the entry code

  - Prevent kprobes on the entry trampoline code which lead to kernel
    crashes when the probe hits before CR3 is updated

  - Don't check microcode versions when running on hypervisors as they are
    considered as lying anyway.

  - Fix the 32bit objtool build and a coment typo


Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/vsyscall/64: Drop "native" vsyscalls

Ashok Raj (4):
      x86/microcode/intel: Check microcode revision before updating sibling threads
      x86/microcode/intel: Writeback and invalidate caches before updating microcode
      x86/microcode: Do not upload microcode if CPUs are offline
      x86/microcode: Synchronize late microcode loading

Borislav Petkov (3):
      x86/microcode: Get rid of struct apply_microcode_ctx
      x86/microcode/intel: Look into the patch cache first
      x86/microcode: Request microcode on the BSP

Dominik Brodowski (6):
      x86/syscalls/32: Simplify $entry == $compat entries
      x86/entry: Remove stale syscall prototype
      x86/syscalls: Use proper syscall definition for sys_ioperm()
      x86/syscalls: Use COMPAT_SYSCALL_DEFINEx() macros for x86-only compat syscalls
      x86/entry: Do not special-case clone(2) in compat entry
      x86/entry/64/compat: Save one instruction in entry_INT80_compat()

Francis Deslauriers (1):
      x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Josh Poimboeuf (1):
      objtool: Fix 32-bit build

Konrad Rzeszutek Wilk (1):
      x86/spectre_v2: Don't check microcode versions when running under hypervisors

Seunghun Han (1):
      x86/pti: Fix a comment typo


 arch/x86/Kconfig                            |  11 +-
 arch/x86/entry/entry_64_compat.S            |  16 +--
 arch/x86/entry/syscalls/syscall_32.tbl      |  38 +++----
 arch/x86/entry/vsyscall/vsyscall_64.c       |  16 +--
 arch/x86/ia32/sys_ia32.c                    |  74 +++++++------
 arch/x86/include/asm/pgtable_types.h        |   2 -
 arch/x86/include/asm/sections.h             |   1 +
 arch/x86/include/asm/sys_ia32.h             |  48 +++++----
 arch/x86/kernel/cpu/intel.c                 |   7 ++
 arch/x86/kernel/cpu/microcode/core.c        | 158 +++++++++++++++++++++-------
 arch/x86/kernel/cpu/microcode/intel.c       |  48 +++++++--
 arch/x86/kernel/ioport.c                    |   2 +-
 arch/x86/kernel/kprobes/core.c              |  10 +-
 arch/x86/kernel/vmlinux.lds.S               |   2 +
 arch/x86/mm/pti.c                           |   2 +-
 tools/objtool/check.c                       |  27 ++---
 tools/testing/selftests/x86/test_vsyscall.c |  11 +-
 17 files changed, 291 insertions(+), 182 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1aed6c0e413..09c599e0900d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2266,7 +2266,7 @@ choice
 	  it can be used to assist security vulnerability exploitation.
 
 	  This setting can be changed at boot time via the kernel command
-	  line parameter vsyscall=[native|emulate|none].
+	  line parameter vsyscall=[emulate|none].
 
 	  On a system with recent enough glibc (2.14 or newer) and no
 	  static binaries, you can say None without a performance penalty
@@ -2274,15 +2274,6 @@ choice
 
 	  If unsure, select "Emulate".
 
-	config LEGACY_VSYSCALL_NATIVE
-		bool "Native"
-		help
-		  Actual executable code is located in the fixed vsyscall
-		  address mapping, implementing time() efficiently. Since
-		  this makes the mapping executable, it can be used during
-		  security vulnerability exploitation (traditionally as
-		  ROP gadgets). This configuration is not recommended.
-
 	config LEGACY_VSYSCALL_EMULATE
 		bool "Emulate"
 		help
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index e811dd9c5e99..08425c42f8b7 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -363,9 +363,7 @@ ENTRY(entry_INT80_compat)
 	pushq	2*8(%rdi)		/* regs->ip */
 	pushq	1*8(%rdi)		/* regs->orig_ax */
 
-	movq	(%rdi), %rdi		/* restore %rdi */
-
-	pushq	%rdi			/* pt_regs->di */
+	pushq	(%rdi)			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
@@ -406,15 +404,3 @@ ENTRY(entry_INT80_compat)
 	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
 END(entry_INT80_compat)
-
-ENTRY(stub32_clone)
-	/*
-	 * The 32-bit clone ABI is: clone(..., int tls_val, int *child_tidptr).
-	 * The 64-bit clone ABI is: clone(..., int *child_tidptr, int tls_val).
-	 *
-	 * The native 64-bit kernel's sys_clone() implements the latter,
-	 * so we need to swap arguments here before calling it:
-	 */
-	xchg	%r8, %rcx
-	jmp	sys_clone
-ENDPROC(stub32_clone)
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 448ac2161112..2a5e99cff859 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -8,12 +8,12 @@
 #
 0	i386	restart_syscall		sys_restart_syscall
 1	i386	exit			sys_exit
-2	i386	fork			sys_fork			sys_fork
+2	i386	fork			sys_fork
 3	i386	read			sys_read
 4	i386	write			sys_write
 5	i386	open			sys_open			compat_sys_open
 6	i386	close			sys_close
-7	i386	waitpid			sys_waitpid			sys32_waitpid
+7	i386	waitpid			sys_waitpid			compat_sys_x86_waitpid
 8	i386	creat			sys_creat
 9	i386	link			sys_link
 10	i386	unlink			sys_unlink
@@ -78,7 +78,7 @@
 69	i386	ssetmask		sys_ssetmask
 70	i386	setreuid		sys_setreuid16
 71	i386	setregid		sys_setregid16
-72	i386	sigsuspend		sys_sigsuspend			sys_sigsuspend
+72	i386	sigsuspend		sys_sigsuspend
 73	i386	sigpending		sys_sigpending			compat_sys_sigpending
 74	i386	sethostname		sys_sethostname
 75	i386	setrlimit		sys_setrlimit			compat_sys_setrlimit
@@ -96,7 +96,7 @@
 87	i386	swapon			sys_swapon
 88	i386	reboot			sys_reboot
 89	i386	readdir			sys_old_readdir			compat_sys_old_readdir
-90	i386	mmap			sys_old_mmap			sys32_mmap
+90	i386	mmap			sys_old_mmap			compat_sys_x86_mmap
 91	i386	munmap			sys_munmap
 92	i386	truncate		sys_truncate			compat_sys_truncate
 93	i386	ftruncate		sys_ftruncate			compat_sys_ftruncate
@@ -126,7 +126,7 @@
 117	i386	ipc			sys_ipc				compat_sys_ipc
 118	i386	fsync			sys_fsync
 119	i386	sigreturn		sys_sigreturn			sys32_sigreturn
-120	i386	clone			sys_clone			stub32_clone
+120	i386	clone			sys_clone			compat_sys_x86_clone
 121	i386	setdomainname		sys_setdomainname
 122	i386	uname			sys_newuname
 123	i386	modify_ldt		sys_modify_ldt
@@ -186,8 +186,8 @@
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			sys32_pread
-181	i386	pwrite64		sys_pwrite64			sys32_pwrite
+180	i386	pread64			sys_pread64			compat_sys_x86_pread
+181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
 182	i386	chown			sys_chown16
 183	i386	getcwd			sys_getcwd
 184	i386	capget			sys_capget
@@ -196,14 +196,14 @@
 187	i386	sendfile		sys_sendfile			compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork			sys_vfork
+190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			sys32_truncate64
-194	i386	ftruncate64		sys_ftruncate64			sys32_ftruncate64
-195	i386	stat64			sys_stat64			sys32_stat64
-196	i386	lstat64			sys_lstat64			sys32_lstat64
-197	i386	fstat64			sys_fstat64			sys32_fstat64
+193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
+194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
+195	i386	stat64			sys_stat64			compat_sys_x86_stat64
+196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
+197	i386	fstat64			sys_fstat64			compat_sys_x86_fstat64
 198	i386	lchown32		sys_lchown
 199	i386	getuid32		sys_getuid
 200	i386	getgid32		sys_getgid
@@ -231,7 +231,7 @@
 # 222 is unused
 # 223 is unused
 224	i386	gettid			sys_gettid
-225	i386	readahead		sys_readahead			sys32_readahead
+225	i386	readahead		sys_readahead			compat_sys_x86_readahead
 226	i386	setxattr		sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr
 228	i386	fsetxattr		sys_fsetxattr
@@ -256,7 +256,7 @@
 247	i386	io_getevents		sys_io_getevents		compat_sys_io_getevents
 248	i386	io_submit		sys_io_submit			compat_sys_io_submit
 249	i386	io_cancel		sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			sys32_fadvise64
+250	i386	fadvise64		sys_fadvise64			compat_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	i386	exit_group		sys_exit_group
 253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
@@ -278,7 +278,7 @@
 269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 270	i386	tgkill			sys_tgkill
 271	i386	utimes			sys_utimes			compat_sys_utimes
-272	i386	fadvise64_64		sys_fadvise64_64		sys32_fadvise64_64
+272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_x86_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind
 275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
@@ -306,7 +306,7 @@
 297	i386	mknodat			sys_mknodat
 298	i386	fchownat		sys_fchownat
 299	i386	futimesat		sys_futimesat			compat_sys_futimesat
-300	i386	fstatat64		sys_fstatat64			sys32_fstatat
+300	i386	fstatat64		sys_fstatat64			compat_sys_x86_fstatat
 301	i386	unlinkat		sys_unlinkat
 302	i386	renameat		sys_renameat
 303	i386	linkat			sys_linkat
@@ -320,7 +320,7 @@
 311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
 313	i386	splice			sys_splice
-314	i386	sync_file_range		sys_sync_file_range		sys32_sync_file_range
+314	i386	sync_file_range		sys_sync_file_range		compat_sys_x86_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
 317	i386	move_pages		sys_move_pages			compat_sys_move_pages
@@ -330,7 +330,7 @@
 321	i386	signalfd		sys_signalfd			compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create
 323	i386	eventfd			sys_eventfd
-324	i386	fallocate		sys_fallocate			sys32_fallocate
+324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
 325	i386	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
 326	i386	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
 327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 577fa8adb785..8560ef68a9d6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -42,10 +42,8 @@
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
 
-static enum { EMULATE, NATIVE, NONE } vsyscall_mode =
-#if defined(CONFIG_LEGACY_VSYSCALL_NATIVE)
-	NATIVE;
-#elif defined(CONFIG_LEGACY_VSYSCALL_NONE)
+static enum { EMULATE, NONE } vsyscall_mode =
+#ifdef CONFIG_LEGACY_VSYSCALL_NONE
 	NONE;
 #else
 	EMULATE;
@@ -56,8 +54,6 @@ static int __init vsyscall_setup(char *str)
 	if (str) {
 		if (!strcmp("emulate", str))
 			vsyscall_mode = EMULATE;
-		else if (!strcmp("native", str))
-			vsyscall_mode = NATIVE;
 		else if (!strcmp("none", str))
 			vsyscall_mode = NONE;
 		else
@@ -139,10 +135,6 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 
 	WARN_ON_ONCE(address != regs->ip);
 
-	/* This should be unreachable in NATIVE mode. */
-	if (WARN_ON(vsyscall_mode == NATIVE))
-		return false;
-
 	if (vsyscall_mode == NONE) {
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall attempted with vsyscall=none");
@@ -370,9 +362,7 @@ void __init map_vsyscall(void)
 
 	if (vsyscall_mode != NONE) {
 		__set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
-			     vsyscall_mode == NATIVE
-			     ? PAGE_KERNEL_VSYSCALL
-			     : PAGE_KERNEL_VVAR);
+			     PAGE_KERNEL_VVAR);
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 96cd33bbfc85..6512498bbef6 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -51,15 +51,14 @@
 #define AA(__x)		((unsigned long)(__x))
 
 
-asmlinkage long sys32_truncate64(const char __user *filename,
-				 unsigned long offset_low,
-				 unsigned long offset_high)
+COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
+		       unsigned long, offset_low, unsigned long, offset_high)
 {
        return sys_truncate(filename, ((loff_t) offset_high << 32) | offset_low);
 }
 
-asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long offset_low,
-				  unsigned long offset_high)
+COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
+		       unsigned long, offset_low, unsigned long, offset_high)
 {
        return sys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
 }
@@ -96,8 +95,8 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
 	return 0;
 }
 
-asmlinkage long sys32_stat64(const char __user *filename,
-			     struct stat64 __user *statbuf)
+COMPAT_SYSCALL_DEFINE2(x86_stat64, const char __user *, filename,
+		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_stat(filename, &stat);
@@ -107,8 +106,8 @@ asmlinkage long sys32_stat64(const char __user *filename,
 	return ret;
 }
 
-asmlinkage long sys32_lstat64(const char __user *filename,
-			      struct stat64 __user *statbuf)
+COMPAT_SYSCALL_DEFINE2(x86_lstat64, const char __user *, filename,
+		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_lstat(filename, &stat);
@@ -117,7 +116,8 @@ asmlinkage long sys32_lstat64(const char __user *filename,
 	return ret;
 }
 
-asmlinkage long sys32_fstat64(unsigned int fd, struct stat64 __user *statbuf)
+COMPAT_SYSCALL_DEFINE2(x86_fstat64, unsigned int, fd,
+		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_fstat(fd, &stat);
@@ -126,8 +126,9 @@ asmlinkage long sys32_fstat64(unsigned int fd, struct stat64 __user *statbuf)
 	return ret;
 }
 
-asmlinkage long sys32_fstatat(unsigned int dfd, const char __user *filename,
-			      struct stat64 __user *statbuf, int flag)
+COMPAT_SYSCALL_DEFINE4(x86_fstatat, unsigned int, dfd,
+		       const char __user *, filename,
+		       struct stat64 __user *, statbuf, int, flag)
 {
 	struct kstat stat;
 	int error;
@@ -153,7 +154,7 @@ struct mmap_arg_struct32 {
 	unsigned int offset;
 };
 
-asmlinkage long sys32_mmap(struct mmap_arg_struct32 __user *arg)
+COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
 {
 	struct mmap_arg_struct32 a;
 
@@ -167,22 +168,22 @@ asmlinkage long sys32_mmap(struct mmap_arg_struct32 __user *arg)
 			       a.offset>>PAGE_SHIFT);
 }
 
-asmlinkage long sys32_waitpid(compat_pid_t pid, unsigned int __user *stat_addr,
-			      int options)
+COMPAT_SYSCALL_DEFINE3(x86_waitpid, compat_pid_t, pid, unsigned int __user *,
+		       stat_addr, int, options)
 {
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
 /* warning: next two assume little endian */
-asmlinkage long sys32_pread(unsigned int fd, char __user *ubuf, u32 count,
-			    u32 poslo, u32 poshi)
+COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
+		       u32, count, u32, poslo, u32, poshi)
 {
 	return sys_pread64(fd, ubuf, count,
 			 ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage long sys32_pwrite(unsigned int fd, const char __user *ubuf,
-			     u32 count, u32 poslo, u32 poshi)
+COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
+		       u32, count, u32, poslo, u32, poshi)
 {
 	return sys_pwrite64(fd, ubuf, count,
 			  ((loff_t)AA(poshi) << 32) | AA(poslo));
@@ -193,8 +194,9 @@ asmlinkage long sys32_pwrite(unsigned int fd, const char __user *ubuf,
  * Some system calls that need sign extended arguments. This could be
  * done by a generic wrapper.
  */
-long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high,
-			__u32 len_low, __u32 len_high, int advice)
+COMPAT_SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
+		       __u32, offset_high, __u32, len_low, __u32, len_high,
+		       int, advice)
 {
 	return sys_fadvise64_64(fd,
 			       (((u64)offset_high)<<32) | offset_low,
@@ -202,31 +204,43 @@ long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high,
 				advice);
 }
 
-asmlinkage ssize_t sys32_readahead(int fd, unsigned off_lo, unsigned off_hi,
-				   size_t count)
+COMPAT_SYSCALL_DEFINE4(x86_readahead, int, fd, unsigned int, off_lo,
+		       unsigned int, off_hi, size_t, count)
 {
 	return sys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
 }
 
-asmlinkage long sys32_sync_file_range(int fd, unsigned off_low, unsigned off_hi,
-				      unsigned n_low, unsigned n_hi,  int flags)
+COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
+		       unsigned int, off_hi, unsigned int, n_low,
+		       unsigned int, n_hi, int, flags)
 {
 	return sys_sync_file_range(fd,
 				   ((u64)off_hi << 32) | off_low,
 				   ((u64)n_hi << 32) | n_low, flags);
 }
 
-asmlinkage long sys32_fadvise64(int fd, unsigned offset_lo, unsigned offset_hi,
-				size_t len, int advice)
+COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
+		       unsigned int, offset_hi, size_t, len, int, advice)
 {
 	return sys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
 				len, advice);
 }
 
-asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_lo,
-				unsigned offset_hi, unsigned len_lo,
-				unsigned len_hi)
+COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
+		       unsigned int, offset_lo, unsigned int, offset_hi,
+		       unsigned int, len_lo, unsigned int, len_hi)
 {
 	return sys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
 			     ((u64)len_hi << 32) | len_lo);
 }
+
+/*
+ * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
+ */
+COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
+		       unsigned long, newsp, int __user *, parent_tidptr,
+		       unsigned long, tls_val, int __user *, child_tidptr)
+{
+	return sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr,
+			tls_val);
+}
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 246f15b4e64c..acfe755562a6 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -174,7 +174,6 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
 #define __PAGE_KERNEL_RX		(__PAGE_KERNEL_EXEC & ~_PAGE_RW)
 #define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_NOCACHE)
-#define __PAGE_KERNEL_VSYSCALL		(__PAGE_KERNEL_RX | _PAGE_USER)
 #define __PAGE_KERNEL_VVAR		(__PAGE_KERNEL_RO | _PAGE_USER)
 #define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
@@ -206,7 +205,6 @@ enum page_cache_mode {
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_VSYSCALL	__pgprot(__PAGE_KERNEL_VSYSCALL | _PAGE_ENC)
 #define PAGE_KERNEL_VVAR	__pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
 
 #define PAGE_KERNEL_IO		__pgprot(__PAGE_KERNEL_IO)
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index d6baf23782bc..5c019d23d06b 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -10,6 +10,7 @@ extern struct exception_table_entry __stop___ex_table[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 82c34ee25a65..906794aa034e 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -20,31 +20,43 @@
 #include <asm/ia32.h>
 
 /* ia32/sys_ia32.c */
-asmlinkage long sys32_truncate64(const char __user *, unsigned long, unsigned long);
-asmlinkage long sys32_ftruncate64(unsigned int, unsigned long, unsigned long);
+asmlinkage long compat_sys_x86_truncate64(const char __user *, unsigned long,
+					  unsigned long);
+asmlinkage long compat_sys_x86_ftruncate64(unsigned int, unsigned long,
+					   unsigned long);
 
-asmlinkage long sys32_stat64(const char __user *, struct stat64 __user *);
-asmlinkage long sys32_lstat64(const char __user *, struct stat64 __user *);
-asmlinkage long sys32_fstat64(unsigned int, struct stat64 __user *);
-asmlinkage long sys32_fstatat(unsigned int, const char __user *,
+asmlinkage long compat_sys_x86_stat64(const char __user *,
+				      struct stat64 __user *);
+asmlinkage long compat_sys_x86_lstat64(const char __user *,
+				       struct stat64 __user *);
+asmlinkage long compat_sys_x86_fstat64(unsigned int, struct stat64 __user *);
+asmlinkage long compat_sys_x86_fstatat(unsigned int, const char __user *,
 			      struct stat64 __user *, int);
 struct mmap_arg_struct32;
-asmlinkage long sys32_mmap(struct mmap_arg_struct32 __user *);
+asmlinkage long compat_sys_x86_mmap(struct mmap_arg_struct32 __user *);
 
-asmlinkage long sys32_waitpid(compat_pid_t, unsigned int __user *, int);
+asmlinkage long compat_sys_x86_waitpid(compat_pid_t, unsigned int __user *,
+				       int);
 
-asmlinkage long sys32_pread(unsigned int, char __user *, u32, u32, u32);
-asmlinkage long sys32_pwrite(unsigned int, const char __user *, u32, u32, u32);
+asmlinkage long compat_sys_x86_pread(unsigned int, char __user *, u32, u32,
+				     u32);
+asmlinkage long compat_sys_x86_pwrite(unsigned int, const char __user *, u32,
+				      u32, u32);
 
-long sys32_fadvise64_64(int, __u32, __u32, __u32, __u32, int);
-long sys32_vm86_warning(void);
+asmlinkage long compat_sys_x86_fadvise64_64(int, __u32, __u32, __u32, __u32,
+					    int);
 
-asmlinkage ssize_t sys32_readahead(int, unsigned, unsigned, size_t);
-asmlinkage long sys32_sync_file_range(int, unsigned, unsigned,
-				      unsigned, unsigned, int);
-asmlinkage long sys32_fadvise64(int, unsigned, unsigned, size_t, int);
-asmlinkage long sys32_fallocate(int, int, unsigned,
-				unsigned, unsigned, unsigned);
+asmlinkage ssize_t compat_sys_x86_readahead(int, unsigned int, unsigned int,
+					    size_t);
+asmlinkage long compat_sys_x86_sync_file_range(int, unsigned int, unsigned int,
+					       unsigned int, unsigned int,
+					       int);
+asmlinkage long compat_sys_x86_fadvise64(int, unsigned int, unsigned int,
+					 size_t, int);
+asmlinkage long compat_sys_x86_fallocate(int, int, unsigned int, unsigned int,
+					 unsigned int, unsigned int);
+asmlinkage long compat_sys_x86_clone(unsigned long, unsigned long, int __user *,
+				     unsigned long, int __user *);
 
 /* ia32/ia32_signal.c */
 asmlinkage long sys32_sigreturn(void);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d19e903214b4..4aa9fd379390 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well hope that it is running the correct version.
+	 */
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index aa1b9a422f2b..70ecbc8099c9 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -22,13 +22,16 @@
 #define pr_fmt(fmt) "microcode: " fmt
 
 #include <linux/platform_device.h>
+#include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/cpu.h>
+#include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 
@@ -64,6 +67,11 @@ LIST_HEAD(microcode_cache);
  */
 static DEFINE_MUTEX(microcode_mutex);
 
+/*
+ * Serialize late loading so that CPUs get updated one-by-one.
+ */
+static DEFINE_SPINLOCK(update_lock);
+
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -373,26 +381,23 @@ static int collect_cpu_info(int cpu)
 	return ret;
 }
 
-struct apply_microcode_ctx {
-	enum ucode_state err;
-};
-
 static void apply_microcode_local(void *arg)
 {
-	struct apply_microcode_ctx *ctx = arg;
+	enum ucode_state *err = arg;
 
-	ctx->err = microcode_ops->apply_microcode(smp_processor_id());
+	*err = microcode_ops->apply_microcode(smp_processor_id());
 }
 
 static int apply_microcode_on_target(int cpu)
 {
-	struct apply_microcode_ctx ctx = { .err = 0 };
+	enum ucode_state err;
 	int ret;
 
-	ret = smp_call_function_single(cpu, apply_microcode_local, &ctx, 1);
-	if (!ret)
-		ret = ctx.err;
-
+	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
+	if (!ret) {
+		if (err == UCODE_ERROR)
+			ret = 1;
+	}
 	return ret;
 }
 
@@ -489,19 +494,100 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
-static enum ucode_state reload_for_cpu(int cpu)
+/*
+ * Late loading dance. Why the heavy-handed stomp_machine effort?
+ *
+ * - HT siblings must be idle and not execute other code while the other sibling
+ *   is loading microcode in order to avoid any negative interactions caused by
+ *   the loading.
+ *
+ * - In addition, microcode update on the cores must be serialized until this
+ *   requirement can be relaxed in the future. Right now, this is conservative
+ *   and good.
+ */
+#define SPINUNIT 100 /* 100 nsec */
+
+static int check_online_cpus(void)
 {
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
+	if (num_online_cpus() == num_present_cpus())
+		return 0;
 
-	if (!uci->valid)
-		return UCODE_OK;
+	pr_err("Not all CPUs online, aborting microcode update.\n");
+
+	return -EINVAL;
+}
+
+static atomic_t late_cpus;
+
+/*
+ * Returns:
+ * < 0 - on error
+ *   0 - no update done
+ *   1 - microcode was updated
+ */
+static int __reload_late(void *info)
+{
+	unsigned int timeout = NSEC_PER_SEC;
+	int all_cpus = num_online_cpus();
+	int cpu = smp_processor_id();
+	enum ucode_state err;
+	int ret = 0;
+
+	atomic_dec(&late_cpus);
+
+	/*
+	 * Wait for all CPUs to arrive. A load will not be attempted unless all
+	 * CPUs show up.
+	 * */
+	while (atomic_read(&late_cpus)) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				atomic_read(&late_cpus));
+			return -1;
+		}
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate != UCODE_OK)
-		return ustate;
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
 
-	return apply_microcode_on_target(cpu);
+		touch_nmi_watchdog();
+	}
+
+	spin_lock(&update_lock);
+	apply_microcode_local(&err);
+	spin_unlock(&update_lock);
+
+	if (err > UCODE_NFOUND) {
+		pr_warn("Error reloading microcode on CPU %d\n", cpu);
+		ret = -1;
+	} else if (err == UCODE_UPDATED) {
+		ret = 1;
+	}
+
+	atomic_inc(&late_cpus);
+
+	while (atomic_read(&late_cpus) != all_cpus)
+		cpu_relax();
+
+	return ret;
+}
+
+/*
+ * Reload microcode late on all CPUs. Wait for a sec until they
+ * all gather together.
+ */
+static int microcode_reload_late(void)
+{
+	int ret;
+
+	atomic_set(&late_cpus, num_online_cpus());
+
+	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	if (ret < 0)
+		return ret;
+	else if (ret > 0)
+		microcode_check();
+
+	return ret;
 }
 
 static ssize_t reload_store(struct device *dev,
@@ -509,10 +595,9 @@ static ssize_t reload_store(struct device *dev,
 			    const char *buf, size_t size)
 {
 	enum ucode_state tmp_ret = UCODE_OK;
-	bool do_callback = false;
+	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
 	ssize_t ret = 0;
-	int cpu;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -521,29 +606,24 @@ static ssize_t reload_store(struct device *dev,
 	if (val != 1)
 		return size;
 
-	get_online_cpus();
-	mutex_lock(&microcode_mutex);
-	for_each_online_cpu(cpu) {
-		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret > UCODE_NFOUND) {
-			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-			/* set retval for the first encountered reload error */
-			if (!ret)
-				ret = -EINVAL;
-		}
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	if (tmp_ret != UCODE_OK)
+		return size;
 
-		if (tmp_ret == UCODE_UPDATED)
-			do_callback = true;
-	}
+	get_online_cpus();
 
-	if (!ret && do_callback)
-		microcode_check();
+	ret = check_online_cpus();
+	if (ret)
+		goto put;
 
+	mutex_lock(&microcode_mutex);
+	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
+
+put:
 	put_online_cpus();
 
-	if (!ret)
+	if (ret >= 0)
 		ret = size;
 
 	return ret;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 923054a6b760..2aded9db1d42 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -589,6 +589,23 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	if (!mc)
 		return 0;
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		return UCODE_OK;
+	}
+
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -774,9 +791,9 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 static enum ucode_state apply_microcode_intel(int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
-	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
 	static int prev_rev;
 	u32 rev;
 
@@ -784,15 +801,32 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	uci = ucode_cpu_info + cpu;
-	mc = uci->mc;
+	/* Look for a newer patch in our cache: */
+	mc = find_patch(uci);
 	if (!mc) {
-		/* Look for a newer patch in our cache: */
-		mc = find_patch(uci);
+		mc = uci->mc;
 		if (!mc)
 			return UCODE_NFOUND;
 	}
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return UCODE_OK;
+	}
+
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -813,8 +847,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 2f723301eb58..38deafebb21b 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -23,7 +23,7 @@
 /*
  * this changes the io permissions bitmap in the current task.
  */
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
+SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
 {
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index bd36f3c33cd0..0715f827607c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1168,10 +1168,18 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
+	bool is_in_entry_trampoline_section = false;
+
+#ifdef CONFIG_X86_64
+	is_in_entry_trampoline_section =
+		(addr >= (unsigned long)__entry_trampoline_start &&
+		 addr < (unsigned long)__entry_trampoline_end);
+#endif
 	return  (addr >= (unsigned long)__kprobes_text_start &&
 		 addr < (unsigned long)__kprobes_text_end) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
+		 addr < (unsigned long)__entry_text_end) ||
+		is_in_entry_trampoline_section;
 }
 
 int __init arch_init_kprobes(void)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9b138a06c1a4..b854ebf5851b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -118,9 +118,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ce38f165489b..631507f0c198 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -332,7 +332,7 @@ static void __init pti_clone_user_shared(void)
 }
 
 /*
- * Clone the ESPFIX P4D into the user space visinble page table
+ * Clone the ESPFIX P4D into the user space visible page table
  */
 static void __init pti_setup_espfix64(void)
 {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 46c1d239cc1b..92b6a2c21631 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1116,42 +1116,29 @@ static int read_unwind_hints(struct objtool_file *file)
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
-	struct section *sec, *relasec;
+	struct section *sec;
 	struct instruction *insn;
 	struct rela *rela;
-	int i;
 
-	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
 	if (!sec)
 		return 0;
 
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.retpoline_safe section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(unsigned long)) {
-		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
-		return -1;
-	}
-
-	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
-		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
-		if (!rela) {
-			WARN("can't find rela for retpoline_safe[%d]", i);
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
 		insn = find_insn(file, rela->sym->sec, rela->addend);
 		if (!insn) {
-			WARN("can't find insn for retpoline_safe[%d]", i);
+			WARN("bad .discard.retpoline_safe entry");
 			return -1;
 		}
 
 		if (insn->type != INSN_JUMP_DYNAMIC &&
 		    insn->type != INSN_CALL_DYNAMIC) {
-			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+			WARN_FUNC("retpoline_safe hint not an indirect jump/call",
 				  insn->sec, insn->offset);
 			return -1;
 		}
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index be81621446f0..0b4f1cc2291c 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -450,7 +450,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 		num_vsyscall_traps++;
 }
 
-static int test_native_vsyscall(void)
+static int test_emulation(void)
 {
 	time_t tmp;
 	bool is_native;
@@ -458,7 +458,7 @@ static int test_native_vsyscall(void)
 	if (!vtime)
 		return 0;
 
-	printf("[RUN]\tchecking for native vsyscall\n");
+	printf("[RUN]\tchecking that vsyscalls are emulated\n");
 	sethandler(SIGTRAP, sigtrap, 0);
 	set_eflags(get_eflags() | X86_EFLAGS_TF);
 	vtime(&tmp);
@@ -474,11 +474,12 @@ static int test_native_vsyscall(void)
 	 */
 	is_native = (num_vsyscall_traps > 1);
 
-	printf("\tvsyscalls are %s (%d instructions in vsyscall page)\n",
+	printf("[%s]\tvsyscalls are %s (%d instructions in vsyscall page)\n",
+	       (is_native ? "FAIL" : "OK"),
 	       (is_native ? "native" : "emulated"),
 	       (int)num_vsyscall_traps);
 
-	return 0;
+	return is_native;
 }
 #endif
 
@@ -498,7 +499,7 @@ int main(int argc, char **argv)
 	nerrs += test_vsys_r();
 
 #ifdef __x86_64__
-	nerrs += test_native_vsyscall();
+	nerrs += test_emulation();
 #endif
 
 	return nerrs ? 1 : 0;
