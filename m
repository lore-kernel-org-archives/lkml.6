Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeDQOex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753622AbeDQOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:34:49 -0400
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
Subject: [PATCH v10 19/25] mm: adding speculative page fault failure trace events
Date: Tue, 17 Apr 2018 16:33:25 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0012-0000-0000-000005CBDCE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0013-0000-0000-00001948281F
Message-Id: <1523975611-15978-20-git-send-email-ldufour@linux.vnet.ibm.com>
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

This patch a set of new trace events to collect the speculative page fault
event failures.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/trace/events/pagefault.h | 88 ++++++++++++++++++++++++++++++++++++++++
 mm/memory.c                      | 62 ++++++++++++++++++++++------
 2 files changed, 137 insertions(+), 13 deletions(-)
 create mode 100644 include/trace/events/pagefault.h

diff --git a/include/trace/events/pagefault.h b/include/trace/events/pagefault.h
new file mode 100644
index 000000000000..a9643b3759f2
--- /dev/null
+++ b/include/trace/events/pagefault.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pagefault
+
+#if !defined(_TRACE_PAGEFAULT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGEFAULT_H
+
+#include <linux/tracepoint.h>
+#include <linux/mm.h>
+
+DECLARE_EVENT_CLASS(spf,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, caller)
+		__field(unsigned long, vm_start)
+		__field(unsigned long, vm_end)
+		__field(unsigned long, address)
+	),
+
+	TP_fast_assign(
+		__entry->caller		= caller;
+		__entry->vm_start	= vma->vm_start;
+		__entry->vm_end		= vma->vm_end;
+		__entry->address	= address;
+	),
+
+	TP_printk("ip:%lx vma:%lx-%lx address:%lx",
+		  __entry->caller, __entry->vm_start, __entry->vm_end,
+		  __entry->address)
+);
+
+DEFINE_EVENT(spf, spf_pte_lock,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+DEFINE_EVENT(spf, spf_vma_changed,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+DEFINE_EVENT(spf, spf_vma_noanon,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+DEFINE_EVENT(spf, spf_vma_notsup,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+DEFINE_EVENT(spf, spf_vma_access,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+DEFINE_EVENT(spf, spf_pmd_changed,
+
+	TP_PROTO(unsigned long caller,
+		 struct vm_area_struct *vma, unsigned long address),
+
+	TP_ARGS(caller, vma, address)
+);
+
+#endif /* _TRACE_PAGEFAULT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/memory.c b/mm/memory.c
index 8addf78deadb..76178feff000 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -80,6 +80,9 @@
 
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pagefault.h>
+
 #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
@@ -2317,8 +2320,10 @@ static bool pte_spinlock(struct vm_fault *vmf)
 	}
 
 	local_irq_disable();
-	if (vma_has_changed(vmf))
+	if (vma_has_changed(vmf)) {
+		trace_spf_vma_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
+	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/*
@@ -2326,16 +2331,21 @@ static bool pte_spinlock(struct vm_fault *vmf)
 	 * is not a huge collapse operation in progress in our back.
 	 */
 	pmdval = READ_ONCE(*vmf->pmd);
-	if (!pmd_same(pmdval, vmf->orig_pmd))
+	if (!pmd_same(pmdval, vmf->orig_pmd)) {
+		trace_spf_pmd_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
+	}
 #endif
 
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
-	if (unlikely(!spin_trylock(vmf->ptl)))
+	if (unlikely(!spin_trylock(vmf->ptl))) {
+		trace_spf_pte_lock(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
+	}
 
 	if (vma_has_changed(vmf)) {
 		spin_unlock(vmf->ptl);
+		trace_spf_vma_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
 	}
 
@@ -2368,8 +2378,10 @@ static bool pte_map_lock(struct vm_fault *vmf)
 	 * block on the PTL and thus we're safe.
 	 */
 	local_irq_disable();
-	if (vma_has_changed(vmf))
+	if (vma_has_changed(vmf)) {
+		trace_spf_vma_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
+	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/*
@@ -2377,8 +2389,10 @@ static bool pte_map_lock(struct vm_fault *vmf)
 	 * is not a huge collapse operation in progress in our back.
 	 */
 	pmdval = READ_ONCE(*vmf->pmd);
-	if (!pmd_same(pmdval, vmf->orig_pmd))
+	if (!pmd_same(pmdval, vmf->orig_pmd)) {
+		trace_spf_pmd_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
+	}
 #endif
 
 	/*
@@ -2392,11 +2406,13 @@ static bool pte_map_lock(struct vm_fault *vmf)
 	pte = pte_offset_map(vmf->pmd, vmf->address);
 	if (unlikely(!spin_trylock(ptl))) {
 		pte_unmap(pte);
+		trace_spf_pte_lock(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
 	}
 
 	if (vma_has_changed(vmf)) {
 		pte_unmap_unlock(pte, ptl);
+		trace_spf_vma_changed(_RET_IP_, vmf->vma, vmf->address);
 		goto out;
 	}
 
@@ -4321,47 +4337,60 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 		return ret;
 
 	seq = raw_read_seqcount(&vma->vm_sequence); /* rmb <-> seqlock,vma_rb_erase() */
-	if (seq & 1)
+	if (seq & 1) {
+		trace_spf_vma_changed(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	/*
 	 * Can't call vm_ops service has we don't know what they would do
 	 * with the VMA.
 	 * This include huge page from hugetlbfs.
 	 */
-	if (vma->vm_ops)
+	if (vma->vm_ops) {
+		trace_spf_vma_notsup(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	/*
 	 * __anon_vma_prepare() requires the mmap_sem to be held
 	 * because vm_next and vm_prev must be safe. This can't be guaranteed
 	 * in the speculative path.
 	 */
-	if (unlikely(!vma->anon_vma))
+	if (unlikely(!vma->anon_vma)) {
+		trace_spf_vma_notsup(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	vmf.vma_flags = READ_ONCE(vma->vm_flags);
 	vmf.vma_page_prot = READ_ONCE(vma->vm_page_prot);
 
 	/* Can't call userland page fault handler in the speculative path */
-	if (unlikely(vmf.vma_flags & VM_UFFD_MISSING))
+	if (unlikely(vmf.vma_flags & VM_UFFD_MISSING)) {
+		trace_spf_vma_notsup(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
-	if (vmf.vma_flags & VM_GROWSDOWN || vmf.vma_flags & VM_GROWSUP)
+	if (vmf.vma_flags & VM_GROWSDOWN || vmf.vma_flags & VM_GROWSUP) {
 		/*
 		 * This could be detected by the check address against VMA's
 		 * boundaries but we want to trace it as not supported instead
 		 * of changed.
 		 */
+		trace_spf_vma_notsup(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	if (address < READ_ONCE(vma->vm_start)
-	    || READ_ONCE(vma->vm_end) <= address)
+	    || READ_ONCE(vma->vm_end) <= address) {
+		trace_spf_vma_changed(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 				       flags & FAULT_FLAG_INSTRUCTION,
 				       flags & FAULT_FLAG_REMOTE)) {
+		trace_spf_vma_access(_RET_IP_, vma, address);
 		ret = VM_FAULT_SIGSEGV;
 		goto out_put;
 	}
@@ -4369,10 +4398,12 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 	/* This is one is required to check that the VMA has write access set */
 	if (flags & FAULT_FLAG_WRITE) {
 		if (unlikely(!(vmf.vma_flags & VM_WRITE))) {
+			trace_spf_vma_access(_RET_IP_, vma, address);
 			ret = VM_FAULT_SIGSEGV;
 			goto out_put;
 		}
 	} else if (unlikely(!(vmf.vma_flags & (VM_READ|VM_EXEC|VM_WRITE)))) {
+		trace_spf_vma_access(_RET_IP_, vma, address);
 		ret = VM_FAULT_SIGSEGV;
 		goto out_put;
 	}
@@ -4388,8 +4419,10 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 		pol = __get_vma_policy(vma, address);
 		if (!pol)
 			pol = get_task_policy(current);
-		if (pol && pol->mode == MPOL_INTERLEAVE)
+		if (pol && pol->mode == MPOL_INTERLEAVE) {
+			trace_spf_vma_notsup(_RET_IP_, vma, address);
 			goto out_put;
+		}
 	}
 
 	/*
@@ -4462,8 +4495,10 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 	 * We need to re-validate the VMA after checking the bounds, otherwise
 	 * we might have a false positive on the bounds.
 	 */
-	if (read_seqcount_retry(&vma->vm_sequence, seq))
+	if (read_seqcount_retry(&vma->vm_sequence, seq)) {
+		trace_spf_vma_changed(_RET_IP_, vma, address);
 		goto out_put;
+	}
 
 	mem_cgroup_oom_enable();
 	ret = handle_pte_fault(&vmf);
@@ -4482,6 +4517,7 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 	return ret;
 
 out_walk:
+	trace_spf_vma_notsup(_RET_IP_, vma, address);
 	local_irq_enable();
 out_put:
 	put_vma(vma);
-- 
2.7.4
