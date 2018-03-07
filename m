Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeCGMre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:47:34 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45931 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeCGMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:28 -0500
X-Google-Smtp-Source: AG47ELvs9jcreGCG6/p7P56QGKFw4yq7wH4ibVWEhywK7E/ud7INfsoXOsqsIylwT1CBaK8I/CfOZg==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] lib/scatterlist: Tidy types and fix overflow checking in sgl_alloc_order
Date: Wed,  7 Mar 2018 12:47:07 +0000
Message-Id: <20180307124712.14963-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

There are several issues in sgl_alloc_order and accompanying APIs:

1.

sgl_alloc_order explicitly takes a 64-bit length (unsigned long long) but
then rejects it in overflow checking if greater than 4GiB allocation was
requested. This is a consequence of using unsigned int for the right hand
side condition which then natuarally overflows when shifted left, earlier
than nent otherwise would.

Fix is to promote the right hand side of the conditional to unsigned long.

It is also not useful to allow for 64-bit lenght on 32-bit platforms so
I have changed this type to a natural unsigned long. Like this it changes
size naturally depending on the architecture.

2.

elem_len should not be explicitly sized u32 but unsigned int, to match
the underlying struct scatterlist nents type. Same for the nent_p output
parameter type.

I renamed this to chunk_len and consolidated its use throughout the
function.

3.

Eliminated nalloc local by re-arranging the code a bit.

4.

Tidied types in other helpers, replacing int with unsigned int when
passing in back the nents returned from sgl_alloc_order. Again, this is to
match the struct scatterlist underlying types.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/scatterlist.h | 13 ++++++-----
 lib/scatterlist.c           | 54 ++++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 22b2131bcdcd..2144de41ee04 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -277,13 +277,14 @@ int sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 			      unsigned long size, gfp_t gfp_mask);
 
 #ifdef CONFIG_SGL_ALLOC
-struct scatterlist *sgl_alloc_order(unsigned long long length,
-				    unsigned int order, bool chainable,
-				    gfp_t gfp, unsigned int *nent_p);
-struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
+struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
+				    bool chainable, gfp_t gfp,
+				    unsigned int *nent_p);
+struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
 			      unsigned int *nent_p);
-void sgl_free_n_order(struct scatterlist *sgl, int nents, int order);
-void sgl_free_order(struct scatterlist *sgl, int order);
+void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
+		      unsigned int order);
+void sgl_free_order(struct scatterlist *sgl, unsigned int order);
 void sgl_free(struct scatterlist *sgl);
 #endif /* CONFIG_SGL_ALLOC */
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 53728d391d3a..d61c025e38b4 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -487,48 +487,51 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
-struct scatterlist *sgl_alloc_order(unsigned long long length,
-				    unsigned int order, bool chainable,
-				    gfp_t gfp, unsigned int *nent_p)
+struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
+				    bool chainable, gfp_t gfp,
+				    unsigned int *nent_p)
 {
+	unsigned int chunk_len = PAGE_SIZE << order;
 	struct scatterlist *sgl, *sg;
-	struct page *page;
-	unsigned int nent, nalloc;
-	u32 elem_len;
+	unsigned int nent;
+
+	nent = round_up(length, chunk_len) >> (PAGE_SHIFT + order);
 
-	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
 	/* Check for integer overflow */
-	if (length > (nent << (PAGE_SHIFT + order)))
+	if (length > ((unsigned long)nent << (PAGE_SHIFT + order)))
 		return NULL;
-	nalloc = nent;
+
+	if (nent_p)
+		*nent_p = nent;
+
 	if (chainable) {
 		/* Check for integer overflow */
-		if (nalloc + 1 < nalloc)
+		if (nent == UINT_MAX)
 			return NULL;
-		nalloc++;
+		nent++;
 	}
-	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist),
+
+	sgl = kmalloc_array(nent, sizeof(struct scatterlist),
 			    (gfp & ~GFP_DMA) | __GFP_ZERO);
 	if (!sgl)
 		return NULL;
 
-	sg_init_table(sgl, nalloc);
+	sg_init_table(sgl, nent);
 	sg = sgl;
 	while (length) {
-		elem_len = min_t(u64, length, PAGE_SIZE << order);
-		page = alloc_pages(gfp, order);
+		struct page *page = alloc_pages(gfp, order);
+
 		if (!page) {
 			sgl_free(sgl);
 			return NULL;
 		}
 
-		sg_set_page(sg, page, elem_len, 0);
-		length -= elem_len;
+		chunk_len = min_t(unsigned long, length, chunk_len);
+		sg_set_page(sg, page, chunk_len, 0);
+		length -= chunk_len;
 		sg = sg_next(sg);
 	}
-	WARN_ONCE(length, "length = %lld\n", length);
-	if (nent_p)
-		*nent_p = nent;
+	WARN_ONCE(length, "length = %ld\n", length);
 	return sgl;
 }
 EXPORT_SYMBOL(sgl_alloc_order);
@@ -541,7 +544,7 @@ EXPORT_SYMBOL(sgl_alloc_order);
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
-struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
+struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
 			      unsigned int *nent_p)
 {
 	return sgl_alloc_order(length, 0, false, gfp, nent_p);
@@ -561,11 +564,12 @@ EXPORT_SYMBOL(sgl_alloc);
  * - All pages in a chained scatterlist can be freed at once by setting @nents
  *   to a high number.
  */
-void sgl_free_n_order(struct scatterlist *sgl, int nents, int order)
+void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
+		      unsigned int order)
 {
 	struct scatterlist *sg;
 	struct page *page;
-	int i;
+	unsigned int i;
 
 	for_each_sg(sgl, sg, nents, i) {
 		if (!sg)
@@ -583,9 +587,9 @@ EXPORT_SYMBOL(sgl_free_n_order);
  * @sgl: Scatterlist with one or more elements
  * @order: Second argument for __free_pages()
  */
-void sgl_free_order(struct scatterlist *sgl, int order)
+void sgl_free_order(struct scatterlist *sgl, unsigned int order)
 {
-	sgl_free_n_order(sgl, INT_MAX, order);
+	sgl_free_n_order(sgl, UINT_MAX, order);
 }
 EXPORT_SYMBOL(sgl_free_order);
 
-- 
2.14.1
