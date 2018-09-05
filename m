Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48512C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35372077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35372077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIERHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36596 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeIERHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42539g50kNz9tvSc;
        Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3dwdG_DjUj03; Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42539g4MzJz9tvSC;
        Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFCF68B82D;
        Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TLwQHPGZXnhO; Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92EB28B82C;
        Wed,  5 Sep 2018 14:36:55 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 881427159B; Wed,  5 Sep 2018 12:36:55 +0000 (UTC)
Message-Id: <d078b40c8f5015611d983d229594a84e1e21d331.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 02/17] powerpc/mm: remove direct use of flags related
 to cache
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:36:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done for PPC64, use pgprot_cache() helpers
instead of flags in ioremap() derived functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h |  2 ++
 arch/powerpc/mm/pgtable_32.c              | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index b321c82b3624..5b82e44c4231 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -197,6 +197,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #if _PAGE_WRITETHRU != 0
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+#else
+#define pgprot_cached_wthru(prot)	pgprot_noncached(prot)
 #endif
 
 #define pgprot_cached_noncoherent(prot) \
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 528999738645..f983ffa24aa0 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -76,24 +76,27 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
 ioremap_wt(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_WRITETHRU,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_cached_wthru(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wt);
 
-- 
2.13.3

