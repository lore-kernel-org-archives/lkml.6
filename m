Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEVMA6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:00:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751239AbeEVMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:00:57 -0400
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [FIX PATCH v11 01/26] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date: Tue, 22 May 2018 14:00:43 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <b5df0b34-5c7b-6d8c-d29d-bc6fb4e51023@infradead.org>
References: <b5df0b34-5c7b-6d8c-d29d-bc6fb4e51023@infradead.org>
X-TM-AS-GCONF: 00
x-cbid: 18052212-0044-0000-0000-00000555269A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052212-0045-0000-0000-00002896B399
Message-Id: <1526990443-30309-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the code needed to
handle speculative page fault.

By default it is turned off, and activated depending on architecture
support, ARCH_HAS_PTE_SPECIAL, SMP and MMU.

The architecture support is needed since the speculative page fault handler
is called from the architecture's page faulting code, and some code has to
be added there to handle the speculative handler.

The dependency on ARCH_HAS_PTE_SPECIAL is required because vm_normal_page()
does processing that is not compatible with the speculative handling in the
case ARCH_HAS_PTE_SPECIAL is not set.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1d0888c5b97a..d958fd8ce73a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -761,3 +761,25 @@ config GUP_BENCHMARK
 
 config ARCH_HAS_PTE_SPECIAL
 	bool
+
+config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+       def_bool n
+
+config SPECULATIVE_PAGE_FAULT
+	bool "Speculative page faults"
+	default y
+	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+	depends on ARCH_HAS_PTE_SPECIAL && MMU && SMP
+	help
+	  Try to handle user space page faults without holding the mmap_sem.
+
+	  This should allow better concurrency for massively threaded processes
+	  since the page fault handler will not wait for other thread's memory
+	  layout change to be done, assuming that this change is done in
+	  another part of the process's memory space. This type of page fault
+	  is named speculative page fault.
+
+	  If the speculative page fault fails because a concurrent modification
+	  is detected or because underlying PMD or PTE tables are not yet
+	  allocated, the speculative page fault fails and a classic page fault
+	  is then tried.
-- 
2.7.4
