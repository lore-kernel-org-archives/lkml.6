Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E895C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C906020671
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C906020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeH0LlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:41:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:25995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0LlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 00:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="80463046"
Received: from yhuang-mobile.sh.intel.com ([10.239.198.115])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2018 00:55:41 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/3] swap: call free_swap_slot() in __swap_entry_free()
Date:   Mon, 27 Aug 2018 15:55:34 +0800
Message-Id: <20180827075535.17406-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827075535.17406-1-ying.huang@intel.com>
References: <20180827075535.17406-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a code cleanup patch without functionality change.

Originally, when __swap_entry_free() is called, and its return value
is 0, free_swap_slot() will always be called to free the swap entry to
the per-CPU pool.  So move the call to free_swap_slot() to
__swap_entry_free() to simplify the code.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/swapfile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 409926079607..ef974bbd7715 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1241,6 +1241,8 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	ci = lock_cluster_or_swap_info(p, offset);
 	usage = __swap_entry_free_locked(p, offset, usage);
 	unlock_cluster_or_swap_info(p, ci);
+	if (!usage)
+		free_swap_slot(entry);
 
 	return usage;
 }
@@ -1271,10 +1273,8 @@ void swap_free(swp_entry_t entry)
 	struct swap_info_struct *p;
 
 	p = _swap_info_get(entry);
-	if (p) {
-		if (!__swap_entry_free(p, entry, 1))
-			free_swap_slot(entry);
-	}
+	if (p)
+		__swap_entry_free(p, entry, 1);
 }
 
 /*
@@ -1705,8 +1705,6 @@ int free_swap_and_cache(swp_entry_t entry)
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
-		else if (!count)
-			free_swap_slot(entry);
 	}
 	return p != NULL;
 }
-- 
2.16.4

