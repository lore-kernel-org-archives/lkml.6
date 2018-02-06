Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeBFVdH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:33:07 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34890 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeBFVdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:33:06 -0500
Date: Tue, 6 Feb 2018 22:25:46 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, x86@kernel.org
Subject: [PATCH tip-pti 1/2] x86/entry: remove SAVE_C_REGS_EXCEPT_* macros
Message-ID: <20180206212546.GA2026@light.dominikbrodowski.net>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de>
 <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros which save all but specific registers have been unused for
a long time. Remove them and the SAVE_C_REGS_HELPER macro, but
instead provide the SAVE_C_REGS macro directly.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f4b129d4af42..75a237c95ff7 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -101,41 +101,18 @@ For 32-bit we have the following conventions - kernel is built with
 	addq	$-(15*8), %rsp
 	.endm
 
-	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
-	.if \r11
+	.macro SAVE_C_REGS offset=0
 	movq %r11, 6*8+\offset(%rsp)
-	.endif
-	.if \r8910
 	movq %r10, 7*8+\offset(%rsp)
 	movq %r9,  8*8+\offset(%rsp)
 	movq %r8,  9*8+\offset(%rsp)
-	.endif
-	.if \rax
 	movq %rax, 10*8+\offset(%rsp)
-	.endif
-	.if \rcx
 	movq %rcx, 11*8+\offset(%rsp)
-	.endif
 	movq %rdx, 12*8+\offset(%rsp)
 	movq %rsi, 13*8+\offset(%rsp)
 	movq %rdi, 14*8+\offset(%rsp)
 	UNWIND_HINT_REGS offset=\offset extra=0
 	.endm
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
 
 	.macro SAVE_EXTRA_REGS offset=0
 	movq %r15, 0*8+\offset(%rsp)
