Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EB8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF09C2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF09C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIERHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44810 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIERHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42539j5XMnz9tvSh;
        Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MO6EKjrUdOtj; Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42539j51NGz9tvSC;
        Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1B008B82B;
        Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hs3R70__fNQt; Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EFB88B762;
        Wed,  5 Sep 2018 14:36:57 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 90AC77159B; Wed,  5 Sep 2018 12:36:57 +0000 (UTC)
Message-Id: <b19dcca52787042f833e261dc4b829c21f52cd49.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 03/17] powerpc/mm: dont't use _PAGE_EXEC in book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:36:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3s/32 doesn't define _PAGE_EXEC, so no need to use it.

All other platforms define _PAGE_EXEC so no need to check
it is not NUL when not book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/mm/pgtable.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 751cf931bb3f..b6d3b25d255c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -234,7 +234,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   int psize)
 {
 	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
 	pte_update(ptep, clr, set);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d71c7777669c..4f788f3762a9 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -73,7 +73,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
 	return page;
 }
 
-#if defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0
+#ifdef CONFIG_PPC_BOOK3S
 
 /* Server-style MMU handles coherency when hashing if HW exec permission
  * is supposed per page (currently 64-bit only). If not, then, we always
@@ -106,7 +106,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return pte;
 }
 
-#else /* defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0 */
+#else /* CONFIG_PPC_BOOK3S */
 
 /* Embedded type MMU with HW exec support. This is a bit more complicated
  * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
@@ -179,7 +179,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return __pte(pte_val(pte) | _PAGE_EXEC);
 }
 
-#endif /* !(defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0) */
+#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * set_pte stores a linux PTE into the linux page table.
-- 
2.13.3

