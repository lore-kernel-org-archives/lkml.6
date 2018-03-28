Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeC1Q7M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:59:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:53107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbeC1Qzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:55:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="38891232"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 03/14] mm/shmem: Zero out unused vma fields in shmem_pseudo_vma_init()
Date: Wed, 28 Mar 2018 19:55:29 +0300
Message-Id: <20180328165540.648-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
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
index b85919243399..387b89d9e17a 100644
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
2.16.2
