Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEVTog (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:44:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39168 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751942AbeEVToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:44:34 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>, <mhocko@kernel.org>,
        <rientjes@google.com>, <aarcange@redhat.com>, <kirill@shutemov.name>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] mm/THP: use hugepage_vma_check() in khugepaged_enter_vma_merge()
Date: Tue, 22 May 2018 12:44:30 -0700
Message-ID: <20180522194430.426688-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

khugepaged_enter_vma_merge() is using a different approach to check
whether a vma is valid for khugepaged_enter():

    if (!vma->anon_vma)
            /*
             * Not yet faulted in so we will register later in the
             * page fault if needed.
             */
            return 0;
    if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
            /* khugepaged not yet working on file or special mappings */
            return 0;

This check has some problems. One of the obvious problems is that
it doesn't check shmem_file(), so that vma backed with shmem files
will not call khugepaged_enter(). Here is an example of failed madvise():

   /* mount /dev/shm with huge=advise:
    *     mount -o remount,huge=advise /dev/shm */
   /* create file /dev/shm/huge */
   #define HUGE_FILE "/dev/shm/huge"

   fd = open(HUGE_FILE, O_RDONLY);
   ptr = mmap(NULL, FILE_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
   ret = madvise(ptr, FILE_SIZE, MADV_HUGEPAGE);

madvise() will return 0, but this memory region is never put in huge
page (check from /proc/meminfo: ShmemHugePages).

This patch fixes these problems by reusing hugepage_vma_check() in
khugepaged_enter_vma_merge().

vma->vm_flags is not yet updated in khugepaged_enter_vma_merge(),
so we need to pass the new vm_flags to hugepage_vma_check() through
a separate argument.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d7b2a4b..9f74e51 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -430,18 +430,15 @@ int __khugepaged_enter(struct mm_struct *mm)
 	return 0;
 }
 
+static bool hugepage_vma_check(struct vm_area_struct *vma,
+			       unsigned long vm_flags);
+
 int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 			       unsigned long vm_flags)
 {
 	unsigned long hstart, hend;
-	if (!vma->anon_vma)
-		/*
-		 * Not yet faulted in so we will register later in the
-		 * page fault if needed.
-		 */
-		return 0;
-	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
-		/* khugepaged not yet working on file or special mappings */
+
+	if (!hugepage_vma_check(vma, vm_flags))
 		return 0;
 	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
 	hend = vma->vm_end & HPAGE_PMD_MASK;
@@ -819,10 +816,11 @@ khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
 }
 #endif
 
-static bool hugepage_vma_check(struct vm_area_struct *vma)
+static bool hugepage_vma_check(struct vm_area_struct *vma,
+			       unsigned long vm_flags)
 {
-	if ((!(vma->vm_flags & VM_HUGEPAGE) && !khugepaged_always()) ||
-	    (vma->vm_flags & VM_NOHUGEPAGE) ||
+	if ((!(vm_flags & VM_HUGEPAGE) && !khugepaged_always()) ||
+	    (vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
 	if (shmem_file(vma->vm_file)) {
@@ -835,7 +833,7 @@ static bool hugepage_vma_check(struct vm_area_struct *vma)
 		return false;
 	if (is_vma_temporary_stack(vma))
 		return false;
-	return !(vma->vm_flags & VM_NO_KHUGEPAGED);
+	return !(vm_flags & VM_NO_KHUGEPAGED);
 }
 
 /*
@@ -862,7 +860,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	hend = vma->vm_end & HPAGE_PMD_MASK;
 	if (address < hstart || address + HPAGE_PMD_SIZE > hend)
 		return SCAN_ADDRESS_RANGE;
-	if (!hugepage_vma_check(vma))
+	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
 	return 0;
 }
@@ -1694,7 +1692,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags)) {
 skip:
 			progress++;
 			continue;
-- 
2.9.5
