Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeBMPjG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933500AbeBMPjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:39:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5E621780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org
Subject: [RFC PATCH 6/8] x86: ptrace: Add function argument access API
Date: Wed, 14 Feb 2018 00:38:39 +0900
Message-Id: <151853631967.31487.9945485971283800270.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151853614489.31487.10683006682475678487.stgit@devbox>
References: <151853614489.31487.10683006682475678487.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regs_get_argument() which returns N th argument of the
function call.
Note that this chooses most probably assignment, in some case
it can be incorrect (e.g. passing data structure or floating
point etc.)

This is expected to be called from kprobes or ftrace with regs
where the top of stack is the return address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/Kconfig                  |    7 +++++++
 arch/x86/Kconfig              |    1 +
 arch/x86/include/asm/ptrace.h |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index a26d6f8ab967..91e839bdcab9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -258,6 +258,13 @@ config HAVE_REGS_AND_STACK_ACCESS_API
 	  declared in asm/ptrace.h
 	  For example the kprobes-based event tracer needs this API.
 
+config HAVE_FUNCTION_ARG_ACCESS_API
+	bool
+	help
+	  This symbol should be selected by an architecure if it supports
+	  the API needed to access function arguments from pt_regs,
+	  declared in asm/ptrace.h
+
 config HAVE_CLK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 423e4b64e683..c63883665a53 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -172,6 +172,7 @@ config X86
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 14131dd06b29..f0688ec22b15 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -251,6 +251,44 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 		return 0;
 }
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ * Note that this chooses most probably assignment, in some case
+ * it can be incorrect.
+ * This is expected to be called from kprobes or ftrace with regs
+ * where the top of stack is the return address.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+	const static unsigned int argument_offs[] = {
+#ifdef __i386__
+		offsetof(struct pt_regs, ax),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, dx),
+#define NR_REG_ARGUMENTS 3
+#else
+		offsetof(struct pt_regs, di),
+		offsetof(struct pt_regs, si),
+		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, r8),
+		offsetof(struct pt_regs, r9),
+#define NR_REG_ARGUMENTS 6
+#endif
+	};
+
+	if (n >= NR_REG_ARGUMENTS) {
+		n -= NR_REG_ARGUMENTS - 1;
+		return regs_get_kernel_stack_nth(regs, n);
+	} else
+		return regs_get_register(regs, argument_offs[n]);
+}
+
 #define arch_has_single_step()	(1)
 #ifdef CONFIG_X86_DEBUGCTLMSR
 #define arch_has_block_step()	(1)
