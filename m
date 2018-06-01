Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFALZ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:25:58 -0400
Received: from foss.arm.com ([217.140.101.70]:50394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeFALZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:26 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 19/19] arm64: implement syscall wrappers
Date: Fri,  1 Jun 2018 12:24:41 +0100
Message-Id: <20180601112441.37810-20-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To minimize the risk of userspace-controlled values being used under
speculation, this patch adds pt_regs based syscall wrappers for arm64,
which pass the minimum set of required userspace values to syscall
implementations. For each syscall, a wrapper which takes a pt_regs
argument is automatically generated, and this extracts the arguments
before calling the "real" syscall implementation.

Each syscall has three functions generated:

* __do_<compat_>sys_<name> is the "real" syscall implementation, with
  the expected prototype.

* __se_<compat_>sys_<name> is the sign-extension/narrowing wrapper,
  inherited from common code. This takes a series of long parameters,
  casting each to the requisite types required by the "real" syscall
  implementation in __do_<compat_>sys_<name>.

  This wrapper *may* not be necessary on arm64 given the AAPCS rules on
  unused register bits, but it seemed safer to keep the wrapper for now.

* __arm64_<compat_>_sys_<name> takes a struct pt_regs pointer, and
  extracts *only* the relevant register values, passing these on to the
  __se_<compat_>sys_<name> wrapper.

The syscall invocation code is updated to handle the calling convention
required by __arm64_<compat_>_sys_<name>, and passes a single struct
pt_regs pointer.

The compiler can fold the syscall implementation and its wrappers, such
that the overhead of this approach is minimized.

Note that we play games with sys_ni_syscall(). It can't be defined with
SYSCALL_DEFINE0() because we must avoid the possibility of error
injection. Additionally, there are a couple of locations where we need
to call it from C code, and we don't (currently) have a
ksys_ni_syscall().  While it has no wrapper, passing in a redundant
pt_regs pointer is benign per the AAPCS.

When ARCH_HAS_SYSCALL_WRAPPER is selected, no prototype is define for
sys_ni_syscall(). Since we need to treat it differently for in-kernel
calls and the syscall tables, the prototype is defined as-required.

The wrappers are largely the same as their x86 counterparts, but
simplified as we don't have a variety of compat calling conventions that
require separate stubs. Unlike x86, we have some zero-argument compat
syscalls, and must define COMPAT_SYSCALL_DEFINE0() to ensure that these
are also given an __arm64_compat_sys_ prefix.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                       |  1 +
 arch/arm64/include/asm/syscall_wrapper.h | 80 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/sys.c                  | 10 +++-
 arch/arm64/kernel/sys32.c                |  9 +++-
 arch/arm64/kernel/syscall.c              |  8 +---
 arch/arm64/kernel/traps.c                |  2 +
 6 files changed, 101 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/syscall_wrapper.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b98a6c42454..4c18c6b3c915 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,6 +23,7 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..a4477e515b79
--- /dev/null
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - arm64 specific wrappers to syscall definitions
+ *
+ * Based on arch/x86/include/asm_syscall_wrapper.h
+ */
+
+#ifndef __ASM_SYSCALL_WRAPPER_H
+#define __ASM_SYSCALL_WRAPPER_H
+
+#define SC_ARM64_REGS_TO_ARGS(x, ...)				\
+	__MAP(x,__SC_ARGS					\
+	      ,,regs->regs[0],,regs->regs[1],,regs->regs[2]	\
+	      ,,regs->regs[3],,regs->regs[4],,regs->regs[5])
+
+#ifdef CONFIG_COMPAT
+
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);				\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs)		\
+	{										\
+		return __se_compat_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}										\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{										\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
+	}										\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#define COMPAT_SYSCALL_DEFINE0(sname)					\
+	asmlinkage long __arm64_compat_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);	\
+	asmlinkage long __arm64_compat_sys_##sname(void)
+
+#define COND_SYSCALL_COMPAT(name) \
+	cond_syscall(__arm64_compat_sys_##name);
+
+#define COMPAT_SYS_NI(name) \
+	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
+
+#endif /* CONFIG_COMPAT */
+
+#define __SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)		\
+	{									\
+		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}									\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{									\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
+		return ret;							\
+	}									\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#ifndef SYSCALL_DEFINE0
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __arm64_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);	\
+	asmlinkage long __arm64_sys_##sname(void)
+#endif
+
+#ifndef COND_SYSCALL
+#define COND_SYSCALL(name) cond_syscall(__arm64_sys_##name)
+#endif
+
+#ifndef SYS_NI
+#define SYS_NI(name) SYSCALL_ALIAS(__arm64_sys_##name, sys_ni_posix_timers);
+#endif
+
+#endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 2ad1497a184e..ee93bf789f0a 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -48,11 +48,17 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-asmlinkage long sys_rt_sigreturn(void);
 #define sys_personality		sys_arm64_personality
 
+asmlinkage long sys_ni_syscall(const struct pt_regs *);
+#define __arm64_sys_ni_syscall	sys_ni_syscall
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
+#include <asm/unistd.h>
+
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
 /*
  * The sys_call_table array must be 4K aligned to be accessible from
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 793bd0952ee0..533c97c5c232 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -131,8 +131,15 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
 	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
 }
 
+asmlinkage long sys_ni_syscall(const struct pt_regs *);
+#define __arm64_sys_ni_syscall	sys_ni_syscall
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
+#include <asm/unistd32.h>
+
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
 /*
  * The sys_call_table array must be 4K aligned to be accessible from
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 6a31bb2a382b..e5985924f57e 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -12,15 +12,11 @@
 
 long do_ni_syscall(struct pt_regs *regs);
 
-typedef long (*syscall_fn_t)(unsigned long, unsigned long,
-			     unsigned long, unsigned long,
-			     unsigned long, unsigned long);
+typedef long (*syscall_fn_t)(struct pt_regs *regs);
 
 static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 {
-	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
-				   regs->regs[2], regs->regs[3],
-				   regs->regs[4], regs->regs[5]);
+	regs->regs[0] = syscall_fn(regs);
 }
 
 static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b8d3e0d8c616..8bfcc37cbc65 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -549,6 +549,8 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 
 long compat_arm_syscall(struct pt_regs *regs);
 
+long sys_ni_syscall(void);
+
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_COMPAT
-- 
2.11.0
