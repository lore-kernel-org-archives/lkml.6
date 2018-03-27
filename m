Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC0Hrz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:47:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeC0Hrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:47:53 -0400
Date: Tue, 27 Mar 2018 00:47:30 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-3c1f05835cbf9fdfe60b81c718d82ceb94b6c55e@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, hpa@zytor.com, peterz@infradead.org,
        mka@chromium.org, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, hpa@zytor.com, peterz@infradead.org,
        mka@chromium.org, torvalds@linux-foundation.org
In-Reply-To: <fce88ce81c356eedcae7f00ed349cfaddb3363cc.1521741586.git.jpoimboe@redhat.com>
References: <fce88ce81c356eedcae7f00ed349cfaddb3363cc.1521741586.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] objtool: Add Clang support
Git-Commit-ID: 3c1f05835cbf9fdfe60b81c718d82ceb94b6c55e
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

Commit-ID:  3c1f05835cbf9fdfe60b81c718d82ceb94b6c55e
Gitweb:     https://git.kernel.org/tip/3c1f05835cbf9fdfe60b81c718d82ceb94b6c55e
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 22 Mar 2018 13:00:37 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Mar 2018 08:21:29 +0200

objtool: Add Clang support

Since the ORC unwinder was made the default on x86_64, Clang-built
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/fce88ce81c356eedcae7f00ed349cfaddb3363cc.1521741586.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

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
