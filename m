Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeEaN4L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:56:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:4697 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755231AbeEaN4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:56:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="55457175"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/shmem: Zero out unused vma fields in shmem_pseudo_vma_init()
Date: Thu, 31 May 2018 16:56:02 +0300
Message-Id: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem/tmpfs uses pseudo vma to allocate page with correct NUMA policy.

The pseudo vma doesn't have vm_page_prot set. We are going to encode
encryption KeyID in vm_page_prot. Having garbage there causes problems.

Zero out all unused fields in the pseudo vma.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9d6c7e595415..693fb82b4b42 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1404,10 +1404,9 @@ static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
 		struct shmem_inode_info *info, pgoff_t index)
 {
 	/* Create a pseudo vma that just contains the policy */
-	vma->vm_start = 0;
+	memset(vma, 0, sizeof(*vma));
 	/* Bias interleave by inode number to distribute better across nodes */
 	vma->vm_pgoff = index + info->vfs_inode.i_ino;
-	vma->vm_ops = NULL;
 	vma->vm_policy = mpol_shared_policy_lookup(&info->policy, index);
 }
 
-- 
2.17.0
