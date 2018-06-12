Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B30DDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E9D208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9D208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeFLM0o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:26:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:53027 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932736AbeFLM0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:26:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5295FABF9;
        Tue, 12 Jun 2018 12:26:42 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH] mm, page_alloc: actually ignore mempolicies for high priority allocations
Date:   Tue, 12 Jun 2018 14:26:24 +0200
Message-Id: <20180612122624.8045-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __alloc_pages_slowpath() function has for a long time contained code to
ignore node restrictions from memory policies for high priority allocations.
The current code that resets the zonelist iterator however does effectively
nothing after commit 7810e6781e0f ("mm, page_alloc: do not break __GFP_THISNODE
by zonelist reset") removed a buggy zonelist reset. Even before that commit,
mempolicy restrictions were still not ignored, as they are passed in
ac->nodemask which is untouched by the code.

We can either remove the code, or make it work as intended. Since
ac->nodemask can be set from task's mempolicy via alloc_pages_current() and
thus also alloc_pages(), it may indeed affect kernel allocations, and it makes
sense to ignore it to allow progress for high priority allocations.

Thus, this patch resets ac->nodemask to NULL in such cases. This assumes all
callers can handle it (i.e. there are no guarantees as in the case of
__GFP_THISNODE) which seems to be the case. The same assumption is already
present in check_retry_cpuset() for some time.

The expected effect is that high priority kernel allocations in the context of
userspace tasks (e.g. OOM victims) restricted by mempolicies will have higher
chance to succeed if they are restricted to nodes with depleted memory, while
there are other nodes with free memory left.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 07b3c23762ad..ec8c92ff8b3c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4164,11 +4164,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		alloc_flags = reserve_flags;
 
 	/*
-	 * Reset the zonelist iterators if memory policies can be ignored.
-	 * These allocations are high priority and system rather than user
-	 * orientated.
+	 * Reset the nodemask and zonelist iterators if memory policies can be
+	 * ignored. These allocations are high priority and system rather than
+	 * user oriented.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
+		ac->nodemask = NULL;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->high_zoneidx, ac->nodemask);
 	}
-- 
2.17.1

