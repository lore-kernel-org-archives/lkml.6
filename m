Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeBLRpH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:45:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752294AbeBLRpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:45:06 -0500
Date: Mon, 12 Feb 2018 11:45:03 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/entry/64: Fix paranoid_entry() frame pointer warning
Message-ID: <20180212174503.5acbymg5z6p32snu@treble>
References: <201802121926.YqVjXPha%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201802121926.YqVjXPha%fengguang.wu@intel.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Fixes: f09d160992d1 ("x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cfbf43366731..1c54204207d8 100644
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
-- 
2.14.3
