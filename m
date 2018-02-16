Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967210AbeBPP1V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:27:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966807AbeBPP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:27:17 -0500
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
Subject: [PATCH v8 24/24] powerpc/mm: Add speculative page fault
Date: Fri, 16 Feb 2018 16:25:38 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021615-0040-0000-0000-00000434809A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021615-0041-0000-0000-000020D68550
Message-Id: <1518794738-4186-25-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802160183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable the speculative page fault on the PowerPC
architecture.

This will try a speculative page fault without holding the mmap_sem,
if it returns with VM_FAULT_RETRY, the mmap_sem is acquired and the
traditional page fault processing is done.

The speculative path is only tried for multithreaded process as there is no
risk of contention on the mmap_sem otherwise.

Build on if CONFIG_SPECULATIVE_PAGE_FAULT is defined (currently for
BOOK3S_64 && SMP).

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 866446cf2d9a..104f3cc86b51 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -392,6 +392,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
 {
 	struct vm_area_struct * vma;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct *spf_vma = NULL;
+#endif
 	struct mm_struct *mm = current->mm;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
  	int is_exec = TRAP(regs) == 0x400;
@@ -459,6 +462,20 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (is_user && (atomic_read(&mm->mm_users) > 1)) {
+		/* let's try a speculative page fault without grabbing the
+		 * mmap_sem.
+		 */
+		fault = handle_speculative_fault(mm, address, flags, &spf_vma);
+		if (!(fault & VM_FAULT_RETRY)) {
+			perf_sw_event(PERF_COUNT_SW_SPF, 1,
+				      regs, address);
+			goto done;
+		}
+	}
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -489,7 +506,16 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		might_sleep();
 	}
 
-	vma = find_vma(mm, address);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (spf_vma) {
+		if (can_reuse_spf_vma(spf_vma, address))
+			vma = spf_vma;
+		else
+			vma =  find_vma(mm, address);
+		spf_vma = NULL;
+	} else
+#endif
+		vma = find_vma(mm, address);
 	if (unlikely(!vma))
 		return bad_area(regs, address);
 	if (likely(vma->vm_start <= address))
@@ -568,6 +594,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	up_read(&current->mm->mmap_sem);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
-- 
2.7.4
