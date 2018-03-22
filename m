Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeCVSBz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:01:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeCVSBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:01:53 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] objtool: add clang support
Date: Thu, 22 Mar 2018 13:00:37 -0500
Message-Id: <fce88ce81c356eedcae7f00ed349cfaddb3363cc.1521741586.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ORC unwinder was made the default on x86_64, clang-built
defconfig kernels have triggered some new objtool warnings:

  drivers/gpu/drm/i915/i915_gpu_error.o: warning: objtool: i915_error_printf()+0x6c: return with modified stack frame
  drivers/gpu/drm/i915/intel_display.o: warning: objtool: pipe_config_err()+0xa6: return with modified stack frame

The problem is that objtool has never seen clang-built binaries before.

Shockingly enough, objtool is apparently able to follow the code flow
mostly fine, except for one instruction sequence.  Instead of a LEAVE
instruction, clang restores RSP and RBP the long way:

   67c:   48 89 ec                mov    %rbp,%rsp
   67f:   5d                      pop    %rbp

Teach objtool about this new code sequence.

Reported-and-test-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..f02df714c18e 100644
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
+				 * Restore the original stack pointer (clang).
+				 */
+				state->stack_size = -state->regs[CFI_BP].offset;
+			}
+
 			else if (op->dest.reg == cfa->base) {
 
 				/* mov %reg, %rsp */
-- 
2.14.3
