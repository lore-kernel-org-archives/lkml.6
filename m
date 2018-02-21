Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965194AbeBURAy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:00:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964941AbeBURAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:00:51 -0500
Date: Wed, 21 Feb 2018 09:00:12 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-3aa99fc3e708b9cd9b4cfe2df0b7a66cf293e3cf@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de, bp@alien8.de,
        peterz@infradead.org, dwmw2@infradead.org, jpoimboe@redhat.com,
        luto@kernel.org, linux@dominikbrodowski.net,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, brgerst@gmail.com
Reply-To: dvlasenk@redhat.com, brgerst@gmail.com, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, jpoimboe@redhat.com, luto@kernel.org,
        linux@dominikbrodowski.net, torvalds@linux-foundation.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org
In-Reply-To: <20180220210113.6725-5-linux@dominikbrodowski.net>
References: <20180220210113.6725-5-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Remove 'interrupt' macro
Git-Commit-ID: 3aa99fc3e708b9cd9b4cfe2df0b7a66cf293e3cf
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

Commit-ID:  3aa99fc3e708b9cd9b4cfe2df0b7a66cf293e3cf
Gitweb:     https://git.kernel.org/tip/3aa99fc3e708b9cd9b4cfe2df0b7a66cf293e3cf
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 20 Feb 2018 22:01:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 16:54:04 +0100

x86/entry/64: Remove 'interrupt' macro

It is now trivial to call interrupt_entry() and then the actual worker.
Therefore, remove the interrupt macro and open code it all.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180220210113.6725-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b45d766..8ea03cf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -608,14 +608,6 @@ ENTRY(interrupt_entry)
 	ret
 END(interrupt_entry)
 
-/* 0(%rsp): ~(interrupt number) */
-	.macro interrupt func
-	call	interrupt_entry
-
-	UNWIND_HINT_REGS indirect=1
-	call	\func	/* rdi points to pt_regs */
-	.endm
-
 	/*
 	 * The interrupt stubs push (~vector+0x80) onto the stack and
 	 * then jump to common_interrupt.
@@ -624,7 +616,9 @@ END(interrupt_entry)
 common_interrupt:
 	ASM_CLAC
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
-	interrupt do_IRQ
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	do_IRQ	/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -820,7 +814,9 @@ ENTRY(\sym)
 	ASM_CLAC
 	pushq	$~(\num)
 .Lcommon_\sym:
-	interrupt \do_sym
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
 .endm
