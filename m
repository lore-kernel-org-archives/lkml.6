Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164379AbeE1KzV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164369AbeE1KzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Tejun Heo <tj@kernel.org>, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 308/496] mm, slab: memcg_link the SLABs kmem_cache
Date: Mon, 28 May 2018 12:01:33 +0200
Message-Id: <20180528100332.776782008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeelb@google.com>

[ Upstream commit 880cd276dff17ea29e9a8404275c9502b265afa7 ]

All the root caches are linked into slab_root_caches which was
introduced by the commit 510ded33e075 ("slab: implement slab_root_caches
list") but it missed to add the SLAB's kmem_cache.

While experimenting with opt-in/opt-out kmem accounting, I noticed
system crashes due to NULL dereference inside cache_from_memcg_idx()
while deferencing kmem_cache.memcg_params.memcg_caches.  The upstream
clean kernel will not see these crashes but SLAB should be consistent
with SLUB which does linked its boot caches (kmem_cache_node and
kmem_cache) into slab_root_caches.

Link: http://lkml.kernel.org/r/20180319210020.60289-1-shakeelb@google.com
Fixes: 510ded33e075c ("slab: implement slab_root_caches list")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slab.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1283,6 +1283,7 @@ void __init kmem_cache_init(void)
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
 				  SLAB_HWCACHE_ALIGN);
 	list_add(&kmem_cache->list, &slab_caches);
+	memcg_link_cache(kmem_cache);
 	slab_state = PARTIAL;
 
 	/*
