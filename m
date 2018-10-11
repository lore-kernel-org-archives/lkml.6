Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E47C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDC21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF3yY2Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFDC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeJKXP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbeJKXP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C04213A2;
        Thu, 11 Oct 2018 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272890;
        bh=zlK44d1BjENXrH6XTmpm5SH3FbWCR+g3pvng+Q+tYCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aF3yY2Zakeychtzh6gJ03iuNw7gfxXml5DYzNdNv4iy+oXtbnOlL9TB1LNVdLyyNX
         RUdXzy86gYssMC9X9aF2Xl/iXBAuvCgM4y9klYlBUviB2ySrPCEqtLqwHnDA8A9yEI
         poLrgpzBhdCoLnbQZwd7DeyCiVN65igR3T9VZYFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.18 03/44] mm, thp: fix mlocking THP page with migration enabled
Date:   Thu, 11 Oct 2018 17:39:41 +0200
Message-Id: <20181011152452.691101284@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit e125fe405abedc1dc8a5b2229b80ee91c1434015 upstream.

A transparent huge page is represented by a single entry on an LRU list.
Therefore, we can only make unevictable an entire compound page, not
individual subpages.

If a user tries to mlock() part of a huge page, we want the rest of the
page to be reclaimable.

We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
PMD on border of VM_LOCKED VMA will be split into PTE table.

Introduction of THP migration breaks[1] the rules around mlocking THP
pages.  If we had a single PMD mapping of the page in mlocked VMA, the
page will get mlocked, regardless of PTE mappings of the page.

For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
remove_migration_pmd().

Anon THP pages can only be shared between processes via fork().  Mlocked
page can only be shared if parent mlocked it before forking, otherwise CoW
will be triggered on mlock().

For Anon-THP, we can fix the issue by munlocking the page on removing PTE
migration entry for the page.  PTEs for the page will always come after
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
	                &nodemask, 4, MPOL_MF_MOVE);

	        return 0;
	}

[1] https://lkml.kernel.org/r/CAOMGZ=G52R-30rZvhGxEbkTw7rLLwBGadVYeo--iizcD3upL3A@mail.gmail.com

Link: http://lkml.kernel.org/r/20180917133816.43995-1-kirill.shutemov@linux.intel.com
Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>	[4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    2 +-
 mm/migrate.c     |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2929,7 +2929,7 @@ void remove_migration_pmd(struct page_vm
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
-	if (vma->vm_flags & VM_LOCKED)
+	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
 		mlock_vma_page(new);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -275,6 +275,9 @@ static bool remove_migration_pte(struct
 		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
 			mlock_vma_page(new);
 
+		if (PageTransHuge(page) && PageMlocked(page))
+			clear_page_mlock(page);
+
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
 	}


