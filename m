Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE421C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E221783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfAILPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:15:10 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:52912 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730111AbfAILPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:15:10 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 041B81C29AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 11:15:08 +0000 (GMT)
Received: (qmail 8796 invoked from network); 9 Jan 2019 11:15:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2019 11:15:07 -0000
Date:   Wed, 9 Jan 2019 11:15:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, YueHaibing <yuehaibing@huawei.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm, compaction: Finish pageblock scanning on contention -fix
Message-ID: <20190109111506.GV31517@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

mm/compaction.c: In function 'compact_zone':
mm/compaction.c:2063:22: warning:
 variable 'c' set but not used [-Wunused-but-set-variable]
mm/compaction.c:2063:19: warning:
 variable 'b' set but not used [-Wunused-but-set-variable]
mm/compaction.c:2063:16: warning:
 variable 'a' set but not used [-Wunused-but-set-variable]

This never used since 94d5992baaa5 ("mm, compaction: finish
pageblock scanning on contention"). This is a fix to the mmotm patch
broken-out/mm-compaction-finish-pageblock-scanning-on-contention.patch

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 51da4691092b..ca8da58ce1cd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1963,7 +1963,6 @@ static enum compact_result compact_zone(struct compact_control *cc)
 	unsigned long end_pfn = zone_end_pfn(cc->zone);
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
-	unsigned long a, b, c;
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
@@ -2009,10 +2008,6 @@ static enum compact_result compact_zone(struct compact_control *cc)
 			cc->whole_zone = true;
 	}
 
-	a = cc->migrate_pfn;
-	b = cc->free_pfn;
-	c = (cc->free_pfn - cc->migrate_pfn) / pageblock_nr_pages;
-
 	last_migrated_pfn = 0;
 
 	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
