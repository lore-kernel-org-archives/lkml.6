Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161958AbeBNSYC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:24:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48106 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161820AbeBNSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:22:34 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: torvalds@linux-foundation.org, luto@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, dan.j.williams@intel.com
Subject: [RFC PATCH 1/4] x86/entry/64: move PUSH_AND_CLEAR_REGS from interrupt macro to helper function
Date: Wed, 14 Feb 2018 19:21:10 +0100
Message-Id: <20180214182113.27247-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214182113.27247-1-linux@dominikbrodowski.net>
References: <20180214182113.27247-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PUSH_AND_CLEAR_REGS macro is able to insert the GP registers
"above" the original return address. This allows us to move a sizeable
part of the interrupt entry macro to an interrupt entry helper function:

   text	   data	    bss	    dec	    hex	filename
  20987	      0	      0	  20987	   51fb	entry_64.o-orig
  17905	      0	      0	  17905	   45f1	entry_64.o

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5d9cb0f037e4..de8a0da0d347 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -526,6 +526,15 @@ END(irq_entries_start)
  *
  * Entry runs with interrupts off.
  */
+ENTRY(interrupt_helper)
+	UNWIND_HINT_FUNC
+	cld
+
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
+
+	ret
+END(interrupt_helper)
 
 /* 0(%rsp): ~(interrupt number) */
 	.macro interrupt func
@@ -537,8 +546,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
+	call	interrupt_helper
 
 	testb	$3, CS(%rsp)
 	jz	1f
-- 
2.16.1
