Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4F22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4F22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKIqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:46:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:1767 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeLKIqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:46:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 00:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="106520763"
Received: from yhuang-mobile.sh.intel.com ([10.239.192.61])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2018 00:46:18 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 2/2] swap: Deal with PTE mapped THP when unuse PTE
Date:   Tue, 11 Dec 2018 16:46:09 +0800
Message-Id: <20181211084609.19553-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181211084609.19553-1-ying.huang@intel.com>
References: <20181211084609.19553-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PTE swap entry may map to a normal swap slot inside a huge swap
cluster.  To free the huge swap cluster and the corresponding
THP (transparent huge page), all PTE swap entry mappings need to be
unmapped.  The original implementation only checks current PTE swap
entry mapping, this is fixed via calling try_to_free_swap() instead,
which will check all PTE swap mappings inside the huge swap cluster.

This fix could be folded into the patch: mm, swap: rid swapoff of
quadratic complexity in -mm patchset.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc: Kelley Nielsen <kelleynnn@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7464d0a92869..9e6da494781f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1921,10 +1921,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			goto out;
 		}
 
-		if (PageSwapCache(page) && (swap_count(*swap_map) == 0))
-			delete_from_swap_cache(compound_head(page));
+		try_to_free_swap(page);
 
-		SetPageDirty(page);
 		unlock_page(page);
 		put_page(page);
 
-- 
2.18.1

