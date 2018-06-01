Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeFAQGG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:06:06 -0400
Received: from foss.arm.com ([217.140.101.70]:54960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbeFAQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:00 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 1/9] h8300: Don't include linux/kernel.h in asm/atomic.h
Date: Fri,  1 Jun 2018 17:06:21 +0100
Message-Id: <1527869189-31512-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/kernel.h isn't needed by asm/atomic.h and will result in circular
dependencies when the asm-generic atomic bitops are built around the
tomic_long_t interface.

Remove the broad include and replace it with linux/compiler.h for
READ_ONCE etc and asm/irqflags.h for arch_local_irq_save etc.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/h8300/include/asm/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index 941e7554e886..b174dec099bf 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -2,8 +2,10 @@
 #ifndef __ARCH_H8300_ATOMIC__
 #define __ARCH_H8300_ATOMIC__
 
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
+#include <asm/irqflags.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -15,8 +17,6 @@
 #define atomic_read(v)		READ_ONCE((v)->counter)
 #define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
-#include <linux/kernel.h>
-
 #define ATOMIC_OP_RETURN(op, c_op)				\
 static inline int atomic_##op##_return(int i, atomic_t *v)	\
 {								\
-- 
2.1.4
