Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21470ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB28E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB28E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeGSJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:31:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:10706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeGSJa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:30:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76038263"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.195.246])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 01:48:50 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 1/8] swap: Add comments to lock_cluster_or_swap_info()
Date:   Thu, 19 Jul 2018 16:48:35 +0800
Message-Id: <20180719084842.11385-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719084842.11385-1-ying.huang@intel.com>
References: <20180719084842.11385-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the code readability.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d8fddfb000ec..29da44411734 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -297,13 +297,19 @@ static inline void unlock_cluster(struct swap_cluster_info *ci)
 		spin_unlock(&ci->lock);
 }
 
+/*
+ * Determine the locking method in use for this device.  Return
+ * swap_cluster_info if SSD-style cluster-based locking is in place.
+ */
 static inline struct swap_cluster_info *lock_cluster_or_swap_info(
 	struct swap_info_struct *si,
 	unsigned long offset)
 {
 	struct swap_cluster_info *ci;
 
+	/* Try to use fine-grained SSD-style locking if available: */
 	ci = lock_cluster(si, offset);
+	/* Otherwise, fall back to traditional, coarse locking: */
 	if (!ci)
 		spin_lock(&si->lock);
 
-- 
2.16.4

