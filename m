Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94752173A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94752173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeHXNiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:38:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7942 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeHXNiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:38:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41xcMm5fMLz9tvh4;
        Fri, 24 Aug 2018 12:04:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NwKr4AYFzsMt; Fri, 24 Aug 2018 12:04:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41xcMm57ZSz9tvgt;
        Fri, 24 Aug 2018 12:04:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 809CC8B8D7;
        Fri, 24 Aug 2018 12:04:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8IXHqGloburG; Fri, 24 Aug 2018 12:04:55 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AB5D8B74C;
        Fri, 24 Aug 2018 12:04:55 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 20C5C714EE; Fri, 24 Aug 2018 10:04:55 +0000 (UTC)
Message-Id: <4f905a9d9752768c628623276f5e2fb465c947c8.1535104490.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc/32: Add ioremap_wt()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Fri, 24 Aug 2018 10:04:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other arches have ioremap_wt() to map IO areas write-through.
Implement it on PPC as well in order to avoid drivers using
__ioremap(_PAGE_WRITETHRU)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io.h | 6 ++++++
 arch/powerpc/mm/pgtable_32.c  | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e0331e754568..3380b5b22450 100644
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
@@ -746,6 +749,8 @@ static inline void iosync(void)
  *
  * * ioremap_wc enables write combining
  *
+ * * ioremap_wt enables write through
+ *
  * * iounmap undoes such a mapping and can be hooked
  *
  * * __ioremap_at (and the pending __iounmap_at) are low level functions to
@@ -767,6 +772,7 @@ extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
 				  unsigned long flags);
 extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
+void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 #define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2bbc22384f78..b2e73e82f8fc 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -90,6 +90,14 @@ ioremap_wc(phys_addr_t addr, unsigned long size)
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
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	pte_t pte = __pte(flags);
-- 
2.13.3

