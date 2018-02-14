Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966528AbeBNC2A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:28:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966382AbeBNC16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:27:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
Date: Tue, 13 Feb 2018 20:27:30 -0600
Message-Id: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paranoid exit code only restores the saved CR3 when it switches back
to the user GS.  However, even in the kernel GS case, it's possible that
it needs to restore a user CR3, if for example, the paranoid exception
occurred in the syscall exit path between SWITCH_TO_USER_CR3_STACK and
SWAPGS.

Fix that issue by making the CR3 restore unconditional.  This is
symmetrical with the unconditional CR3 save in paranoid_entry().

Also, since RESTORE_CR3 is now done before the EBX compare, it needs to
use a different scratch register (R15 instead of RBX).

I haven't actually seen any real-world bugs caused by this, so I'm not
sure how theoretical it is.  I just stumbled upon it in code review when
looking for another bug.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cd216c9431e1..68c95a09b48d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1167,10 +1167,10 @@ ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
+	RESTORE_CR3	scratch_reg=%r15 save_reg=%r14
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
-- 
2.14.3
