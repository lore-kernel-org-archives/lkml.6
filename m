Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeBKKfY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:35:24 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:35422 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752288AbeBKKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:35:23 -0500
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] mm/huge_memory.c: split should clone page flags before
 unfreezing pageref
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 11 Feb 2018 13:35:17 +0300
Message-ID: <151834531706.176342.14968581451762734122.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THP split makes non-atomic change of tail page flags. This is almost ok
because tail pages are locked and isolated but this breaks recent changes
in page locking: non-atomic operation could clear bit PG_waiters.

As a result concurrent sequence get_page_unless_zero() -> lock_page()
might block forever. Especially if this page was truncated later.

Fix is trivial: clone flags before unfreezing page reference counter.

This race exists since commit 62906027091f ("mm: add PageWaiters indicating
tasks are waiting for a page bit") while unsave unfreeze itself was added
in commit 8df651c7059e ("thp: cleanup split_huge_page()").

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/huge_memory.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87ab9b8f56b5..2b38d9f2f262 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2357,6 +2357,19 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
 	VM_BUG_ON_PAGE(page_ref_count(page_tail) != 0, page_tail);
 
+	/* Clone page flags before unfreezing refcount. */
+	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page_tail->flags |= (head->flags &
+			((1L << PG_referenced) |
+			 (1L << PG_swapbacked) |
+			 (1L << PG_swapcache) |
+			 (1L << PG_mlocked) |
+			 (1L << PG_uptodate) |
+			 (1L << PG_active) |
+			 (1L << PG_locked) |
+			 (1L << PG_unevictable) |
+			 (1L << PG_dirty)));
+
 	/*
 	 * tail_page->_refcount is zero and not changing from under us. But
 	 * get_page_unless_zero() may be running from under us on the
@@ -2375,18 +2388,6 @@ static void __split_huge_page_tail(struct page *head, int tail,
 		page_ref_add(page_tail, 2);
 	}
 
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
-			((1L << PG_referenced) |
-			 (1L << PG_swapbacked) |
-			 (1L << PG_swapcache) |
-			 (1L << PG_mlocked) |
-			 (1L << PG_uptodate) |
-			 (1L << PG_active) |
-			 (1L << PG_locked) |
-			 (1L << PG_unevictable) |
-			 (1L << PG_dirty)));
-
 	/*
 	 * After clearing PageTail the gup refcount can be released.
 	 * Page flags also must be visible before we make the page non-compound.
