Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F133C208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F133C208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeH0T5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:57:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61292 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0T5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:57:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41zcKx5l1Dz9ttmB;
        Mon, 27 Aug 2018 18:10:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z5Z4VXzDONDU; Mon, 27 Aug 2018 18:10:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41zcKx55ckz9ttlx;
        Mon, 27 Aug 2018 18:10:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38A808B7D5;
        Mon, 27 Aug 2018 18:10:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iqIGGyOCWWh3; Mon, 27 Aug 2018 18:10:22 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4C3A8B7D1;
        Mon, 27 Aug 2018 18:10:21 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B51F8711E6; Mon, 27 Aug 2018 16:10:21 +0000 (UTC)
Message-Id: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] powerpc/32: Add ioremap_wt()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Mon, 27 Aug 2018 16:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other arches have ioremap_wt() to map IO areas write-through.
Implement it on PPC as well in order to avoid drivers using
__ioremap(_PAGE_WRITETHRU)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: no change

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
index 120a49bfb9c6..528999738645 100644
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
 	/* writeable implies dirty for kernel addresses */
-- 
2.13.3

