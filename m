Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C698C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfADMvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:51:25 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:35363 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfADMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:51:25 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 735231C2148
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:51:23 +0000 (GMT)
Received: (qmail 32386 invoked from network); 4 Jan 2019 12:51:23 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:51:23 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/25] mm, compaction: Skip pageblocks with reserved pages
Date:   Fri,  4 Jan 2019 12:49:52 +0000
Message-Id: <20190104125011.16071-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved pages are set at boot time, tend to be clustered and almost never
become unreserved. When isolating pages for either migration sources or
target, skip the entire pageblock is one PageReserved page is encountered
on the grounds that it is highly probable the entire pageblock is reserved.

The performance impact is relative to the number of reserved pages in
the system and their location so it'll be variable but intuitively it
should make sense. If the memblock allocator was ever changed to spread
reserved pages throughout the address space then this patch would be
impaired but it would also be considered a bug given that such a change
would ruin fragmentation.

On both 1-socket and 2-socket machines, scan rates are reduced slightly
on workloads that intensively allocate THP while the system is fragmented.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3afa4e9188b6..94d1e5b062ea 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -484,6 +484,15 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 			goto isolate_fail;
 		}
 
+		/*
+		 * A reserved page is never freed and tend to be clustered in
+		 * the same pageblock. Skip the block.
+		 */
+		if (PageReserved(page)) {
+			blockpfn = end_pfn;
+			break;
+		}
+
 		if (!PageBuddy(page))
 			goto isolate_fail;
 
@@ -827,6 +836,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					goto isolate_success;
 			}
 
+			/*
+			 * A reserved page is never freed and tend to be
+			 * clustered in the same pageblocks. Skip the block.
+			 */
+			if (PageReserved(page))
+				low_pfn = end_pfn;
+
 			goto isolate_fail;
 		}
 
-- 
2.16.4

