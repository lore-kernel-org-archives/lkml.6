Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227IdXWUrguwfGSQ6rbT22ZauG1rHNEBDV1yig3OM2U1/VT4XXkIvLq7tRZTL0t3NUVZRg7D
ARC-Seal: i=1; a=rsa-sha256; t=1519788412; cv=none;
        d=google.com; s=arc-20160816;
        b=Mg/mBqnAhsEbp66AHEOzUp36ad95RD6RPkeHMBuLOglIIZ9LVpTkN8/kwyXtAVueHG
         Hn2Jxm4RiZ4N+5uG8xuknH7/VMep/pWI0ua9VeZU5UyQfcJp8O0ksM4940tzTsD0Swqp
         NKlhJpMwIsBxHIgzVN77ZrG/EHV1dyjepo9qSPPJRRR4mog91AJITCBAtFZ3BbToP5nI
         r4IZWzf2iItuSwYrNgaK8JNqIxzUSf5qSKQJIPQ183AHdjBv6l+IcSu6Sd6qt8Nt9vxf
         Q0geVl0Ukk950uNoF3l0ezHPRjFMvBeHcftJdlXOUIdIctuITpZqsGMlmAhxF9/nQYD3
         b8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Bu6z+M/A4lXmHbl2uamOuXuBzOFhDP+hcf81yuJgx9Y=;
        b=0YnSyU/Jy/B3jiBMOMDwEAvRNAfATvM/l/Wk01V3MaOvMKppfYZCIMEwZbzAL/TH5C
         Q/ETn43Z/KbkPt3PnDxLgVCKoTosTRMCRQm+oFSGImkLK7vUb+Smz6qr4lW7EvIJ9neJ
         aInxgAH7qYnBx6xpHP4QxZYsTWbpWUOK75Zl1NjSHGmAphx9+rUizbpI7d9rT9h5PmPd
         LbS8I/WH3HioyhP1H1oW74WD5dmun8AFqfaFll98mAXkYsRPrVddfVxNfi6byhwxCqf7
         0NJyhbBF2LUGF6KG4hFtZWL4FgkQKQOcVOQm/IJyfTr06JNkBCgUbrMTbYWzyrXuUw6/
         bLjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeB1D0k (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbeB1D0j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:26:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7552133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v4 14/19] x86: ptrace: Add function argument access API
Date: Wed, 28 Feb 2018 12:26:15 +0900
Message-Id: <151978837500.2577.1096284635519642144.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151978796240.2577.6531711990653677529.stgit@devbox>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613654431307008?=
X-GMAIL-MSGID: =?utf-8?q?1593613654431307008?=
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
index bdfd503065d3..d7e6d93968ea 100644
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

