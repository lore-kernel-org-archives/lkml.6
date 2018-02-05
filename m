Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeBEBjm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:39:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbeBEB22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:28 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 22/64] mm: avoid mmap_sem trylock in vm_insert_page()
Date: Mon,  5 Feb 2018 02:27:12 +0100
Message-Id: <20180205012754.23615-23-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

The rules to this function state that mmap_sem must
be acquired by the caller:

- for write if used in f_op->mmap() (by far the most common case)
- for read if used from vma_op->fault()(with VM_MIXEDMAP)

The only exception is:
  mmap_vmcore()
   remap_vmalloc_range_partial()
      mmap_vmcore()

But there is no concurrency here, thus mmap_sem is not held.
After auditing the kernel, the following drivers use the fault
path and correctly set VM_MIXEDMAP):

.fault = etnaviv_gem_fault
.fault = udl_gem_fault
tegra_bo_fault()

As such, drop the reader trylock BUG_ON() for the common case.
This avoids having file_operations know about mmranges, as
mmap_sem is held during, mmap() for example.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5adcdc7dee80..7c69674cd9da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1773,7 +1773,6 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 	if (!page_count(page))
 		return -EINVAL;
 	if (!(vma->vm_flags & VM_MIXEDMAP)) {
-		BUG_ON(down_read_trylock(&vma->vm_mm->mmap_sem));
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vma->vm_flags |= VM_MIXEDMAP;
 	}
-- 
2.13.6
