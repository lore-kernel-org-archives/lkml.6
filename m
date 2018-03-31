Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeCaKcs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:32:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43596 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeCaKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:32:47 -0400
X-Google-Smtp-Source: AIpwx480NPwZclhjPiOhPZ7DG8ev2wyXXdKViIRDTdqmykzUj50DCLHe13ZRoCsBqt7qBDaNKVoVLA==
Date: Sat, 31 Mar 2018 12:32:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 PTI fixes
Message-ID: <20180331103243.sajo2gd35okelfys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

   # HEAD: bd6271039ee6f0c9b468148fc2d73e0584af6b4f x86/alternatives: Fixup alternative_call_2

Two fixes: a relatively simple objtool fix that makes Clang built kernels work 
with ORC debug info, plus an alternatives macro fix.

  out-of-topic modifications in x86-pti-for-linus:
  --------------------------------------------------
  tools/objtool/check.c              # 3c1f05835cbf: objtool: Add Clang support

 Thanks,

	Ingo

------------------>
Alexey Dobriyan (1):
      x86/alternatives: Fixup alternative_call_2

Josh Poimboeuf (1):
      objtool: Add Clang support


 arch/x86/include/asm/alternative.h |  4 +---
 tools/objtool/check.c              | 11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index cf5961ca8677..4cd6a3b71824 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -218,13 +218,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
 			   output, input...)				      \
-{									      \
 	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input);			      \
-}
+		  [new2] "i" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..5409f6f6c48d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1386,6 +1386,17 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				state->vals[op->dest.reg].offset = -state->stack_size;
 			}
 
+			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
+				 cfa->base == CFI_BP) {
+
+				/*
+				 * mov %rbp, %rsp
+				 *
+				 * Restore the original stack pointer (Clang).
+				 */
+				state->stack_size = -state->regs[CFI_BP].offset;
+			}
+
 			else if (op->dest.reg == cfa->base) {
 
 				/* mov %reg, %rsp */
