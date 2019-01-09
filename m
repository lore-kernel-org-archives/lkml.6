Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF7C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B39C214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfAIEB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:01:26 -0500
Received: from shelob.surriel.com ([96.67.55.147]:39782 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfAIEB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:01:26 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gh53I-0006Hz-B2; Tue, 08 Jan 2019 23:01:12 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>, kernel-team@fb.com,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] mm,slab,memcg: call memcg kmem put cache with same condition as get
Date:   Tue,  8 Jan 2019 23:01:07 -0500
Message-Id: <20190109040107.4110-1-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an imbalance between when slab_pre_alloc_hook calls
memcg_kmem_get_cache and when slab_post_alloc_hook calls
memcg_kmem_put_cache.

This can cause a memcg kmem cache to be destroyed right as
an object from that cache is being allocated, which is probably
not good. It could lead to things like a memcg allocating new
kmalloc slabs instead of using freed space in old ones, maybe
memory leaks, and maybe oopses as a memcg kmalloc slab is getting
destroyed on one CPU while another CPU is trying to do an allocation
from that same memcg.

The obvious fix would be to use the same condition for calling
memcg_kmem_put_cache that we also use to decide whether to call
memcg_kmem_get_cache.

I am not sure how long this bug has been around, since the last
changeset to touch that code - 452647784b2f ("mm: memcontrol: cleanup
 kmem charge functions") - merely moved the bug from one location to
another. I am still tagging that changeset, because the fix should
automatically apply that far back.

Signed-off-by: Rik van Riel <riel@surriel.com>
Fixes: 452647784b2f ("mm: memcontrol: cleanup kmem charge functions")
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/slab.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9..ab3d95bef8a0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -444,7 +444,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 		p[i] = kasan_slab_alloc(s, object, flags);
 	}
 
-	if (memcg_kmem_enabled())
+	if (memcg_kmem_enabled() &&
+	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
 		memcg_kmem_put_cache(s);
 }
 
-- 
2.17.1

