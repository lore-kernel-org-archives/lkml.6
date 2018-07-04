Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973E520878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973E520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeGDTkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:40:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeGDTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:40:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w64JeNRX785341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Jul 2018 12:40:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w64JeNRL785338;
        Wed, 4 Jul 2018 12:40:23 -0700
Date:   Wed, 4 Jul 2018 12:40:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chintan Pandya <tipbot@zytor.com>
Message-ID: <tip-785a19f9d1dd8a4ab2d0633be4656653bd3de1fc@git.kernel.org>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        will.deacon@arm.com, mhocko@suse.com, hpa@zytor.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, toshi.kani@hpe.com, cpandya@codeaurora.org
Reply-To: joro@8bytes.org, hpa@zytor.com, stable@vger.kernel.org,
          toshi.kani@hpe.com, cpandya@codeaurora.org,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          tglx@linutronix.de, mingo@kernel.org, will.deacon@arm.com,
          mhocko@suse.com
In-Reply-To: <20180627141348.21777-3-toshi.kani@hpe.com>
References: <20180627141348.21777-3-toshi.kani@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] ioremap: Update pgtable free interfaces with addr
Git-Commit-ID: 785a19f9d1dd8a4ab2d0633be4656653bd3de1fc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  785a19f9d1dd8a4ab2d0633be4656653bd3de1fc
Gitweb:     https://git.kernel.org/tip/785a19f9d1dd8a4ab2d0633be4656653bd3de1fc
Author:     Chintan Pandya <cpandya@codeaurora.org>
AuthorDate: Wed, 27 Jun 2018 08:13:47 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 4 Jul 2018 21:37:08 +0200

ioremap: Update pgtable free interfaces with addr

The following kernel panic was observed on ARM64 platform due to a stale
TLB entry.

 1. ioremap with 4K size, a valid pte page table is set.
 2. iounmap it, its pte entry is set to 0.
 3. ioremap the same address with 2M size, update its pmd entry with
    a new value.
 4. CPU may hit an exception because the old pmd entry is still in TLB,
    which leads to a kernel panic.

Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table") has addressed this panic by falling to pte mappings in the above
case on ARM64.

To support pmd mappings in all cases, TLB purge needs to be performed
in this case on ARM64.

Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
so that TLB purge can be added later in seprate patches.

[toshi.kani@hpe.com: merge changes, rewrite patch description]
Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: mhocko@suse.com
Cc: akpm@linux-foundation.org
Cc: hpa@zytor.com
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20180627141348.21777-3-toshi.kani@hpe.com

---
 arch/arm64/mm/mmu.c           |  4 ++--
 arch/x86/mm/pgtable.c         | 12 +++++++-----
 include/asm-generic/pgtable.h |  8 ++++----
 lib/ioremap.c                 |  4 ++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 493ff75670ff..8ae5d7ae4af3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -977,12 +977,12 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
 
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1aeb7a5dbce5..fbd14e506758 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -723,11 +723,12 @@ int pmd_clear_huge(pmd_t *pmd)
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
+ * @addr: Virtual address associated with pud.
  *
  * Context: The pud range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd;
 	int i;
@@ -738,7 +739,7 @@ int pud_free_pmd_page(pud_t *pud)
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
 
 	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i]))
+		if (!pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE)))
 			return 0;
 
 	pud_clear(pud);
@@ -750,11 +751,12 @@ int pud_free_pmd_page(pud_t *pud)
 /**
  * pmd_free_pte_page - Clear pmd entry and free pte page.
  * @pmd: Pointer to a PMD.
+ * @addr: Virtual address associated with pmd.
  *
  * Context: The pmd range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
@@ -770,7 +772,7 @@ int pmd_free_pte_page(pmd_t *pmd)
 
 #else /* !CONFIG_X86_64 */
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
@@ -779,7 +781,7 @@ int pud_free_pmd_page(pud_t *pud)
  * Disable free page handling on x86-PAE. This assures that ioremap()
  * does not update sync'd pmd entries. See vmalloc_sync_one().
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639afaa39..b081794ba135 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1019,8 +1019,8 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-int pud_free_pmd_page(pud_t *pud);
-int pmd_free_pte_page(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud, unsigned long addr);
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1046,11 +1046,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
-static inline int pud_free_pmd_page(pud_t *pud)
+static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
 }
-static inline int pmd_free_pte_page(pmd_t *pmd)
+static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return 0;
 }
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bbaa3200..517f5853ffed 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -92,7 +92,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd)) {
+		    pmd_free_pte_page(pmd, addr)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -119,7 +119,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud)) {
+		    pud_free_pmd_page(pud, addr)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
