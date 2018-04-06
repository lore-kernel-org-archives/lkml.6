Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDFRLY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:11:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeDFRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:11:21 -0400
Date: Fri, 6 Apr 2018 10:10:32 -0700
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-1bd21c6c21e848996339508d3ffb106d505256a8@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        bp@alien8.de, linux@dominikbrodowski.net, brgerst@gmail.com,
        viro@zeniv.linux.org.uk, jpoimboe@redhat.com, mingo@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, dvlasenk@redhat.com, peterz@infradead.org
Reply-To: hpa@zytor.com, bp@alien8.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux@dominikbrodowski.net, jpoimboe@redhat.com,
        viro@zeniv.linux.org.uk, brgerst@gmail.com, mingo@kernel.org,
        luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, akpm@linux-foundation.org
In-Reply-To: <20180405095307.3730-3-linux@dominikbrodowski.net>
References: <20180405095307.3730-3-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] syscalls/core: Introduce
 CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
Git-Commit-ID: 1bd21c6c21e848996339508d3ffb106d505256a8
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

Commit-ID:  1bd21c6c21e848996339508d3ffb106d505256a8
Gitweb:     https://git.kernel.org/tip/1bd21c6c21e848996339508d3ffb106d505256a8
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Thu, 5 Apr 2018 11:53:01 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 16:59:25 +0200

syscalls/core: Introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

It may be useful for an architecture to override the definitions of the
SYSCALL_DEFINE0() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>,
in particular to use a different calling convention for syscalls.

This patch provides a mechanism to do so: It introduces
CONFIG_ARCH_HAS_SYSCALL_WRAPPER. If it is enabled, <asm/sycall_wrapper.h>
is included in <linux/syscalls.h> and may be used to define the macros
mentioned above. Moreover, as the syscall calling convention may be
different if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is set, the syscall function
prototypes in <linux/syscalls.h> are #ifndef'd out in that case.

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
Link: http://lkml.kernel.org/r/20180405095307.3730-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/syscalls.h | 23 +++++++++++++++++++++++
 init/Kconfig             |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b961184f597a..503ab245d4ce 100644
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
@@ -209,6 +222,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
+
+#ifndef __SYSCALL_DEFINEx
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(SyS##name))));		\
@@ -223,6 +238,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 		return ret;						\
 	}								\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* __SYSCALL_DEFINEx */
 
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
@@ -252,7 +268,12 @@ static inline void addr_limit_user_check(void)
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
@@ -1076,6 +1097,8 @@ asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
  */
 asmlinkage long sys_ni_syscall(void);
 
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/init/Kconfig b/init/Kconfig
index 2852692d7c9c..068eb6c3bbf7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1923,3 +1923,10 @@ source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
+
+# It may be useful for an architecture to override the definitions of the
+# SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>,
+# in particular to use a different calling convention for syscalls.
+config ARCH_HAS_SYSCALL_WRAPPER
+	def_bool n
+	depends on !COMPAT
