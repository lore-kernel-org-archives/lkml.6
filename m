Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeENJsN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:48:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeENJsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:48:09 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 17/18] arm64: convert compat wrappers to C
Date: Mon, 14 May 2018 10:46:39 +0100
Message-Id: <20180514094640.27569-18-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting to pt_regs syscall wrappers, convert our
existing compat wrappers to C. This will allow the pt_regs wrappers to
be automatically generated, and will allow for the compat register
manipulation to be folded in with the pt_regs accesses.

To avoid confusion with the upcoming pt_regs wrappers and existing
compat wrappers provided by core code, the C wrappers are renamed to
compat_sys_aarch32_<syscall>.

With the assembly wrappers gone, we can get rid of entry32.S and the
associated boilerplate.

Note that these must call the ksys_* syscall entry points, as the usual
sys_* entry points will be modified to take a single pt_regs pointer
argument.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd32.h |  22 ++++----
 arch/arm64/kernel/Makefile        |   2 +-
 arch/arm64/kernel/entry32.S       | 111 --------------------------------------
 arch/arm64/kernel/sys32.c         | 103 +++++++++++++++++++++++++++++++----
 4 files changed, 104 insertions(+), 134 deletions(-)
 delete mode 100644 arch/arm64/kernel/entry32.S

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index ab95554b1734..0e3dd3265993 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -382,9 +382,9 @@ __SYSCALL(__NR_rt_sigqueueinfo, compat_sys_rt_sigqueueinfo)
 #define __NR_rt_sigsuspend 179
 __SYSCALL(__NR_rt_sigsuspend, compat_sys_rt_sigsuspend)
 #define __NR_pread64 180
-__SYSCALL(__NR_pread64, compat_sys_pread64_wrapper)
+__SYSCALL(__NR_pread64, compat_sys_aarch32_pread64)
 #define __NR_pwrite64 181
-__SYSCALL(__NR_pwrite64, compat_sys_pwrite64_wrapper)
+__SYSCALL(__NR_pwrite64, compat_sys_aarch32_pwrite64)
 #define __NR_chown 182
 __SYSCALL(__NR_chown, sys_chown16)
 #define __NR_getcwd 183
@@ -406,11 +406,11 @@ __SYSCALL(__NR_vfork, sys_vfork)
 #define __NR_ugetrlimit 191	/* SuS compliant getrlimit */
 __SYSCALL(__NR_ugetrlimit, compat_sys_getrlimit)		/* SuS compliant getrlimit */
 #define __NR_mmap2 192
-__SYSCALL(__NR_mmap2, compat_sys_mmap2_wrapper)
+__SYSCALL(__NR_mmap2, compat_sys_aarch32_mmap2)
 #define __NR_truncate64 193
-__SYSCALL(__NR_truncate64, compat_sys_truncate64_wrapper)
+__SYSCALL(__NR_truncate64, compat_sys_aarch32_truncate64)
 #define __NR_ftruncate64 194
-__SYSCALL(__NR_ftruncate64, compat_sys_ftruncate64_wrapper)
+__SYSCALL(__NR_ftruncate64, compat_sys_aarch32_ftruncate64)
 #define __NR_stat64 195
 __SYSCALL(__NR_stat64, sys_stat64)
 #define __NR_lstat64 196
@@ -472,7 +472,7 @@ __SYSCALL(223, sys_ni_syscall)
 #define __NR_gettid 224
 __SYSCALL(__NR_gettid, sys_gettid)
 #define __NR_readahead 225
-__SYSCALL(__NR_readahead, compat_sys_readahead_wrapper)
+__SYSCALL(__NR_readahead, compat_sys_aarch32_readahead)
 #define __NR_setxattr 226
 __SYSCALL(__NR_setxattr, sys_setxattr)
 #define __NR_lsetxattr 227
@@ -554,15 +554,15 @@ __SYSCALL(__NR_clock_getres, compat_sys_clock_getres)
 #define __NR_clock_nanosleep 265
 __SYSCALL(__NR_clock_nanosleep, compat_sys_clock_nanosleep)
 #define __NR_statfs64 266
-__SYSCALL(__NR_statfs64, compat_sys_statfs64_wrapper)
+__SYSCALL(__NR_statfs64, compat_sys_aarch32_statfs64)
 #define __NR_fstatfs64 267
-__SYSCALL(__NR_fstatfs64, compat_sys_fstatfs64_wrapper)
+__SYSCALL(__NR_fstatfs64, compat_sys_aarch32_fstatfs64)
 #define __NR_tgkill 268
 __SYSCALL(__NR_tgkill, sys_tgkill)
 #define __NR_utimes 269
 __SYSCALL(__NR_utimes, compat_sys_utimes)
 #define __NR_arm_fadvise64_64 270
-__SYSCALL(__NR_arm_fadvise64_64, compat_sys_fadvise64_64_wrapper)
+__SYSCALL(__NR_arm_fadvise64_64, compat_sys_aarch32_fadvise64_64)
 #define __NR_pciconfig_iobase 271
 __SYSCALL(__NR_pciconfig_iobase, sys_pciconfig_iobase)
 #define __NR_pciconfig_read 272
@@ -704,7 +704,7 @@ __SYSCALL(__NR_get_robust_list, compat_sys_get_robust_list)
 #define __NR_splice 340
 __SYSCALL(__NR_splice, sys_splice)
 #define __NR_sync_file_range2 341
-__SYSCALL(__NR_sync_file_range2, compat_sys_sync_file_range2_wrapper)
+__SYSCALL(__NR_sync_file_range2, compat_sys_aarch32_sync_file_range2)
 #define __NR_tee 342
 __SYSCALL(__NR_tee, sys_tee)
 #define __NR_vmsplice 343
@@ -726,7 +726,7 @@ __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
 #define __NR_eventfd 351
 __SYSCALL(__NR_eventfd, sys_eventfd)
 #define __NR_fallocate 352
-__SYSCALL(__NR_fallocate, compat_sys_fallocate_wrapper)
+__SYSCALL(__NR_fallocate, compat_sys_aarch32_fallocate)
 #define __NR_timerfd_settime 353
 __SYSCALL(__NR_timerfd_settime, compat_sys_timerfd_settime)
 #define __NR_timerfd_gettime 354
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index c22e8ace5ea3..5886bc53fc9f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o entry32.o
+					   sys_compat.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
deleted file mode 100644
index f9461696dde4..000000000000
--- a/arch/arm64/kernel/entry32.S
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * Compat system call wrappers
- *
- * Copyright (C) 2012 ARM Ltd.
- * Authors: Will Deacon <will.deacon@arm.com>
- *	    Catalin Marinas <catalin.marinas@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/linkage.h>
-#include <linux/const.h>
-
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/errno.h>
-#include <asm/page.h>
-
-/*
- * System call wrappers for the AArch32 compatibility layer.
- */
-
-ENTRY(compat_sys_statfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_statfs64
-ENDPROC(compat_sys_statfs64_wrapper)
-
-ENTRY(compat_sys_fstatfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_fstatfs64
-ENDPROC(compat_sys_fstatfs64_wrapper)
-
-/*
- * Note: off_4k (w5) is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-ENTRY(compat_sys_mmap2_wrapper)
-#if PAGE_SHIFT > 12
-	tst	w5, #~PAGE_MASK >> 12
-	b.ne	1f
-	lsr	w5, w5, #PAGE_SHIFT - 12
-#endif
-	b	sys_mmap_pgoff
-1:	mov	x0, #-EINVAL
-	ret
-ENDPROC(compat_sys_mmap2_wrapper)
-
-/*
- * Wrappers for AArch32 syscalls that either take 64-bit parameters
- * in registers or that take 32-bit parameters which require sign
- * extension.
- */
-ENTRY(compat_sys_pread64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pread64
-ENDPROC(compat_sys_pread64_wrapper)
-
-ENTRY(compat_sys_pwrite64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pwrite64
-ENDPROC(compat_sys_pwrite64_wrapper)
-
-ENTRY(compat_sys_truncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_truncate
-ENDPROC(compat_sys_truncate64_wrapper)
-
-ENTRY(compat_sys_ftruncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_ftruncate
-ENDPROC(compat_sys_ftruncate64_wrapper)
-
-ENTRY(compat_sys_readahead_wrapper)
-	regs_to_64	x1, x2, x3
-	mov	w2, w4
-	b	sys_readahead
-ENDPROC(compat_sys_readahead_wrapper)
-
-ENTRY(compat_sys_fadvise64_64_wrapper)
-	mov	w6, w1
-	regs_to_64	x1, x2, x3
-	regs_to_64	x2, x4, x5
-	mov	w3, w6
-	b	sys_fadvise64_64
-ENDPROC(compat_sys_fadvise64_64_wrapper)
-
-ENTRY(compat_sys_sync_file_range2_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_sync_file_range2
-ENDPROC(compat_sys_sync_file_range2_wrapper)
-
-ENTRY(compat_sys_fallocate_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_fallocate
-ENDPROC(compat_sys_fallocate_wrapper)
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 1ef103c95410..1a84e79c47f3 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -27,17 +27,98 @@
 
 asmlinkage long compat_sys_sigreturn(void);
 asmlinkage long compat_sys_rt_sigreturn(void);
-asmlinkage long compat_sys_statfs64_wrapper(void);
-asmlinkage long compat_sys_fstatfs64_wrapper(void);
-asmlinkage long compat_sys_pread64_wrapper(void);
-asmlinkage long compat_sys_pwrite64_wrapper(void);
-asmlinkage long compat_sys_truncate64_wrapper(void);
-asmlinkage long compat_sys_ftruncate64_wrapper(void);
-asmlinkage long compat_sys_readahead_wrapper(void);
-asmlinkage long compat_sys_fadvise64_64_wrapper(void);
-asmlinkage long compat_sys_sync_file_range2_wrapper(void);
-asmlinkage long compat_sys_fallocate_wrapper(void);
-asmlinkage long compat_sys_mmap2_wrapper(void);
+
+COMPAT_SYSCALL_DEFINE3(aarch32_statfs64, const char __user *, pathname,
+		       compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	if (sz == 88)
+		sz = 84;
+
+	return kcompat_sys_statfs64(pathname, sz, buf);
+}
+
+COMPAT_SYSCALL_DEFINE3(aarch32_fstatfs64, unsigned int, fd, compat_size_t, sz,
+		       struct compat_statfs64 __user *, buf)
+{
+	if (sz == 88)
+		sz = 84;
+
+	return kcompat_sys_fstatfs64(fd, sz, buf);
+}
+
+/*
+ * Note: off_4k is always in units of 4K. If we can't do the
+ * requested offset because it is not page-aligned, we return -EINVAL.
+ */
+COMPAT_SYSCALL_DEFINE6(aarch32_mmap2, unsigned long, addr, unsigned long, len,
+		       unsigned long, prot, unsigned long, flags,
+		       unsigned long, fd, unsigned long, off_4k)
+{
+	if (off_4k & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	off_4k >>= (PAGE_SHIFT - 12);
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off_4k);
+}
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define arg_u32p(name)	u32, name##_hi, u32, name##_lo
+#else
+#define arg_u32p(name)	u32, name##_lo, u32, name##_hi
+#endif
+
+#define arg_u64(name)	(((u64)name##_hi << 32) | name##_lo)
+
+COMPAT_SYSCALL_DEFINE6(aarch32_pread64, unsigned int, fd, char __user *, buf,
+		       size_t, count, u32, __pad, arg_u32p(pos))
+{
+	return ksys_pread64(fd, buf, count, arg_u64(pos));
+}
+
+COMPAT_SYSCALL_DEFINE6(aarch32_pwrite64, unsigned int, fd,
+		       const char __user *, buf, size_t, count, u32, __pad,
+		       arg_u32p(pos))
+{
+	return ksys_pwrite64(fd, buf, count, arg_u64(pos));
+}
+
+COMPAT_SYSCALL_DEFINE4(aarch32_truncate64, const char __user *, pathname,
+		       u32, __pad, arg_u32p(length))
+{
+	return ksys_truncate(pathname, arg_u64(length));
+}
+
+COMPAT_SYSCALL_DEFINE4(aarch32_ftruncate64, unsigned int, fd, u32, __pad,
+		       arg_u32p(length))
+{
+	return ksys_ftruncate(fd, arg_u64(length));
+}
+
+COMPAT_SYSCALL_DEFINE5(aarch32_readahead, int, fd, u32, __pad,
+		       arg_u32p(offset), size_t, count)
+{
+	return ksys_readahead(fd, arg_u64(offset), count);
+}
+
+COMPAT_SYSCALL_DEFINE6(aarch32_fadvise64_64, int, fd, int, advice,
+		       arg_u32p(offset), arg_u32p(len))
+{
+	return ksys_fadvise64_64(fd, arg_u64(offset), arg_u64(len), advice);
+}
+
+COMPAT_SYSCALL_DEFINE6(aarch32_sync_file_range2, int, fd, unsigned int, flags,
+		       arg_u32p(offset), arg_u32p(nbytes))
+{
+	return ksys_sync_file_range(fd, arg_u64(offset), arg_u64(nbytes),
+				    flags);
+}
+
+COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
+		       arg_u32p(offset), arg_u32p(len))
+{
+	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
+}
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
-- 
2.11.0
