Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbeE2Mgx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:36:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933778AbeE2Mg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:36:29 -0400
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>, Josef Bacik <jbacik@fb.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] error-injection: Simplify arch specific helpers
Date: Tue, 29 May 2018 18:06:02 +0530
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052912-0040-0000-0000-0000045E87CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0041-0000-0000-00002102F8E8
Message-Id: <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have an arch-independent way to set the instruction pointer
with instruction_pointer_set(). Using this allows us to get rid of the
need for override_function_with_return() that each architecture has to
implement.

Furthermore, just_return_func() only has to encode arch-specific
assembly instructions to return from a function. Introduce a macro
ARCH_FUNC_RET to provide the arch-specific instruction and move over
just_return_func() to generic code.

With these changes, architectures that already support kprobes, only
just need to ensure they provide regs_set_return_value(), GET_IP() (for
instruction_pointer_set()), and ARCH_FUNC_RET to support error
injection.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/x86/include/asm/error-injection.h |  6 +-----
 arch/x86/lib/Makefile                  |  1 -
 arch/x86/lib/error-inject.c            | 20 --------------------
 include/asm-generic/error-injection.h  |  6 ++++++
 include/linux/error-injection.h        |  1 +
 kernel/fail_function.c                 |  2 +-
 kernel/trace/bpf_trace.c               |  2 +-
 lib/error-inject.c                     |  8 ++++++++
 8 files changed, 18 insertions(+), 28 deletions(-)
 delete mode 100644 arch/x86/lib/error-inject.c

diff --git a/arch/x86/include/asm/error-injection.h b/arch/x86/include/asm/error-injection.h
index 47b7a1296245..f3f22e237b86 100644
--- a/arch/x86/include/asm/error-injection.h
+++ b/arch/x86/include/asm/error-injection.h
@@ -2,12 +2,8 @@
 #ifndef _ASM_ERROR_INJECTION_H
 #define _ASM_ERROR_INJECTION_H
 
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
 #include <asm-generic/error-injection.h>
 
-asmlinkage void just_return_func(void);
-void override_function_with_return(struct pt_regs *regs);
+#define ARCH_FUNC_RET	"ret"
 
 #endif /* _ASM_ERROR_INJECTION_H */
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 25a972c61b0a..f23934bbaf4e 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -26,7 +26,6 @@ lib-y += memcpy_$(BITS).o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
-lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
deleted file mode 100644
index 3cdf06128d13..000000000000
--- a/arch/x86/lib/error-inject.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/error-injection.h>
-#include <linux/kprobes.h>
-
-asmlinkage void just_return_func(void);
-
-asm(
-	".type just_return_func, @function\n"
-	".globl just_return_func\n"
-	"just_return_func:\n"
-	"	ret\n"
-	".size just_return_func, .-just_return_func\n"
-);
-
-void override_function_with_return(struct pt_regs *regs)
-{
-	regs->ip = (unsigned long)&just_return_func;
-}
-NOKPROBE_SYMBOL(override_function_with_return);
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 296c65442f00..8ac152cc204a 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -3,6 +3,9 @@
 #define _ASM_GENERIC_ERROR_INJECTION_H
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+
 enum {
 	EI_ETYPE_NONE,		/* Dummy value for undefined case */
 	EI_ETYPE_NULL,		/* Return NULL if failure */
@@ -27,6 +30,9 @@ static struct error_injection_entry __used				\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
 	};
+
+asmlinkage void just_return_func(void);
+
 #else
 #define ALLOW_ERROR_INJECTION(fname, _etype)
 #endif
diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
index 280c61ecbf20..f4a0b23423d2 100644
--- a/include/linux/error-injection.h
+++ b/include/linux/error-injection.h
@@ -4,6 +4,7 @@
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
+#include <linux/types.h>
 #include <asm/error-injection.h>
 
 extern bool within_error_injection_list(unsigned long addr);
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 1d5632d8bbcc..0ae2ca4a29e8 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -183,7 +183,7 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 
 	if (should_fail(&fei_fault_attr, 1)) {
 		regs_set_return_value(regs, attr->retval);
-		override_function_with_return(regs);
+		instruction_pointer_set(regs, (unsigned long)&just_return_func);
 		/* Kprobe specific fixup */
 		reset_current_kprobe();
 		preempt_enable_no_resched();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 56ba0f2a01db..23f1f4ffda6c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(trace_call_bpf);
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
 	regs_set_return_value(regs, rc);
-	override_function_with_return(regs);
+	instruction_pointer_set(regs, (unsigned long)&just_return_func);
 	return 0;
 }
 
diff --git a/lib/error-inject.c b/lib/error-inject.c
index c0d4600f4896..7fdc92b5babc 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -20,6 +20,14 @@ struct ei_entry {
 	void *priv;
 };
 
+asm(
+	".type just_return_func, @function\n"
+	".globl just_return_func\n"
+	"just_return_func:\n"
+	ARCH_FUNC_RET "\n"
+	".size just_return_func, .-just_return_func\n"
+);
+
 bool within_error_injection_list(unsigned long addr)
 {
 	struct ei_entry *ent;
-- 
2.17.0
