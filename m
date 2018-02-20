Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBTVCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:02:48 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46958 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeBTVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:01:27 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v3 5/6] x86/entry/64: move ASM_CLAC to interrupt_entry
Date: Tue, 20 Feb 2018 22:01:12 +0100
Message-Id: <20180220210113.6725-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180220210113.6725-1-linux@dominikbrodowski.net>
References: <20180220210113.6725-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving ASM_CLAC to interrupt_entry means two instructions (addq / pushq
and call interrupt_entry) are not covered by it. However, it offers a
noticeable size reduction (-.2k):

   text	   data	    bss	    dec	    hex	filename
  16882	      0	      0	  16882	   41f2	entry_64.o-orig
  16623	      0	      0	  16623	   40ef	entry_64.o

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8ea03cf94a2d..42a4b652469d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -572,6 +572,7 @@ END(irq_entries_start)
 /* 8(%rsp): ~(interrupt number) */
 ENTRY(interrupt_entry)
 	UNWIND_HINT_FUNC
+	ASM_CLAC
 	cld
 
 	testb	$3, CS-ORIG_RAX+8(%rsp)
@@ -614,7 +615,6 @@ END(interrupt_entry)
 	 */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 common_interrupt:
-	ASM_CLAC
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
@@ -811,7 +811,6 @@ END(common_interrupt)
 .macro apicinterrupt3 num sym do_sym
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS
-	ASM_CLAC
 	pushq	$~(\num)
 .Lcommon_\sym:
 	call	interrupt_entry
-- 
2.16.2
