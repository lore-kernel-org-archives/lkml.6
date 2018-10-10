Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31CF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31CF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJJXqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:46:14 -0400
Received: from foss.arm.com ([217.140.101.70]:54898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJXqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:46:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2B51688;
        Wed, 10 Oct 2018 09:23:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D7553F5B3;
        Wed, 10 Oct 2018 09:23:14 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 265EB1AE2D8E; Wed, 10 Oct 2018 17:23:13 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org,
        sean.j.christopherson@intel.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 5/5] lib/ioremap: Ensure break-before-make is used for huge p4d mappings
Date:   Wed, 10 Oct 2018 17:23:04 +0100
Message-Id: <1539188584-15819-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539188584-15819-1-git-send-email-will.deacon@arm.com>
References: <1539188584-15819-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst no architectures actually enable support for huge p4d mappings
in the vmap area, the code that is implemented should be using
break-before-make, as we do for pud and pmd huge entries.

Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c           |  5 +++++
 arch/x86/mm/pgtable.c         |  8 ++++++++
 include/asm-generic/pgtable.h |  5 +++++
 lib/ioremap.c                 | 27 +++++++++++++++++++++------
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0dcb3354d6dd..58776b90dd2a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1024,3 +1024,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pmd_free(NULL, table);
 	return 1;
 }
+
+int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+{
+	return 0;	/* Don't attempt a block mapping */
+}
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b4919c44a194..c6094997d060 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -779,6 +779,14 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+/*
+ * Until we support 512GB pages, skip them in the vmap area.
+ */
+int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+{
+	return 0;
+}
+
 #ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc6102c7c..4297a2519ebf 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1019,6 +1019,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
+int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
@@ -1046,6 +1047,10 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
+static inline int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+{
+	return 0;
+}
 static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 10d7c5485c39..063213685563 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -156,6 +156,25 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 	return 0;
 }
 
+static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
+				unsigned long end, phys_addr_t phys_addr,
+				pgprot_t prot)
+{
+	if (!ioremap_p4d_enabled())
+		return 0;
+
+	if ((end - addr) != P4D_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
+		return 0;
+
+	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+		return 0;
+
+	return p4d_set_huge(p4d, phys_addr, prot);
+}
+
 static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
@@ -168,12 +187,8 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 
-		if (ioremap_p4d_enabled() &&
-		    ((next - addr) == P4D_SIZE) &&
-		    IS_ALIGNED(phys_addr, P4D_SIZE)) {
-			if (p4d_set_huge(p4d, phys_addr, prot))
-				continue;
-		}
+		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot))
+			continue;
 
 		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
 			return -ENOMEM;
-- 
2.1.4

