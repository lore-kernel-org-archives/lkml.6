Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652C8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A9622419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9622419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeKNF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:58:06 -0500
Received: from mail.binarylogic.ch ([88.198.23.72]:47886 "EHLO
        mail.binarylogic.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNF6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:58:05 -0500
Received: from fortknox.localdomain (unknown [192.168.122.1])
        by mail.binarylogic.ch (Postfix) with ESMTP id 0B4CEDF6FF;
        Tue, 13 Nov 2018 20:58:23 +0100 (CET)
From:   =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [RFC/RFT 1/2] RISC-V: Implement ptrace regs and stack API
Date:   Tue, 13 Nov 2018 20:58:03 +0100
Message-Id: <20181113195804.22825-2-me@packi.ch>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113195804.22825-1-me@packi.ch>
References: <20181113195804.22825-1-me@packi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for kprobes support. Copied and adapted from arm64 code.

Signed-off-by: Patrick Stählin <me@packi.ch>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h | 34 +++++++++++
 arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f4e818..b157ac82d486 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -43,6 +43,7 @@ config RISCV
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 config MMU
 	def_bool y
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index 2c5df945d43c..70c0ad08ac08 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -16,6 +16,7 @@
 
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
 
@@ -68,6 +69,7 @@ struct pt_regs {
 
 #define user_mode(regs) (((regs)->sstatus & SR_SPP) == 0)
 
+#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
 
 /* Helpers for working with the instruction pointer */
 #define GET_IP(regs) ((regs)->sepc)
@@ -99,6 +101,17 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 	SET_USP(regs, val);
 }
 
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
 /* Helpers for working with the frame pointer */
 #define GET_FP(regs) ((regs)->s0)
 #define SET_FP(regs, val) (GET_FP(regs) = (val))
@@ -113,6 +126,27 @@ static inline void frame_pointer_set(struct pt_regs *regs,
 	SET_FP(regs, val);
 }
 
+extern int regs_query_register_offset(const char *name);
+extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+					       unsigned int n);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	pt_regs from which register value is gotten
+ * @offset:	offset of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					      unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 60f1e02eed36..5b684e4ffc10 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -130,6 +130,105 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &riscv_user_native_view;
 }
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(sepc),
+	REG_OFFSET_NAME(ra),
+	REG_OFFSET_NAME(sp),
+	REG_OFFSET_NAME(gp),
+	REG_OFFSET_NAME(tp),
+	REG_OFFSET_NAME(t0),
+	REG_OFFSET_NAME(t1),
+	REG_OFFSET_NAME(t2),
+	REG_OFFSET_NAME(s0),
+	REG_OFFSET_NAME(s1),
+	REG_OFFSET_NAME(a0),
+	REG_OFFSET_NAME(a1),
+	REG_OFFSET_NAME(a2),
+	REG_OFFSET_NAME(a3),
+	REG_OFFSET_NAME(a4),
+	REG_OFFSET_NAME(a5),
+	REG_OFFSET_NAME(a6),
+	REG_OFFSET_NAME(a7),
+	REG_OFFSET_NAME(s2),
+	REG_OFFSET_NAME(s3),
+	REG_OFFSET_NAME(s4),
+	REG_OFFSET_NAME(s5),
+	REG_OFFSET_NAME(s6),
+	REG_OFFSET_NAME(s7),
+	REG_OFFSET_NAME(s8),
+	REG_OFFSET_NAME(s9),
+	REG_OFFSET_NAME(s10),
+	REG_OFFSET_NAME(s11),
+	REG_OFFSET_NAME(t3),
+	REG_OFFSET_NAME(t4),
+	REG_OFFSET_NAME(t5),
+	REG_OFFSET_NAME(t6),
+	REG_OFFSET_NAME(sstatus),
+	REG_OFFSET_NAME(sbadaddr),
+	REG_OFFSET_NAME(scause),
+	REG_OFFSET_NAME(orig_a0),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return (addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 void ptrace_disable(struct task_struct *child)
 {
 	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-- 
2.17.1

