Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeDQOfN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:35:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752812AbeDQOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:35:10 -0400
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
Subject: [PATCH v10 25/25] powerpc/mm: add speculative page fault
Date: Tue, 17 Apr 2018 16:33:31 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0020-0000-0000-00000412EC7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0021-0000-0000-000042A72D0F
Message-Id: <1523975611-15978-26-git-send-email-ldufour@linux.vnet.ibm.com>
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

This patch enable the speculative page fault on the PowerPC
architecture.

This will try a speculative page fault without holding the mmap_sem,
if it returns with VM_FAULT_RETRY, the mmap_sem is acquired and the
traditional page fault processing is done.

The speculative path is only tried for multithreaded process as there is no
risk of contention on the mmap_sem otherwise.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..37191147026e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -464,6 +464,26 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
+		fault = handle_speculative_fault(mm, address, flags, &vma);
+		/*
+		 * Page fault is done if VM_FAULT_RETRY is not returned.
+		 * But if the memory protection keys are active, we don't know
+		 * if the fault is due to key mistmatch or due to a
+		 * classic protection check.
+		 * To differentiate that, we will need the VMA we no
+		 * more have, so let's retry with the mmap_sem held.
+		 */
+		if (fault != VM_FAULT_RETRY &&
+		    (IS_ENABLED(CONFIG_PPC_MEM_KEYS) &&
+		     fault != VM_FAULT_SIGSEGV)) {
+			perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, address);
+			goto done;
+		}
+	} else {
+		vma = NULL;
+	}
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -494,7 +514,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		might_sleep();
 	}
 
-	vma = find_vma(mm, address);
+	if (!vma || !can_reuse_spf_vma(vma, address))
+		vma = find_vma(mm, address);
 	if (unlikely(!vma))
 		return bad_area(regs, address);
 	if (likely(vma->vm_start <= address))
@@ -551,8 +572,15 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			 */
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(current))
+			if (!fatal_signal_pending(current)) {
+				/*
+				 * Do not try to reuse this vma and fetch it
+				 * again since we will release the mmap_sem.
+				 */
+				if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
+					vma = NULL;
 				goto retry;
+			}
 		}
 
 		/*
@@ -564,6 +592,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	up_read(&current->mm->mmap_sem);
 
+done:
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
-- 
2.7.4
