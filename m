Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40596ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB51721568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51721568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbeIUU7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:59:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:27306 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390298AbeIUU6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 08:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="71856577"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 08:08:50 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v4 16/27] mm: Update can_follow_write_pte/pmd for shadow stack
Date:   Fri, 21 Sep 2018 08:03:40 -0700
Message-Id: <20180921150351.20898-17-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921150351.20898-1-yu-cheng.yu@intel.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can_follow_write_pte/pmd look for the (RO & DIRTY) PTE/PMD to
verify an exclusive RO page still exists after a broken COW.

A shadow stack PTE is RO & PAGE_DIRTY_SW when it is shared,
otherwise RO & PAGE_DIRTY_HW.

Introduce pte_exclusive() and pmd_exclusive() to also verify a
shadow stack PTE is exclusive.

Also rename can_follow_write_pte/pmd() to can_follow_write() to
make their meaning clear; i.e. "Can we write to the page?", not
"Is the PTE writable?"

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/mm/pgtable.c         | 19 +++++++++++++++++++
 include/asm-generic/pgtable.h |  4 ++++
 mm/gup.c                      |  8 +++++---
 mm/huge_memory.c              |  8 +++++---
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ccdfd3dd7163..e13a020e37db 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -894,4 +894,23 @@ inline bool arch_copy_pte_mapping(vm_flags_t vm_flags)
 {
 	return (vm_flags & VM_SHSTK);
 }
+
+inline bool pte_exclusive(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHSTK)
+		return pte_dirty_hw(pte);
+	else
+		return pte_dirty(pte);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+inline bool pmd_exclusive(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHSTK)
+		return pmd_dirty_hw(pmd);
+	else
+		return pmd_dirty(pmd);
+}
+#endif
+
 #endif /* CONFIG_X86_INTEL_SHADOW_STACK_USER */
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index a91f07454ced..6223017929be 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1131,10 +1131,14 @@ static inline bool arch_has_pfn_modify_check(void)
 #define pte_set_vma_features(pte, vma) pte
 #define pmd_set_vma_features(pmd, vma) pmd
 #define arch_copy_pte_mapping(vma_flags) false
+#define pte_exclusive(pte, vma) pte_dirty(pte)
+#define pmd_exclusive(pmd, vma) pmd_dirty(pmd)
 #else
 inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma);
 inline pmd_t pmd_set_vma_features(pmd_t pmd, struct vm_area_struct *vma);
 bool arch_copy_pte_mapping(vm_flags_t vm_flags);
+bool pte_exclusive(pte_t pte, struct vm_area_struct *vma);
+bool pmd_exclusive(pmd_t pmd, struct vm_area_struct *vma);
 #endif
 
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..03cb2e331f80 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -64,10 +64,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
+static inline bool can_follow_write(pte_t pte, unsigned int flags,
+				    struct vm_area_struct *vma)
 {
 	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+		((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
+		 pte_exclusive(pte, vma));
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -105,7 +107,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	if ((flags & FOLL_WRITE) && !can_follow_write(pte, flags, vma)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index df39ae20fe40..c70aa8fa4cb2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1387,10 +1387,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
  * FOLL_FORCE can write to even unwritable pmd's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
+static inline bool can_follow_write(pmd_t pmd, unsigned int flags,
+				    struct vm_area_struct *vma)
 {
 	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
+		pmd_exclusive(pmd, vma));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
@@ -1403,7 +1405,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	if (flags & FOLL_WRITE && !can_follow_write(*pmd, flags, vma))
 		goto out;
 
 	/* Avoid dumping huge zero page */
-- 
2.17.1

