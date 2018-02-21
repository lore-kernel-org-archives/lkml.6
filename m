Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965614AbeBURBY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:01:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbeBURBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:01:22 -0500
Date: Wed, 21 Feb 2018 09:00:42 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-b2855d8d2de0fa15c1ff30c69ed7756b00c48b22@git.kernel.org>
Cc: bp@alien8.de, tglx@linutronix.de, luto@kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, peterz@infradead.org, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, dwmw2@infradead.org, hpa@zytor.com
Reply-To: dwmw2@infradead.org, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, jpoimboe@redhat.com, brgerst@gmail.com,
        bp@alien8.de, tglx@linutronix.de, luto@kernel.org
In-Reply-To: <20180220210113.6725-6-linux@dominikbrodowski.net>
References: <20180220210113.6725-6-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Move ASM_CLAC to interrupt_entry()
Git-Commit-ID: b2855d8d2de0fa15c1ff30c69ed7756b00c48b22
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

Commit-ID:  b2855d8d2de0fa15c1ff30c69ed7756b00c48b22
Gitweb:     https://git.kernel.org/tip/b2855d8d2de0fa15c1ff30c69ed7756b00c48b22
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 20 Feb 2018 22:01:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 16:54:05 +0100

x86/entry/64: Move ASM_CLAC to interrupt_entry()

Moving ASM_CLAC to interrupt_entry means two instructions (addq / pushq
and call interrupt_entry) are not covered by it. However, it offers a
noticeable size reduction (-.2k):

   text	   data	    bss	    dec	    hex	filename
  16882	      0	      0	  16882	   41f2	entry_64.o-orig
  16623	      0	      0	  16623	   40ef	entry_64.o

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180220210113.6725-6-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8ea03cf..42a4b65 100644
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
