Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423265AbeE1LG1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423219AbeE1LGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 056/272] kasan, slub: fix handling of kasan_slab_free hook
Date: Mon, 28 May 2018 12:01:29 +0200
Message-Id: <20180528100245.615413705@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit c3895391df385c6628638f014c87e16f5e2efd45 ]

The kasan_slab_free hook's return value denotes whether the reuse of a
slab object must be delayed (e.g.  when the object is put into memory
qurantine).

The current way SLUB handles this hook is by ignoring its return value
and hardcoding checks similar (but not exactly the same) to the ones
performed in kasan_slab_free, which is prone to making mistakes.

The main difference between the hardcoded checks and the ones in
kasan_slab_free is whether we want to perform a free in case when an
invalid-free or a double-free was detected (we don't).

This patch changes the way SLUB handles this by:
1. taking into account the return value of kasan_slab_free for each of
   the objects, that are being freed;
2. reconstructing the freelist of objects to exclude the ones, whose
   reuse must be delayed.

[andreyknvl@google.com: eliminate unnecessary branch in slab_free]
  Link: http://lkml.kernel.org/r/a62759a2545fddf69b0c034547212ca1eb1b3ce2.1520359686.git.andreyknvl@google.com
Link: http://lkml.kernel.org/r/083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |   57 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1362,10 +1362,8 @@ static __always_inline void kfree_hook(v
 	kasan_kfree_large(x, _RET_IP_);
 }
 
-static __always_inline void *slab_free_hook(struct kmem_cache *s, void *x)
+static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 {
-	void *freeptr;
-
 	kmemleak_free_recursive(x, s->flags);
 
 	/*
@@ -1385,17 +1383,12 @@ static __always_inline void *slab_free_h
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
 
-static inline void slab_free_freelist_hook(struct kmem_cache *s,
-					   void *head, void *tail)
+static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+					   void **head, void **tail)
 {
 /*
  * Compiler cannot detect this function can be removed if slab_free_hook()
@@ -1406,13 +1399,33 @@ static inline void slab_free_freelist_ho
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
+
+	return *head != NULL;
+#else
+	return true;
 #endif
 }
 
@@ -2965,14 +2978,12 @@ static __always_inline void slab_free(st
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
+	if (slab_free_freelist_hook(s, &head, &tail))
+		do_slab_free(s, page, head, tail, cnt, addr);
 }
 
 #ifdef CONFIG_KASAN
