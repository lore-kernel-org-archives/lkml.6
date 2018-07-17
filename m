Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3F5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbeGQBZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:25:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:31703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbeGQBZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="245788293"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.197.184])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2018 17:55:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 4/7] swap: Unify normal/huge code path in swap_page_trans_huge_swapped()
Date:   Tue, 17 Jul 2018 08:55:53 +0800
Message-Id: <20180717005556.29758-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717005556.29758-1-ying.huang@intel.com>
References: <20180717005556.29758-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Dave, we should unify the code path for normal and
huge swap support if possible to avoid duplicated code, bugs, etc. and
make it easier to review code.

In this patch, the normal/huge code path in swap_page_trans_huge_swapped()
is unified, the added and removed lines are same.  And the binary size
is kept almost same when CONFIG_TRANSPARENT_HUGEPAGE=n.

		 text	   data	    bss	    dec	    hex	filename
base:		24179	   2028	    340	  26547	   67b3	mm/swapfile.o
unified:	24215	   2028	    340	  26583	   67d7	mm/swapfile.o

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 92c24402706c..a6d8b8117bc5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -270,7 +270,10 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
 
 static inline bool cluster_is_huge(struct swap_cluster_info *info)
 {
-	return info->flags & CLUSTER_FLAG_HUGE;
+	if (IS_ENABLED(CONFIG_THP_SWAP))
+		return info->flags & CLUSTER_FLAG_HUGE;
+	else
+		return false;
 }
 
 static inline void cluster_clear_huge(struct swap_cluster_info *info)
@@ -1489,9 +1492,6 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 	int i;
 	bool ret = false;
 
-	if (!IS_ENABLED(CONFIG_THP_SWAP))
-		return swap_swapcount(si, entry) != 0;
-
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (!ci || !cluster_is_huge(ci)) {
 		if (swap_count(map[roffset]))
-- 
2.16.4

