Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954DDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C420671
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH0LlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:41:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:25995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeH0LlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:41:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 00:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="80463059"
Received: from yhuang-mobile.sh.intel.com ([10.239.198.115])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2018 00:55:44 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 3/3] swap: Clear si->swap_map[] in swap_free_cluster()
Date:   Mon, 27 Aug 2018 15:55:35 +0800
Message-Id: <20180827075535.17406-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827075535.17406-1-ying.huang@intel.com>
References: <20180827075535.17406-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si->swap_map[] of the swap entries in cluster needs to be cleared
during freeing.  Previously, this is done in the caller of
swap_free_cluster().  This may cause code duplication (one user now,
will add more users later) and lock/unlock cluster unnecessarily.  In
this patch, the clearing code is moved to swap_free_cluster() to avoid
the downside.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ef974bbd7715..97a1bd1a7c9a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -933,6 +933,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	struct swap_cluster_info *ci;
 
 	ci = lock_cluster(si, offset);
+	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
 	cluster_set_count_flag(ci, 0, 0);
 	free_cluster(si, idx);
 	unlock_cluster(ci);
@@ -1309,9 +1310,6 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 		if (free_entries == SWAPFILE_CLUSTER) {
 			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
-			ci = lock_cluster(si, offset);
-			memset(map, 0, SWAPFILE_CLUSTER);
-			unlock_cluster(ci);
 			mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
 			swap_free_cluster(si, idx);
 			spin_unlock(&si->lock);
-- 
2.16.4

