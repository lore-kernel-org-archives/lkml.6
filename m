Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeBMAEy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:04:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:38701 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932773AbeBMAEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:04:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="203567454"
From: Andi Kleen <andi@firstfloor.org>
To: tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        dwmw2@infradead.org, jpoimboe@redhat.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] x86/retpoline: Fix return buffer filling
Date: Mon, 12 Feb 2018 16:04:22 -0800
Message-Id: <20180213000422.16916-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180213000422.16916-1-andi@firstfloor.org>
References: <20180213000422.16916-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

An earlier patch moved the RSB filling out of line, ending
it with a return. This results in the return buffer filling
only giving 15 instead of 16 usable returns because
the return from fill_rsb already uses one up.

Since the kernel call chains can be quite deep that's
somewhat dangerous and better avoided.

Always do one extra return buffer fill in the caller.
I added a STUFF_ONE_RSB macro for this, and fixed
up all the caller

An alternative would be to revert 1dde7415e999
and just go back to the inline version.

Needs the earlier patch to avoid lots of bogus warnings
from objtool, but even with that there is one left.

Fixes: 1dde7415e999 ("x86/retpoline: Simplify vmexit...")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 788c4da7dda9..af0ca73abb23 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -77,10 +77,19 @@
 #endif
 .endm
 
+.macro STUFF_ONE_RSB
+#ifdef CONFIG_RETPOLINE
+	call 581f
+	pause ; lfence
+581:	add  $(BITS_PER_LONG/8), %_ASM_SP
+#endif
+.endm
+
 /* This clobbers the BX register */
 .macro FILL_RETURN_BUFFER nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE "", "call __clear_rsb", \ftr
+	ALTERNATIVE "", "call __clear_rsb" , \ftr
+	ALTERNATIVE "", "STUFF_ONE_RSB", \ftr
 #endif
 .endm
 
@@ -133,6 +142,20 @@
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 
+#ifdef CONFIG_X86_64
+#define STUFF_ONE_RSB	\
+	"	call 881f\n"					\
+	"	pause;lfence\n"					\
+	"881:\n"						\
+	"	addq $8,%%rsp\n"
+#else
+#define STUFF_ONE_RSB	\
+	"	call 881f\n"					\
+	"	pause;lfence\n"					\
+	"881:\n"						\
+	"	addl $4,%%esp\n"
+#endif
+
 /* The Spectre V2 mitigation variants */
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
@@ -156,7 +179,7 @@ static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
 	alternative_input("",
-			  "call __fill_rsb",
+			  "call __fill_rsb;" STUFF_ONE_RSB,
 			  X86_FEATURE_RETPOLINE,
 			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
 #endif
-- 
2.14.3
