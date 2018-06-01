Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeFAQGr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:06:47 -0400
Received: from foss.arm.com ([217.140.101.70]:55034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeFAQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:01 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 8/9] arm64: Replace our atomic/lock bitop implementations with asm-generic
Date: Fri,  1 Jun 2018 17:06:28 +0100
Message-Id: <1527869189-31512-9-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic/bitops/{atomic,lock}.h implementations are built around
the atomic-fetch ops, which we implement efficiently for both LSE and
LL/SC systems. Use that instead of our hand-rolled, out-of-line bitops.S.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/bitops.h | 14 ++------
 arch/arm64/lib/Makefile         |  2 +-
 arch/arm64/lib/bitops.S         | 76 -----------------------------------------
 3 files changed, 3 insertions(+), 89 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S

diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 9c19594ce7cb..13501460be6b 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -17,22 +17,11 @@
 #define __ASM_BITOPS_H
 
 #include <linux/compiler.h>
-#include <asm/barrier.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
 #endif
 
-/*
- * Little endian assembly atomic bitops.
- */
-extern void set_bit(int nr, volatile unsigned long *p);
-extern void clear_bit(int nr, volatile unsigned long *p);
-extern void change_bit(int nr, volatile unsigned long *p);
-extern int test_and_set_bit(int nr, volatile unsigned long *p);
-extern int test_and_clear_bit(int nr, volatile unsigned long *p);
-extern int test_and_change_bit(int nr, volatile unsigned long *p);
-
 #include <asm-generic/bitops/builtin-__ffs.h>
 #include <asm-generic/bitops/builtin-ffs.h>
 #include <asm-generic/bitops/builtin-__fls.h>
@@ -44,8 +33,9 @@ extern int test_and_change_bit(int nr, volatile unsigned long *p);
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
-#include <asm-generic/bitops/lock.h>
 
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
 
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 137710f4dac3..68755fd70dcf 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
+lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
diff --git a/arch/arm64/lib/bitops.S b/arch/arm64/lib/bitops.S
deleted file mode 100644
index 43ac736baa5b..000000000000
--- a/arch/arm64/lib/bitops.S
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * Based on arch/arm/lib/bitops.h
- *
- * Copyright (C) 2013 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/lse.h>
-
-/*
- * x0: bits 5:0  bit offset
- *     bits 31:6 word offset
- * x1: address
- */
-	.macro	bitop, name, llsc, lse
-ENTRY(	\name	)
-	and	w3, w0, #63		// Get bit offset
-	eor	w0, w0, w3		// Clear low bits
-	mov	x2, #1
-	add	x1, x1, x0, lsr #3	// Get word offset
-alt_lse "	prfm	pstl1strm, [x1]",	"nop"
-	lsl	x3, x2, x3		// Create mask
-
-alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x3, [x1]"
-alt_lse	"	\llsc	x2, x2, x3",		"nop"
-alt_lse	"	stxr	w0, x2, [x1]",		"nop"
-alt_lse	"	cbnz	w0, 1b",		"nop"
-
-	ret
-ENDPROC(\name	)
-	.endm
-
-	.macro	testop, name, llsc, lse
-ENTRY(	\name	)
-	and	w3, w0, #63		// Get bit offset
-	eor	w0, w0, w3		// Clear low bits
-	mov	x2, #1
-	add	x1, x1, x0, lsr #3	// Get word offset
-alt_lse "	prfm	pstl1strm, [x1]",	"nop"
-	lsl	x4, x2, x3		// Create mask
-
-alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x4, x2, [x1]"
-	lsr	x0, x2, x3
-alt_lse	"	\llsc	x2, x2, x4",		"nop"
-alt_lse	"	stlxr	w5, x2, [x1]",		"nop"
-alt_lse	"	cbnz	w5, 1b",		"nop"
-alt_lse	"	dmb	ish",			"nop"
-
-	and	x0, x0, #1
-	ret
-ENDPROC(\name	)
-	.endm
-
-/*
- * Atomic bit operations.
- */
-	bitop	change_bit, eor, steor
-	bitop	clear_bit, bic, stclr
-	bitop	set_bit, orr, stset
-
-	testop	test_and_change_bit, eor, ldeoral
-	testop	test_and_clear_bit, bic, ldclral
-	testop	test_and_set_bit, orr, ldsetal
-- 
2.1.4
