Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F5C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D62054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAROjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:39:07 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:52558 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbfAROjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:39:06 -0500
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 43C011C3514
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:39:04 +0000 (GMT)
Received: (qmail 7357 invoked from network); 18 Jan 2019 14:39:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2019 14:39:04 -0000
Date:   Fri, 18 Jan 2019 14:39:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 24/25] mm, compaction: Capture a page under direct
 compaction
Message-ID: <20190118143902.GR27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-25-mgorman@techsingularity.net>
 <d8a3dfc9-e4f6-ceb6-f29d-832bef14a14a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d8a3dfc9-e4f6-ceb6-f29d-832bef14a14a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:40:00PM +0100, Vlastimil Babka wrote:
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Great, you crossed off this old TODO item, and didn't need pageblock isolation
> to do that :D
> 

The TODO is not just old, it's ancient! The idea of capture was first
floated in 2008! A version was proposed at https://lwn.net/Articles/301246/
against 2.6.27-rc1-mm1.

> I have just one worry...
> 
> > @@ -837,6 +873,12 @@ static inline void __free_one_page(struct page *page,
> >  
> >  continue_merging:
> >  	while (order < max_order - 1) {
> > +		if (compaction_capture(capc, page, order)) {
> > +			if (likely(!is_migrate_isolate(migratetype)))
> > +				__mod_zone_freepage_state(zone, -(1 << order),
> > +								migratetype);
> > +			return;
> 
> What about MIGRATE_CMA pageblocks and compaction for non-movable allocation,
> won't that violate CMA expecteations?
> And less critically, this will avoid the migratetype stealing decisions and
> actions, potentially resulting in worse fragmentation avoidance?
> 

Both might be issues. How about this (untested)?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fe089ac8a207..d61174bb0333 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -799,11 +799,26 @@ static inline struct capture_control *task_capc(struct zone *zone)
 }
 
 static inline bool
-compaction_capture(struct capture_control *capc, struct page *page, int order)
+compaction_capture(struct capture_control *capc, struct page *page,
+		   int order, int migratetype)
 {
 	if (!capc || order != capc->cc->order)
 		return false;
 
+	/* Do not accidentally pollute CMA or isolated regions*/
+	if (is_migrate_cma(migratetype) ||
+	    is_migrate_isolate(migratetype))
+		return false;
+
+	/*
+	 * Do not let lower order allocations polluate a movable pageblock.
+	 * This might let an unmovable request use a reclaimable pageblock
+	 * and vice-versa but no more than normal fallback logic which can
+	 * have trouble finding a high-order free page.
+	 */
+	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
+		return false;
+
 	capc->page = page;
 	return true;
 }
@@ -815,7 +830,8 @@ static inline struct capture_control *task_capc(struct zone *zone)
 }
 
 static inline bool
-compaction_capture(struct capture_control *capc, struct page *page, int order)
+compaction_capture(struct capture_control *capc, struct page *page,
+		   int order, int migratetype)
 {
 	return false;
 }
@@ -870,7 +886,7 @@ static inline void __free_one_page(struct page *page,
 
 continue_merging:
 	while (order < max_order - 1) {
-		if (compaction_capture(capc, page, order)) {
+		if (compaction_capture(capc, page, order, migratetype)) {
 			if (likely(!is_migrate_isolate(migratetype)))
 				__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);

-- 
Mel Gorman
SUSE Labs
