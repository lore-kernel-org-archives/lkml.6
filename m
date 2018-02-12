Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932786AbeBLWhF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:37:05 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39062 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbeBLWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:37:04 -0500
X-Google-Smtp-Source: AH8x227tMN+Jydh3CZR9BNT4x9DGgBNCmAHjAipznS2/XXwGSBoNyvr5WruP/tCH66payG5SlHsw2w==
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Date: Mon, 12 Feb 2018 14:37:01 -0800
Message-Id: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
the i40e driver uses cmpxchg64(). This causes mips:allmodconfig builds
to fail with

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
	In function 'i40e_set_priv_flags':
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
	implicit declaration of function 'cmpxchg64'

Implement a poor-mans-version of cmpxchg64() to fix the problem for 32-bit
mips builds. The code is derived from sparc32, but only uses a single
spinlock.

Fixes: 60f481b970386 ("i40e: change flags to use 64 bits")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile-tested only.

 arch/mips/include/asm/cmpxchg.h |  3 +++
 arch/mips/kernel/cmpxchg.c      | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe..9f7b1df95b99 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -206,6 +206,9 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#else
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 #endif
 #endif
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index 0b9535bc2c53..30216beb2334 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/spinlock.h>
 #include <asm/cmpxchg.h>
 
 unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
@@ -107,3 +108,19 @@ unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 			return old;
 	}
 }
+
+static DEFINE_SPINLOCK(cmpxchg_lock);
+
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+{
+	unsigned long flags;
+	u64 prev;
+
+	spin_lock_irqsave(&cmpxchg_lock, flags);
+	if ((prev = *ptr) == old)
+		*ptr = new;
+	spin_unlock_irqrestore(&cmpxchg_lock, flags);
+
+	return prev;
+}
+EXPORT_SYMBOL(__cmpxchg_u64);
-- 
2.7.4
