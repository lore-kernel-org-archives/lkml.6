Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBWPxK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:53:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38490 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeBWPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:53:09 -0500
X-Google-Smtp-Source: AG47ELv9ejfVwS/2wAacM5fbFARB0wIWnGKuT5AmxUrv5imFsXaBqNdz3GYCC9357hSbeGDz82gwdg==
From: Andrey Konovalov <andreyknvl@google.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Cc: Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan, slub: fix handling of kasan_slab_free hook
Date: Fri, 23 Feb 2018 16:53:00 +0100
Message-Id: <083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kasan_slab_free hook's return value denotes whether the reuse of a
slab object must be delayed (e.g. when the object is put into memory
qurantine).

The current way SLUB handles this hook is by ignoring its return value
and hardcoding checks similar (but not exactly the same) to the ones
performed in kasan_slab_free, which is prone to making mistakes.

This patch changes the way SLUB handles this by:
1. taking into account the return value of kasan_slab_free for each of
   the objects, that are being freed;
2. reconstructing the freelist of objects to exclude the ones, whose
   reuse must be delayed.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e381728a3751..f111c2a908b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1362,10 +1362,8 @@ static __always_inline void kfree_hook(void *x)
 	kasan_kfree_large(x, _RET_IP_);
 }
 
-static __always_inline void *slab_free_hook(struct kmem_cache *s, void *x)
+static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 {
-	void *freeptr;
-
 	kmemleak_free_recursive(x, s->flags);
 
 	/*
@@ -1385,17 +1383,12 @@ static __always_inline void *slab_free_hook(struct kmem_cache *s, void *x)
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
-	freeptr = get_freepointer(s, x);
-	/*
-	 * kasan_slab_free() may put x into memory quarantine, delaying its
-	 * reuse. In this case the object's freelist pointer is changed.
-	 */
-	kasan_slab_free(s, x, _RET_IP_);
-	return freeptr;
+	/* KASAN might put x into memory quarantine, delaying its reuse */
+	return kasan_slab_free(s, x, _RET_IP_);
 }
 
 static inline void slab_free_freelist_hook(struct kmem_cache *s,
-					   void *head, void *tail)
+					   void **head, void **tail)
 {
 /*
  * Compiler cannot detect this function can be removed if slab_free_hook()
@@ -1406,13 +1399,29 @@ static inline void slab_free_freelist_hook(struct kmem_cache *s,
 	defined(CONFIG_DEBUG_OBJECTS_FREE) ||	\
 	defined(CONFIG_KASAN)
 
-	void *object = head;
-	void *tail_obj = tail ? : head;
-	void *freeptr;
+	void *object;
+	void *next = *head;
+	void *old_tail = *tail ? *tail : *head;
+
+	/* Head and tail of the reconstructed freelist */
+	*head = NULL;
+	*tail = NULL;
 
 	do {
-		freeptr = slab_free_hook(s, object);
-	} while ((object != tail_obj) && (object = freeptr));
+		object = next;
+		next = get_freepointer(s, object);
+		/* If object's reuse doesn't have to be delayed */
+		if (!slab_free_hook(s, object)) {
+			/* Move object to the new freelist */
+			set_freepointer(s, object, *head);
+			*head = object;
+			if (!*tail)
+				*tail = object;
+		}
+	} while (object != old_tail);
+
+	if (*head == *tail)
+		*tail = NULL;
 #endif
 }
 
@@ -2965,14 +2974,13 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
 				      void *head, void *tail, int cnt,
 				      unsigned long addr)
 {
-	slab_free_freelist_hook(s, head, tail);
 	/*
-	 * slab_free_freelist_hook() could have put the items into quarantine.
-	 * If so, no need to free them.
+	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
+	 * to remove objects, whose reuse must be delayed.
 	 */
-	if (s->flags & SLAB_KASAN && !(s->flags & SLAB_TYPESAFE_BY_RCU))
-		return;
-	do_slab_free(s, page, head, tail, cnt, addr);
+	slab_free_freelist_hook(s, &head, &tail);
+	if (head != NULL)
+		do_slab_free(s, page, head, tail, cnt, addr);
 }
 
 #ifdef CONFIG_KASAN
-- 
2.16.1.291.g4437f3f132-goog
