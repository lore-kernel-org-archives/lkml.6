Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/FupgsuLgnwAmFTKKIX+F/10bE81FeKnXkJdakRKDc3BeIDQ88TAJaU3DTX+ve+3Dds1dk
ARC-Seal: i=1; a=rsa-sha256; t=1524658883; cv=none;
        d=google.com; s=arc-20160816;
        b=WQqbsWX0URaf3OP8MNYI+RtPaittdKYXmfHFjXBcZlTOm5J8Bh3P2U3+doIByqVUNI
         +7Bred14pacaeOYYbHqO+ONX73OJuW0tmCVGYqMW5bIl9FC/IXmogKfm3caA5ICBWgOs
         yamS5PzeuPofsDwj020ZYHP2bWxZ5bRNfGhvmcePP7N8tom32mZTGCX7NjuI1YAp10NK
         sjyddWJ/bydwvVoY1mRwYfnjY8qw7WZnEI7Ysu7AEwmolsLBd/e20VV8EYy9wqIpsHK8
         NzQWluBx0lStXcKmS3UgvqoK+LBzwfCH7m1Eomyn8vj2iG+3aFDzUw3m2FIK41ZCFczR
         Ngeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=7sUkfpGDBkCU4cP8WaXddLL5R0gSM+6nDRd+CcTf6Sc=;
        b=oHeC321kqZDWXLflOVVTT04AKyMjhY1p3Ky+9scKZihpmU57Xvs00OQgJcF+fuAhzz
         ennK4Wu5NtciO1Co6BCS6AFUJN8/Y5J7Qu38xQP55fVh3Cteg+quhJUiL/IxrZS04zVs
         EV9ltYbFn8ZGtQ+R/7gW6DxeEMYbMscYImMXkCqmbp9nrTuRQY36S/3KvVT0Gx1pJ5BX
         l7mRbcz/3Y90aoinojQqXrgrV6cwir4Y0FS1DspMtUS+M8NIKJD61MADuGTJj8mMKsKm
         3RQU3Eh3tgU9bB0JGQvQl8CHmp1kPCn6vn55PTfoG3gai8QVNQ1PnXfBQCpuiJdHsbIn
         Umhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDYMVW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752873AbeDYMVV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:21:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C6321748
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
Subject: [PATCH v7 10/16] x86: ptrace: Add function argument access API
Date: Wed, 25 Apr 2018 21:20:57 +0900
Message-Id: <152465885737.26224.2822487520472783854.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720712556653350?=
X-GMAIL-MSGID: =?utf-8?q?1598720712556653350?=
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
index 8e0d665c8d53..e20c3781b3ca 100644
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
index 00fcf81f2c56..2d8aaee91694 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -177,6 +177,7 @@ config X86
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

