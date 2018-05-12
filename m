Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeELGfk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 02:35:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45451 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 02:35:39 -0400
X-Google-Smtp-Source: AB8JxZrXnpCPqAEQMMvefpJy/REAMynDePaXDZ6PtaGZG1T96aS8zex/Ng5I1GLD7VtvU0lQT7DMoA==
Date: Sat, 12 May 2018 12:07:46 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: joe@perches.com, akpm@linux-foundation.org, mhocko@suse.com,
        hughd@google.com, dan.j.williams@intel.com, rientjes@google.com,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v4] mm: Change return type to vm_fault_t
Message-ID: <20180512063745.GA26866@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

commit 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/mm_types.h | 6 +++---
 mm/hugetlb.c             | 2 +-
 mm/mmap.c                | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2161234..cde40e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -627,9 +627,9 @@ struct vm_special_mapping {
 	 * If non-NULL, then this is called to resolve page faults
 	 * on the special mapping.  If used, .pages is not checked.
 	 */
-	int (*fault)(const struct vm_special_mapping *sm,
-		     struct vm_area_struct *vma,
-		     struct vm_fault *vmf);
+	vm_fault_t (*fault)(const struct vm_special_mapping *sm,
+				struct vm_area_struct *vma,
+				struct vm_fault *vmf);
 
 	int (*mremap)(const struct vm_special_mapping *sm,
 		     struct vm_area_struct *new_vma);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2186791..7e00bd3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3159,7 +3159,7 @@ static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
  * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
  * this far.
  */
-static int hugetlb_vm_op_fault(struct vm_fault *vmf)
+static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 {
 	BUG();
 	return 0;
diff --git a/mm/mmap.c b/mm/mmap.c
index 188f195..bdd4ba9a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3228,7 +3228,7 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->data_vm += npages;
 }
 
-static int special_mapping_fault(struct vm_fault *vmf);
+static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
 
 /*
  * Having a close hook prevents vma merging regardless of flags.
@@ -3267,7 +3267,7 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma)
 	.fault = special_mapping_fault,
 };
 
-static int special_mapping_fault(struct vm_fault *vmf)
+static vm_fault_t special_mapping_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pgoff_t pgoff;
-- 
1.9.1
