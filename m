Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeDXKRp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:17:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753223AbeDXKRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:17:41 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] ftrace/x86: Fix arch_syscall_match_sym_name for x86_64
Date: Tue, 24 Apr 2018 12:17:38 +0200
Message-Id: <20180424101738.30015-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent commit changed the name prefix of syscalls
for x86_64 (check the 'Fixes:' for commit number).

The names switch from "sys_" prefix to ""__x64_sys_",
which made the default matching function always fail.

Consequently the ftrace syscall __init code could not
match any syscall metadata so the "syscall" events
vanished. This fix returns them back.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/ftrace.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..7b131ad39ee2 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -67,6 +67,18 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 	return false;
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
+
+#ifdef CONFIG_X86_64
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME 1
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	/*
+	 * Skip the __x64_sys_ prefix and compare the
+	 * syscall name only.
+	 */
+	return !strcmp(sym + 9, name + 3);
+}
+#endif /* CONFIG_X86_64 */
 #endif /* !__ASSEMBLY__  && !COMPILE_OFFSETS */
 
 #endif /* _ASM_X86_FTRACE_H */
-- 
2.13.6
