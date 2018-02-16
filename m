Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755879AbeBPP0k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:26:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755387AbeBPP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:26:34 -0500
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
Subject: [PATCH v8 12/24] mm/migrate: Pass vm_fault pointer to migrate_misplaced_page()
Date: Fri, 16 Feb 2018 16:25:26 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021615-0008-0000-0000-000004D08097
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021615-0009-0000-0000-00001E63856E
Message-Id: <1518794738-4186-13-git-send-email-ldufour@linux.vnet.ibm.com>
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

migrate_misplaced_page() is only called during the page fault handling so
it's better to pass the pointer to the struct vm_fault instead of the vma.

This way during the speculative page fault path the saved vma->vm_flags
could be used.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/migrate.h | 4 ++--
 mm/memory.c             | 2 +-
 mm/migrate.c            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0c6fe904bc97..08960ec74246 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -126,14 +126,14 @@ static inline void __ClearPageMovable(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 extern bool pmd_trans_migrating(pmd_t pmd);
 extern int migrate_misplaced_page(struct page *page,
-				  struct vm_area_struct *vma, int node);
+				  struct vm_fault *vmf, int node);
 #else
 static inline bool pmd_trans_migrating(pmd_t pmd)
 {
 	return false;
 }
 static inline int migrate_misplaced_page(struct page *page,
-					 struct vm_area_struct *vma, int node)
+					 struct vm_fault *vmf, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/memory.c b/mm/memory.c
index 66a79f44f303..bd5de1aa3f7a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3903,7 +3903,7 @@ static int do_numa_page(struct vm_fault *vmf)
 	}
 
 	/* Migrate to the requested node */
-	migrated = migrate_misplaced_page(page, vma, target_nid);
+	migrated = migrate_misplaced_page(page, vmf, target_nid);
 	if (migrated) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
diff --git a/mm/migrate.c b/mm/migrate.c
index 5d0dc7b85f90..ad8692ca6a4f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1900,7 +1900,7 @@ bool pmd_trans_migrating(pmd_t pmd)
  * node. Caller is expected to have an elevated reference count on
  * the page that will be dropped by this function before returning.
  */
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
+int migrate_misplaced_page(struct page *page, struct vm_fault *vmf,
 			   int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
@@ -1913,7 +1913,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * with execute permissions as they are probably shared libraries.
 	 */
 	if (page_mapcount(page) != 1 && page_is_file_cache(page) &&
-	    (vma->vm_flags & VM_EXEC))
+	    (vmf->vma_flags & VM_EXEC))
 		goto out;
 
 	/*
-- 
2.7.4
