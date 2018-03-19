Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755571AbeCSOWQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:22:16 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:19287 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbeCSOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:22:11 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Date: Mon, 19 Mar 2018 19:50:35 +0530
Message-Id: <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use VMOVDQU AVX CPU instruction when available to do 256-bit
IO read and write.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 arch/x86/include/asm/io.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 95e948627fd0..b04f417b3374 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -109,7 +109,62 @@ build_mmio_write(__writeq, "q", unsigned long, "r", )
 #define readq			readq
 #define writeq			writeq
 
-#endif
+#ifdef CONFIG_AS_AVX
+#include <asm/fpu/api.h>
+
+static inline u256 __readqq(const volatile void __iomem *addr)
+{
+	u256 ret;
+
+	kernel_fpu_begin();
+	asm volatile("vmovdqu %0, %%ymm0" :
+		     : "m" (*(volatile u256 __force *)addr));
+	asm volatile("vmovdqu %%ymm0, %0" : "=m" (ret));
+	kernel_fpu_end();
+	return ret;
+}
+
+static inline u256 readqq(const volatile void __iomem *addr)
+{
+	u256 ret;
+
+	kernel_fpu_begin();
+	asm volatile("vmovdqu %0, %%ymm0" :
+		     : "m" (*(volatile u256 __force *)addr));
+	asm volatile("vmovdqu %%ymm0, %0" : "=m" (ret) : : "memory");
+	kernel_fpu_end();
+	return ret;
+}
+
+#define __raw_readqq __readqq
+#define readqq_relaxed(a) __readqq(a)
+#define readqq readqq
+
+static inline void __writeqq(u256 val, volatile void __iomem *addr)
+{
+	kernel_fpu_begin();
+	asm volatile("vmovdqu %0, %%ymm0" : : "m" (val));
+	asm volatile("vmovdqu %%ymm0, %0"
+		     : "=m" (*(volatile u256 __force *)addr));
+	kernel_fpu_end();
+}
+
+static inline void writeqq(u256 val, volatile void __iomem *addr)
+{
+	kernel_fpu_begin();
+	asm volatile("vmovdqu %0, %%ymm0" : : "m" (val));
+	asm volatile("vmovdqu %%ymm0, %0"
+		     : "=m" (*(volatile u256 __force *)addr)
+		     : : "memory");
+	kernel_fpu_end();
+}
+
+#define __raw_writeqq __writeqq
+#define writeqq_relaxed(a) __writeqq(a)
+#define writeqq writeqq
+#endif /* CONFIG_AS_AVX */
+
+#endif /* CONFIG_X86_64 */
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
-- 
2.14.1
