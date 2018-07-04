Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5C520878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5C520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeGDTlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:41:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:41:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w64Jerkr785387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Jul 2018 12:40:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w64Jer0f785384;
        Wed, 4 Jul 2018 12:40:53 -0700
Date:   Wed, 4 Jul 2018 12:40:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Toshi Kani <tipbot@zytor.com>
Message-ID: <tip-5e0fb5df2ee871b841f96f9cb6a7f2784e96aa4e@git.kernel.org>
Cc:     stable@vger.kernel.org, toshi.kani@hpe.com, mingo@kernel.org,
        mhocko@suse.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        joro@8bytes.org
Reply-To: stable@vger.kernel.org, toshi.kani@hpe.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, mhocko@suse.com,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          joro@8bytes.org
In-Reply-To: <20180627141348.21777-4-toshi.kani@hpe.com>
References: <20180627141348.21777-4-toshi.kani@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Add TLB purge to free pmd/pte page interfaces
Git-Commit-ID: 5e0fb5df2ee871b841f96f9cb6a7f2784e96aa4e
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

Commit-ID:  5e0fb5df2ee871b841f96f9cb6a7f2784e96aa4e
Gitweb:     https://git.kernel.org/tip/5e0fb5df2ee871b841f96f9cb6a7f2784e96aa4e
Author:     Toshi Kani <toshi.kani@hpe.com>
AuthorDate: Wed, 27 Jun 2018 08:13:48 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 4 Jul 2018 21:37:09 +0200

x86/mm: Add TLB purge to free pmd/pte page interfaces

ioremap() calls pud_free_pmd_page() / pmd_free_pte_page() when it creates
a pud / pmd map.  The following preconditions are met at their entry.
 - All pte entries for a target pud/pmd address range have been cleared.
 - System-wide TLB purges have been peformed for a target pud/pmd address
   range.

The preconditions assure that there is no stale TLB entry for the range.
Speculation may not cache TLB entries since it requires all levels of page
entries, including ptes, to have P & A-bits set for an associated address.
However, speculation may cache pud/pmd entries (paging-structure caches)
when they have P-bit set.

Add a system-wide TLB purge (INVLPG) to a single page after clearing
pud/pmd entry's P-bit.

SDM 4.10.4.1, Operation that Invalidate TLBs and Paging-Structure Caches,
states that:
  INVLPG invalidates all paging-structure caches associated with the
  current PCID regardless of the liner addresses to which they correspond.

Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: mhocko@suse.com
Cc: akpm@linux-foundation.org
Cc: hpa@zytor.com
Cc: cpandya@codeaurora.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20180627141348.21777-4-toshi.kani@hpe.com

---
 arch/x86/mm/pgtable.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index fbd14e506758..e3deefb891da 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -725,24 +725,44 @@ int pmd_clear_huge(pmd_t *pmd)
  * @pud: Pointer to a PUD.
  * @addr: Virtual address associated with pud.
  *
- * Context: The pud range has been unmaped and TLB purged.
+ * Context: The pud range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
+ *
+ * NOTE: Callers must allow a single page allocation.
  */
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	pmd_t *pmd;
+	pmd_t *pmd, *pmd_sv;
+	pte_t *pte;
 	int i;
 
 	if (pud_none(*pud))
 		return 1;
 
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
+	if (!pmd_sv)
+		return 0;
 
-	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE)))
-			return 0;
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd_sv[i] = pmd[i];
+		if (!pmd_none(pmd[i]))
+			pmd_clear(&pmd[i]);
+	}
 
 	pud_clear(pud);
+
+	/* INVLPG to clear all paging-structure caches */
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_none(pmd_sv[i])) {
+			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
+			free_page((unsigned long)pte);
+		}
+	}
+
+	free_page((unsigned long)pmd_sv);
 	free_page((unsigned long)pmd);
 
 	return 1;
@@ -753,7 +773,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
  * @pmd: Pointer to a PMD.
  * @addr: Virtual address associated with pmd.
  *
- * Context: The pmd range has been unmaped and TLB purged.
+ * Context: The pmd range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
@@ -765,6 +785,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	pte = (pte_t *)pmd_page_vaddr(*pmd);
 	pmd_clear(pmd);
+
+	/* INVLPG to clear all paging-structure caches */
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+
 	free_page((unsigned long)pte);
 
 	return 1;
