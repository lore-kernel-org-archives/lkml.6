Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2530EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB34222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfBPRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:19:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:20101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfBPRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:19:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,377,1544515200"; 
   d="scan'208";a="320958358"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2019 09:19:39 -0800
Subject: [PATCH] mm: Fix buddy list helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Sat, 16 Feb 2019 09:07:02 -0800
Message-ID: <155033679702.1773410.13041474192173212653.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo reports that free page statistics are not reporting correctly,
and Vlastimil noticed that "mm: Move buddy list manipulations into
helpers" botched one of its conversions of add_to_free_area(). Fix the
double-increment of ->nr_free.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Andrew,

Please fold this into
mm-move-buddy-list-manipulations-into-helpers.patch.

 mm/page_alloc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a0969e3b0eb..da537fc39c54 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1851,7 +1851,6 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_area(&page[size], area, migratetype);
-		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
 }

