Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF116214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLZFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:15:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:56433 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbeLZFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:15:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2018 21:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,399,1539673200"; 
   d="scan'208";a="121683858"
Received: from yhuang-mobile.sh.intel.com ([10.239.192.121])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2018 21:14:57 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Shaohua Li <shli@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm, swap: Fix swapoff with KSM pages
Date:   Wed, 26 Dec 2018 13:15:22 +0800
Message-Id: <20181226051522.28442-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSM pages may be mapped to the multiple VMAs that cannot be reached
from one anon_vma.  So during swapin, a new copy of the page need to
be generated if a different anon_vma is needed, please refer to
comments of ksm_might_need_to_copy() for details.

During swapoff, unuse_vma() uses anon_vma (if available) to locate VMA
and virtual address mapped to the page, so not all mappings to a
swapped out KSM page could be found.  So in try_to_unuse(), even if
the swap count of a swap entry isn't zero, the page needs to be
deleted from swap cache, so that, in the next round a new page could
be allocated and swapin for the other mappings of the swapped out KSM
page.

But this contradicts with the THP swap support.  Where the THP could
be deleted from swap cache only after the swap count of every swap
entry in the huge swap cluster backing the THP has reach 0.  So
try_to_unuse() is changed in commit e07098294adf ("mm, THP, swap:
support to reclaim swap space for THP swapped out") to check that
before delete a page from swap cache, but this has broken KSM swapoff
too.

Fortunately, KSM is for the normal pages only, so the original
behavior for KSM pages could be restored easily via checking
PageTransCompound().  That is how this patch works.

Fixes: e07098294adf ("mm, THP, swap: support to reclaim swap space for THP swapped out")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-and-Tested-and-Acked-by: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swapfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8688ae65ef58..20d3c0f47a5f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2197,7 +2197,8 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		 */
 		if (PageSwapCache(page) &&
 		    likely(page_private(page) == entry.val) &&
-		    !page_swapped(page))
+		    (!PageTransCompound(page) ||
+		     !swap_page_trans_huge_swapped(si, entry)))
 			delete_from_swap_cache(compound_head(page));
 
 		/*
-- 
2.19.2

