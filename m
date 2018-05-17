Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeEQLHS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:07:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752136AbeEQLHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:07:07 -0400
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
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v11 08/26] mm: introduce INIT_VMA()
Date: Thu, 17 May 2018 13:06:15 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051711-0008-0000-0000-000004F7797B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051711-0009-0000-0000-00001E8BEDEE
Message-Id: <1526555193-7242-9-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some VMA struct fields need to be initialized once the VMA structure is
allocated.
Currently this only concerns anon_vma_chain field but some other will be
added to support the speculative page fault.

Instead of spreading the initialization calls all over the code, let's
introduce a dedicated inline function.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 fs/exec.c          |  2 +-
 include/linux/mm.h |  5 +++++
 kernel/fork.c      |  2 +-
 mm/mmap.c          | 10 +++++-----
 mm/nommu.c         |  2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6fc98cfd3bdb..7e134a588ef3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -311,7 +311,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	vma->vm_start = vma->vm_end - PAGE_SIZE;
 	vma->vm_flags = VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_VMA(vma);
 
 	err = insert_vm_struct(mm, vma);
 	if (err)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 113b572471ca..35ecb983ff36 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1303,6 +1303,11 @@ struct zap_details {
 	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
+static inline void INIT_VMA(struct vm_area_struct *vma)
+{
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+}
+
 struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte, bool with_public_device);
 #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
diff --git a/kernel/fork.c b/kernel/fork.c
index 744d6fbba8f8..99198a02efe9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -458,7 +458,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!tmp)
 			goto fail_nomem;
 		*tmp = *mpnt;
-		INIT_LIST_HEAD(&tmp->anon_vma_chain);
+		INIT_VMA(tmp);
 		retval = vma_dup_policy(mpnt, tmp);
 		if (retval)
 			goto fail_nomem_policy;
diff --git a/mm/mmap.c b/mm/mmap.c
index d2ef1060a2d2..ceb1c2c1b46b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1709,7 +1709,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_flags = vm_flags;
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_VMA(vma);
 
 	if (file) {
 		if (vm_flags & VM_DENYWRITE) {
@@ -2595,7 +2595,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
 
-	INIT_LIST_HEAD(&new->anon_vma_chain);
+	INIT_VMA(new);
 
 	if (new_below)
 		new->vm_end = addr;
@@ -2965,7 +2965,7 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 		return -ENOMEM;
 	}
 
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_VMA(vma);
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
@@ -3184,7 +3184,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma->vm_pgoff = pgoff;
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
-		INIT_LIST_HEAD(&new_vma->anon_vma_chain);
+		INIT_VMA(new_vma);
 		if (anon_vma_clone(new_vma, vma))
 			goto out_free_mempol;
 		if (new_vma->vm_file)
@@ -3327,7 +3327,7 @@ static struct vm_area_struct *__install_special_mapping(
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_VMA(vma);
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
diff --git a/mm/nommu.c b/mm/nommu.c
index 4452d8bd9ae4..ece424315cc5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1212,7 +1212,7 @@ unsigned long do_mmap(struct file *file,
 	region->vm_flags = vm_flags;
 	region->vm_pgoff = pgoff;
 
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_VMA(vma);
 	vma->vm_flags = vm_flags;
 	vma->vm_pgoff = pgoff;
 
-- 
2.7.4
