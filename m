Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeDQOn2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753608AbeDQOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:34:34 -0400
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
Subject: [PATCH v10 14/25] mm: introduce __lru_cache_add_active_or_unevictable
Date: Tue, 17 Apr 2018 16:33:20 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0040-0000-0000-0000042FFFBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0041-0000-0000-000026340B07
Message-Id: <1523975611-15978-15-git-send-email-ldufour@linux.vnet.ibm.com>
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

The speculative page fault handler which is run without holding the
mmap_sem is calling lru_cache_add_active_or_unevictable() but the vm_flags
is not guaranteed to remain constant.
Introducing __lru_cache_add_active_or_unevictable() which has the vma flags
value parameter instead of the vma pointer.

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/swap.h | 10 ++++++++--
 mm/memory.c          |  8 ++++----
 mm/swap.c            |  6 +++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1985940af479..a7dc37e0e405 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -338,8 +338,14 @@ extern void deactivate_file_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
-extern void lru_cache_add_active_or_unevictable(struct page *page,
-						struct vm_area_struct *vma);
+extern void __lru_cache_add_active_or_unevictable(struct page *page,
+						unsigned long vma_flags);
+
+static inline void lru_cache_add_active_or_unevictable(struct page *page,
+						struct vm_area_struct *vma)
+{
+	return __lru_cache_add_active_or_unevictable(page, vma->vm_flags);
+}
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/memory.c b/mm/memory.c
index e28cbbae3f3d..47af9e97f02a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2559,7 +2559,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		__lru_cache_add_active_or_unevictable(new_page, vmf->vma_flags);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3095,7 +3095,7 @@ int do_swap_page(struct vm_fault *vmf)
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
@@ -3246,7 +3246,7 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(page, vma);
+	__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3500,7 +3500,7 @@ int alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/swap.c b/mm/swap.c
index 3dd518832096..f2f9c587246f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -455,12 +455,12 @@ void lru_cache_add(struct page *page)
  * directly back onto it's zone's unevictable list, it does NOT use a
  * per cpu pagevec.
  */
-void lru_cache_add_active_or_unevictable(struct page *page,
-					 struct vm_area_struct *vma)
+void __lru_cache_add_active_or_unevictable(struct page *page,
+					   unsigned long vma_flags)
 {
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
+	if (likely((vma_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
 		SetPageActive(page);
 	else if (!TestSetPageMlocked(page)) {
 		/*
-- 
2.7.4
