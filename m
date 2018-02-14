Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbeBNF6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:58:05 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45885 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeBNF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:58:03 -0500
X-Google-Smtp-Source: AH8x224sFrfm24t2EunvabR3A5w5P9fG/3AbkrUKNBzNZsr8bBiQm4Iy4CRmPKlH+M8qT4MXPBSfJA==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv3 1/2] zsmalloc: introduce zs_huge_object() function
Date: Wed, 14 Feb 2018 14:57:47 +0900
Message-Id: <20180214055747.8420-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
References: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every object can be share its zspage with other objects, e.g.
when the object is as big as zspage or nearly as big a zspage.
For such objects zsmalloc has a so called huge class - every object
which belongs to huge class consumes the entire zspage (which
consists of a physical page). On x86_64, PAGE_SHIFT 12 box, the
first non-huge class size is 3264, so starting down from size 3264,
objects can share page(-s) and thus minimize memory wastage.

ZRAM, however, has its own statically defined watermark for huge
objects - "3 * PAGE_SIZE / 4 = 3072", and forcibly stores every
object larger than this watermark (3072) as a PAGE_SIZE object,
in other words, to a huge class, while zsmalloc can keep some of
those objects in non-huge classes. This results in increased
memory consumption.

zsmalloc knows better if the object is huge or not. Introduce
zs_huge_object() function which tells if the given object can be
stored in one of non-huge classes or not. This will let us to drop
ZRAM's huge object watermark and fully rely on zsmalloc when we
decide if the object is huge.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/zsmalloc.h |  2 ++
 mm/zsmalloc.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 57a8e98f2708..9a1baf673cc1 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -47,6 +47,8 @@ void zs_destroy_pool(struct zs_pool *pool);
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
 void zs_free(struct zs_pool *pool, unsigned long obj);
 
+bool zs_huge_object(size_t sz);
+
 void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 			enum zs_mapmode mm);
 void zs_unmap_object(struct zs_pool *pool, unsigned long handle);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c3013505c305..e43fc6ebb8e1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -192,6 +192,7 @@ static struct vfsmount *zsmalloc_mnt;
  * (see: fix_fullness_group())
  */
 static const int fullness_threshold_frac = 4;
+static size_t zs_huge_class_size;
 
 struct size_class {
 	spinlock_t lock;
@@ -1417,6 +1418,28 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
+/**
+ * zs_huge_object() - Test if a compressed object's size is too big for normal
+ *                    zspool classes and it should be stored in a huge class.
+ * @sz: Size of the compressed object (in bytes).
+ *
+ * The function checks if the object's size falls into huge_class
+ * area. We must take handle size into account and test the actual
+ * size we are going to use, because zs_malloc() unconditionally
+ * adds %ZS_HANDLE_SIZE before it performs &size_class lookup.
+ *
+ * Context: Any context.
+ *
+ * Return:
+ * * true  - The object is too big, it will be stored in the huge class.
+ * * false - The object will be stored in a normal zspool class.
+ */
+bool zs_huge_object(size_t sz)
+{
+	return sz + ZS_HANDLE_SIZE >= zs_huge_class_size;
+}
+EXPORT_SYMBOL_GPL(zs_huge_object);
+
 static unsigned long obj_malloc(struct size_class *class,
 				struct zspage *zspage, unsigned long handle)
 {
@@ -2404,6 +2427,9 @@ struct zs_pool *zs_create_pool(const char *name)
 			INIT_LIST_HEAD(&class->fullness_list[fullness]);
 
 		prev_class = class;
+		if (pages_per_zspage == 1 && objs_per_zspage == 1
+				&& !zs_huge_class_size)
+			zs_huge_class_size = size;
 	}
 
 	/* debug only, don't abort if it fails */
-- 
2.16.1
