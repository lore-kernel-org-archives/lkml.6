Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414BFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38A8208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeLNXDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:46 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:54583 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729789AbeLNXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:13 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 533C61C20A2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:12 +0000 (GMT)
Received: (qmail 31262 invoked from network); 14 Dec 2018 23:03:12 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPA; 14 Dec 2018 23:03:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/14] mm, migrate: Immediately fail migration of a page with no migration handler
Date:   Fri, 14 Dec 2018 23:03:02 +0000
Message-Id: <20181214230310.572-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages with no migration handler use a fallback hander which sometimes
works and sometimes persistently fails such as blockdev pages. Migration
will retry a number of times on these persistent pages which is wasteful
during compaction. This patch will fail migration immediately unless the
caller is in MIGRATE_SYNC mode which indicates the caller is willing to
wait while being persistent.

This is not expected to help THP allocation success rates but it does
reduce latencies slightly.

1-socket thpfioscale
                                    4.20.0-rc6             4.20.0-rc6
                               noreserved-v1r4          failfast-v1r4
Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
Amean     fault-both-3      2276.15 (   0.00%)     3867.54 * -69.92%*
Amean     fault-both-5      4992.20 (   0.00%)     5313.20 (  -6.43%)
Amean     fault-both-7      7373.30 (   0.00%)     7039.11 (   4.53%)
Amean     fault-both-12    11911.52 (   0.00%)    11328.29 (   4.90%)
Amean     fault-both-18    17209.42 (   0.00%)    16455.34 (   4.38%)
Amean     fault-both-24    20943.71 (   0.00%)    20448.94 (   2.36%)
Amean     fault-both-30    22703.00 (   0.00%)    21655.07 (   4.62%)
Amean     fault-both-32    22461.41 (   0.00%)    21415.35 (   4.66%)

The 2-socket results are not materially different. Scan rates are
similar as expected.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df17a710e2c7..0e27a10429e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -885,7 +885,7 @@ static int fallback_migrate_page(struct address_space *mapping,
 	 */
 	if (page_has_private(page) &&
 	    !try_to_release_page(page, GFP_KERNEL))
-		return -EAGAIN;
+		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
 
 	return migrate_page(mapping, newpage, page, mode);
 }
-- 
2.16.4

