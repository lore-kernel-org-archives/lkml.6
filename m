Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NxrlC91DGVuzCwAAmS7hNA
	; Thu, 07 Jun 2018 14:40:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B5278608CA; Thu,  7 Jun 2018 14:40:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1D271607DC;
	Thu,  7 Jun 2018 14:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D271607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934564AbeFGOkt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:36283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934513AbeFGOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="47542315"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 07:40:34 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 9/9] x86/cet: Handle THP/HugeTLB shadow stack page copying
Date: Thu,  7 Jun 2018 07:37:05 -0700
Message-Id: <20180607143705.3531-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143705.3531-1-yu-cheng.yu@intel.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements THP shadow stack memory copying in the same
way as the previous patch for regular PTE.

In copy_huge_pmd(), we clear the dirty bit from the PMD.  On the
next shadow stack access to the PMD, a page fault occurs.  At
that time, the page is copied/re-used and the PMD is fixed.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/huge_memory.c | 10 +++++++++-
 mm/hugetlb.c     |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3a1815f8e11..c6e72ccc4274 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -600,6 +600,8 @@ static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		if (is_shstk_mapping(vma->vm_flags))
+			entry = pmd_mkdirty_shstk(entry);
 		page_add_new_anon_rmap(page, vma, haddr, true);
 		mem_cgroup_commit_charge(page, memcg, false, true);
 		lru_cache_add_active_or_unevictable(page, vma);
@@ -976,7 +978,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
+	pmdp_set_wrprotect_flush(vma, addr, src_pmd);
 	pmd = pmd_mkold(pmd_wrprotect(pmd));
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
@@ -1196,6 +1198,8 @@ static int do_huge_pmd_wp_page_fallback(struct vm_fault *vmf, pmd_t orig_pmd,
 		pte_t entry;
 		entry = mk_pte(pages[i], vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (is_shstk_mapping(vma->vm_flags))
+			entry = pte_mkdirty_shstk(entry);
 		memcg = (void *)page_private(pages[i]);
 		set_page_private(pages[i], 0);
 		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
@@ -1280,6 +1284,8 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		if (is_shstk_mapping(vma->vm_flags))
+			entry = pmd_mkdirty_shstk(entry);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry,  1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		ret |= VM_FAULT_WRITE;
@@ -1350,6 +1356,8 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		pmd_t entry;
 		entry = mk_huge_pmd(new_page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		if (is_shstk_mapping(vma->vm_flags))
+			entry = pmd_mkdirty_shstk(entry);
 		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 218679138255..d694cfab9f90 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3293,7 +3293,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 *
 				 * See Documentation/vm/mmu_notifier.txt
 				 */
-				huge_ptep_set_wrprotect(src, addr, src_pte);
+				huge_ptep_set_wrprotect_flush(vma, addr, src_pte);
 			}
 			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
-- 
2.15.1
