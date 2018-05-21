Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeEUTjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:39:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46980 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbeEUTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:39:10 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] mm/THP: use hugepage_vma_check() in khugepaged_enter_vma_merge()
Date: Mon, 21 May 2018 12:38:53 -0700
Message-ID: <20180521193853.3089484-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_08:,,
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
will not call khugepaged_enter().

This patch fixes these problems by reusing hugepage_vma_check() in
khugepaged_enter_vma_merge().

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d7b2a4b..e50c2bd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -430,18 +430,14 @@ int __khugepaged_enter(struct mm_struct *mm)
 	return 0;
 }
 
+static bool hugepage_vma_check(struct vm_area_struct *vma);
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
+	if (!hugepage_vma_check(vma))
 		return 0;
 	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
 	hend = vma->vm_end & HPAGE_PMD_MASK;
-- 
2.9.5
