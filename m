Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C0CC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04213206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04213206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJBRsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:48:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJBRsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:48:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2DCA7A9;
        Tue,  2 Oct 2018 04:05:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93D573F774;
        Tue,  2 Oct 2018 04:05:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7E2771AE402D; Tue,  2 Oct 2018 12:06:04 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org,
        sean.j.christopherson@intel.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 4/5] lib/ioremap: Ensure phys_addr actually corresponds to a physical address
Date:   Tue,  2 Oct 2018 12:06:02 +0100
Message-Id: <1538478363-16255-5-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1538478363-16255-1-git-send-email-will.deacon@arm.com>
References: <1538478363-16255-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ioremap() code uses a phys_addr variable at each level of
page table, which is confusingly offset by subtracting the base virtual
address being mapped so that adding the current virtual address back on
when iterating through the page table entries gives back the corresponding
physical address.

This is fairly confusing and results in all users of phys_addr having to
add the current virtual address back on. Instead, this patch just updates
phys_addr when iterating over the page table entries, ensuring that it's
always up-to-date and doesn't require explicit offsetting.

Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 lib/ioremap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 6c72764af19c..10d7c5485c39 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -101,19 +101,18 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 	pmd_t *pmd;
 	unsigned long next;
 
-	phys_addr -= addr;
 	pmd = pmd_alloc(&init_mm, pud, addr);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr + addr, prot))
+		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
 			continue;
 
-		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
+		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
+	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
@@ -142,19 +141,18 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 	pud_t *pud;
 	unsigned long next;
 
-	phys_addr -= addr;
 	pud = pud_alloc(&init_mm, p4d, addr);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
 
-		if (ioremap_try_huge_pud(pud, addr, next, phys_addr + addr, prot))
+		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot))
 			continue;
 
-		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
+		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
+	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
@@ -164,7 +162,6 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 	p4d_t *p4d;
 	unsigned long next;
 
-	phys_addr -= addr;
 	p4d = p4d_alloc(&init_mm, pgd, addr);
 	if (!p4d)
 		return -ENOMEM;
@@ -173,14 +170,14 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 
 		if (ioremap_p4d_enabled() &&
 		    ((next - addr) == P4D_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, P4D_SIZE)) {
-			if (p4d_set_huge(p4d, phys_addr + addr, prot))
+		    IS_ALIGNED(phys_addr, P4D_SIZE)) {
+			if (p4d_set_huge(p4d, phys_addr, prot))
 				continue;
 		}
 
-		if (ioremap_pud_range(p4d, addr, next, phys_addr + addr, prot))
+		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (p4d++, addr = next, addr != end);
+	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
@@ -196,14 +193,13 @@ int ioremap_page_range(unsigned long addr,
 	BUG_ON(addr >= end);
 
 	start = addr;
-	phys_addr -= addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr+addr, prot);
+		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot);
 		if (err)
 			break;
-	} while (pgd++, addr = next, addr != end);
+	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
 	flush_cache_vmap(start, end);
 
-- 
2.1.4

