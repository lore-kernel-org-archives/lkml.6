Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6F8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6494218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBAOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:38:57 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:59668 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfBAOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:38:56 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 1D0B11C1AA6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 14:38:55 +0000 (GMT)
Received: (qmail 12935 invoked from network); 1 Feb 2019 14:38:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Feb 2019 14:38:55 -0000
Date:   Fri, 1 Feb 2019 14:38:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm, compaction: Capture a page under direct compaction -fix
Message-ID: <20190201143853.GH9565@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-23-mgorman@techsingularity.net>
 <2124d934-0678-6a4b-9991-7450b1e4e39a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2124d934-0678-6a4b-9991-7450b1e4e39a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil pointed out that a check for isolation is redundant in
__free_one_page as compaction_capture checks for it.

This is a fix for the mmotm patch
mm-compaction-capture-a-page-under-direct-compaction.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d61174bb0333..b2eee9b71986 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -887,8 +887,7 @@ static inline void __free_one_page(struct page *page,
 continue_merging:
 	while (order < max_order - 1) {
 		if (compaction_capture(capc, page, order, migratetype)) {
-			if (likely(!is_migrate_isolate(migratetype)))
-				__mod_zone_freepage_state(zone, -(1 << order),
+			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
 			return;
 		}
