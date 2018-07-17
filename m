Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79509208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79509208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbeGQBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:25:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:31704 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbeGQBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="245788312"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.197.184])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2018 17:55:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 7/7] swap, put_swap_page: Share more between huge/normal code path
Date:   Tue, 17 Jul 2018 08:55:56 +0800
Message-Id: <20180717005556.29758-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717005556.29758-1-ying.huang@intel.com>
References: <20180717005556.29758-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, locking related code is shared between huge/normal code
path in put_swap_page() to reduce code duplication.  And `free_entries
== 0` case is merged into more general `free_entries !=
SWAPFILE_CLUSTER` case, because the new locking method makes it easy.

The added lines is same as the removed lines.  But the code size is
increased when CONFIG_TRANSPARENT_HUGEPAGE=n.

		text	   data	    bss	    dec	    hex	filename
base:	       24215	   2028	    340	  26583	   67d7	mm/swapfile.o
unified:       24577	   2028	    340	  26945	   6941	mm/swapfile.o

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index fec28f6c05b0..cd75f449896b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1280,8 +1280,8 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 	if (!si)
 		return;
 
+	ci = lock_cluster_or_swap_info(si, offset);
 	if (nr == SWAPFILE_CLUSTER) {
-		ci = lock_cluster(si, offset);
 		VM_BUG_ON(!cluster_is_huge(ci));
 		map = si->swap_map + offset;
 		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
@@ -1290,13 +1290,9 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 			if (val == SWAP_HAS_CACHE)
 				free_entries++;
 		}
-		if (!free_entries) {
-			for (i = 0; i < SWAPFILE_CLUSTER; i++)
-				map[i] &= ~SWAP_HAS_CACHE;
-		}
 		cluster_clear_huge(ci);
-		unlock_cluster(ci);
 		if (free_entries == SWAPFILE_CLUSTER) {
+			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
 			ci = lock_cluster(si, offset);
 			memset(map, 0, SWAPFILE_CLUSTER);
@@ -1307,12 +1303,16 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 			return;
 		}
 	}
-	if (nr == 1 || free_entries) {
-		for (i = 0; i < nr; i++, entry.val++) {
-			if (!__swap_entry_free(si, entry, SWAP_HAS_CACHE))
-				free_swap_slot(entry);
+	for (i = 0; i < nr; i++, entry.val++) {
+		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
+			unlock_cluster_or_swap_info(si, ci);
+			free_swap_slot(entry);
+			if (i == nr - 1)
+				return;
+			lock_cluster_or_swap_info(si, offset);
 		}
 	}
+	unlock_cluster_or_swap_info(si, ci);
 }
 
 #ifdef CONFIG_THP_SWAP
-- 
2.16.4

