Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeBFQvJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:51:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752865AbeBFQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:50:31 -0500
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
Subject: [PATCH v7 04/24] mm: Dont assume page-table invariance during faults
Date: Tue,  6 Feb 2018 17:49:50 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020616-0012-0000-0000-000005ABFC05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020616-0013-0000-0000-00001927B0B8
Message-Id: <1517935810-31177-5-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

One of the side effects of speculating on faults (without holding
mmap_sem) is that we can race with free_pgtables() and therefore we
cannot assume the page-tables will stick around.

Remove the reliance on the pte pointer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

In most of the case pte_unmap_same() was returning 1, which meaning that
do_swap_page() should do its processing. So in most of the case there will
be no impact.

Now regarding the case where pte_unmap_safe() was returning 0, and thus
do_swap_page return 0 too, this happens when the page has already been
swapped back. This may happen before do_swap_page() get called or while in
the call to do_swap_page(). In that later case, the check done when
swapin_readahead() returns will detect that case.

The worst case would be that a page fault is occuring on 2 threads at the
same time on the same swapped out page. In that case one thread will take
much time looping in __read_swap_cache_async(). But in the regular page
fault path, this is even worse since the thread would wait for semaphore to
be released before starting anything.

[Remove only if !CONFIG_SPECULATIVE_PAGE_FAULT]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5ec6433d6a5c..32b9eb77d95c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2288,6 +2288,7 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
+#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
@@ -2311,6 +2312,7 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap(page_table);
 	return same;
 }
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
 {
@@ -2898,11 +2900,13 @@ int do_swap_page(struct vm_fault *vmf)
 		swapcache = page;
 	}
 
+#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte)) {
 		if (page)
 			put_page(page);
 		goto out;
 	}
+#endif
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
-- 
2.7.4
