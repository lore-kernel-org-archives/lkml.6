Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81649C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E54A20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVJwsvPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E54A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeLDLCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLDLCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3072146D;
        Tue,  4 Dec 2018 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921332;
        bh=DK6w8pYfV3aONvmII6h2iNDmw6l6Evq53yHFJCvDqRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVJwsvPBEQe6YOThnkKX2NPWkBAYovbEatXUNABoAFPJIlO7UB75pZUCdenJqEV6c
         JdPLO+iAwG1iUsn3XMJFYYl2zGSpMRCD8H3S+tn9Ohn9RPdjjXKof4iAH6vmuvc4KH
         nHJFDVSHmto9yDDYQ25L/D/q613A0aljHbqlBwA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 009/146] mm/khugepaged: collapse_shmem() without freezing new_page
Date:   Tue,  4 Dec 2018 11:48:15 +0100
Message-Id: <20181204103727.161359379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 87c460a0bded56195b5eb497d44709777ef7b415 upstream.

khugepaged's collapse_shmem() does almost all of its work, to assemble
the huge new_page from 512 scattered old pages, with the new_page's
refcount frozen to 0 (and refcounts of all old pages so far also frozen
to 0).  Including shmem_getpage() to read in any which were out on swap,
memory reclaim if necessary to allocate their intermediate pages, and
copying over all the data from old to new.

Imagine the frozen refcount as a spinlock held, but without any lock
debugging to highlight the abuse: it's not good, and under serious load
heads into lockups - speculative getters of the page are not expecting
to spin while khugepaged is rescheduled.

One can get a little further under load by hacking around elsewhere; but
fortunately, freezing the new_page turns out to have been entirely
unnecessary, with no hacks needed elsewhere.

The huge new_page lock is already held throughout, and guards all its
subpages as they are brought one by one into the page cache tree; and
anything reading the data in that page, without the lock, before it has
been marked PageUptodate, would already be in the wrong.  So simply
eliminate the freezing of the new_page.

Each of the old pages remains frozen with refcount 0 after it has been
replaced by a new_page subpage in the page cache tree, until they are
all unfrozen on success or failure: just as before.  They could be
unfrozen sooner, but cause no problem once no longer visible to
find_get_entry(), filemap_map_pages() and other speculative lookups.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261527570.2275@eggly.anvils
Fixes: f3f0e1d2150b2 ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0eac4344477a..45bf0e5775f7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1288,7 +1288,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
  *
  * Basic scheme is simple, details are more complex:
- *  - allocate and freeze a new huge page;
+ *  - allocate and lock a new huge page;
  *  - scan over radix tree replacing old pages the new one
  *    + swap in pages if necessary;
  *    + fill in gaps;
@@ -1296,11 +1296,11 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  *  - if replacing succeed:
  *    + copy data over;
  *    + free old pages;
- *    + unfreeze huge page;
+ *    + unlock huge page;
  *  - if replacing failed;
  *    + put all pages back and unfreeze them;
  *    + restore gaps in the radix-tree;
- *    + free huge page;
+ *    + unlock and free huge page;
  */
 static void collapse_shmem(struct mm_struct *mm,
 		struct address_space *mapping, pgoff_t start,
@@ -1337,13 +1337,11 @@ static void collapse_shmem(struct mm_struct *mm,
 	__SetPageSwapBacked(new_page);
 	new_page->index = start;
 	new_page->mapping = mapping;
-	BUG_ON(!page_ref_freeze(new_page, 1));
 
 	/*
-	 * At this point the new_page is 'frozen' (page_count() is zero), locked
-	 * and not up-to-date. It's safe to insert it into radix tree, because
-	 * nobody would be able to map it or use it in other way until we
-	 * unfreeze it.
+	 * At this point the new_page is locked and not up-to-date.
+	 * It's safe to insert it into the page cache, because nobody would
+	 * be able to map it or use it in another way until we unlock it.
 	 */
 
 	index = start;
@@ -1521,9 +1519,8 @@ static void collapse_shmem(struct mm_struct *mm,
 			index++;
 		}
 
-		/* Everything is ready, let's unfreeze the new_page */
 		SetPageUptodate(new_page);
-		page_ref_unfreeze(new_page, HPAGE_PMD_NR);
+		page_ref_add(new_page, HPAGE_PMD_NR - 1);
 		set_page_dirty(new_page);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
 		lru_cache_add_anon(new_page);
@@ -1571,8 +1568,6 @@ static void collapse_shmem(struct mm_struct *mm,
 		VM_BUG_ON(nr_none);
 		spin_unlock_irq(&mapping->tree_lock);
 
-		/* Unfreeze new_page, caller would take care about freeing it */
-		page_ref_unfreeze(new_page, 1);
 		mem_cgroup_cancel_charge(new_page, memcg, true);
 		new_page->mapping = NULL;
 	}
-- 
2.17.1



