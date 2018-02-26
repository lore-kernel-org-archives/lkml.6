Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeBZPFJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:05:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbeBZPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:00 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 03/12] asm-generic: Move some macros from linux/bitops.h to a new bits.h file
Date: Mon, 26 Feb 2018 15:04:51 +0000
Message-Id: <1519657500-15094-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing the asm-generic atomic bitops in terms
of atomic_long_*, we need to prevent asm/atomic.h implementations from
pulling in linux/bitops.h. A common reason for this include is for the
BITS_PER_BYTE definition, so move this and some other BIT and masking
macros into a new header file, asm-generic/bits.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/bits.h | 26 ++++++++++++++++++++++++++
 include/linux/bitops.h     | 22 +---------------------
 2 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644 include/asm-generic/bits.h

diff --git a/include/asm-generic/bits.h b/include/asm-generic/bits.h
new file mode 100644
index 000000000000..738f8038440b
--- /dev/null
+++ b/include/asm-generic/bits.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_BITS_H
+#define __ASM_GENERIC_BITS_H
+#include <asm/bitsperlong.h>
+
+#define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
+#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE		8
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+#define GENMASK(h, l) \
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) - (1ULL << (l)) + 1) & \
+	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#endif	/* __ASM_GENERIC_BITS_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..57ba7f67b360 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -2,29 +2,9 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
 #include <asm/types.h>
+#include <asm-generic/bits.h>
 
-#ifdef	__KERNEL__
-#define BIT(nr)			(1UL << (nr))
-#define BIT_ULL(nr)		(1ULL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
-#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
-#define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
-#endif
-
-/*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
- * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
- */
-#define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
-
-#define GENMASK_ULL(h, l) \
-	(((~0ULL) - (1ULL << (l)) + 1) & \
-	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.1.4
