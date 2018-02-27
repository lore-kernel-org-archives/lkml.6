Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeB0X0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:26:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39003 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeB0X0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:26:20 -0500
X-Google-Smtp-Source: AH8x226eI5gFKvGVWl1B0+T/IOciMPIjeuAtsIWbJzDDuyxwlAslcyc0KIOv3ibko5yaGRZb5iINlg==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH] mm:swap: do not check readahead flag with THP anon
Date: Wed, 28 Feb 2018 08:26:11 +0900
Message-Id: <20180227232611.169883-1-minchan@kernel.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang reported PG_readahead flag marked PF_NO_COMPOUND so that
we cannot use the flag for THP page. So, we need to check first
whether page is THP or not before using TestClearPageReadahead
in lookup_swap_cache.

This patch fixes it.

Furthermore, swap_[cluster|vma]_readahead cannot mark PG_readahead
for newly allocated page because the allocated page is always a
normal page, not THP at this moment. So let's clean it up, too.

Cc: Hugh Dickins <hughd@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/swap_state.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8dde719e973c..1c4ac3220f41 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -348,12 +348,17 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 	INC_CACHE_INFO(find_total);
 	if (page) {
 		bool vma_ra = swap_use_vma_readahead();
-		bool readahead = TestClearPageReadahead(page);
+		bool readahead;
 
 		INC_CACHE_INFO(find_success);
+		/*
+		 * At the moment, we don't support PG_readahead for anon THP
+		 * so let's bail out rather than confusing the readahead stat.
+		 */
 		if (unlikely(PageTransCompound(page)))
 			return page;
 
+		readahead = TestClearPageReadahead(page);
 		if (vma && vma_ra) {
 			unsigned long ra_val;
 			int win, hits;
@@ -608,8 +613,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 			continue;
 		if (page_allocated) {
 			swap_readpage(page, false);
-			if (offset != entry_offset &&
-			    likely(!PageTransCompound(page))) {
+			if (offset != entry_offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
 			}
@@ -772,8 +776,7 @@ struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 			continue;
 		if (page_allocated) {
 			swap_readpage(page, false);
-			if (i != ra_info.offset &&
-			    likely(!PageTransCompound(page))) {
+			if (i != ra_info.offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
 			}
-- 
2.16.2.395.g2e18187dfd-goog
