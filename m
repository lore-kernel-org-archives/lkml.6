Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3895C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB4208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfADMvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:51:15 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:35964 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbfADMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:51:15 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 40DC7988BA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:51:13 +0000 (UTC)
Received: (qmail 31909 invoked from network); 4 Jan 2019 12:51:13 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:51:13 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 05/25] mm, compaction: Rename map_pages to split_map_pages
Date:   Fri,  4 Jan 2019 12:49:51 +0000
Message-Id: <20190104125011.16071-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's non-obvious that high-order free pages are split into order-0 pages
from the function name. Fix it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7acb43f07303..3afa4e9188b6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -66,7 +66,7 @@ static unsigned long release_freepages(struct list_head *freelist)
 	return high_pfn;
 }
 
-static void map_pages(struct list_head *list)
+static void split_map_pages(struct list_head *list)
 {
 	unsigned int i, order, nr_pages;
 	struct page *page, *next;
@@ -644,7 +644,7 @@ isolate_freepages_range(struct compact_control *cc,
 	}
 
 	/* __isolate_free_page() does not map the pages */
-	map_pages(&freelist);
+	split_map_pages(&freelist);
 
 	if (pfn < end_pfn) {
 		/* Loop terminated early, cleanup. */
@@ -1141,7 +1141,7 @@ static void isolate_freepages(struct compact_control *cc)
 	}
 
 	/* __isolate_free_page() does not map the pages */
-	map_pages(freelist);
+	split_map_pages(freelist);
 
 	/*
 	 * Record where the free scanner will restart next time. Either we
-- 
2.16.4

