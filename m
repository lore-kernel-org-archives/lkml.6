Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F92C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F8218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QlNAG2Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbeLTTWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:22:40 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:42296 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389328AbeLTTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545333718;
        h=Message-Id:Date:From:To:Cc:Cc:Cc:CC:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:References:MIME-Version:Content-Type:Feedback-ID;
        bh=MEo1JnulmTAHG+WXA+afG0E08WmvUdsEOe37fi6PrrM=;
        b=QlNAG2DbLCddJR2rTzuDDeU5Bi4NhHZ686TqNEwNlRTD/c2MgN5RbdIK98ycS8Cu
        8Cb2xj8r43L7Rx9lSoR4+7luOLmsh4gqghmW/FkPslBSSU9RuEk5Zi45gxjTUtrsfqu
        5QH9n+9YHIP7rGhBd5cPpCWa/SItiQKh8huHJC7g=
Message-ID: <01000167cd113f16-b5a2b2db-e75a-4bad-a47a-0a66fbf7fd8a-000000@email.amazonses.com>
User-Agent: quilt/0.65
Date:   Thu, 20 Dec 2018 19:21:58 +0000
From:   Christoph Lameter <cl@linux.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Cc:     Pekka Enberg <penberg@cs.helsinki.fi>
CC:     akpm@linux-foundation.org
Cc:     Mel Gorman <mel@skynet.ie>
Cc:     andi@firstfloor.org
Cc:     Rik van Riel <riel@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC 3/7] slub: Add isolate() and migrate() methods
References: <20181220192145.023162076@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=isolate_and_migrate_methods
X-SES-Outgoing: 2018.12.20-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two methods needed for moving objects and enable the
display of the callbacks via the /sys/kernel/slab interface.

Add documentation explaining the use of these methods and the prototypes
for slab.h. Add functions to setup the callbacks method for a slab cache.

Add empty functions for SLAB/SLOB. The API is generic so it
could be theoretically implemented for these allocators as well.

Signed-off-by: Christoph Lameter <cl@linux.com>

---
 include/linux/slab.h     |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/slub_def.h |    3 ++
 mm/slub.c                |   29 ++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

Index: linux/include/linux/slub_def.h
===================================================================
--- linux.orig/include/linux/slub_def.h
+++ linux/include/linux/slub_def.h
@@ -99,6 +99,9 @@ struct kmem_cache {
 	gfp_t allocflags;	/* gfp flags to use on each alloc */
 	int refcount;		/* Refcount for slab cache destroy */
 	void (*ctor)(void *);
+	kmem_isolate_func *isolate;
+	kmem_migrate_func *migrate;
+
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c
+++ linux/mm/slub.c
@@ -3498,7 +3498,6 @@ static int calculate_sizes(struct kmem_c
 	else
 		s->flags &= ~__OBJECT_POISON;
 
-
 	/*
 	 * If we are Redzoning then check if there is some space between the
 	 * end of the object and the free pointer. If not then add an
@@ -4311,6 +4310,25 @@ int __kmem_cache_create(struct kmem_cach
 	return err;
 }
 
+void kmem_cache_setup_mobility(struct kmem_cache *s,
+	kmem_isolate_func isolate, kmem_migrate_func migrate)
+{
+	/*
+	 * Defragmentable slabs must have a ctor otherwise objects may be
+	 * in an undetermined state after they are allocated.
+	 */
+	BUG_ON(!s->ctor);
+	s->isolate = isolate;
+	s->migrate = migrate;
+	/*
+	 * Sadly serialization requirements currently mean that we have
+	 * to disable fast cmpxchg based processing.
+	 */
+	s->flags &= ~__CMPXCHG_DOUBLE;
+
+}
+EXPORT_SYMBOL(kmem_cache_setup_mobility);
+
 void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -5004,6 +5022,20 @@ static ssize_t ops_show(struct kmem_cach
 
 	if (s->ctor)
 		x += sprintf(buf + x, "ctor : %pS\n", s->ctor);
+
+	if (s->isolate) {
+		x += sprintf(buf + x, "isolate : ");
+		x += sprint_symbol(buf + x,
+				(unsigned long)s->isolate);
+		x += sprintf(buf + x, "\n");
+	}
+
+	if (s->migrate) {
+		x += sprintf(buf + x, "migrate : ");
+		x += sprint_symbol(buf + x,
+				(unsigned long)s->migrate);
+		x += sprintf(buf + x, "\n");
+	}
 	return x;
 }
 SLAB_ATTR_RO(ops);
Index: linux/include/linux/slab.h
===================================================================
--- linux.orig/include/linux/slab.h
+++ linux/include/linux/slab.h
@@ -153,6 +153,68 @@ void memcg_deactivate_kmem_caches(struct
 void memcg_destroy_kmem_caches(struct mem_cgroup *);
 
 /*
+ * Function prototypes passed to kmem_cache_setup_mobility() to enable mobile
+ * objects and targeted reclaim in slab caches.
+ */
+
+/*
+ * kmem_cache_isolate_func() is called with locks held so that the slab
+ * objects cannot be freed. We are in an atomic context and no slab
+ * operations may be performed. The purpose of kmem_cache_isolate_func()
+ * is to pin the object so that it cannot be freed until
+ * kmem_cache_migrate_func() has processed them. This may be accomplished
+ * by increasing the refcount or setting a flag.
+ *
+ * Parameters passed are the number of objects to process and an array of
+ * pointers to objects which are intended to be moved.
+ *
+ * Returns a pointer that is passed to the migrate function. If any objects
+ * cannot be touched at this point then the pointer may indicate a
+ * failure and then the migration function can simply remove the references
+ * that were already obtained. The private data could be used to track
+ * the objects that were already pinned.
+ *
+ * The object pointer array passed is also passed to kmem_cache_migrate().
+ * The function may remove objects from the array by setting pointers to
+ * NULL. This is useful if we can determine that an object is being freed
+ * because kmem_cache_isolate_func() was called when the subsystem
+ * was calling kmem_cache_free().
+ * In that case it is not necessary to increase the refcount or
+ * specially mark the object because the release of the slab lock
+ * will lead to the immediate freeing of the object.
+ */
+typedef void *kmem_isolate_func(struct kmem_cache *, void **, int);
+
+/*
+ * kmem_cache_move_migrate_func is called with no locks held and interrupts
+ * enabled. Sleeping is possible. Any operation may be performed in
+ * migrate(). kmem_cache_migrate_func should allocate new objects and
+ * free all the objects.
+ **
+ * Parameters passed are the number of objects in the array, the array of
+ * pointers to the objects, the NUMA node where the object should be
+ * allocated and the pointer returned by kmem_cache_isolate_func().
+ *
+ * Success is checked by examining the number of remaining objects in
+ * the slab. If the number is zero then the objects will be freed.
+ */
+typedef void kmem_migrate_func(struct kmem_cache *, void **, int nr, int node, void *private);
+
+/*
+ * kmem_cache_setup_mobility() is used to setup callbacks for a slab cache.
+ */
+#ifdef CONFIG_SLUB
+void kmem_cache_setup_mobility(struct kmem_cache *, kmem_isolate_func,
+						kmem_migrate_func);
+#else
+static inline void kmem_cache_setup_mobility(struct kmem_cache *s,
+	kmem_isolate_func isolate, kmem_migrate_func migrate) {}
+#endif
+
+/*
+ * Allocator specific definitions. These are mainly used to establish optimized
+ * ways to convert kmalloc() calls to kmem_cache_alloc() invocations by
+ * selecting the appropriate general cache at compile time.
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
  *
Index: linux/mm/slab_common.c
===================================================================
--- linux.orig/mm/slab_common.c
+++ linux/mm/slab_common.c
@@ -298,7 +298,7 @@ int slab_unmergeable(struct kmem_cache *
 	if (!is_root_cache(s))
 		return 1;
 
-	if (s->ctor)
+	if (s->ctor || s->isolate || s->migrate)
 		return 1;
 
 	if (s->usersize)

