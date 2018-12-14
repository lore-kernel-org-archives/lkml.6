Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34020675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeLNXDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:53 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:47987 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbeLNXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:13 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 1A3701C20AD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:12 +0000 (GMT)
Received: (qmail 31244 invoked from network); 14 Dec 2018 23:03:11 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPA; 14 Dec 2018 23:03:11 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 05/14] mm, compaction: Skip pageblocks with reserved pages
Date:   Fri, 14 Dec 2018 23:03:01 +0000
Message-Id: <20181214230310.572-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved pages are set at boot time, tend to be clustered and almost
never become unreserved. When isolating pages for migrating, skip
the entire pageblock is one PageReserved page is encountered on the
grounds that it is highly probable the entire pageblock is reserved.

The impact depends on the machine and timing but both thpscale and
thpfioscale when using MADV_HUGEPAGE show a reduction of scanning and
fault latency on a 1-socket machine. The 2-socket results were too
noisy to draw any meaningful conclusion but it's safe to assume less
scanning is useful.

1-socket thpfioscale
                                   4.20.0-rc6             4.20.0-rc6
                               mmotm-20181210        noreserved-v1r4
Amean     fault-base-1     1481.32 (   0.00%)     1443.63 (   2.54%)
Amean     fault-huge-1     1118.17 (   0.00%)      981.30 *  12.24%*
Amean     fault-both-1     1176.43 (   0.00%)     1052.64 *  10.52%*

Compaction migrate scanned     3860713     3294284
Compaction free scanned      613786341   433423502
Kcompactd migrate scanned       408711      291915
Kcompactd free scanned       242509759   217164988

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3afa4e9188b6..8134dba47584 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -827,6 +827,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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

