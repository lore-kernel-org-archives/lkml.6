Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756994AbeDZRcu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756664AbeDZRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD8C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173201.764690367@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/7] tracing/x86: Update syscall trace events to handle new prefixed
 syscall func names
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-x86-Update-syscall-trace-events-to-handle-ne.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Arnaldo noticed that the latest kernel is missing the syscall event system
directory in x86. I bisected it down to d5a00528b58c ("syscalls/core,
syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()").

The system call trace events are special, as there is only one trace event
for all system calls (the raw_syscalls). But a macro that wraps the system
calls creates meta data for them that copies the name to find the system
call that maps to the system call table (the number). At boot up, it does a
kallsyms lookup of the system call table to find the function that maps to
the meta data of the system call. If it does not find a function, then that
system call is ignored.

Because the x86 system calls had "__x64_", or "__ia32_" prefixed to the
"sys" for the names, they do not match the default compare algorithm. As
this was a problem for power pc, the algorithm can be overwritten by the
architecture. The solution is to have x86 have its own algorithm to do the
compare and this brings back the system call trace events.

Link: http://lkml.kernel.org/r/20180417174128.0f3457f0@gandalf.local.home

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/ftrace.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..cc8f8fcf9b4a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -46,7 +46,21 @@ int ftrace_int3_handler(struct pt_regs *regs);
 #endif /* CONFIG_FUNCTION_TRACER */
 
 
-#if !defined(__ASSEMBLY__) && !defined(COMPILE_OFFSETS)
+#ifndef __ASSEMBLY__
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	/*
+	 * Compare the symbol name with the system call name. Skip the
+	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
+	 */
+	return !strcmp(sym + 3, name + 3) ||
+		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
+		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
+}
+
+#ifndef COMPILE_OFFSETS
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
 #include <asm/compat.h>
@@ -67,6 +81,7 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 	return false;
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
-#endif /* !__ASSEMBLY__  && !COMPILE_OFFSETS */
+#endif /* !COMPILE_OFFSETS */
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_FTRACE_H */
-- 
2.16.3
