Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966643AbeBPP1N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:27:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758158AbeBPP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:27:10 -0500
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
Subject: [PATCH v8 23/24] x86/mm: Add speculative pagefault handling
Date: Fri, 16 Feb 2018 16:25:37 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021615-0020-0000-0000-000003F8815D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021615-0021-0000-0000-0000428C8557
Message-Id: <1518794738-4186-24-git-send-email-ldufour@linux.vnet.ibm.com>
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
[Try to the VMA fetch during the speculative path in case of retry]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/x86/mm/fault.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 800de815519c..d9f9236ccb9a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1239,6 +1239,9 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
 {
 	struct vm_area_struct *vma;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct *spf_vma = NULL;
+#endif
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int fault, major = 0;
@@ -1336,6 +1339,27 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if ((error_code & X86_PF_USER) && (atomic_read(&mm->mm_users) > 1)) {
+		fault = handle_speculative_fault(mm, address, flags,
+						 &spf_vma);
+
+		if (!(fault & VM_FAULT_RETRY)) {
+			if (!(fault & VM_FAULT_ERROR)) {
+				perf_sw_event(PERF_COUNT_SW_SPF, 1,
+					      regs, address);
+				goto done;
+			}
+			/*
+			 * In case of error we need the pkey value, but
+			 * can't get it from the spf_vma as it is only returned
+			 * when VM_FAULT_RETRY is returned. So we have to
+			 * retry the page fault with the mmap_sem grabbed.
+			 */
+		}
+	}
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/*
 	 * When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in
@@ -1369,7 +1393,16 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		might_sleep();
 	}
 
-	vma = find_vma(mm, address);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (spf_vma) {
+		if (can_reuse_spf_vma(spf_vma, address))
+			vma = spf_vma;
+		else
+			vma = find_vma(mm, address);
+		spf_vma = NULL;
+	} else
+#endif
+		vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
 		bad_area(regs, error_code, address);
 		return;
@@ -1455,6 +1488,9 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		return;
 	}
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 	/*
 	 * Major/minor page fault accounting. If any of the events
 	 * returned VM_FAULT_MAJOR, we account it as a major fault.
-- 
2.7.4
