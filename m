Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0735DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BAE2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ts+gYqP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BAE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757086AbeFQCNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:13:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbeFQCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p1s2XMEBnk2D2g4VCEPonZ83pOATuhxhcDCFzjFyqaA=; b=Ts+gYqP58YnyMrylGMj1c3Vlr
        G7ir+Jl6wnAU+9DDOuemSTNUDDOgye9CTsdjRJMkgUr7naQkqyfiiS846wWZtOpjC1p58YkgOuAvq
        1TyX+ERRxeEfszMRX59jrj7F3z7rfC8fnrZ39IlaXNR/HS6YGaPFcgD1V2XCDMzZUHTkAJBLr5dVu
        0iMppuZd6qFxubrHpJNgSp0vuwAQo5Ntse7WCKsUWA9aGLg03a8eKcf67fGiq5w67I+Z1jgtla8pf
        9Q5LMNmt7TSbiHYLtW3BFD2DOIjcNwnCHxf5Pf2wCw4vVeWj4IIWR1Q2aPAMBEiMVeG1gK76ssUf+
        PUQXnEJHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN03-0001Kx-BB; Sun, 17 Jun 2018 02:01:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 36/74] mm: Convert workingset to XArray
Date:   Sat, 16 Jun 2018 19:00:14 -0700
Message-Id: <20180617020052.4759-37-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We construct an XA_STATE and use it to delete the node with
xas_store() rather than adding a special function for this unique
use case.  Includes a test that simulates this usage for the
test suite.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/swap.h |  9 -------
 lib/test_xarray.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
 mm/workingset.c      | 51 +++++++++++++++---------------------
 3 files changed, 82 insertions(+), 39 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1b91e7f7bdeb..a450a1d40b19 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,15 +307,6 @@ void workingset_update_node(struct xa_node *node);
 		xas_set_update(xas, workingset_update_node);		\
 } while (0)
 
-/* Returns workingset_update_node() if the mapping has shadow entries. */
-#define workingset_lookup_update(mapping)				\
-({									\
-	radix_tree_update_node_t __helper = workingset_update_node;	\
-	if (dax_mapping(mapping) || shmem_mapping(mapping))		\
-		__helper = NULL;					\
-	__helper;							\
-})
-
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalreserve_pages;
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 818cfd8746ba..0ac0c8108ef4 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -554,6 +554,63 @@ static void check_move(struct xarray *xa)
 		check_move_small(xa, (1UL << i) - 1);
 }
 
+static LIST_HEAD(shadow_nodes);
+
+static void test_update_node(struct xa_node *node)
+{
+	if (node->count && node->count == node->nr_values) {
+		if (list_empty(&node->private_list))
+			list_add(&shadow_nodes, &node->private_list);
+	} else {
+		if (!list_empty(&node->private_list))
+			list_del_init(&node->private_list);
+	}
+}
+
+static void shadow_remove(struct xarray *xa)
+{
+	struct xa_node *node;
+
+	while ((node = list_first_entry_or_null(&shadow_nodes,
+					struct xa_node, private_list))) {
+		XA_STATE(xas, node->array, 0);
+		XA_BUG_ON(xa, node->array != xa);
+		list_del_init(&node->private_list);
+		xas.xa_node = xa_parent_locked(node->array, node);
+		xas.xa_offset = node->offset;
+		xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
+		xas_set_update(&xas, test_update_node);
+		xas_store(&xas, NULL);
+	}
+}
+
+static void check_workingset(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	xas_set_update(&xas, test_update_node);
+
+	do {
+		xas_store(&xas, xa_mk_value(0));
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	xas_next(&xas);
+	do {
+		xas_store(&xas, xa_mk_value(1));
+	} while (xas_nomem(&xas, GFP_KERNEL));
+	XA_BUG_ON(xa, list_empty(&shadow_nodes));
+
+	xas_next(&xas);
+	xas_store(&xas, &xas);
+	XA_BUG_ON(xa, !list_empty(&shadow_nodes));
+
+	xas_store(&xas, xa_mk_value(2));
+	XA_BUG_ON(xa, list_empty(&shadow_nodes));
+
+	shadow_remove(xa);
+	XA_BUG_ON(xa, !list_empty(&shadow_nodes));
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static int xarray_checks(void)
 {
 	DEFINE_XARRAY(array);
@@ -570,6 +627,10 @@ static int xarray_checks(void)
 	check_move(&array);
 	check_store_iter(&array);
 
+	check_workingset(&array, 0);
+	check_workingset(&array, 64);
+	check_workingset(&array, 4096);
+
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
 }
diff --git a/mm/workingset.c b/mm/workingset.c
index bad4e58881cd..f7fc5456fa77 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -148,7 +148,7 @@
  * and activations is maintained (node->inactive_age).
  *
  * On eviction, a snapshot of this counter (along with some bits to
- * identify the node) is stored in the now empty page cache radix tree
+ * identify the node) is stored in the now empty page cache
  * slot of the evicted page.  This is called a shadow entry.
  *
  * On cache misses for which there are shadow entries, an eligible
@@ -162,7 +162,7 @@
 
 /*
  * Eviction timestamps need to be able to cover the full range of
- * actionable refaults. However, bits are tight in the radix tree
+ * actionable refaults. However, bits are tight in the xarray
  * entry, and after storing the identifier for the lruvec there might
  * not be enough left to represent every single actionable refault. In
  * that case, we have to sacrifice granularity for distance, and group
@@ -338,7 +338,7 @@ void workingset_activation(struct page *page)
 
 static struct list_lru shadow_nodes;
 
-void workingset_update_node(struct radix_tree_node *node)
+void workingset_update_node(struct xa_node *node)
 {
 	/*
 	 * Track non-empty nodes that contain only shadow entries;
@@ -370,7 +370,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	local_irq_enable();
 
 	/*
-	 * Approximate a reasonable limit for the radix tree nodes
+	 * Approximate a reasonable limit for the nodes
 	 * containing shadow entries. We don't need to keep more
 	 * shadow entries than possible pages on the active list,
 	 * since refault distances bigger than that are dismissed.
@@ -385,11 +385,11 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	 * worst-case density of 1/8th. Below that, not all eligible
 	 * refaults can be detected anymore.
 	 *
-	 * On 64-bit with 7 radix_tree_nodes per page and 64 slots
+	 * On 64-bit with 7 xa_nodes per page and 64 slots
 	 * each, this will reclaim shadow entries when they consume
 	 * ~1.8% of available memory:
 	 *
-	 * PAGE_SIZE / radix_tree_nodes / node_entries * 8 / PAGE_SIZE
+	 * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
 	 */
 	if (sc->memcg) {
 		cache = mem_cgroup_node_nr_lru_pages(sc->memcg, sc->nid,
@@ -398,7 +398,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		cache = node_page_state(NODE_DATA(sc->nid), NR_ACTIVE_FILE) +
 			node_page_state(NODE_DATA(sc->nid), NR_INACTIVE_FILE);
 	}
-	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
+	max_nodes = cache >> (XA_CHUNK_SHIFT - 3);
 
 	if (nodes <= max_nodes)
 		return 0;
@@ -408,11 +408,11 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 static enum lru_status shadow_lru_isolate(struct list_head *item,
 					  struct list_lru_one *lru,
 					  spinlock_t *lru_lock,
-					  void *arg)
+					  void *arg) __must_hold(lru_lock)
 {
+	struct xa_node *node = container_of(item, struct xa_node, private_list);
+	XA_STATE(xas, node->array, 0);
 	struct address_space *mapping;
-	struct radix_tree_node *node;
-	unsigned int i;
 	int ret;
 
 	/*
@@ -420,14 +420,13 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * the shadow node LRU under the i_pages lock and the
 	 * lru_lock.  Because the page cache tree is emptied before
 	 * the inode can be destroyed, holding the lru_lock pins any
-	 * address_space that has radix tree nodes on the LRU.
+	 * address_space that has nodes on the LRU.
 	 *
 	 * We can then safely transition to the i_pages lock to
 	 * pin only the address_space of the particular node we want
 	 * to reclaim, take the node off-LRU, and drop the lru_lock.
 	 */
 
-	node = container_of(item, struct xa_node, private_list);
 	mapping = container_of(node->array, struct address_space, i_pages);
 
 	/* Coming from the list, invert the lock order */
@@ -449,25 +448,17 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out_invalid;
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
-	for (i = 0; i < RADIX_TREE_MAP_SIZE; i++) {
-		if (node->slots[i]) {
-			if (WARN_ON_ONCE(!xa_is_value(node->slots[i])))
-				goto out_invalid;
-			if (WARN_ON_ONCE(!node->nr_values))
-				goto out_invalid;
-			if (WARN_ON_ONCE(!mapping->nrexceptional))
-				goto out_invalid;
-			node->slots[i] = NULL;
-			node->nr_values--;
-			node->count--;
-			mapping->nrexceptional--;
-		}
-	}
-	if (WARN_ON_ONCE(node->nr_values))
-		goto out_invalid;
+	mapping->nrexceptional -= node->nr_values;
+	xas.xa_node = xa_parent_locked(&mapping->i_pages, node);
+	xas.xa_offset = node->offset;
+	xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
+	xas_set_update(&xas, workingset_update_node);
+	/*
+	 * We could store a shadow entry here which was the minimum of the
+	 * shadow entries we were tracking ...
+	 */
+	xas_store(&xas, NULL);
 	inc_lruvec_page_state(virt_to_page(node), WORKINGSET_NODERECLAIM);
-	__radix_tree_delete_node(&mapping->i_pages, node,
-				 workingset_lookup_update(mapping));
 
 out_invalid:
 	xa_unlock(&mapping->i_pages);
-- 
2.17.1

