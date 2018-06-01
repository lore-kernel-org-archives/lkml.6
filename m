Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeFAQGD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:06:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbeFAQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:00 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/9] m68k: Don't use asm-generic/bitops/lock.h
Date: Fri,  1 Jun 2018 17:06:22 +0100
Message-Id: <1527869189-31512-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/bitops/lock.h is shortly going to be built on top of the
atomic_long_* API, which introduces a nasty circular dependency for
m68k where linux/atomic.h pulls in linux/bitops.h via:

	linux/atomic.h
	asm/atomic.h
	linux/irqflags.h
	asm/irqflags.h
	linux/preempt.h
	asm/preempt.h
	asm-generic/preempt.h
	linux/thread_info.h
	asm/thread_info.h
	asm/page.h
	asm-generic/getorder.h
	linux/log2.h
	linux/bitops.h

Since m68k isn't SMP and doesn't support ACQUIRE/RELEASE barriers, we
can just define the lock bitops in terms of the atomic bitops in the
asm/bitops.h header.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m68k/include/asm/bitops.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 93b47b1f6fb4..18193419f97d 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -515,12 +515,16 @@ static inline int __fls(int x)
 
 #endif
 
+/* Simple test-and-set bit locks */
+#define test_and_set_bit_lock	test_and_set_bit
+#define clear_bit_unlock	clear_bit
+#define __clear_bit_unlock	clear_bit_unlock
+
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
-#include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_BITOPS_H */
-- 
2.1.4
