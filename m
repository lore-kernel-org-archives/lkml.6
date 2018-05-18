Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeERRub (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:50:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeERRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:50:27 -0400
Date: Fri, 18 May 2018 10:50:25 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180518175025.GD6361@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'd be nice if you cc'd the person who wrote the code you're patching.
You'd get a response a lot quicker than waiting until I happened to
notice the email in a different forum.

Thanks for finding the situation that leads to the bug.  Your fix is
incorrect; it's legitimate to store a NULL value at offset 0, and
your patch makes it impossible to delete.  Fortunately, the test-suite
covers that case ;-)

Andrew, can you take this through your tree for extra testing?

--- >8 ---

From: Matthew Wilcox <mawilcox@microsoft.com>

If the radix tree underlying the IDR happens to be full and we attempt
to remove an id which is larger than any id in the IDR, we will call
__radix_tree_delete() with an uninitialised 'slot' pointer, at which
point anything could happen.  This was easiest to hit with a single entry
at id 0 and attempting to remove a non-0 id, but it could have happened
with 64 entries and attempting to remove an id >= 64.

Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..4dd4fbc7279c 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2036,10 +2036,12 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 			     unsigned long index, void *item)
 {
 	struct radix_tree_node *node = NULL;
-	void __rcu **slot;
+	void __rcu **slot = NULL;
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
+	if (!slot)
+		return NULL;
 	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
 						get_slot_offset(node, slot))))
 		return NULL;
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 1c18617951dd..410ca58bbe9c 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -254,6 +254,13 @@ void idr_checks(void)
 	idr_remove(&idr, 0xfedcba98U);
 	idr_remove(&idr, 0);
 
+	assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == 0);
+	idr_remove(&idr, 1);
+	for (i = 1; i < RADIX_TREE_MAP_SIZE; i++)
+		assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == i);
+	idr_remove(&idr, 1 << 30);
+	idr_destroy(&idr);
+
 	for (i = INT_MAX - 3UL; i < INT_MAX + 1UL; i++) {
 		struct item *item = item_create(i, 0);
 		assert(idr_alloc(&idr, item, i, i + 10, GFP_KERNEL) == i);

--- original email ---

If an IDR contains a single entry at index==0, the underlying radix tree
has a single item in its root node, in which case
__radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
addition to returning NULL).

However, the tree itself is not empty, i.e. the tree root doesn't have
IDR_FREE tag.

As a result, on an attempt to remove an index!=0 entry from such an IDR,
radix_tree_delete_item doesn't return early and calls
__radix_tree_delete with invalid parameters which are then dereferenced.

Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 lib/radix-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..10ff1bfae952 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
-	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
-						get_slot_offset(node, slot))))
+	if (!entry && (!is_idr(root) || !node ||
+		       node_tag_get(root, node, IDR_FREE,
+				    get_slot_offset(node, slot))))
 		return NULL;
 
 	if (item && entry != item)
