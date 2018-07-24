Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BB8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E0220880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E0220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeGXNRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:17:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:7043 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388287AbeGXNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="218637834"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2018 05:11:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E38F122B; Tue, 24 Jul 2018 15:11:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 2/3] mm: Use vma_init() to initialize VMAs on stack and data segments
Date:   Tue, 24 Jul 2018 15:11:38 +0300
Message-Id: <20180724121139.62570-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to initialize all VMAs properly, not only which comes from
vm_area_cachep.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/arm/kernel/process.c    | 1 +
 arch/arm/mach-rpc/ecard.c    | 2 +-
 arch/arm64/include/asm/tlb.h | 4 +++-
 arch/arm64/mm/hugetlbpage.c  | 7 +++++--
 arch/ia64/include/asm/tlb.h  | 2 +-
 arch/ia64/mm/init.c          | 2 +-
 arch/x86/um/mem_32.c         | 2 +-
 fs/hugetlbfs/inode.c         | 2 ++
 mm/mempolicy.c               | 1 +
 mm/shmem.c                   | 1 +
 10 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 225d1c58d2de..d9c299133111 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -338,6 +338,7 @@ static struct vm_area_struct gate_vma = {
 
 static int __init gate_vma_init(void)
 {
+	vma_init(&gate_vma, NULL);
 	gate_vma.vm_page_prot = PAGE_READONLY_EXEC;
 	return 0;
 }
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 39aef4876ed4..8db62cc54a6a 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -237,8 +237,8 @@ static void ecard_init_pgtables(struct mm_struct *mm)
 
 	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
 
+	vma_init(&vma, mm);
 	vma.vm_flags = VM_EXEC;
-	vma.vm_mm = mm;
 
 	flush_tlb_range(&vma, IO_START, IO_START + IO_SIZE);
 	flush_tlb_range(&vma, EASI_START, EASI_START + EASI_SIZE);
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index ffdaea7954bb..d87f2d646caa 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -37,7 +37,9 @@ static inline void __tlb_remove_table(void *_table)
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	struct vm_area_struct vma = { .vm_mm = tlb->mm, };
+	struct vm_area_struct vma;
+
+	vma_init(&vma, tlb->mm);
 
 	/*
 	 * The ASID allocator will either invalidate the ASID or mark
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ecc6818191df..1854e49aa18a 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -108,11 +108,13 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	struct vm_area_struct vma = { .vm_mm = mm };
+	struct vm_area_struct vma;
 	pte_t orig_pte = huge_ptep_get(ptep);
 	bool valid = pte_valid(orig_pte);
 	unsigned long i, saddr = addr;
 
+	vma_init(&vma, mm);
+
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
 		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
 
@@ -145,9 +147,10 @@ static void clear_flush(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	struct vm_area_struct vma = { .vm_mm = mm };
+	struct vm_area_struct vma;
 	unsigned long i, saddr = addr;
 
+	vma_init(&vma, mm);
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 44f0ac0df308..db89e7306081 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -120,7 +120,7 @@ ia64_tlb_flush_mmu_tlbonly(struct mmu_gather *tlb, unsigned long start, unsigned
 		 */
 		struct vm_area_struct vma;
 
-		vma.vm_mm = tlb->mm;
+		vma_init(&vma, tlb->mm);
 		/* flush the address range from the tlb: */
 		flush_tlb_range(&vma, start, end);
 		/* now flush the virt. page-table area mapping the address range: */
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index bdb14a369137..e6c6dfd98de2 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -273,7 +273,7 @@ static struct vm_area_struct gate_vma;
 
 static int __init gate_vma_init(void)
 {
-	gate_vma.vm_mm = NULL;
+	vma_init(&gate_vma, NULL);
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
index 744afdc18cf3..56c44d865f7b 100644
--- a/arch/x86/um/mem_32.c
+++ b/arch/x86/um/mem_32.c
@@ -16,7 +16,7 @@ static int __init gate_vma_init(void)
 	if (!FIXADDR_USER_START)
 		return 0;
 
-	gate_vma.vm_mm = NULL;
+	vma_init(&gate_vma, NULL);
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d508c7844681..40d4c66c7751 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -411,6 +411,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	bool truncate_op = (lend == LLONG_MAX);
 
 	memset(&pseudo_vma, 0, sizeof(struct vm_area_struct));
+	vma_init(&pseudo_vma, current->mm);
 	pseudo_vma.vm_flags = (VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
 	pagevec_init(&pvec);
 	next = start;
@@ -595,6 +596,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	 * as input to create an allocation policy.
 	 */
 	memset(&pseudo_vma, 0, sizeof(struct vm_area_struct));
+	vma_init(&pseudo_vma, mm);
 	pseudo_vma.vm_flags = (VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
 	pseudo_vma.vm_file = file;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9ac49ef17b4e..01f1a14facc4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2505,6 +2505,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 
 		/* Create pseudo-vma that contains just the policy */
 		memset(&pvma, 0, sizeof(struct vm_area_struct));
+		vma_init(&pvma, NULL);
 		pvma.vm_end = TASK_SIZE;	/* policy covers entire file */
 		mpol_set_shared_policy(sp, &pvma, new); /* adds ref */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 2cab84403055..41b9bbf24e16 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1421,6 +1421,7 @@ static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
 {
 	/* Create a pseudo vma that just contains the policy */
 	memset(vma, 0, sizeof(*vma));
+	vma_init(vma, NULL);
 	/* Bias interleave by inode number to distribute better across nodes */
 	vma->vm_pgoff = index + info->vfs_inode.i_ino;
 	vma->vm_policy = mpol_shared_policy_lookup(&info->policy, index);
-- 
2.18.0

