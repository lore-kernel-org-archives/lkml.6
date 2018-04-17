Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeDQOfG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:35:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752796AbeDQOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:35:03 -0400
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
Subject: [PATCH v10 23/25] mm: add speculative page fault vmstats
Date: Tue, 17 Apr 2018 16:33:29 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041714-0012-0000-0000-000005CBDCE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0013-0000-0000-000019482826
Message-Id: <1523975611-15978-24-git-send-email-ldufour@linux.vnet.ibm.com>
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

Add speculative_pgfault vmstat counter to count successful speculative page
fault handling.

Also fixing a minor typo in include/linux/vm_event_item.h.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/vm_event_item.h | 3 +++
 mm/memory.c                   | 1 +
 mm/vmstat.c                   | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 5c7f010676a7..a240acc09684 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -111,6 +111,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		SWAP_RA,
 		SWAP_RA_HIT,
 #endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		SPECULATIVE_PGFAULT,
+#endif
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index 425f07e0bf38..1cd5bc000643 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4508,6 +4508,7 @@ int __handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 	 * If there is no need to retry, don't return the vma to the caller.
 	 */
 	if (ret != VM_FAULT_RETRY) {
+		count_vm_event(SPECULATIVE_PGFAULT);
 		put_vma(vmf.vma);
 		*vma = NULL;
 	}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 536332e988b8..c6b49bfa8139 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1289,7 +1289,10 @@ const char * const vmstat_text[] = {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
-#endif /* CONFIG_VM_EVENTS_COUNTERS */
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	"speculative_pgfault"
+#endif
+#endif /* CONFIG_VM_EVENT_COUNTERS */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA */
 
-- 
2.7.4
