Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDSP2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:28:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeDSP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:28:18 -0400
Date: Thu, 19 Apr 2018 08:28:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Christopher Lameter <cl@linux.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: RFC: Use Microsoft C extensions
Message-ID: <20180419152817.GD25406@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


No, this isn't a joke.  No, it doesn't even really have anything to do
with my employer ;-)

What it is about is saving some stack space in the slub allocator.
You see, slub has some bitfields embedded in struct page which it wants
to be able to access as a single unsigned int.  To avoid repeating the
definition of the bitfield, it allocates a struct page on the stack
which costs 64 bytes at a time.

If only we could embed a named struct in an unnamed way.  Well,
gcc has two extensions that let us do that; -fms-extensions and
-fplan9-extensions.  I'd prefer to use -fplan9-extensions (because they
enable some amazing other improvements), but they weren't added until
gcc-4.6, while -fms-extensions were added back in the egcs days.

Here's what it looks like for slub, but as Johannes pointed out to me,
this is something that networking already does with some amazing macro
preprocessing tricks, and it'd be nice for those to go away as well.

diff --git a/Makefile b/Makefile
index e811e0c509c5..53265a92f689 100644
--- a/Makefile
+++ b/Makefile
@@ -422,7 +422,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
-		   -std=gnu89
+		   -std=gnu89 -fms-extensions
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 21612347d311..ee2c59ff4cd5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -65,15 +65,20 @@ struct hmm;
  */
 #ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
 #define _struct_page_alignment	__aligned(2 * sizeof(unsigned long))
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)
-#define _slub_counter_t		unsigned long
 #else
-#define _slub_counter_t		unsigned int
-#endif
-#else /* !CONFIG_HAVE_ALIGNED_STRUCT_PAGE */
 #define _struct_page_alignment
-#define _slub_counter_t		unsigned int
-#endif /* !CONFIG_HAVE_ALIGNED_STRUCT_PAGE */
+#endif
+
+struct slub_counters {
+	union {
+		unsigned long counters;
+		struct {
+			unsigned inuse:16;
+			unsigned objects:15;
+			unsigned frozen:1;
+		};
+	};
+};
 
 struct page {
 	/* First double word block */
@@ -96,13 +101,8 @@ struct page {
 	};
 
 	union {
-		_slub_counter_t counters;
 		unsigned int active;		/* SLAB */
-		struct {			/* SLUB */
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
-		};
+		struct slub_counters;
 		int units;			/* SLOB */
 
 		struct {			/* Page cache */
diff --git a/mm/slub.c b/mm/slub.c
index 44aa7847324a..2071a10c667d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -356,9 +356,14 @@ static __always_inline void slab_unlock(struct page *page)
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
+struct slub_freelist {
+	void *freelist;
+	struct slub_counters;
+};
+
 static inline void set_page_slub_counters(struct page *page, unsigned long counters_new)
 {
-	struct page tmp;
+	struct slub_counters tmp;
 	tmp.counters = counters_new;
 	/*
 	 * page->counters can cover frozen/inuse/objects as well
@@ -1782,7 +1787,7 @@ static inline void *acquire_slab(struct kmem_cache *s,
 {
 	void *freelist;
 	unsigned long counters;
-	struct page new;
+	struct slub_freelist new;
 
 	lockdep_assert_held(&n->list_lock);
 
@@ -2032,8 +2037,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree;
 	int tail = DEACTIVATE_TO_HEAD;
-	struct page new;
-	struct page old;
+	struct slub_freelist new;
+	struct slub_freelist old;
 
 	if (page->freelist) {
 		stat(s, DEACTIVATE_REMOTE_FREES);
@@ -2183,8 +2188,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 	struct page *page, *discard_page = NULL;
 
 	while ((page = c->partial)) {
-		struct page new;
-		struct page old;
+		struct slub_freelist new;
+		struct slub_freelist old;
 
 		c->partial = page->next;
 
@@ -2491,7 +2496,7 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
  */
 static inline void *get_freelist(struct kmem_cache *s, struct page *page)
 {
-	struct page new;
+	struct slub_counters new;
 	unsigned long counters;
 	void *freelist;
 
@@ -2815,7 +2820,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 {
 	void *prior;
 	int was_frozen;
-	struct page new;
+	struct slub_counters new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long uninitialized_var(flags);
