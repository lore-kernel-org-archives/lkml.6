Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsOdrLs1267hf0BElXV6gAqw/3Z319pSsDegM+xjKbWTLjrcmn2xbYa/4Nj+jk4uy/Gkgrr
ARC-Seal: i=1; a=rsa-sha256; t=1521290920; cv=none;
        d=google.com; s=arc-20160816;
        b=QNIlcHUGmn03Eat9m79iqsoKf1djVmaNiY8nE4qjUM+0IhdyN3FfYB0TOURDqiIthX
         zoa6FCqGD96f9YLmfIAfZMTM+cwazvS86alz7XX3yy2Q9F2nJederWMNk3sk01SI2kJk
         ndGx9sfeoCLVcBJ7rm+znA8Kf695qydSoW/BIc9T5zdKNLm+JHS2MJeQy0H+2xB1Fr9q
         KknMeyP11j13cFIur72pHFtR5m4AJF4gRFY04ioK5r0h8WaX0+v9RxIZuXGs8t64ihs4
         /wMVM1m3aJUwhD/m2ei1brQHoTiUr0HROhkvVGVbjZb3q4OKjfTTHKKGaqQhFqF8vkfm
         MvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=++tr2CS7eeb8t3WtZ8y4GUgseGYbs/zBb9jE5t+8pho=;
        b=aNTkfLiUFlC/EPfV5UqCJ+e01pfi5YD2QcpRFFGCvv+nW7wiPXtRRj1k4jsiSJBJ+u
         xLAtPNKRpfjJno74ox/MASTyjFw3HcM4gNq6v/p2TTZT38w8QSaib51kshAbVZJJVqnL
         LS3o/8Hj4tqN+bEBGfSA89KM/di4O38edC/TlcjTv538B86kynzB3Acg7CXOzg0TQfSj
         rGVvFtCPYif/xX5fIWipo2cnZQXyholtHbchAi5eEMDU1k7PgB3+6njvfHvPbtoBhzzB
         Be9CEvpagZovwVovTy6mSbT957Arx+JbyQ4FWKvSLA3XSWG81SyTJYUmwj1aTYOIhZtj
         PU3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeCQMsk (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752723AbeCQMsj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:48:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC81217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 14/21] x86: ptrace: Add function argument access API
Date: Sat, 17 Mar 2018 21:47:53 +0900
Message-Id: <152129087298.31874.16468026611863630807.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189149190042063?=
X-GMAIL-MSGID: =?utf-8?q?1595189149190042063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 76c0b54443b1..4126ad4b122c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -272,6 +272,13 @@ config HAVE_REGS_AND_STACK_ACCESS_API
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
index 3b037bc589ab..1ac63d118224 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -176,6 +176,7 @@ config X86
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..c2304b25e2fd 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -256,6 +256,44 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
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
+	static const unsigned int argument_offs[] = {
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

