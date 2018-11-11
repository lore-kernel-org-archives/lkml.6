Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C12C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C75D214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C75D214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbeKLGFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53076 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731042AbeKLGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000l9-DZ; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001X2-Mx; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Vlastimil Babka" <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "David Rientjes" <rientjes@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.30264303@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 126/366] mm, page_alloc: do not break __GFP_THISNODE
 by zonelist reset
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 7810e6781e0fcbca78b91cf65053f895bf59e85f upstream.

In __alloc_pages_slowpath() we reset zonelist and preferred_zoneref for
allocations that can ignore memory policies.  The zonelist is obtained
from current CPU's node.  This is a problem for __GFP_THISNODE
allocations that want to allocate on a different node, e.g.  because the
allocating thread has been migrated to a different CPU.

This has been observed to break SLAB in our 4.4-based kernel, because
there it relies on __GFP_THISNODE working as intended.  If a slab page
is put on wrong node's list, then further list manipulations may corrupt
the list because page_to_nid() is used to determine which node's
list_lock should be locked and thus we may take a wrong lock and race.

Current SLAB implementation seems to be immune by luck thanks to commit
511e3a058812 ("mm/slab: make cache_grow() handle the page allocated on
arbitrary node") but there may be others assuming that __GFP_THISNODE
works as promised.

We can fix it by simply removing the zonelist reset completely.  There
is actually no reason to reset it, because memory policies and cpusets
don't affect the zonelist choice in the first place.  This was different
when commit 183f6371aac2 ("mm: ignore mempolicies when using
ALLOC_NO_WATERMARK") introduced the code, as mempolicies provided their
own restricted zonelists.

We might consider this for 4.17 although I don't know if there's
anything currently broken.

SLAB is currently not affected, but in kernels older than 4.7 that don't
yet have 511e3a058812 ("mm/slab: make cache_grow() handle the page
allocated on arbitrary node") it is.  That's at least 4.4 LTS.  Older
ones I'll have to check.

So stable backports should be more important, but will have to be
reviewed carefully, as the code went through many changes.  BTW I think
that also the ac->preferred_zoneref reset is currently useless if we
don't also reset ac->nodemask from a mempolicy to NULL first (which we
probably should for the OOM victims etc?), but I would leave that for a
separate patch.

Link: http://lkml.kernel.org/r/20180525130853.13915-1-vbabka@suse.cz
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: 183f6371aac2 ("mm: ignore mempolicies when using ALLOC_NO_WATERMARK")
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Resetting the zonelist may still be useful here,
 so keep doing it if __GFP_THISNODE is not used.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2594,7 +2594,8 @@ rebalance:
 		 * the allocation is high priority and these type of
 		 * allocations are system rather than user orientated
 		 */
-		zonelist = node_zonelist(numa_node_id(), gfp_mask);
+		if (!(gfp_mask & __GFP_THISNODE))
+			zonelist = node_zonelist(numa_node_id(), gfp_mask);
 
 		page = __alloc_pages_high_priority(gfp_mask, order,
 				zonelist, high_zoneidx, nodemask,

