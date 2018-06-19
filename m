Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A238C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24262075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24262075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937913AbeFSMwr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:47 -0400
Received: from foss.arm.com ([217.140.101.70]:49316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937849AbeFSMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47DAC15BF;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19E453F557;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id ABBBC1AE3638; Tue, 19 Jun 2018 13:53:15 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 3/9] asm-generic: Move some macros from linux/bitops.h to a new bits.h file
Date:   Tue, 19 Jun 2018 13:53:08 +0100
Message-Id: <1529412794-17720-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing the asm-generic atomic bitops in terms
of atomic_long_*, we need to prevent asm/atomic.h implementations from
pulling in linux/bitops.h. A common reason for this include is for the
BITS_PER_BYTE definition, so move this and some other BIT() and masking
macros into a new header file, linux/bits.h

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/bitops.h | 22 +---------------------
 include/linux/bits.h   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/bits.h

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..af419012d77d 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -2,29 +2,9 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
 #include <asm/types.h>
+#include <linux/bits.h>
 
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
diff --git a/include/linux/bits.h b/include/linux/bits.h
new file mode 100644
index 000000000000..2b7b532c1d51
--- /dev/null
+++ b/include/linux/bits.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BITS_H
+#define __LINUX_BITS_H
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
+#endif	/* __LINUX_BITS_H */
-- 
2.1.4

