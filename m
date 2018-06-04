Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeFDHEj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753808AbeFDHEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 40/47] mm/huge_memory.c: __split_huge_page() use atomic ClearPageDirty()
Date: Mon,  4 Jun 2018 08:58:52 +0200
Message-Id: <20180604065551.166394340@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit 2d077d4b59924acd1f5180c6fb73b57f4771fde6 upstream.

Swapping load on huge=always tmpfs (with khugepaged tuned up to be very
eager, but I'm not sure that is relevant) soon hung uninterruptibly,
waiting for page lock in shmem_getpage_gfp()'s find_lock_entry(), most
often when "cp -a" was trying to write to a smallish file.  Debug showed
that the page in question was not locked, and page->mapping NULL by now,
but page->index consistent with having been in a huge page before.

Reproduced in minutes on a 4.15 kernel, even with 4.17's 605ca5ede764
("mm/huge_memory.c: reorder operations in __split_huge_page_tail()") added
in; but took hours to reproduce on a 4.17 kernel (no idea why).

The culprit proved to be the __ClearPageDirty() on tails beyond i_size in
__split_huge_page(): the non-atomic __bitoperation may have been safe when
4.8's baa355fd3314 ("thp: file pages support for split_huge_page()")
introduced it, but liable to erase PageWaiters after 4.10's 62906027091f
("mm: add PageWaiters indicating tasks are waiting for a page bit").

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1805291841070.3197@eggly.anvils
Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2432,7 +2432,7 @@ static void __split_huge_page(struct pag
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
-			__ClearPageDirty(head + i);
+			ClearPageDirty(head + i);
 			__delete_from_page_cache(head + i, NULL);
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
 				shmem_uncharge(head->mapping->host, 1);
