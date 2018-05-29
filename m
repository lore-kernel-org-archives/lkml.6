Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933886AbeE2MMO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:12:14 -0400
Received: from foss.arm.com ([217.140.101.70]:38658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933793AbeE2MMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:12:09 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 15/17] arm64: Add test_and_clear_flag and set_flag atomic assembler primitives
Date: Tue, 29 May 2018 13:11:19 +0100
Message-Id: <20180529121121.24927-16-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to need to atomically manipulate some thread
flags from entry.S, let's introduce two atomic primitives
(test_and_clear_flag and set_flag) for that purpose.

We provide two implementations: one using the traditional
LL/SC instructions, and one using the ARMv8.1 atomics.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/assembler.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..d3612ad8035e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -26,6 +26,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
+#include <asm/lse.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -701,4 +702,40 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 .Lyield_out_\@ :
 	.endm
 
+/*
+ * test_and_clear_flag:
+ *
+ * res: register containing the result (0 or 1 << bitnum)
+ * addr: address of the word to be manipulated
+ * bitnum: number of the bit in that word
+ * wtmp: temporary register, must be a 32bit reg
+ */
+	.macro test_and_clear_flag, res, addr, bitnum, wtmp
+alt_lse "  prfm	 pstl1strm, [\addr]",		"nop"
+alt_lse "8:ldxr  \res, [\addr]",		"ldr	 \res, [\addr]"
+	   tbz	 \res, #\bitnum, 9f
+alt_lse "  bic	 \res, \res, #(1 << \bitnum)",	"mov	 \res, #(1 << \bitnum)"
+alt_lse "  stlxr \wtmp, \res, [\addr]",		"ldclral \res, \res, [\addr]"
+alt_lse "  cbnz	 \wtmp, 8b",			"nop"
+alt_lse "  dmb   ish",				"nop"
+alt_lse "  orr	 \res, \res, #(1 << \bitnum)",	"nop"
+9:
+	.endm
+
+/*
+ * set_flag:
+ *
+ * addr: address of the word to be manipulated
+ * bitnum: number of the bit in that word
+ * tmp: temporary register
+ * wtmp: temporary register, must be a 32bit reg
+ */
+	.macro set_flag, addr, bitnum, tmp, wtmp
+alt_lse "  prfm	pstl1strm, [\addr]",		"mov   \tmp, #(1 << \bitnum)"
+alt_lse "8:ldxr \tmp, [\addr]", 		"stset \tmp, [\addr]"
+alt_lse "  orr	\tmp, \tmp, #(1 << \bitnum)",	"nop"
+alt_lse "  stxr \wtmp, \tmp, [\addr]",		"nop"
+alt_lse "  cbnz	\wtmp, 8b",			"nop"
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.14.2
