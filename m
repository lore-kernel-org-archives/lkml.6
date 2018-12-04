Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA89C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478E214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMJGwImv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478E214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeLDLBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeLDLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E659214DB;
        Tue,  4 Dec 2018 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921304;
        bh=AWf89GrWbOmAZdBwBsfrB7lD7elwNhKdOAPYQ9+knss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMJGwImvQyO9FnJeb9Cak/Mub0I5LEEr0G5fCxkNR7UxYe0Yfd037N5UZTaZa0xIu
         heZ80J2NFxkwtDtI9W6xay0E7GPRHimTeUAAK+YIAF9Tqf3oHA2AMZ9PHtzPnLx+8R
         MdVtPcKom81DInSL4u86csVYBc8m5NwAqXa3sbmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 002/146] mm/huge_memory.c: reorder operations in __split_huge_page_tail()
Date:   Tue,  4 Dec 2018 11:48:08 +0100
Message-Id: <20181204103726.851923121@linuxfoundation.org>
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

commit 605ca5ede7643a01f4c4a15913f9714ac297f8a6 upstream.

THP split makes non-atomic change of tail page flags.  This is almost ok
because tail pages are locked and isolated but this breaks recent
changes in page locking: non-atomic operation could clear bit
PG_waiters.

As a result concurrent sequence get_page_unless_zero() -> lock_page()
might block forever.  Especially if this page was truncated later.

Fix is trivial: clone flags before unfreezing page reference counter.

This race exists since commit 62906027091f ("mm: add PageWaiters
indicating tasks are waiting for a page bit") while unsave unfreeze
itself was added in commit 8df651c7059e ("thp: cleanup
split_huge_page()").

clear_compound_head() also must be called before unfreezing page
reference because after successful get_page_unless_zero() might follow
put_page() which needs correct compound_head().

And replace page_ref_inc()/page_ref_add() with page_ref_unfreeze() which
is made especially for that and has semantic of smp_store_release().

Link: http://lkml.kernel.org/r/151844393341.210639.13162088407980624477.stgit@buzz
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 09d7e9c4de89..8969f5cf3174 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2312,26 +2312,13 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	struct page *page_tail = head + tail;
 
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
-	VM_BUG_ON_PAGE(page_ref_count(page_tail) != 0, page_tail);
 
 	/*
-	 * tail_page->_refcount is zero and not changing from under us. But
-	 * get_page_unless_zero() may be running from under us on the
-	 * tail_page. If we used atomic_set() below instead of atomic_inc() or
-	 * atomic_add(), we would then run atomic_set() concurrently with
-	 * get_page_unless_zero(), and atomic_set() is implemented in C not
-	 * using locked ops. spin_unlock on x86 sometime uses locked ops
-	 * because of PPro errata 66, 92, so unless somebody can guarantee
-	 * atomic_set() here would be safe on all archs (and not only on x86),
-	 * it's safer to use atomic_inc()/atomic_add().
+	 * Clone page flags before unfreezing refcount.
+	 *
+	 * After successful get_page_unless_zero() might follow flags change,
+	 * for exmaple lock_page() which set PG_waiters.
 	 */
-	if (PageAnon(head) && !PageSwapCache(head)) {
-		page_ref_inc(page_tail);
-	} else {
-		/* Additional pin to radix tree */
-		page_ref_add(page_tail, 2);
-	}
-
 	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	page_tail->flags |= (head->flags &
 			((1L << PG_referenced) |
@@ -2344,14 +2331,21 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_unevictable) |
 			 (1L << PG_dirty)));
 
-	/*
-	 * After clearing PageTail the gup refcount can be released.
-	 * Page flags also must be visible before we make the page non-compound.
-	 */
+	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
 
+	/*
+	 * Clear PageTail before unfreezing page refcount.
+	 *
+	 * After successful get_page_unless_zero() might follow put_page()
+	 * which needs correct compound_head().
+	 */
 	clear_compound_head(page_tail);
 
+	/* Finally unfreeze refcount. Additional reference from page cache. */
+	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
+					  PageSwapCache(head)));
+
 	if (page_is_young(head))
 		set_page_young(page_tail);
 	if (page_is_idle(head))
-- 
2.17.1



