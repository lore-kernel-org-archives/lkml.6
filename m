Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C282084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C282084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbeGTIGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:06:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:13644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeGTIGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:06:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 00:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,377,1526367600"; 
   d="scan'208";a="68652038"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.198.6])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2018 00:18:52 -0700
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
Subject: [PATCH v4 1/8] swap: Add comments to lock_cluster_or_swap_info()
Date:   Fri, 20 Jul 2018 15:18:38 +0800
Message-Id: <20180720071845.17920-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180720071845.17920-1-ying.huang@intel.com>
References: <20180720071845.17920-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the code readability.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-and-acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d8fddfb000ec..d101e044efbf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -297,13 +297,18 @@ static inline void unlock_cluster(struct swap_cluster_info *ci)
 		spin_unlock(&ci->lock);
 }
 
+/*
+ * Determine the locking method in use for this device.  Return
+ * swap_cluster_info if SSD-style cluster-based locking is in place.
+ */
 static inline struct swap_cluster_info *lock_cluster_or_swap_info(
-	struct swap_info_struct *si,
-	unsigned long offset)
+		struct swap_info_struct *si, unsigned long offset)
 {
 	struct swap_cluster_info *ci;
 
+	/* Try to use fine-grained SSD-style locking if available: */
 	ci = lock_cluster(si, offset);
+	/* Otherwise, fall back to traditional, coarse locking: */
 	if (!ci)
 		spin_lock(&si->lock);
 
-- 
2.16.4

