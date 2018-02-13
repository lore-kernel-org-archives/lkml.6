Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933855AbeBMJEH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:04:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933638AbeBMJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:04:02 -0500
Date: Tue, 13 Feb 2018 01:03:37 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-b3ccefaed922529e6a67de7b30af5aa38c76ace9@git.kernel.org>
Cc: tglx@linutronix.de, linux@dominikbrodowski.net, hpa@zytor.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, linux@dominikbrodowski.net,
        hpa@zytor.com
In-Reply-To: <20180212174503.5acbymg5z6p32snu@treble>
References: <20180212174503.5acbymg5z6p32snu@treble>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Fix paranoid_entry() frame pointer
 warning
Git-Commit-ID: b3ccefaed922529e6a67de7b30af5aa38c76ace9
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

Commit-ID:  b3ccefaed922529e6a67de7b30af5aa38c76ace9
Gitweb:     https://git.kernel.org/tip/b3ccefaed922529e6a67de7b30af5aa38c76ace9
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Mon, 12 Feb 2018 11:45:03 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:55 +0100

x86/entry/64: Fix paranoid_entry() frame pointer warning

With the following commit:

  f09d160992d1 ("x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros")

... one of my suggested improvements triggered a frame pointer warning:

  arch/x86/entry/entry_64.o: warning: objtool: paranoid_entry()+0x11: call without frame pointer save/setup

The warning is correct for the build-time code, but it's actually not
relevant at runtime because of paravirt patching.  The paravirt swapgs
call gets replaced with either a SWAPGS instruction or NOPs at runtime.

Go back to the previous behavior by removing the ELF function annotation
for paranoid_entry() and adding an unwind hint, which effectively
silences the warning.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild-all@01.org
Cc: tipbuild@zytor.com
Fixes: f09d160992d1 ("x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros")
Link: http://lkml.kernel.org/r/20180212174503.5acbymg5z6p32snu@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cfbf433..1c5420420 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1128,6 +1128,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
+	UNWIND_HINT_FUNC
 	cld
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1141,7 +1142,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-ENDPROC(paranoid_entry)
+END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
