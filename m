Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeBPP0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:26:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755429AbeBPP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:26:18 -0500
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
Subject: [PATCH v8 07/24] mm: VMA sequence count
Date: Fri, 16 Feb 2018 16:25:21 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021615-0040-0000-0000-000004137361
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021615-0041-0000-0000-000026167780
Message-Id: <1518794738-4186-8-git-send-email-ldufour@linux.vnet.ibm.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Wrap the VMA modifications (vma_adjust/unmap_page_range) with sequence
counts such that we can easily test if a VMA is changed.

The unmap_page_range() one allows us to make assumptions about
page-tables; when we find the seqcount hasn't changed we can assume
page-tables are still valid.

The flip side is that we cannot distinguish between a vma_adjust() and
the unmap_page_range() -- where with the former we could have
re-checked the vma bounds against the address.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[Port to 4.12 kernel]
[Build depends on CONFIG_SPECULATIVE_PAGE_FAULT]
[Introduce vm_write_* inline function depending on
 CONFIG_SPECULATIVE_PAGE_FAULT]
[Fix lock dependency between mapping->i_mmap_rwsem and vma->vm_sequence by
 using vm_raw_write* functions]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm.h       | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  3 +++
 mm/memory.c              |  2 ++
 mm/mmap.c                | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e869adec9023..9c22b4134c5d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1370,6 +1370,47 @@ static inline void unmap_shared_mapping_range(struct address_space *mapping,
 	unmap_mapping_range(mapping, holebegin, holelen, 0);
 }
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static inline void vm_write_begin(struct vm_area_struct *vma)
+{
+	write_seqcount_begin(&vma->vm_sequence);
+}
+static inline void vm_write_begin_nested(struct vm_area_struct *vma,
+					 int subclass)
+{
+	write_seqcount_begin_nested(&vma->vm_sequence, subclass);
+}
+static inline void vm_write_end(struct vm_area_struct *vma)
+{
+	write_seqcount_end(&vma->vm_sequence);
+}
+static inline void vm_raw_write_begin(struct vm_area_struct *vma)
+{
+	raw_write_seqcount_begin(&vma->vm_sequence);
+}
+static inline void vm_raw_write_end(struct vm_area_struct *vma)
+{
+	raw_write_seqcount_end(&vma->vm_sequence);
+}
+#else
+static inline void vm_write_begin(struct vm_area_struct *vma)
+{
+}
+static inline void vm_write_begin_nested(struct vm_area_struct *vma,
+					 int subclass)
+{
+}
+static inline void vm_write_end(struct vm_area_struct *vma)
+{
+}
+static inline void vm_raw_write_begin(struct vm_area_struct *vma)
+{
+}
+static inline void vm_raw_write_end(struct vm_area_struct *vma)
+{
+}
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd1af6b9591d..34fde7111e88 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -333,6 +333,9 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	seqcount_t vm_sequence;
+#endif
 } __randomize_layout;
 
 struct core_thread {
diff --git a/mm/memory.c b/mm/memory.c
index a301b9003200..3cc1a13417cf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1503,6 +1503,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 	unsigned long next;
 
 	BUG_ON(addr >= end);
+	vm_write_begin(vma);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
@@ -1512,6 +1513,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
+	vm_write_end(vma);
 }
 
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bb038e7984b..671940b72696 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -558,6 +558,10 @@ void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
 	else
 		mm->highest_vm_end = vm_end_gap(vma);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	seqcount_init(&vma->vm_sequence);
+#endif
+
 	/*
 	 * vma->vm_prev wasn't known when we followed the rbtree to find the
 	 * correct insertion point for that vma. As a result, we could not
@@ -692,6 +696,30 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	long adjust_next = 0;
 	int remove_next = 0;
 
+	/*
+	 * Why using vm_raw_write*() functions here to avoid lockdep's warning ?
+	 *
+	 * Locked is complaining about a theoretical lock dependency, involving
+	 * 3 locks:
+	 *   mapping->i_mmap_rwsem --> vma->vm_sequence --> fs_reclaim
+	 *
+	 * Here are the major path leading to this dependency :
+	 *  1. __vma_adjust() mmap_sem  -> vm_sequence -> i_mmap_rwsem
+	 *  2. move_vmap() mmap_sem -> vm_sequence -> fs_reclaim
+	 *  3. __alloc_pages_nodemask() fs_reclaim -> i_mmap_rwsem
+	 *  4. unmap_mapping_range() i_mmap_rwsem -> vm_sequence
+	 *
+	 * So there is no way to solve this easily, especially because in
+	 * unmap_mapping_range() the i_mmap_rwsem is grab while the impacted
+	 * VMAs are not yet known.
+	 * However, the way the vm_seq is used is guarantying that we will
+	 * never block on it since we just check for its value and never wait
+	 * for it to move, see vma_has_changed() and handle_speculative_fault().
+	 */
+	vm_raw_write_begin(vma);
+	if (next)
+		vm_raw_write_begin(next);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
@@ -902,6 +930,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			anon_vma_merge(vma, next);
 		mm->map_count--;
 		mpol_put(vma_policy(next));
+		vm_raw_write_end(next);
 		kmem_cache_free(vm_area_cachep, next);
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
@@ -916,6 +945,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "vma->vm_next" gap must be updated.
 			 */
 			next = vma->vm_next;
+			if (next)
+				vm_raw_write_begin(next);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -962,6 +993,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (insert && file)
 		uprobe_mmap(insert);
 
+	if (next && next != vma)
+		vm_raw_write_end(next);
+	vm_raw_write_end(vma);
+
 	validate_mm(mm);
 
 	return 0;
-- 
2.7.4
