Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeBMFnF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:43:05 -0500
Received: from exmail.andestech.com ([59.124.169.137]:7147 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeBMFmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:22 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 4/6] riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
Date: Tue, 13 Feb 2018 13:13:19 +0800
Message-ID: <1518498801-677-5-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5GGQP046250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/include/asm/ftrace.h | 1 +
 arch/riscv/kernel/mcount-dyn.S  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 078743aacfd3..fedadc40e358 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -9,6 +9,7 @@
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 #endif
 
+#define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
 void _mcount(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 739e07a6fd85..6bbc3f88fcb3 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -74,9 +74,12 @@ ENTRY(ftrace_caller)
 	/*
 	 * a0: the address in the caller when calling ftrace_caller
 	 * a1: the caller's return address
+	 * a2: the address of global variable function_trace_op
 	 */
 	ld	a1, -8(s0)
 	addi	a0, ra, -MCOUNT_INSN_SIZE
+	la	t5, function_trace_op
+	ld	a2, 0(t5)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/*
-- 
2.15.1
