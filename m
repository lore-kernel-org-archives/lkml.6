Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDQOi1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:38:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752941AbeDQOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:35:05 -0400
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
Subject: [PATCH v10 24/25] x86/mm: add speculative pagefault handling
Date: Tue, 17 Apr 2018 16:33:30 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0044-0000-0000-000005493A84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0045-0000-0000-00002889494A
Message-Id: <1523975611-15978-25-git-send-email-ldufour@linux.vnet.ibm.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Try a speculative fault before acquiring mmap_sem, if it returns with
VM_FAULT_RETRY continue with the mmap_sem acquisition and do the
traditional fault.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[Clearing of FAULT_FLAG_ALLOW_RETRY is now done in
 handle_speculative_fault()]
[Retry with usual fault path in the case VM_ERROR is returned by
 handle_speculative_fault(). This allows signal to be delivered]
[Don't build SPF call if !CONFIG_SPECULATIVE_PAGE_FAULT]
[Try speculative fault path only for multi threaded processes]
[Try reuse to the VMA fetch during the speculative path in case of retry]
[Call reuse_spf_or_find_vma()]
[Handle memory protection key fault]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/x86/mm/fault.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 73bd8c95ac71..59f778386df5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1220,7 +1220,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	struct mm_struct *mm;
 	int fault, major = 0;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
-	u32 pkey;
+	u32 pkey, *pt_pkey = &pkey;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1310,6 +1310,30 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
+	 * Do not try speculative page fault for kernel's pages and if
+	 * the fault was due to protection keys since it can't be resolved.
+	 */
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT) &&
+	    !(error_code & X86_PF_PK)) {
+		fault = handle_speculative_fault(mm, address, flags, &vma);
+		if (fault != VM_FAULT_RETRY) {
+			perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, address);
+			/*
+			 * Do not advertise for the pkey value since we don't
+			 * know it.
+			 * This is not a matter as we checked for X86_PF_PK
+			 * earlier, so we should not handle pkey fault here,
+			 * but to be sure that mm_fault_error() callees will
+			 * not try to use it, we invalidate the pointer.
+			 */
+			pt_pkey = NULL;
+			goto done;
+		}
+	} else {
+		vma = NULL;
+	}
+
+	/*
 	 * When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in
 	 * the kernel and should generate an OOPS.  Unfortunately, in the
@@ -1342,7 +1366,8 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		might_sleep();
 	}
 
-	vma = find_vma(mm, address);
+	if (!vma || !can_reuse_spf_vma(vma, address))
+		vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
 		bad_area(regs, error_code, address);
 		return;
@@ -1409,8 +1434,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(tsk))
+			if (!fatal_signal_pending(tsk)) {
+				/*
+				 * Do not try to reuse this vma and fetch it
+				 * again since we will release the mmap_sem.
+				 */
+				if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
+					vma = NULL;
 				goto retry;
+			}
 		}
 
 		/* User mode? Just return to handle the fatal exception */
@@ -1423,8 +1455,10 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 
 	up_read(&mm->mmap_sem);
+
+done:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, error_code, address, &pkey, fault);
+		mm_fault_error(regs, error_code, address, pt_pkey, fault);
 		return;
 	}
 
-- 
2.7.4
