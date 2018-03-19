Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971505AbeCSVBY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:01:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41671 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032270AbeCSVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:00:28 -0400
X-Google-Smtp-Source: AG47ELsgRAlKnRZ5ZJKmB6Z1al6LgBJzyJ67PprhyKum+Ckn+eEnDVexoIuoq+S66uXo+G2bLLL05g==
From: Shakeel Butt <shakeelb@google.com>
To: Tejun Heo <tj@kernel.org>, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm, slab: memcg_link the SLAB's kmem_cache
Date: Mon, 19 Mar 2018 14:00:20 -0700
Message-Id: <20180319210020.60289-1-shakeelb@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the root caches are linked into slab_root_caches which was
introduced by the commit 510ded33e075 ("slab: implement slab_root_caches
list") but it missed to add the SLAB's kmem_cache.

While experimenting with opt-in/opt-out kmem accounting, I noticed
system crashes due to NULL dereference inside cache_from_memcg_idx()
while deferencing kmem_cache.memcg_params.memcg_caches. The upstream
clean kernel will not see these crashes but SLAB should be consistent
with SLUB which does linked its boot caches (kmem_cache_node and
kmem_cache) into slab_root_caches.

Fixes: 510ded33e075c ("slab: implement slab_root_caches list")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slab.c b/mm/slab.c
index 324446621b3e..9095c3945425 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1283,6 +1283,7 @@ void __init kmem_cache_init(void)
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
 				  SLAB_HWCACHE_ALIGN, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
+	memcg_link_cache(kmem_cache);
 	slab_state = PARTIAL;
 
 	/*
-- 
2.16.2.804.g6dcf76e118-goog
