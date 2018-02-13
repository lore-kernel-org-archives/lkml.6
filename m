Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeBMJHz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:07:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933638AbeBMJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:07:46 -0500
Date: Tue, 13 Feb 2018 01:00:37 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1@git.kernel.org>
Cc: luto@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, brgerst@gmail.com,
        jpoimboe@redhat.com, peterz@infradead.org, linux@dominikbrodowski.net,
        dvlasenk@redhat.com, torvalds@linux-foundation.org, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, jpoimboe@redhat.com,
        linux@dominikbrodowski.net, dvlasenk@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, brgerst@gmail.com, luto@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180211104949.12992-2-linux@dominikbrodowski.net>
References: <20180211104949.12992-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS,
 remove unused extensions
Git-Commit-ID: 2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1
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

Commit-ID:  2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1
Gitweb:     https://git.kernel.org/tip/2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 11:49:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:52 +0100

x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused extensions

All current code paths call SAVE_C_REGS and then immediately
SAVE_EXTRA_REGS. Therefore, merge these two macros and order the MOV
sequeneces properly.

While at it, remove the macros to save all except specific registers,
as these macros have been unused for a long time.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  | 57 +++++++++++++----------------------------------
 arch/x86/entry/entry_64.S | 12 ++++------
 2 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f4b129d..8907a65 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -101,49 +101,22 @@ For 32-bit we have the following conventions - kernel is built with
 	addq	$-(15*8), %rsp
 	.endm
 
-	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
-	.if \r11
-	movq %r11, 6*8+\offset(%rsp)
-	.endif
-	.if \r8910
-	movq %r10, 7*8+\offset(%rsp)
-	movq %r9,  8*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	.endif
-	.if \rax
-	movq %rax, 10*8+\offset(%rsp)
-	.endif
-	.if \rcx
-	movq %rcx, 11*8+\offset(%rsp)
-	.endif
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
+	.macro SAVE_REGS offset=0
 	movq %rdi, 14*8+\offset(%rsp)
-	UNWIND_HINT_REGS offset=\offset extra=0
-	.endm
-	.macro SAVE_C_REGS offset=0
-	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX offset=0
-	SAVE_C_REGS_HELPER \offset, 0, 0, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_R891011
-	SAVE_C_REGS_HELPER 0, 1, 1, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RCX_R891011
-	SAVE_C_REGS_HELPER 0, 1, 0, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
-	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
-	.endm
-
-	.macro SAVE_EXTRA_REGS offset=0
-	movq %r15, 0*8+\offset(%rsp)
-	movq %r14, 1*8+\offset(%rsp)
-	movq %r13, 2*8+\offset(%rsp)
-	movq %r12, 3*8+\offset(%rsp)
-	movq %rbp, 4*8+\offset(%rsp)
+	movq %rsi, 13*8+\offset(%rsp)
+	movq %rdx, 12*8+\offset(%rsp)
+	movq %rcx, 11*8+\offset(%rsp)
+	movq %rax, 10*8+\offset(%rsp)
+	movq %r8,  9*8+\offset(%rsp)
+	movq %r9,  8*8+\offset(%rsp)
+	movq %r10, 7*8+\offset(%rsp)
+	movq %r11, 6*8+\offset(%rsp)
 	movq %rbx, 5*8+\offset(%rsp)
+	movq %rbp, 4*8+\offset(%rsp)
+	movq %r12, 3*8+\offset(%rsp)
+	movq %r13, 2*8+\offset(%rsp)
+	movq %r14, 1*8+\offset(%rsp)
+	movq %r15, 0*8+\offset(%rsp)
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
@@ -197,7 +170,7 @@ For 32-bit we have the following conventions - kernel is built with
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_EXTRA_REGS because it corrupts
+ * NOTE: This macro must be used *after* SAVE_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 932a445..1a6fc01 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -573,8 +573,7 @@ END(irq_entries_start)
 1:
 
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
@@ -1132,8 +1131,7 @@ ENTRY(xen_failsafe_callback)
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
@@ -1178,8 +1176,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
@@ -1231,8 +1228,7 @@ END(paranoid_exit)
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
