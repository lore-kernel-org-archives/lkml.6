Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeEDMeK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:34:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18914 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeEDMeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:34:08 -0400
Message-Id: <a0ebf1e63f280dd928797c4e68e2cf21670a1bb6.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  08/17] powerpc: make __iounmap() common to PPC32 and PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes __iounmap() common to PPC32 and PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ioremap.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 153657db084e..65d611d44d38 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -120,20 +120,6 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
 
-void __iounmap(volatile void __iomem *addr)
-{
-	/*
-	 * If mapped by BATs then there is nothing to do.
-	 * Calling vfree() generates a benign warning.
-	 */
-	if (v_block_mapped((unsigned long)addr))
-		return;
-
-	if ((unsigned long) addr >= ioremap_bot)
-		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
-}
-EXPORT_SYMBOL(__iounmap);
-
 #else
 
 /**
@@ -225,6 +211,8 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
+#endif
+
 /*
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
@@ -238,6 +226,14 @@ void __iounmap(volatile void __iomem *token)
 
 	addr = (void *) ((unsigned long __force)
 			 PCI_FIX_ADDR(token) & PAGE_MASK);
+
+	/*
+	 * If mapped by BATs then there is nothing to do.
+	 * Calling vfree() generates a benign warning.
+	 */
+	if (v_block_mapped((unsigned long)addr))
+		return;
+
 	if ((unsigned long)addr < ioremap_bot) {
 		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
 		       " at 0x%p\n", addr);
@@ -247,8 +243,6 @@ void __iounmap(volatile void __iomem *token)
 }
 EXPORT_SYMBOL(__iounmap);
 
-#endif
-
 void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 			 unsigned long flags)
 {
-- 
2.13.3
