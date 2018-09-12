Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD3ECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B0D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B0D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeILVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:03:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35289 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeILVD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:03:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RJn2lLMz9ttRV;
        Wed, 12 Sep 2018 17:58:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Et80psxdjkw0; Wed, 12 Sep 2018 17:58:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RJn2BjQz9ttBm;
        Wed, 12 Sep 2018 17:58:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 351B18B858;
        Wed, 12 Sep 2018 17:58:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1By0tlulpOB5; Wed, 12 Sep 2018 17:58:17 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F07F98B873;
        Wed, 12 Sep 2018 17:58:15 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B245071913; Wed, 12 Sep 2018 15:58:15 +0000 (UTC)
Message-Id: <1ac1795d39315628744604df233b4cddf50535eb.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/24] powerpc/32: Add ioremap_wt() and ioremap_coherent()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Wed, 12 Sep 2018 15:58:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other arches have ioremap_wt() to map IO areas write-through.
Implement it on PPC as well in order to avoid drivers using
__ioremap(_PAGE_WRITETHRU)

Also implement ioremap_coherent() to avoid drivers using
__ioremap(_PAGE_COHERENT)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io.h |  9 +++++++++
 arch/powerpc/mm/pgtable_32.c  | 16 ++++++++++++++++
 arch/powerpc/mm/pgtable_64.c  | 10 ++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e0331e754568..cdccab3938db 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -3,6 +3,9 @@
 #ifdef __KERNEL__
 
 #define ARCH_HAS_IOREMAP_WC
+#ifdef CONFIG_PPC32
+#define ARCH_HAS_IOREMAP_WT
+#endif
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -746,6 +749,10 @@ static inline void iosync(void)
  *
  * * ioremap_wc enables write combining
  *
+ * * ioremap_wt enables write through
+ *
+ * * ioremap_coherent maps coherent cached memory
+ *
  * * iounmap undoes such a mapping and can be hooked
  *
  * * __ioremap_at (and the pending __iounmap_at) are low level functions to
@@ -767,6 +774,8 @@ extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
 				  unsigned long flags);
 extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
+void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
+void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 #define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 120a49bfb9c6..4c3adde09d95 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -90,6 +90,22 @@ ioremap_wc(phys_addr_t addr, unsigned long size)
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
+ioremap_wt(phys_addr_t addr, unsigned long size)
+{
+	return __ioremap_caller(addr, size, _PAGE_WRITETHRU,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_wt);
+
+void __iomem *
+ioremap_coherent(phys_addr_t addr, unsigned long size)
+{
+	return __ioremap_caller(addr, size, _PAGE_COHERENT,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_coherent);
+
+void __iomem *
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	/* writeable implies dirty for kernel addresses */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 53e9eeecd5d4..cdccfac477e0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -222,6 +222,16 @@ void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 	return __ioremap_caller(addr, size, flags, caller);
 }
 
+void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
+{
+	unsigned long flags = pgprot_val(pgprot_cached(__pgprot(0)));
+	void *caller = __builtin_return_address(0);
+
+	if (ppc_md.ioremap)
+		return ppc_md.ioremap(addr, size, flags, caller);
+	return __ioremap_caller(addr, size, flags, caller);
+}
+
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
-- 
2.13.3

