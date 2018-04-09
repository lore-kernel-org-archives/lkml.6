Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDIKw4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:52:56 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:60842 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeDIKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:51:54 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 4/4] syscalls/x86: adapt syscall_wrapper.h to the new syscall stub naming convention
Date: Mon,  9 Apr 2018 12:51:45 +0200
Message-Id: <20180409105145.5364-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180409105145.5364-1-linux@dominikbrodowski.net>
References: <20180409105145.5364-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code in syscall_wrapper.h more readable by naming the stub macros
similar to the stub they provide. While at it, fix a stray newline at the
end of the __IA32_COMPAT_SYS_STUBx macro.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/include/asm/syscall_wrapper.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a598013e08e9..e046a405743d 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -28,7 +28,7 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)				\
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
@@ -36,7 +36,7 @@
 		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
 
-#define SC_IA32_WRAPPERx(x, name, ...)					\
+#define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
 	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
@@ -64,8 +64,8 @@
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)
-#define SC_IA32_WRAPPERx(x, fullname, name, ...)
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUBx(x, fullname, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -75,7 +75,7 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
-#define COMPAT_SC_X32_STUBx(x, name, ...)				\
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
@@ -84,7 +84,7 @@
 	}								\
 
 #else /* CONFIG_X86_X32 */
-#define COMPAT_SC_X32_STUBx(x, name, ...)
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -97,8 +97,8 @@
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	COMPAT_SC_IA32_STUBx(x, name, __VA_ARGS__)				\
-	COMPAT_SC_X32_STUBx(x, name, __VA_ARGS__)				\
+	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
 		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
@@ -163,7 +163,7 @@
 	{								\
 		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
-	SC_IA32_WRAPPERx(x, name, __VA_ARGS__)				\
+	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
 		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
-- 
2.17.0
