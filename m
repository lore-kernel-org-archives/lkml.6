Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K8g3Iz9DGVvWBgAAmS7hNA
	; Thu, 07 Jun 2018 14:40:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98AF6608C8; Thu,  7 Jun 2018 14:40:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B4C3E602FC;
	Thu,  7 Jun 2018 14:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4C3E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934531AbeFGOkn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:36283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932912AbeFGOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="47542302"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 07:40:33 -0700
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
Subject: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and related functions
Date: Thu,  7 Jun 2018 07:37:02 -0700
Message-Id: <20180607143705.3531-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143705.3531-1-yu-cheng.yu@intel.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ptep_set_wrprotect()/huge_ptep_set_wrprotect() is
used by copy_page_range()/copy_hugetlb_page_range() to copy
PTEs.

On x86, when the shadow stack is enabled, only a shadow stack
PTE has the read-only and _PAGE_DIRTY_HW combination.  Upon
making a dirty PTE read-only, we move its _PAGE_DIRTY_HW to
_PAGE_DIRTY_SW.

When ptep_set_wrprotect() moves _PAGE_DIRTY_HW to _PAGE_DIRTY_SW,
if the PTE is writable and the mm is shared, another task could
race to set _PAGE_DIRTY_HW again.

Introduce ptep_set_wrprotect_flush(), pmdp_set_wrprotect_flush(),
and huge_ptep_set_wrprotect_flush() to make sure this does not
happen.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h | 56 +++++++++++++++++++++++++++++++++++-------
 include/asm-generic/pgtable.h  | 26 ++++++++++++++++++++
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0996f8a6979a..1053b940b35c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1148,11 +1148,27 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	return pte;
 }
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long addr, pte_t *ptep)
-{
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT_FLUSH
+extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
+			      unsigned long address,
+			      pte_t *ptep);
+static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep)
+{
+	bool rw;
+
+	rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+	if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
+		struct mm_struct *mm = vma->vm_mm;
+		pte_t pte;
+
+		if (rw && (atomic_read(&mm->mm_users) > 1))
+			pte = ptep_clear_flush(vma, addr, ptep);
+		else
+			pte = *ptep;
+		pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
+		set_pte_at(mm, addr, ptep, pte);
+	}
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
@@ -1198,11 +1214,33 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 	return native_pudp_get_and_clear(pudp);
 }
 
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm,
-				      unsigned long addr, pmd_t *pmdp)
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT_FLUSH
+static inline void huge_ptep_set_wrprotect_flush(struct vm_area_struct *vma,
+						 unsigned long addr, pte_t *ptep)
 {
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+	ptep_set_wrprotect_flush(vma, addr, ptep);
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT_FLUSH
+extern pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
+				   unsigned long address,
+				   pmd_t *pmdp);
+static inline void pmdp_set_wrprotect_flush(struct vm_area_struct *vma,
+					    unsigned long addr, pmd_t *pmdp)
+{	bool rw;
+
+	rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&pmdp);
+	if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
+		struct mm_struct *mm = vma->vm_mm;
+		pmd_t pmd;
+
+		if (rw && (atomic_read(&mm->mm_users) > 1))
+			pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
+		else
+			pmd = *pmdp;
+		pmd = pmd_move_flags(pmd, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
+		set_pmd_at(mm, addr, pmdp, pmd);
+	}
 }
 
 #define pud_write pud_write
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 3f6f998509f0..9bcfdfc045bb 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -121,6 +121,15 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT_FLUSH
+static inline void huge_ptep_set_wrorptect_flush(struct vm_area_struct *vma,
+						 unsigned long addr,
+						 pte_t *ptep)
+{
+	huge_ptep_set_wrprotect(vma->vm_mm, addr, ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
@@ -226,6 +235,15 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT_FLUSH
+static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pte_t *ptep)
+{
+	ptep_set_wrprotect(vma->vm_mm, address, ptep);
+}
+#endif
+
 #ifndef pte_savedwrite
 #define pte_savedwrite pte_write
 #endif
@@ -266,6 +284,14 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
+#ifndef __HAVE_ARCH_PMDP_SET_WRPROTECT_FLUSH
+static inline void pmdp_set_wrprotect_flush(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pmd_t *pmdp)
+{
+	pmdp_set_wrprotect(vma->vm_mm, address, pmdp);
+}
+#endif
 #ifndef __HAVE_ARCH_PUDP_SET_WRPROTECT
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline void pudp_set_wrprotect(struct mm_struct *mm,
-- 
2.15.1
