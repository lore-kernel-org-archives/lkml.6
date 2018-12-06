Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E959C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0236321479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0236321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLFTSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:34171 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLFTSl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/7] tools/perf: Update rbtree implementation
Date:   Thu,  6 Dec 2018 11:18:13 -0800
Message-Id: <20181206191819.30182-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181206191819.30182-1-dave@stgolabs.net>
References: <20181206191819.30182-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a number of changes in the kernel's rbrtee
implementation, including loose lockless searching guarantees
and rb_root_cached, which later patches will use as an
optimization.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/include/linux/rbtree.h           |  52 ++++++++--
 tools/include/linux/rbtree_augmented.h |  60 ++++++++---
 tools/lib/rbtree.c                     | 178 +++++++++++++++++++++++++--------
 3 files changed, 229 insertions(+), 61 deletions(-)

diff --git a/tools/include/linux/rbtree.h b/tools/include/linux/rbtree.h
index 112582253dd0..8e9ed4786269 100644
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -43,13 +43,28 @@ struct rb_root {
 	struct rb_node *rb_node;
 };
 
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
 
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
 #define RB_ROOT	(struct rb_root) { NULL, }
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
-#define RB_EMPTY_ROOT(root)  ((root)->rb_node == NULL)
+#define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
 
 /* 'empty' nodes are nodes that are known not to be inserted in an rbtree */
 #define RB_EMPTY_NODE(node)  \
@@ -68,6 +83,12 @@ extern struct rb_node *rb_prev(const struct rb_node *);
 extern struct rb_node *rb_first(const struct rb_root *);
 extern struct rb_node *rb_last(const struct rb_root *);
 
+extern void rb_insert_color_cached(struct rb_node *,
+				   struct rb_root_cached *, bool);
+extern void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
+/* Same as rb_first(), but O(1) */
+#define rb_first_cached(root) (root)->rb_leftmost
+
 /* Postorder iteration - always visit the parent after its children */
 extern struct rb_node *rb_first_postorder(const struct rb_root *);
 extern struct rb_node *rb_next_postorder(const struct rb_node *);
@@ -75,6 +96,8 @@ extern struct rb_node *rb_next_postorder(const struct rb_node *);
 /* Fast replacement of a single node without remove/rebalance/add/rebalance */
 extern void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 			    struct rb_root *root);
+extern void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
+				   struct rb_root_cached *root);
 
 static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
 				struct rb_node **rb_link)
@@ -90,12 +113,29 @@ static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
 	   ____ptr ? rb_entry(____ptr, type, member) : NULL; \
 	})
 
-
-/*
- * Handy for checking that we are not deleting an entry that is
- * already in a list, found in block/{blk-throttle,cfq-iosched}.c,
- * probably should be moved to lib/rbtree.c...
+/**
+ * rbtree_postorder_for_each_entry_safe - iterate in post-order over rb_root of
+ * given type allowing the backing memory of @pos to be invalidated
+ *
+ * @pos:	the 'type *' to use as a loop cursor.
+ * @n:		another 'type *' to use as temporary storage
+ * @root:	'rb_root *' of the rbtree.
+ * @field:	the name of the rb_node field within 'type'.
+ *
+ * rbtree_postorder_for_each_entry_safe() provides a similar guarantee as
+ * list_for_each_entry_safe() and allows the iteration to continue independent
+ * of changes to @pos by the body of the loop.
+ *
+ * Note, however, that it cannot handle other modifications that re-order the
+ * rbtree it is iterating over. This includes calling rb_erase() on @pos, as
+ * rb_erase() may rebalance the tree, causing us to miss some nodes.
  */
+#define rbtree_postorder_for_each_entry_safe(pos, n, root, field) \
+	for (pos = rb_entry_safe(rb_first_postorder(root), typeof(*pos), field); \
+	     pos && ({ n = rb_entry_safe(rb_next_postorder(&pos->field), \
+			typeof(*pos), field); 1; }); \
+	     pos = n)
+
 static inline void rb_erase_init(struct rb_node *n, struct rb_root *root)
 {
 	rb_erase(n, root);
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index 43be941db695..d008e1404580 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -44,7 +44,9 @@ struct rb_augment_callbacks {
 	void (*rotate)(struct rb_node *old, struct rb_node *new);
 };
 
-extern void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
+extern void __rb_insert_augmented(struct rb_node *node,
+				  struct rb_root *root,
+				  bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new));
 /*
  * Fixup the rbtree and update the augmented information when rebalancing.
@@ -60,7 +62,16 @@ static inline void
 rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 		    const struct rb_augment_callbacks *augment)
 {
-	__rb_insert_augmented(node, root, augment->rotate);
+	__rb_insert_augmented(node, root, false, NULL, augment->rotate);
+}
+
+static inline void
+rb_insert_augmented_cached(struct rb_node *node,
+			   struct rb_root_cached *root, bool newleft,
+			   const struct rb_augment_callbacks *augment)
+{
+	__rb_insert_augmented(node, &root->rb_root,
+			      newleft, &root->rb_leftmost, augment->rotate);
 }
 
 #define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
@@ -93,7 +104,9 @@ rbname ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
 	old->rbaugmented = rbcompute(old);				\
 }									\
 rbstatic const struct rb_augment_callbacks rbname = {			\
-	rbname ## _propagate, rbname ## _copy, rbname ## _rotate	\
+	.propagate = rbname ## _propagate,				\
+	.copy = rbname ## _copy,					\
+	.rotate = rbname ## _rotate					\
 };
 
 
@@ -126,11 +139,11 @@ __rb_change_child(struct rb_node *old, struct rb_node *new,
 {
 	if (parent) {
 		if (parent->rb_left == old)
-			parent->rb_left = new;
+			WRITE_ONCE(parent->rb_left, new);
 		else
-			parent->rb_right = new;
+			WRITE_ONCE(parent->rb_right, new);
 	} else
-		root->rb_node = new;
+		WRITE_ONCE(root->rb_node, new);
 }
 
 extern void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
@@ -138,12 +151,17 @@ extern void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
 
 static __always_inline struct rb_node *
 __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
+		     struct rb_node **leftmost,
 		     const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *child = node->rb_right, *tmp = node->rb_left;
+	struct rb_node *child = node->rb_right;
+	struct rb_node *tmp = node->rb_left;
 	struct rb_node *parent, *rebalance;
 	unsigned long pc;
 
+	if (leftmost && node == *leftmost)
+		*leftmost = rb_next(node);
+
 	if (!tmp) {
 		/*
 		 * Case 1: node to erase has no more than 1 child (easy!)
@@ -170,6 +188,7 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		tmp = parent;
 	} else {
 		struct rb_node *successor = child, *child2;
+
 		tmp = child->rb_left;
 		if (!tmp) {
 			/*
@@ -183,6 +202,7 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 			 */
 			parent = successor;
 			child2 = successor->rb_right;
+
 			augment->copy(node, successor);
 		} else {
 			/*
@@ -204,19 +224,23 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 				successor = tmp;
 				tmp = tmp->rb_left;
 			} while (tmp);
-			parent->rb_left = child2 = successor->rb_right;
-			successor->rb_right = child;
+			child2 = successor->rb_right;
+			WRITE_ONCE(parent->rb_left, child2);
+			WRITE_ONCE(successor->rb_right, child);
 			rb_set_parent(child, successor);
+
 			augment->copy(node, successor);
 			augment->propagate(parent, successor);
 		}
 
-		successor->rb_left = tmp = node->rb_left;
+		tmp = node->rb_left;
+		WRITE_ONCE(successor->rb_left, tmp);
 		rb_set_parent(tmp, successor);
 
 		pc = node->__rb_parent_color;
 		tmp = __rb_parent(pc);
 		__rb_change_child(node, successor, tmp, root);
+
 		if (child2) {
 			successor->__rb_parent_color = pc;
 			rb_set_parent_color(child2, parent, RB_BLACK);
@@ -237,9 +261,21 @@ static __always_inline void
 rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		   const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *rebalance = __rb_erase_augmented(node, root, augment);
+	struct rb_node *rebalance = __rb_erase_augmented(node, root,
+							 NULL, augment);
 	if (rebalance)
 		__rb_erase_color(rebalance, root, augment->rotate);
 }
 
-#endif	/* _TOOLS_LINUX_RBTREE_AUGMENTED_H */
+static __always_inline void
+rb_erase_augmented_cached(struct rb_node *node, struct rb_root_cached *root,
+			  const struct rb_augment_callbacks *augment)
+{
+	struct rb_node *rebalance = __rb_erase_augmented(node, &root->rb_root,
+							 &root->rb_leftmost,
+							 augment);
+	if (rebalance)
+		__rb_erase_color(rebalance, &root->rb_root, augment->rotate);
+}
+
+#endif /* _TOOLS_LINUX_RBTREE_AUGMENTED_H */
diff --git a/tools/lib/rbtree.c b/tools/lib/rbtree.c
index 17c2b596f043..904adb70a4f0 100644
--- a/tools/lib/rbtree.c
+++ b/tools/lib/rbtree.c
@@ -22,6 +22,7 @@
 */
 
 #include <linux/rbtree_augmented.h>
+#include <linux/export.h>
 
 /*
  * red-black trees properties:  http://en.wikipedia.org/wiki/Rbtree
@@ -43,6 +44,30 @@
  *  parentheses and have some accompanying text comment.
  */
 
+/*
+ * Notes on lockless lookups:
+ *
+ * All stores to the tree structure (rb_left and rb_right) must be done using
+ * WRITE_ONCE(). And we must not inadvertently cause (temporary) loops in the
+ * tree structure as seen in program order.
+ *
+ * These two requirements will allow lockless iteration of the tree -- not
+ * correct iteration mind you, tree rotations are not atomic so a lookup might
+ * miss entire subtrees.
+ *
+ * But they do guarantee that any such traversal will only see valid elements
+ * and that it will indeed complete -- does not get stuck in a loop.
+ *
+ * It also guarantees that if the lookup returns an element it is the 'correct'
+ * one. But not returning an element does _NOT_ mean it's not present.
+ *
+ * NOTE:
+ *
+ * Stores to __rb_parent_color are not important for simple lookups so those
+ * are left undone as of now. Nor did I check for loops involving parent
+ * pointers.
+ */
+
 static inline void rb_set_black(struct rb_node *rb)
 {
 	rb->__rb_parent_color |= RB_BLACK;
@@ -70,22 +95,35 @@ __rb_rotate_set_parents(struct rb_node *old, struct rb_node *new,
 
 static __always_inline void
 __rb_insert(struct rb_node *node, struct rb_root *root,
+	    bool newleft, struct rb_node **leftmost,
 	    void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
 	struct rb_node *parent = rb_red_parent(node), *gparent, *tmp;
 
+	if (newleft)
+		*leftmost = node;
+
 	while (true) {
 		/*
-		 * Loop invariant: node is red
-		 *
-		 * If there is a black parent, we are done.
-		 * Otherwise, take some corrective action as we don't
-		 * want a red root or two consecutive red nodes.
+		 * Loop invariant: node is red.
 		 */
-		if (!parent) {
+		if (unlikely(!parent)) {
+			/*
+			 * The inserted node is root. Either this is the
+			 * first node, or we recursed at Case 1 below and
+			 * are no longer violating 4).
+			 */
 			rb_set_parent_color(node, NULL, RB_BLACK);
 			break;
-		} else if (rb_is_black(parent))
+		}
+
+		/*
+		 * If there is a black parent, we are done.
+		 * Otherwise, take some corrective action as,
+		 * per 4), we don't want a red root or two
+		 * consecutive red nodes.
+		 */
+		if(rb_is_black(parent))
 			break;
 
 		gparent = rb_red_parent(parent);
@@ -94,7 +132,7 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 		if (parent != tmp) {	/* parent == gparent->rb_left */
 			if (tmp && rb_is_red(tmp)) {
 				/*
-				 * Case 1 - color flips
+				 * Case 1 - node's uncle is red (color flips).
 				 *
 				 *       G            g
 				 *      / \          / \
@@ -117,7 +155,8 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			tmp = parent->rb_right;
 			if (node == tmp) {
 				/*
-				 * Case 2 - left rotate at parent
+				 * Case 2 - node's uncle is black and node is
+				 * the parent's right child (left rotate at parent).
 				 *
 				 *      G             G
 				 *     / \           / \
@@ -128,8 +167,9 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 				 * This still leaves us in violation of 4), the
 				 * continuation into Case 3 will fix that.
 				 */
-				parent->rb_right = tmp = node->rb_left;
-				node->rb_left = parent;
+				tmp = node->rb_left;
+				WRITE_ONCE(parent->rb_right, tmp);
+				WRITE_ONCE(node->rb_left, parent);
 				if (tmp)
 					rb_set_parent_color(tmp, parent,
 							    RB_BLACK);
@@ -140,7 +180,8 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			}
 
 			/*
-			 * Case 3 - right rotate at gparent
+			 * Case 3 - node's uncle is black and node is
+			 * the parent's left child (right rotate at gparent).
 			 *
 			 *        G           P
 			 *       / \         / \
@@ -148,8 +189,8 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			 *     /                 \
 			 *    n                   U
 			 */
-			gparent->rb_left = tmp;  /* == parent->rb_right */
-			parent->rb_right = gparent;
+			WRITE_ONCE(gparent->rb_left, tmp); /* == parent->rb_right */
+			WRITE_ONCE(parent->rb_right, gparent);
 			if (tmp)
 				rb_set_parent_color(tmp, gparent, RB_BLACK);
 			__rb_rotate_set_parents(gparent, parent, root, RB_RED);
@@ -170,8 +211,9 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			tmp = parent->rb_left;
 			if (node == tmp) {
 				/* Case 2 - right rotate at parent */
-				parent->rb_left = tmp = node->rb_right;
-				node->rb_right = parent;
+				tmp = node->rb_right;
+				WRITE_ONCE(parent->rb_left, tmp);
+				WRITE_ONCE(node->rb_right, parent);
 				if (tmp)
 					rb_set_parent_color(tmp, parent,
 							    RB_BLACK);
@@ -182,8 +224,8 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			}
 
 			/* Case 3 - left rotate at gparent */
-			gparent->rb_right = tmp;  /* == parent->rb_left */
-			parent->rb_left = gparent;
+			WRITE_ONCE(gparent->rb_right, tmp); /* == parent->rb_left */
+			WRITE_ONCE(parent->rb_left, gparent);
 			if (tmp)
 				rb_set_parent_color(tmp, gparent, RB_BLACK);
 			__rb_rotate_set_parents(gparent, parent, root, RB_RED);
@@ -223,8 +265,9 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 				 *      / \         / \
 				 *     Sl  Sr      N   Sl
 				 */
-				parent->rb_right = tmp1 = sibling->rb_left;
-				sibling->rb_left = parent;
+				tmp1 = sibling->rb_left;
+				WRITE_ONCE(parent->rb_right, tmp1);
+				WRITE_ONCE(sibling->rb_left, parent);
 				rb_set_parent_color(tmp1, parent, RB_BLACK);
 				__rb_rotate_set_parents(parent, sibling, root,
 							RB_RED);
@@ -268,15 +311,31 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 				 *
 				 *   (p)           (p)
 				 *   / \           / \
-				 *  N   S    -->  N   Sl
+				 *  N   S    -->  N   sl
 				 *     / \             \
-				 *    sl  Sr            s
+				 *    sl  Sr            S
 				 *                       \
 				 *                        Sr
+				 *
+				 * Note: p might be red, and then both
+				 * p and sl are red after rotation(which
+				 * breaks property 4). This is fixed in
+				 * Case 4 (in __rb_rotate_set_parents()
+				 *         which set sl the color of p
+				 *         and set p RB_BLACK)
+				 *
+				 *   (p)            (sl)
+				 *   / \            /  \
+				 *  N   sl   -->   P    S
+				 *       \        /      \
+				 *        S      N        Sr
+				 *         \
+				 *          Sr
 				 */
-				sibling->rb_left = tmp1 = tmp2->rb_right;
-				tmp2->rb_right = sibling;
-				parent->rb_right = tmp2;
+				tmp1 = tmp2->rb_right;
+				WRITE_ONCE(sibling->rb_left, tmp1);
+				WRITE_ONCE(tmp2->rb_right, sibling);
+				WRITE_ONCE(parent->rb_right, tmp2);
 				if (tmp1)
 					rb_set_parent_color(tmp1, sibling,
 							    RB_BLACK);
@@ -296,8 +355,9 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 			 *        / \         / \
 			 *      (sl) sr      N  (sl)
 			 */
-			parent->rb_right = tmp2 = sibling->rb_left;
-			sibling->rb_left = parent;
+			tmp2 = sibling->rb_left;
+			WRITE_ONCE(parent->rb_right, tmp2);
+			WRITE_ONCE(sibling->rb_left, parent);
 			rb_set_parent_color(tmp1, sibling, RB_BLACK);
 			if (tmp2)
 				rb_set_parent(tmp2, parent);
@@ -309,8 +369,9 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 			sibling = parent->rb_left;
 			if (rb_is_red(sibling)) {
 				/* Case 1 - right rotate at parent */
-				parent->rb_left = tmp1 = sibling->rb_right;
-				sibling->rb_right = parent;
+				tmp1 = sibling->rb_right;
+				WRITE_ONCE(parent->rb_left, tmp1);
+				WRITE_ONCE(sibling->rb_right, parent);
 				rb_set_parent_color(tmp1, parent, RB_BLACK);
 				__rb_rotate_set_parents(parent, sibling, root,
 							RB_RED);
@@ -334,10 +395,11 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 					}
 					break;
 				}
-				/* Case 3 - right rotate at sibling */
-				sibling->rb_right = tmp1 = tmp2->rb_left;
-				tmp2->rb_left = sibling;
-				parent->rb_left = tmp2;
+				/* Case 3 - left rotate at sibling */
+				tmp1 = tmp2->rb_left;
+				WRITE_ONCE(sibling->rb_right, tmp1);
+				WRITE_ONCE(tmp2->rb_left, sibling);
+				WRITE_ONCE(parent->rb_left, tmp2);
 				if (tmp1)
 					rb_set_parent_color(tmp1, sibling,
 							    RB_BLACK);
@@ -345,9 +407,10 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 				tmp1 = sibling;
 				sibling = tmp2;
 			}
-			/* Case 4 - left rotate at parent + color flips */
-			parent->rb_left = tmp2 = sibling->rb_right;
-			sibling->rb_right = parent;
+			/* Case 4 - right rotate at parent + color flips */
+			tmp2 = sibling->rb_right;
+			WRITE_ONCE(parent->rb_left, tmp2);
+			WRITE_ONCE(sibling->rb_right, parent);
 			rb_set_parent_color(tmp1, sibling, RB_BLACK);
 			if (tmp2)
 				rb_set_parent(tmp2, parent);
@@ -378,22 +441,41 @@ static inline void dummy_copy(struct rb_node *old, struct rb_node *new) {}
 static inline void dummy_rotate(struct rb_node *old, struct rb_node *new) {}
 
 static const struct rb_augment_callbacks dummy_callbacks = {
-	dummy_propagate, dummy_copy, dummy_rotate
+	.propagate = dummy_propagate,
+	.copy = dummy_copy,
+	.rotate = dummy_rotate
 };
 
 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-	__rb_insert(node, root, dummy_rotate);
+	__rb_insert(node, root, false, NULL, dummy_rotate);
 }
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, root, &dummy_callbacks);
+	rebalance = __rb_erase_augmented(node, root,
+					 NULL, &dummy_callbacks);
 	if (rebalance)
 		____rb_erase_color(rebalance, root, dummy_rotate);
 }
 
+void rb_insert_color_cached(struct rb_node *node,
+			    struct rb_root_cached *root, bool leftmost)
+{
+	__rb_insert(node, &root->rb_root, leftmost,
+		    &root->rb_leftmost, dummy_rotate);
+}
+
+void rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
+{
+	struct rb_node *rebalance;
+	rebalance = __rb_erase_augmented(node, &root->rb_root,
+					 &root->rb_leftmost, &dummy_callbacks);
+	if (rebalance)
+		____rb_erase_color(rebalance, &root->rb_root, dummy_rotate);
+}
+
 /*
  * Augmented rbtree manipulation functions.
  *
@@ -402,9 +484,10 @@ void rb_erase(struct rb_node *node, struct rb_root *root)
  */
 
 void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
+			   bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
-	__rb_insert(node, root, augment_rotate);
+	__rb_insert(node, root, newleft, leftmost, augment_rotate);
 }
 
 /*
@@ -498,15 +581,24 @@ void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 {
 	struct rb_node *parent = rb_parent(victim);
 
+	/* Copy the pointers/colour from the victim to the replacement */
+	*new = *victim;
+
 	/* Set the surrounding nodes to point to the replacement */
-	__rb_change_child(victim, new, parent, root);
 	if (victim->rb_left)
 		rb_set_parent(victim->rb_left, new);
 	if (victim->rb_right)
 		rb_set_parent(victim->rb_right, new);
+	__rb_change_child(victim, new, parent, root);
+}
 
-	/* Copy the pointers/colour from the victim to the replacement */
-	*new = *victim;
+void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
+			    struct rb_root_cached *root)
+{
+	rb_replace_node(victim, new, &root->rb_root);
+
+	if (root->rb_leftmost == victim)
+		root->rb_leftmost = new;
 }
 
 static struct rb_node *rb_left_deepest_node(const struct rb_node *node)
-- 
2.16.4

