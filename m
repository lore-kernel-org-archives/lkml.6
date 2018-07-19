Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B5720693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B5720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeGSJbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:31:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:10712 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbeGSJbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:31:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76038280"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.195.246])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 01:48:55 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 3/8] swap: Use swap_count() in swap_page_trans_huge_swapped()
Date:   Thu, 19 Jul 2018 16:48:37 +0800
Message-Id: <20180719084842.11385-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719084842.11385-1-ying.huang@intel.com>
References: <20180719084842.11385-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In swap_page_trans_huge_swapped(), to identify whether there's any
page table mapping for a 4k sized swap entry, "si->swap_map[i] !=
SWAP_HAS_CACHE" is used.  This works correctly now, because all users
of the function will only call it after checking SWAP_HAS_CACHE.  But
as pointed out by Daniel, it is better to use "swap_count(map[i])"
here, because it works for "map[i] == 0" case too.

And this makes the implementation more consistent between normal and
huge swap entry.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-and-reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 87c4c3446aed..cb0bc54e99c0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1498,12 +1498,12 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (!ci || !cluster_is_huge(ci)) {
-		if (map[roffset] != SWAP_HAS_CACHE)
+		if (swap_count(map[roffset]))
 			ret = true;
 		goto unlock_out;
 	}
 	for (i = 0; i < SWAPFILE_CLUSTER; i++) {
-		if (map[offset + i] != SWAP_HAS_CACHE) {
+		if (swap_count(map[offset + i])) {
 			ret = true;
 			break;
 		}
-- 
2.16.4

