Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968629AbeE3Bui (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:50:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39386 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968432AbeE3Bug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:50:36 -0400
X-Google-Smtp-Source: ADUXVKJSEFcHcw/Vi9xwa5JTvYT8VdJPPgGgjdig9QheH3Ocap2fN5fwyeyMOsHlZ0DzON1rbax9Dg==
Date: Tue, 29 May 2018 18:50:22 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Andrew Morton <akpm@linux-foundation.org>
cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/huge_memory.c: __split_huge_page() use atomic
 ClearPageDirty()
Message-ID: <alpine.LSU.2.11.1805291841070.3197@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swapping load on huge=always tmpfs (with khugepaged tuned up to be very
eager, but I'm not sure that is relevant) soon hung uninterruptibly,
waiting for page lock in shmem_getpage_gfp()'s find_lock_entry(), most
often when "cp -a" was trying to write to a smallish file.  Debug showed
that the page in question was not locked, and page->mapping NULL by now,
but page->index consistent with having been in a huge page before.

Reproduced in minutes on a 4.15 kernel, even with 4.17's 605ca5ede764
("mm/huge_memory.c: reorder operations in __split_huge_page_tail()")
added in; but took hours to reproduce on a 4.17 kernel (no idea why).

The culprit proved to be the __ClearPageDirty() on tails beyond i_size
in __split_huge_page(): the non-atomic __bitoperation may have been safe
when 4.8's baa355fd3314 ("thp: file pages support for split_huge_page()")
introduced it, but liable to erase PageWaiters after 4.10's 62906027091f
("mm: add PageWaiters indicating tasks are waiting for a page bit").

Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

It's not a 4.17-rc regression that this fixes, so no great need to slip
this into 4.17 at the last moment - though it makes a good companion to
Konstantin's 605ca5ede764. I think they both should go to stable, but
since Konstantin's already went into rc1 without that tag, we shall
have to recommend Konstantin's to GregKH out-of-band.

 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.17-rc7/mm/huge_memory.c	2018-04-26 10:48:36.019288258 -0700
+++ linux/mm/huge_memory.c	2018-05-29 18:14:52.095512715 -0700
@@ -2431,7 +2431,7 @@ static void __split_huge_page(struct pag
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
-			__ClearPageDirty(head + i);
+			ClearPageDirty(head + i);
 			__delete_from_page_cache(head + i, NULL);
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
 				shmem_uncharge(head->mapping->host, 1);
