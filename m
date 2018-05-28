Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033520AbeE1PVA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033343AbeE1KVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:21:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 167/268] mm/ksm: fix interaction with THP
Date: Mon, 28 May 2018 12:02:21 +0200
Message-Id: <20180528100221.317780826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

[ Upstream commit 77da2ba0648a4fd52e5ff97b8b2b8dd312aec4b0 ]

This patch fixes a corner case for KSM.  When two pages belong or
belonged to the same transparent hugepage, and they should be merged,
KSM fails to split the page, and therefore no merging happens.

This bug can be reproduced by:
* making sure ksm is running (in case disabling ksmtuned)
* enabling transparent hugepages
* allocating a THP-aligned 1-THP-sized buffer
  e.g. on amd64: posix_memalign(&p, 1<<21, 1<<21)
* filling it with the same values
  e.g. memset(p, 42, 1<<21)
* performing madvise to make it mergeable
  e.g. madvise(p, 1<<21, MADV_MERGEABLE)
* waiting for KSM to perform a few scans

The expected outcome is that the all the pages get merged (1 shared and
the rest sharing); the actual outcome is that no pages get merged (1
unshared and the rest volatile)

The reason of this behaviour is that we increase the reference count
once for both pages we want to merge, but if they belong to the same
hugepage (or compound page), the reference counter used in both cases is
the one of the head of the compound page.  This means that
split_huge_page will find a value of the reference counter too high and
will fail.

This patch solves this problem by testing if the two pages to merge
belong to the same hugepage when attempting to merge them.  If so, the
hugepage is split safely.  This means that the hugepage is not split if
not necessary.

Link: http://lkml.kernel.org/r/1521548069-24758-1-git-send-email-imbrenda@linux.vnet.ibm.com
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Co-authored-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/ksm.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1494,8 +1494,22 @@ static void cmp_and_merge_page(struct pa
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
+		bool split;
+
 		kpage = try_to_merge_two_pages(rmap_item, page,
 						tree_rmap_item, tree_page);
+		/*
+		 * If both pages we tried to merge belong to the same compound
+		 * page, then we actually ended up increasing the reference
+		 * count of the same compound page twice, and split_huge_page
+		 * failed.
+		 * Here we set a flag if that happened, and we use it later to
+		 * try split_huge_page again. Since we call put_page right
+		 * afterwards, the reference count will be correct and
+		 * split_huge_page should succeed.
+		 */
+		split = PageTransCompound(page)
+			&& compound_head(page) == compound_head(tree_page);
 		put_page(tree_page);
 		if (kpage) {
 			/*
@@ -1520,6 +1534,20 @@ static void cmp_and_merge_page(struct pa
 				break_cow(tree_rmap_item);
 				break_cow(rmap_item);
 			}
+		} else if (split) {
+			/*
+			 * We are here if we tried to merge two pages and
+			 * failed because they both belonged to the same
+			 * compound page. We will split the page now, but no
+			 * merging will take place.
+			 * We do not want to add the cost of a full lock; if
+			 * the page is locked, it is better to skip it and
+			 * perhaps try again later.
+			 */
+			if (!trylock_page(page))
+				return;
+			split_huge_page(page);
+			unlock_page(page);
 		}
 	}
 }
