Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeDQOeJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:34:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753370AbeDQOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:34:06 -0400
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v10 06/25] mm: make pte_unmap_same compatible with SPF
Date: Tue, 17 Apr 2018 16:33:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0040-0000-0000-0000042FFFAB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0041-0000-0000-000026340AEF
Message-Id: <1523975611-15978-7-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap_same() is making the assumption that the page table are still
around because the mmap_sem is held.
This is no more the case when running a speculative page fault and
additional check must be made to ensure that the final page table are still
there.

This is now done by calling pte_spinlock() to check for the VMA's
consistency while locking for the page tables.

This is requiring passing a vm_fault structure to pte_unmap_same() which is
containing all the needed parameters.

As pte_spinlock() may fail in the case of a speculative page fault, if the
VMA has been touched in our back, pte_unmap_same() should now return 3
cases :
	1. pte are the same (0)
	2. pte are different (VM_FAULT_PTNOTSAME)
	3. a VMA's changes has been detected (VM_FAULT_RETRY)

The case 2 is handled by the introduction of a new VM_FAULT flag named
VM_FAULT_PTNOTSAME which is then trapped in cow_user_page().
If VM_FAULT_RETRY is returned, it is passed up to the callers to retry the
page fault while holding the mmap_sem.

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm.h |  1 +
 mm/memory.c        | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d1aff80669c..714da99d77a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1208,6 +1208,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 #define VM_FAULT_NEEDDSYNC  0x2000	/* ->fault did not modify page tables
 					 * and needs fsync() to complete (for
 					 * synchronous page faults in DAX) */
+#define VM_FAULT_PTNOTSAME 0x4000	/* Page table entries have changed */
 
 #define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
 			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
diff --git a/mm/memory.c b/mm/memory.c
index 0b9a51f80e0e..f86efcb8e268 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2309,21 +2309,29 @@ static inline bool pte_map_lock(struct vm_fault *vmf)
  * parts, do_swap_page must check under lock before unmapping the pte and
  * proceeding (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page can safely check later on).
+ *
+ * pte_unmap_same() returns:
+ *	0			if the PTE are the same
+ *	VM_FAULT_PTNOTSAME	if the PTE are different
+ *	VM_FAULT_RETRY		if the VMA has changed in our back during
+ *				a speculative page fault handling.
  */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-				pte_t *page_table, pte_t orig_pte)
+static inline int pte_unmap_same(struct vm_fault *vmf)
 {
-	int same = 1;
+	int ret = 0;
+
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(mm, pmd);
-		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
-		spin_unlock(ptl);
+		if (pte_spinlock(vmf)) {
+			if (!pte_same(*vmf->pte, vmf->orig_pte))
+				ret = VM_FAULT_PTNOTSAME;
+			spin_unlock(vmf->ptl);
+		} else
+			ret = VM_FAULT_RETRY;
 	}
 #endif
-	pte_unmap(page_table);
-	return same;
+	pte_unmap(vmf->pte);
+	return ret;
 }
 
 static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
@@ -2912,10 +2920,19 @@ int do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	int locked;
 	int exclusive = 0;
-	int ret = 0;
+	int ret;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	ret = pte_unmap_same(vmf);
+	if (ret) {
+		/*
+		 * If pte != orig_pte, this means another thread did the
+		 * swap operation in our back.
+		 * So nothing else to do.
+		 */
+		if (ret == VM_FAULT_PTNOTSAME)
+			ret = 0;
 		goto out;
+	}
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
-- 
2.7.4
