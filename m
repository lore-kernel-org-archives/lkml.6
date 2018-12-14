Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B1C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375E120645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375E120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeLNG3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:29:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:52260 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:27:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 22:27:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,351,1539673200"; 
   d="scan'208";a="125840848"
Received: from yhuang-mobile.sh.intel.com ([10.239.197.226])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2018 22:27:52 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -V9 05/21] swap: Support PMD swap mapping in put_swap_page()
Date:   Fri, 14 Dec 2018 14:27:38 +0800
Message-Id: <20181214062754.13723-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181214062754.13723-1-ying.huang@intel.com>
References: <20181214062754.13723-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, during swapout, all PMD page mapping will be split and
replaced with PTE swap mapping.  And when clearing the SWAP_HAS_CACHE
flag for the huge swap cluster in put_swap_page(), the huge swap
cluster will be split.  Now, during swapout, the PMD page mappings to
the THP will be changed to PMD swap mappings to the corresponding swap
cluster.  So when clearing the SWAP_HAS_CACHE flag, the huge swap
cluster will only be split if the PMD swap mapping count is 0.
Otherwise, we will keep it as the huge swap cluster.  So that we can
swapin a THP in one piece later.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swapfile.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bd8756ac3bcc..04cf6b95cae0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1314,6 +1314,15 @@ void swap_free(swp_entry_t entry)
 
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
+ *
+ * When a THP is added into swap cache, the SWAP_HAS_CACHE flag will
+ * be set in the swap_map[] of all swap entries in the huge swap
+ * cluster backing the THP.  This huge swap cluster will not be split
+ * unless the THP is split even if its PMD swap mapping count dropped
+ * to 0.  Later, when the THP is removed from swap cache, the
+ * SWAP_HAS_CACHE flag will be cleared in the swap_map[] of all swap
+ * entries in the huge swap cluster.  And this huge swap cluster will
+ * be split if its PMD swap mapping count is 0.
  */
 void put_swap_page(struct page *page, swp_entry_t entry)
 {
@@ -1332,15 +1341,23 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (size == SWAPFILE_CLUSTER) {
-		VM_BUG_ON(!cluster_is_huge(ci));
+		VM_BUG_ON(!IS_ALIGNED(offset, size));
 		map = si->swap_map + offset;
-		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
-			val = map[i];
-			VM_BUG_ON(!(val & SWAP_HAS_CACHE));
-			if (val == SWAP_HAS_CACHE)
-				free_entries++;
+		/*
+		 * No PMD swap mapping, the swap cluster will be freed
+		 * if all swap entries becoming free, otherwise the
+		 * huge swap cluster will be split.
+		 */
+		if (!cluster_swapcount(ci)) {
+			for (i = 0; i < SWAPFILE_CLUSTER; i++) {
+				val = map[i];
+				VM_BUG_ON(!(val & SWAP_HAS_CACHE));
+				if (val == SWAP_HAS_CACHE)
+					free_entries++;
+			}
+			if (free_entries != SWAPFILE_CLUSTER)
+				cluster_clear_huge(ci);
 		}
-		cluster_clear_huge(ci);
 		if (free_entries == SWAPFILE_CLUSTER) {
 			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
-- 
2.18.1

