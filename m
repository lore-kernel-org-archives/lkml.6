Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeBSTqH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:46:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeBSTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:46:05 -0500
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 01/61] radix tree test suite: Check reclaim bit
Date: Mon, 19 Feb 2018 11:44:56 -0800
Message-Id: <20180219194556.6575-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219194556.6575-1-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

In order to test the memory allocation failure paths, the radix tree
test suite fails allocations if __GFP_NOWARN is set.  That happens to work
for the radix tree implementation, but the semantics we really want are
that we want to fail allocations which are not GFP_KERNEL.  Do this
by failing allocations which don't have the DIRECT_RECLAIM bit set.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 tools/testing/radix-tree/linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 6903ccf35595..f7f3caed3650 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -29,7 +29,7 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int flags)
 {
 	struct radix_tree_node *node;
 
-	if (flags & __GFP_NOWARN)
+	if (!(flags & __GFP_DIRECT_RECLAIM))
 		return NULL;
 
 	pthread_mutex_lock(&cachep->lock);
-- 
2.16.1
