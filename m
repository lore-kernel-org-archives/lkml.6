Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934962AbeEIM6m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934638AbeEIM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:58:40 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 1/2] kprobes: x86: Prohibit probing on exception masking instructions
Date: Wed,  9 May 2018 21:58:15 +0900
Message-Id: <152587069574.17316.3311695234863248641.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152587066475.17316.3035446966107675608.stgit@devbox>
References: <152587066475.17316.3035446966107675608.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MOV SS and POP SS instructions will delay the exceptions
until the next instruction is executed, we should not do
single-stepping on it by kprobes.

However, kprobes usually executes those instructions directly
on trampoline buffer (a.k.a. kprobe-booster), except for the
kprobes which has post_handler. Thus if kprobe user probes MOV SS
with post_handler, it will do single-stepping on the MOV SS.

This means it is safe that if we use it via ftrace or perf/bpf
since those don't use the post_handler.

Anyway, since the stack switching is a rare case, it is safer
just rejecting kprobes on such instructions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/insn.h    |   18 ++++++++++++++++++
 arch/x86/kernel/kprobes/core.c |    4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index b3e32b010ab1..c2c01f84df75 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..6f4d42377fe5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -370,6 +370,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return 0;
+
 #ifdef CONFIG_X86_64
 	/* Only x86_64 has RIP relative instructions */
 	if (insn_rip_relative(insn)) {
