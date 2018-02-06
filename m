Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeBFQwA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:52:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752870AbeBFQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:50:33 -0500
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v7 05/24] mm: Prepare for FAULT_FLAG_SPECULATIVE
Date: Tue,  6 Feb 2018 17:49:51 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020616-0020-0000-0000-000003F2EA9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020616-0021-0000-0000-0000428562AC
Message-Id: <1517935810-31177-6-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When speculating faults (without holding mmap_sem) we need to validate
that the vma against which we loaded pages is still valid when we're
ready to install the new PTE.

Therefore, replace the pte_offset_map_lock() calls that (re)take the
PTL with pte_map_lock() which can fail in case we find the VMA changed
since we started the fault.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[Port to 4.12 kernel]
[Remove the comment about the fault_env structure which has been
 implemented as the vm_fault structure in the kernel]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm.h |  1 +
 mm/memory.c        | 56 ++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 47c06fd20f6a..51d950cac772 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -302,6 +302,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
 #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
 #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
+#define FAULT_FLAG_SPECULATIVE	0x200	/* Speculative fault, not holding mmap_sem */
 
 #define FAULT_FLAG_TRACE \
 	{ FAULT_FLAG_WRITE,		"WRITE" }, \
diff --git a/mm/memory.c b/mm/memory.c
index 32b9eb77d95c..bb058527525a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2452,6 +2452,13 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 }
 
+static bool pte_map_lock(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	return true;
+}
+
 /*
  * Handle the case of a page which we actually need to copy to a new page.
  *
@@ -2479,6 +2486,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 	const unsigned long mmun_start = vmf->address & PAGE_MASK;
 	const unsigned long mmun_end = mmun_start + PAGE_SIZE;
 	struct mem_cgroup *memcg;
+	int ret = VM_FAULT_OOM;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
@@ -2506,7 +2514,11 @@ static int wp_page_copy(struct vm_fault *vmf)
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		mem_cgroup_cancel_charge(new_page, memcg, false);
+		ret = VM_FAULT_RETRY;
+		goto oom_free_new;
+	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
@@ -2598,7 +2610,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 oom:
 	if (old_page)
 		put_page(old_page);
-	return VM_FAULT_OOM;
+	return ret;
 }
 
 /**
@@ -2619,8 +2631,8 @@ static int wp_page_copy(struct vm_fault *vmf)
 int finish_mkwrite_fault(struct vm_fault *vmf)
 {
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
-	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
-				       &vmf->ptl);
+	if (!pte_map_lock(vmf))
+		return VM_FAULT_RETRY;
 	/*
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
@@ -2738,8 +2750,11 @@ static int do_wp_page(struct vm_fault *vmf)
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			lock_page(vmf->page);
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
+			if (!pte_map_lock(vmf)) {
+				unlock_page(vmf->page);
+				put_page(vmf->page);
+				return VM_FAULT_RETRY;
+			}
 			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
 				unlock_page(vmf->page);
 				pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -2967,8 +2982,10 @@ int do_swap_page(struct vm_fault *vmf)
 			 * Back out if somebody else faulted in this pte
 			 * while we released the pte lock.
 			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
+			if (!pte_map_lock(vmf)) {
+				delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+				return VM_FAULT_RETRY;
+			}
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
@@ -3024,8 +3041,11 @@ int do_swap_page(struct vm_fault *vmf)
 	/*
 	 * Back out if somebody else already faulted in this pte.
 	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		mem_cgroup_cancel_charge(page, memcg, false);
+		goto out_page;
+	}
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
 		goto out_nomap;
 
@@ -3154,8 +3174,8 @@ static int do_anonymous_page(struct vm_fault *vmf)
 			!mm_forbids_zeropage(vma->vm_mm)) {
 		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
 						vma->vm_page_prot));
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				vmf->address, &vmf->ptl);
+		if (!pte_map_lock(vmf))
+			return VM_FAULT_RETRY;
 		if (!pte_none(*vmf->pte))
 			goto unlock;
 		ret = check_stable_address_space(vma->vm_mm);
@@ -3190,8 +3210,11 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		mem_cgroup_cancel_charge(page, memcg, false);
+		put_page(page);
+		return VM_FAULT_RETRY;
+	}
 	if (!pte_none(*vmf->pte))
 		goto release;
 
@@ -3315,8 +3338,9 @@ static int pte_alloc_one_map(struct vm_fault *vmf)
 	 * pte_none() under vmf->ptl protection when we return to
 	 * alloc_set_pte().
 	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf))
+		return VM_FAULT_RETRY;
+
 	return 0;
 }
 
-- 
2.7.4
