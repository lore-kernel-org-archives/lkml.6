Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeBUKqS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:46:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBUKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:46:16 -0500
Date: Wed, 21 Feb 2018 02:45:37 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-6014809adf04188c4bce4a5d231f13a602203c95@git.kernel.org>
Cc: mingo@kernel.org, brgerst@gmail.com, tglx@linutronix.de,
        luto@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, hpa@zytor.com, peterz@infradead.org,
        linux@dominikbrodowski.net, jpoimboe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, dwmw2@infradead.org, bp@alien8.de,
        dvlasenk@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, linux@dominikbrodowski.net, jpoimboe@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, brgerst@gmail.com,
        luto@kernel.org
In-Reply-To: <20180220210113.6725-2-linux@dominikbrodowski.net>
References: <20180220210113.6725-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Move PUSH_AND_CLEAR_REGS from interrupt
 macro to helper function
Git-Commit-ID: 6014809adf04188c4bce4a5d231f13a602203c95
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

Commit-ID:  6014809adf04188c4bce4a5d231f13a602203c95
Gitweb:     https://git.kernel.org/tip/6014809adf04188c4bce4a5d231f13a602203c95
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 20 Feb 2018 22:01:08 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:04:46 +0100

x86/entry/64: Move PUSH_AND_CLEAR_REGS from interrupt macro to helper function

The PUSH_AND_CLEAR_REGS macro is able to insert the GP registers
"above" the original return address. This allows us to move a sizeable
part of the interrupt entry macro to an interrupt entry helper function:

   text	   data	    bss	    dec	    hex	filename
  21088	      0	      0	  21088	   5260	entry_64.o-orig
  18006	      0	      0	  18006	   4656	entry_64.o

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
Link: http://lkml.kernel.org/r/20180220210113.6725-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7a53879..b0ae0c3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -525,6 +525,14 @@ END(irq_entries_start)
  *
  * Entry runs with interrupts off.
  */
+ENTRY(interrupt_entry)
+	UNWIND_HINT_FUNC
+
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
+
+	ret
+END(interrupt_entry)
 
 /* 0(%rsp): ~(interrupt number) */
 	.macro interrupt func
@@ -536,8 +544,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
+	call	interrupt_entry
 
 	testb	$3, CS(%rsp)
 	jz	1f
