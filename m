Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD16C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58B72082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58B72082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeH3UTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:19:17 -0400
Received: from foss.arm.com ([217.140.101.70]:44854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeH3USm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B6C19BF;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B8ED23F738;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6900C1AE3719; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 06/12] arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
Date:   Thu, 30 Aug 2018 17:15:40 +0100
Message-Id: <1535645747-9823-7-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's one thing the RCU-based table freeing doesn't need, it's more
ifdeffery.

Remove the redundant !CONFIG_HAVE_RCU_TABLE_FREE code, since this option
is unconditionally selected in our Kconfig.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 1e1f68ce28f4..bd00017d529a 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -22,16 +22,10 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-
-#define tlb_remove_entry(tlb, entry)	tlb_remove_table(tlb, entry)
 static inline void __tlb_remove_table(void *_table)
 {
 	free_page_and_swap_cache((struct page *)_table);
 }
-#else
-#define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
 
 static void tlb_flush(struct mmu_gather *tlb);
 
@@ -61,7 +55,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
 	pgtable_page_dtor(pte);
-	tlb_remove_entry(tlb, pte);
+	tlb_remove_table(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -69,7 +63,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
-	tlb_remove_entry(tlb, virt_to_page(pmdp));
+	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
 
@@ -78,7 +72,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
-	tlb_remove_entry(tlb, virt_to_page(pudp));
+	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
 
-- 
2.1.4

