Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBRMd6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:33:58 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51574 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeBRMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:33:56 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v2 1/5] x86/entry/64: move PUSH_AND_CLEAR_REGS from interrupt macro to helper function
Date: Sun, 18 Feb 2018 13:31:12 +0100
Message-Id: <20180218123116.21334-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180218123116.21334-1-linux@dominikbrodowski.net>
References: <20180218123116.21334-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PUSH_AND_CLEAR_REGS macro is able to insert the GP registers
"above" the original return address. This allows us to move a sizeable
part of the interrupt entry macro to an interrupt entry helper function:

   text	   data	    bss	    dec	    hex	filename
  21088	      0	      0	  21088	   5260	entry_64.o-orig
  18006	      0	      0	  18006	   4656	entry_64.o

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 77edc2390868..5690391cb7c7 100644
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
