Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeDRPpO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeDRPpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:45:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE0C217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 11:45:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3] tracing/x86: Update syscall trace events to handle new
 prefixed syscall func names
Message-ID: <20180418114509.5a76847d@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

Changes from v2:

  Included check for "__ia32_" as well.

 arch/x86/include/asm/ftrace.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..06196a302c89 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -31,6 +31,18 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
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
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
-- 
2.13.6
