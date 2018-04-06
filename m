Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDFRMk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:12:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeDFRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:12:38 -0400
Date: Fri, 6 Apr 2018 10:11:54 -0700
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-7303e30ec1d8fb5ca1f07c92d069241c32b2ee1b@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net, bp@alien8.de,
        jpoimboe@redhat.com, dvlasenk@redhat.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, mingo@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, hpa@zytor.com, luto@kernel.org,
        torvalds@linux-foundation.org, brgerst@gmail.com
Reply-To: torvalds@linux-foundation.org, luto@kernel.org, brgerst@gmail.com,
        viro@zeniv.linux.org.uk, tglx@linutronix.de, dvlasenk@redhat.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        linux@dominikbrodowski.net, mingo@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20180405095307.3730-5-linux@dominikbrodowski.net>
References: <20180405095307.3730-5-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] syscalls/core: Prepare
 CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y for compat syscalls
Git-Commit-ID: 7303e30ec1d8fb5ca1f07c92d069241c32b2ee1b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7303e30ec1d8fb5ca1f07c92d069241c32b2ee1b
Gitweb:     https://git.kernel.org/tip/7303e30ec1d8fb5ca1f07c92d069241c32b2ee1b
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Thu, 5 Apr 2018 11:53:03 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 16:59:38 +0200

syscalls/core: Prepare CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y for compat syscalls

It may be useful for an architecture to override the definitions of the
COMPAT_SYSCALL_DEFINE0() and __COMPAT_SYSCALL_DEFINEx() macros in
<linux/compat.h>, in particular to use a different calling convention
for syscalls. This patch provides a mechanism to do so, based on the
previously introduced CONFIG_ARCH_HAS_SYSCALL_WRAPPER. If it is enabled,
<asm/sycall_wrapper.h> is included in <linux/compat.h> and may be used
to define the macros mentioned above. Moreover, as the syscall calling
convention may be different if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is set,
the compat syscall function prototypes in <linux/compat.h> are #ifndef'd
out in that case.

As some of the syscalls and/or compat syscalls may not be present,
the COND_SYSCALL() and COND_SYSCALL_COMPAT() macros in kernel/sys_ni.c
as well as the SYS_NI() and COMPAT_SYS_NI() macros in
kernel/time/posix-stubs.c can be re-defined in <asm/syscall_wrapper.h> iff
CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180405095307.3730-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/compat.h    | 22 ++++++++++++++++++++++
 init/Kconfig              |  9 ++++++---
 kernel/sys_ni.c           | 10 ++++++++++
 kernel/time/posix-stubs.c | 10 ++++++++++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 9847c5a013c3..2d85ec5cfda2 100644
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
@@ -50,6 +63,7 @@
 #define COMPAT_SYSCALL_DEFINE6(name, ...) \
 	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
 
+#ifndef COMPAT_SYSCALL_DEFINEx
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
@@ -62,6 +76,7 @@
 		return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
 	}								\
 	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* COMPAT_SYSCALL_DEFINEx */
 
 #ifndef compat_user_stack_pointer
 #define compat_user_stack_pointer() current_user_stack_pointer()
@@ -517,7 +532,12 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
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
@@ -955,6 +975,8 @@ asmlinkage long compat_sys_stime(compat_time_t __user *tptr);
 /* obsolete: net/socket.c */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
diff --git a/init/Kconfig b/init/Kconfig
index 068eb6c3bbf7..2dbc88051bde 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1925,8 +1925,11 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
 
 # It may be useful for an architecture to override the definitions of the
-# SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>,
-# in particular to use a different calling convention for syscalls.
+# SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>
+# and the COMPAT_ variants in <linux/compat.h>, in particular to use a
+# different calling convention for syscalls. They can also override the
+# macros for not-implemented syscalls in kernel/sys_ni.c and
+# kernel/time/posix-stubs.c. All these overrides need to be available in
+# <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
-	depends on !COMPAT
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
