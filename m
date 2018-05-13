Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeEMR6U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 13:58:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40579 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 13:58:18 -0400
Date: Sun, 13 May 2018 10:57:46 -0700
From: tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-ee6a7354a3629f9b65bc18dbe393503e9440d6f5@git.kernel.org>
Cc: hpa@zytor.com, ricardo.neri-calderon@linux.intel.com, oleg@redhat.com,
        davem@davemloft.net, ast@kernel.org, yhs@fb.com, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        francis.deslauriers@efficios.com, mingo@kernel.org,
        mhiramat@kernel.org
Reply-To: rostedt@goodmis.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, francis.deslauriers@efficios.com,
        mhiramat@kernel.org, mingo@kernel.org, hpa@zytor.com, oleg@redhat.com,
        ricardo.neri-calderon@linux.intel.com, davem@davemloft.net,
        ast@kernel.org, yhs@fb.com, bp@suse.de, luto@kernel.org,
        tglx@linutronix.de
In-Reply-To: <152587069574.17316.3311695234863248641.stgit@devbox>
References: <152587069574.17316.3311695234863248641.stgit@devbox>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] kprobes/x86: Prohibit probing on exception masking
 instructions
Git-Commit-ID: ee6a7354a3629f9b65bc18dbe393503e9440d6f5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ee6a7354a3629f9b65bc18dbe393503e9440d6f5
Gitweb:     https://git.kernel.org/tip/ee6a7354a3629f9b65bc18dbe393503e9440d6f5
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 9 May 2018 21:58:15 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 19:52:55 +0200

kprobes/x86: Prohibit probing on exception masking instructions

Since MOV SS and POP SS instructions will delay the exceptions until the
next instruction is executed, single-stepping on it by kprobes must be
prohibited.

However, kprobes usually executes those instructions directly on trampoline
buffer (a.k.a. kprobe-booster), except for the kprobes which has
post_handler. Thus if kprobe user probes MOV SS with post_handler, it will
do single-stepping on the MOV SS.

This means it is safe that if it is used via ftrace or perf/bpf since those
don't use the post_handler.

Anyway, since the stack switching is a rare case, it is safer just
rejecting kprobes on such instructions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S . Miller" <davem@davemloft.net>
Link: https://lkml.kernel.org/r/152587069574.17316.3311695234863248641.stgit@devbox

---
 arch/x86/include/asm/insn.h    | 18 ++++++++++++++++++
 arch/x86/kernel/kprobes/core.c |  4 ++++
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
