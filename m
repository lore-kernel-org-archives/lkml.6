Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeERHx2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:53:28 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46501 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeERHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:11 -0400
X-Google-Smtp-Source: AB8JxZrU6l7HwFJm1ovgSrEBZCrFnv6Iiaut2Cnn/J95LjlypvL1npo52NHPuGfFXkqnaN5TIu4jcw==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 06/10] Generic radix trees
Date: Fri, 18 May 2018 03:49:10 -0400
Message-Id: <20180518074918.13816-13-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/generic-radix-tree.h | 131 ++++++++++++++++++++++
 lib/Makefile                       |   3 +-
 lib/generic-radix-tree.c           | 167 +++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/generic-radix-tree.h
 create mode 100644 lib/generic-radix-tree.c

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
new file mode 100644
index 0000000000..4ede23e55f
--- /dev/null
+++ b/include/linux/generic-radix-tree.h
@@ -0,0 +1,131 @@
+#ifndef _LINUX_GENERIC_RADIX_TREE_H
+#define _LINUX_GENERIC_RADIX_TREE_H
+
+/*
+ * Generic radix trees/sparse arrays:
+ *
+ * A generic radix tree has all nodes of size PAGE_SIZE - both leaves and
+ * interior nodes.
+ */
+
+#include <asm/page.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+
+struct genradix_node;
+
+struct __genradix {
+	struct genradix_node		*root;
+	size_t				depth;
+};
+
+/*
+ * NOTE: currently, sizeof(_type) must be a power of two and not larger than
+ * PAGE_SIZE:
+ */
+
+#define __GENRADIX_INITIALIZER					\
+	{							\
+		.tree = {					\
+			.root = NULL,				\
+			.depth = 0,				\
+		}						\
+	}
+
+/*
+ * We use a 0 size array to stash the type we're storing without taking any
+ * space at runtime - then the various accessor macros can use typeof() to get
+ * to it for casts/sizeof - we also force the alignment so that storing a type
+ * with a ridiculous alignment doesn't blow up the alignment or size of the
+ * genradix.
+ */
+
+#define GENRADIX(_type)						\
+struct {							\
+	struct __genradix	tree;				\
+	_type			type[0] __aligned(1);		\
+}
+
+#define DEFINE_GENRADIX(_name, _type)				\
+	GENRADIX(_type) _name = __GENRADIX_INITIALIZER
+
+#define genradix_init(_radix)					\
+do {								\
+	*(_radix) = (typeof(*_radix)) __GENRADIX_INITIALIZER;	\
+} while (0)
+
+void __genradix_free(struct __genradix *);
+
+#define genradix_free(_radix)	__genradix_free(&(_radix)->tree)
+
+static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
+{
+	BUILD_BUG_ON(obj_size > PAGE_SIZE);
+
+	if (!is_power_of_2(obj_size)) {
+		size_t objs_per_page = PAGE_SIZE / obj_size;
+
+		return (idx / objs_per_page) * PAGE_SIZE +
+			(idx % objs_per_page) * obj_size;
+	} else {
+		return idx * obj_size;
+	}
+}
+
+#define __genradix_cast(_radix)		(typeof((_radix)->type[0]) *)
+#define __genradix_obj_size(_radix)	sizeof((_radix)->type[0])
+#define __genradix_idx_to_offset(_radix, _idx)			\
+	__idx_to_offset(_idx, __genradix_obj_size(_radix))
+
+void *__genradix_ptr(struct __genradix *, size_t);
+
+/* Returns a pointer to element at @_idx */
+#define genradix_ptr(_radix, _idx)				\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx)))
+
+void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
+
+/* Returns a pointer to element at @_idx, allocating it if necessary */
+#define genradix_ptr_alloc(_radix, _idx, _gfp)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr_alloc(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx),	\
+			_gfp))
+
+struct genradix_iter {
+	size_t			offset;
+	size_t			pos;
+};
+
+#define genradix_iter_init(_radix, _idx)			\
+	((struct genradix_iter) {				\
+		.pos	= (_idx),				\
+		.offset	= __genradix_idx_to_offset((_radix), (_idx)),\
+	})
+
+void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
+
+#define genradix_iter_peek(_iter, _radix)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_iter_peek(_iter, &(_radix)->tree,		\
+			      PAGE_SIZE / __genradix_obj_size(_radix)))
+
+static inline void __genradix_iter_advance(struct genradix_iter *iter,
+					   size_t obj_size)
+{
+	iter->offset += obj_size;
+
+	if (!is_power_of_2(obj_size) &&
+	    (iter->offset & (PAGE_SIZE - 1)) + obj_size > PAGE_SIZE)
+		iter->offset = round_up(iter->offset, PAGE_SIZE);
+
+	iter->pos++;
+}
+
+#define genradix_iter_advance(_iter, _radix)			\
+	__genradix_iter_advance(_iter, __genradix_obj_size(_radix))
+
+#endif /* _LINUX_GENERIC_RADIX_TREE_H */
diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd74..5db5a7fb1e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -39,7 +39,8 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
+	 generic-radix-tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
new file mode 100644
index 0000000000..5c4a275ea3
--- /dev/null
+++ b/lib/generic-radix-tree.c
@@ -0,0 +1,167 @@
+
+#include <linux/export.h>
+#include <linux/generic-radix-tree.h>
+#include <linux/gfp.h>
+
+#define GENRADIX_ARY		(PAGE_SIZE / sizeof(struct genradix_node *))
+#define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
+
+struct genradix_node {
+	union {
+		/* Interior node: */
+		struct genradix_node	*children[GENRADIX_ARY];
+
+		/* Leaf: */
+		u8			data[PAGE_SIZE];
+	};
+};
+
+static inline unsigned genradix_depth_shift(unsigned depth)
+{
+	return PAGE_SHIFT + GENRADIX_ARY_SHIFT * depth;
+}
+
+/*
+ * Returns size (of data, in bytes) that a tree of a given depth holds:
+ */
+static inline size_t genradix_depth_size(unsigned depth)
+{
+	return 1UL << genradix_depth_shift(depth);
+}
+
+/*
+ * Returns pointer to the specified byte @offset within @radix, or NULL if not
+ * allocated
+ */
+void *__genradix_ptr(struct __genradix *radix, size_t offset)
+{
+	size_t level = radix->depth;
+	struct genradix_node *n = radix->root;
+
+	if (offset >= genradix_depth_size(radix->depth))
+		return NULL;
+
+	while (1) {
+		if (!n)
+			return NULL;
+		if (!level)
+			break;
+
+		level--;
+
+		n = n->children[offset >> genradix_depth_shift(level)];
+		offset &= genradix_depth_size(level) - 1;
+	}
+
+	return &n->data[offset];
+}
+EXPORT_SYMBOL(__genradix_ptr);
+
+/*
+ * Returns pointer to the specified byte @offset within @radix, allocating it if
+ * necessary - newly allocated slots are always zeroed out:
+ */
+void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
+			   gfp_t gfp_mask)
+{
+	struct genradix_node **n;
+	size_t level;
+
+	/* Increase tree depth if necessary: */
+
+	while (offset >= genradix_depth_size(radix->depth)) {
+		struct genradix_node *new_root =
+			(void *) __get_free_page(gfp_mask|__GFP_ZERO);
+
+		if (!new_root)
+			return NULL;
+
+		new_root->children[0] = radix->root;
+		radix->root = new_root;
+		radix->depth++;
+	}
+
+	n = &radix->root;
+	level = radix->depth;
+
+	while (1) {
+		if (!*n) {
+			*n = (void *) __get_free_page(gfp_mask|__GFP_ZERO);
+			if (!*n)
+				return NULL;
+		}
+
+		if (!level)
+			break;
+
+		level--;
+
+		n = &(*n)->children[offset >> genradix_depth_shift(level)];
+		offset &= genradix_depth_size(level) - 1;
+	}
+
+	return &(*n)->data[offset];
+}
+EXPORT_SYMBOL(__genradix_ptr_alloc);
+
+void *__genradix_iter_peek(struct genradix_iter *iter,
+			   struct __genradix *radix,
+			   size_t objs_per_page)
+{
+	struct genradix_node *n;
+	size_t level, i;
+
+	if (!radix->root)
+		return NULL;
+restart:
+	if (iter->offset >= genradix_depth_size(radix->depth))
+		return NULL;
+
+	n	= radix->root;
+	level	= radix->depth;
+
+	while (level) {
+		level--;
+
+		i = (iter->offset >> genradix_depth_shift(level)) &
+			(GENRADIX_ARY - 1);
+
+		while (!n->children[i]) {
+			i++;
+			iter->offset = round_down(iter->offset +
+					   genradix_depth_size(level),
+					   genradix_depth_size(level));
+			iter->pos = (iter->offset >> PAGE_SHIFT) *
+				objs_per_page;
+			if (i == GENRADIX_ARY)
+				goto restart;
+		}
+
+		n = n->children[i];
+	}
+
+	return &n->data[iter->offset & (PAGE_SIZE - 1)];
+}
+EXPORT_SYMBOL(__genradix_iter_peek);
+
+static void genradix_free_recurse(struct genradix_node *n, unsigned level)
+{
+	if (level) {
+		unsigned i;
+
+		for (i = 0; i < GENRADIX_ARY; i++)
+			if (n->children[i])
+				genradix_free_recurse(n->children[i], level - 1);
+	}
+
+	free_page((unsigned long) n);
+}
+
+void __genradix_free(struct __genradix *radix)
+{
+	genradix_free_recurse(radix->root, radix->depth);
+
+	radix->root = NULL;
+	radix->depth = 0;
+}
+EXPORT_SYMBOL(__genradix_free);
-- 
2.17.0
