Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2789B206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2789B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeIKPdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:33:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:21385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbeIKPdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:33:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 03:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="69964605"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2018 03:34:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 388CC32A; Tue, 11 Sep 2018 13:34:15 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vegard Nossum <vegard.nossum@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org, Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] mm, thp: Fix mlocking THP page with migration enabled
Date:   Tue, 11 Sep 2018 13:34:03 +0300
Message-Id: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A transparent huge page is represented by a single entry on an LRU list.
Therefore, we can only make unevictable an entire compound page, not
individual subpages.

If a user tries to mlock() part of a huge page, we want the rest of the
page to be reclaimable.

We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
PMD on border of VM_LOCKED VMA will be split into PTE table.

Introduction of THP migration breaks the rules around mlocking THP
pages. If we had a single PMD mapping of the page in mlocked VMA, the
page will get mlocked, regardless of PTE mappings of the page.

For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
remove_migration_pmd().

Anon THP pages can only be shared between processes via fork(). Mlocked
page can only be shared if parent mlocked it before forking, otherwise
CoW will be triggered on mlock().

For Anon-THP, we can fix the issue by munlocking the page on removing PTE
migration entry for the page. PTEs for the page will always come after
mlocked PMD: rmap walks VMAs from oldest to newest.

Test-case:

	#include <unistd.h>
	#include <sys/mman.h>
	#include <sys/wait.h>
	#include <linux/mempolicy.h>
	#include <numaif.h>

	int main(void)
	{
	        unsigned long nodemask = 4;
	        void *addr;

		addr = mmap((void *)0x20000000UL, 2UL << 20, PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);

	        if (fork()) {
			wait(NULL);
			return 0;
	        }

	        mlock(addr, 4UL << 10);
	        mbind(addr, 2UL << 20, MPOL_PREFERRED | MPOL_F_RELATIVE_NODES,
	                &nodemask, 4, MPOL_MF_MOVE | MPOL_MF_MOVE_ALL);

	        return 0;
	}

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Cc: <stable@vger.kernel.org> [v4.14+]
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/huge_memory.c | 2 +-
 mm/migrate.c     | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 533f9b00147d..00704060b7f7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2931,7 +2931,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
-	if (vma->vm_flags & VM_LOCKED)
+	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
 		mlock_vma_page(new);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index d6a2e89b086a..01dad96b25b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -275,6 +275,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
 			mlock_vma_page(new);
 
+		if (PageTransCompound(new) && PageMlocked(page))
+			clear_page_mlock(page);
+
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
 	}
-- 
2.18.0

