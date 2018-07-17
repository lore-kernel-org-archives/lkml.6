Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42387ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9BF208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9BF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGQBZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:25:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:31703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbeGQBZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="245788303"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.197.184])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2018 17:55:57 -0700
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
Subject: [PATCH v2 6/7] swap: Add __swap_entry_free_locked()
Date:   Tue, 17 Jul 2018 08:55:55 +0800
Message-Id: <20180717005556.29758-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717005556.29758-1-ying.huang@intel.com>
References: <20180717005556.29758-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part of __swap_entry_free() with lock held is separated into a new
function __swap_entry_free_locked().  Because we want to reuse that
piece of code in some other places.

Just mechanical code refactoring, there is no any functional change in
this function.

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
 mm/swapfile.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 622edc47b67a..fec28f6c05b0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1180,16 +1180,13 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free(struct swap_info_struct *p,
-				       swp_entry_t entry, unsigned char usage)
+static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
+					      unsigned long offset,
+					      unsigned char usage)
 {
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
 	unsigned char count;
 	unsigned char has_cache;
 
-	ci = lock_cluster_or_swap_info(p, offset);
-
 	count = p->swap_map[offset];
 
 	has_cache = count & SWAP_HAS_CACHE;
@@ -1217,6 +1214,17 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	usage = count | has_cache;
 	p->swap_map[offset] = usage ? : SWAP_HAS_CACHE;
 
+	return usage;
+}
+
+static unsigned char __swap_entry_free(struct swap_info_struct *p,
+				       swp_entry_t entry, unsigned char usage)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+
+	ci = lock_cluster_or_swap_info(p, offset);
+	usage = __swap_entry_free_locked(p, offset, usage);
 	unlock_cluster_or_swap_info(p, ci);
 
 	return usage;
-- 
2.16.4

