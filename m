Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758167AbeBPPaK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:30:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755852AbeBPP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:26:38 -0500
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
Subject: [PATCH v8 14/24] mm: Introduce __maybe_mkwrite()
Date: Fri, 16 Feb 2018 16:25:28 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021615-0020-0000-0000-000003F88152
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021615-0021-0000-0000-0000428C854B
Message-Id: <1518794738-4186-15-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802160183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current maybe_mkwrite() is getting passed the pointer to the vma
structure to fetch the vm_flags field.

When dealing with the speculative page fault handler, it will be better to
rely on the cached vm_flags value stored in the vm_fault structure.

This patch introduce a __maybe_mkwrite() service which can be called by
passing the value of the vm_flags field.

There is no change functional changes expected for the other callers of
maybe_mkwrite().

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm.h | 9 +++++++--
 mm/memory.c        | 6 +++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fd4eda5195b9..49f160e56a0f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -685,13 +685,18 @@ void free_compound_page(struct page *page);
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
  */
-static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+static inline pte_t __maybe_mkwrite(pte_t pte, unsigned long vma_flags)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_flags & VM_WRITE))
 		pte = pte_mkwrite(pte);
 	return pte;
 }
 
+static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	return __maybe_mkwrite(pte, vma->vm_flags);
+}
+
 int alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		struct page *page);
 int finish_fault(struct vm_fault *vmf);
diff --git a/mm/memory.c b/mm/memory.c
index bc14973b4eba..8fd33d05ef1e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2472,7 +2472,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 
 	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 	entry = pte_mkyoung(vmf->orig_pte);
-	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	entry = __maybe_mkwrite(pte_mkdirty(entry), vmf->vma_flags);
 	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -2549,8 +2549,8 @@ static int wp_page_copy(struct vm_fault *vmf)
 			inc_mm_counter_fast(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		entry = mk_pte(new_page, vmf->vma_page_prot);
+		entry = __maybe_mkwrite(pte_mkdirty(entry), vmf->vma_flags);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
-- 
2.7.4
