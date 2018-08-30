Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B3A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B3A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeH3USm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:42 -0400
Received: from foss.arm.com ([217.140.101.70]:44822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3USl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6701684;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F34253F819;
        Thu, 30 Aug 2018 09:15:48 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3C3B11AE36A1; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 03/12] arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
Date:   Thu, 30 Aug 2018 17:15:37 +0100
Message-Id: <1535645747-9823-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that our walk-cache invalidation routines imply a DSB before the
invalidation, we no longer need one when we are clearing an entry during
unmap.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..2ab2031b778c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -360,6 +360,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
@@ -431,7 +432,9 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	WRITE_ONCE(*pmdp, pmd);
-	dsb(ishst);
+
+	if (pmd_valid(pmd))
+		dsb(ishst);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -477,11 +480,14 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#define pud_valid(pud)		pte_valid(pud_pte(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	WRITE_ONCE(*pudp, pud);
-	dsb(ishst);
+
+	if (pud_valid(pud))
+		dsb(ishst);
 }
 
 static inline void pud_clear(pud_t *pudp)
-- 
2.1.4

