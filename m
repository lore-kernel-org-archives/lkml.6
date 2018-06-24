Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6417C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C93125031
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C93125031
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755754AbeFXPib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:38:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbeFXPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:38:28 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A519649F;
        Sun, 24 Jun 2018 15:38:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 64/64] mm, page_alloc: do not break __GFP_THISNODE by zonelist reset
Date:   Sun, 24 Jun 2018 23:22:45 +0800
Message-Id: <20180624142747.574342819@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4043,7 +4043,6 @@ retry:
 	 * orientated.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
-		ac->zonelist = node_zonelist(numa_node_id(), gfp_mask);
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->high_zoneidx, ac->nodemask);
 	}


