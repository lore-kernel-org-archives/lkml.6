Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ECD208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfADMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:51:36 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:41702 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfADMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:51:35 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 9F4F91C213C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:51:33 +0000 (GMT)
Received: (qmail 613 invoked from network); 4 Jan 2019 12:51:33 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:51:33 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 07/25] mm, migrate: Immediately fail migration of a page with no migration handler
Date:   Fri,  4 Jan 2019 12:49:53 +0000
Message-Id: <20190104125011.16071-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages with no migration handler use a fallback handler which sometimes
works and sometimes persistently retries. A historical example was blockdev
pages but there are others such as odd refcounting when page->private
is used.  These are retried multiple times which is wasteful during
compaction so this patch will fail migration faster unless the caller
specifies MIGRATE_SYNC.

This is not expected to help THP allocation success rates but it did
reduce latencies very slightly in some cases.

1-socket thpfioscale
                                        4.20.0                 4.20.0
                              noreserved-v2r15         failfast-v2r15
Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
Amean     fault-both-3      3839.67 (   0.00%)     3833.72 (   0.15%)
Amean     fault-both-5      5177.47 (   0.00%)     4967.15 (   4.06%)
Amean     fault-both-7      7245.03 (   0.00%)     7139.19 (   1.46%)
Amean     fault-both-12    11534.89 (   0.00%)    11326.30 (   1.81%)
Amean     fault-both-18    16241.10 (   0.00%)    16270.70 (  -0.18%)
Amean     fault-both-24    19075.91 (   0.00%)    19839.65 (  -4.00%)
Amean     fault-both-30    22712.11 (   0.00%)    21707.05 (   4.43%)
Amean     fault-both-32    21692.92 (   0.00%)    21968.16 (  -1.27%)

The 2-socket results are not materially different. Scan rates are similar
as expected.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5d1839a9148d..547cc1f3f3bb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -916,7 +916,7 @@ static int fallback_migrate_page(struct address_space *mapping,
 	 */
 	if (page_has_private(page) &&
 	    !try_to_release_page(page, GFP_KERNEL))
-		return -EAGAIN;
+		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
 
 	return migrate_page(mapping, newpage, page, mode);
 }
-- 
2.16.4

