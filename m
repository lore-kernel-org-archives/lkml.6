Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4175AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32D420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966907AbeFRJS7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:18:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38573 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936755AbeFRJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE44AACC0;
        Mon, 18 Jun 2018 09:18:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 3/7] mm, slab: allocate off-slab freelists as reclaimable when appropriate
Date:   Mon, 18 Jun 2018 11:18:04 +0200
Message-Id: <20180618091808.4419-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618091808.4419-1-vbabka@suse.cz>
References: <20180618091808.4419-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SLAB, OFF_SLAB caches allocate management structures (currently just the
freelist) from kmalloc caches when placement in a slab page together with
objects would lead to suboptimal memory usage. For SLAB_RECLAIM_ACCOUNT caches,
we can allocate the freelists from the newly introduced reclaimable kmalloc
caches, because shrinking the OFF_SLAB cache will in general result to freeing
of the freelists as well. This should improve accounting and anti-fragmentation
a bit.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9515798f37b2..99d779ba2b92 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2140,8 +2140,13 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 #endif
 
 	if (OFF_SLAB(cachep)) {
+		/*
+		 * If this cache is reclaimable, allocate also freelists from
+		 * a reclaimable kmalloc cache.
+		 */
 		cachep->freelist_cache =
-			kmalloc_slab(cachep->freelist_size, 0u);
+			kmalloc_slab(cachep->freelist_size,
+				     cachep->allocflags & __GFP_RECLAIMABLE);
 	}
 
 	err = setup_cpu_cache(cachep, gfp);
-- 
2.17.1

