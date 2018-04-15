Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDOVzE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:04 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24005 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeDOVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="339950784"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: Filippo Sironi <sironi@amazon.de>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 04/12] X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
Date: Sun, 15 Apr 2018 23:53:10 +0200
Message-Id: <1523829198-13236-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

cmpxchg_gpte() calls get_user_pages_fast() to retrieve the number of
pages and the respective struct page to map in the kernel virtual
address space.
This doesn't work if get_user_pages_fast() is invoked with a userspace
virtual address that's backed by PFNs outside of kernel reach (e.g., when
limiting the kernel memory with mem= in the command line and using
/dev/mem to map memory).

If get_user_pages_fast() fails, look up the VMA that back the userspace
virtual address, compute the PFN and the physical address, and map it in
the kernel virtual address space with memremap().

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/paging_tmpl.h | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6288e9d..31a37e4 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -141,15 +141,35 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	struct page *page;
 
 	npages = get_user_pages_fast((unsigned long)ptep_user, 1, 1, &page);
-	/* Check if the user is doing something meaningless. */
-	if (unlikely(npages != 1))
-		return -EFAULT;
-
-	table = kmap_atomic(page);
-	ret = CMPXCHG(&table[index], orig_pte, new_pte);
-	kunmap_atomic(table);
-
-	kvm_release_page_dirty(page);
+	if (likely(npages == 1)) {
+		table = kmap_atomic(page);
+		ret = CMPXCHG(&table[index], orig_pte, new_pte);
+		kunmap_atomic(table);
+
+		kvm_release_page_dirty(page);
+	} else {
+		struct vm_area_struct *vma;
+		unsigned long vaddr = (unsigned long)ptep_user & PAGE_MASK;
+		unsigned long pfn;
+		unsigned long paddr;
+
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
+		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
+			up_read(&current->mm->mmap_sem);
+			return -EFAULT;
+		}
+		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+		paddr = pfn << PAGE_SHIFT;
+		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
+		if (!table) {
+			up_read(&current->mm->mmap_sem);
+			return -EFAULT;
+		}
+		ret = CMPXCHG(&table[index], orig_pte, new_pte);
+		memunmap(table);
+		up_read(&current->mm->mmap_sem);
+	}
 
 	return (ret != orig_pte);
 }
-- 
2.7.4
