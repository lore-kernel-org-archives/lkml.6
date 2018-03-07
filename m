Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeCGMs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:48:56 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46655 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeCGMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:31 -0500
X-Google-Smtp-Source: AG47ELuiDA1Pp4tSP/GvfooosXAHj/+FgBcYP2sap2tIurb/g/mkmQDFhwbt2vJVFTz36iCscMdOjg==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] lib/scatterlist: Unexport some trivial wrappers
Date: Wed,  7 Mar 2018 12:47:10 +0000
Message-Id: <20180307124712.14963-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Save some kernel size by moving trivial wrappers to header as static
inline instead of exporting symbols for them.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/scatterlist.h | 38 ++++++++++++++++++++++++++++++++++----
 lib/scatterlist.c           | 36 ------------------------------------
 2 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 2144de41ee04..f665a278011a 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -280,12 +280,42 @@ int sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 				    bool chainable, gfp_t gfp,
 				    unsigned int *nent_p);
-struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
-			      unsigned int *nent_p);
 void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
 		      unsigned int order);
-void sgl_free_order(struct scatterlist *sgl, unsigned int order);
-void sgl_free(struct scatterlist *sgl);
+
+/**
+ * sgl_alloc - allocate a scatterlist and its pages
+ * @length: Length in bytes of the scatterlist
+ * @gfp: Memory allocation flags
+ * @nent_p: [out] Number of entries in the scatterlist
+ *
+ * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
+ */
+static inline struct scatterlist *
+sgl_alloc(unsigned long length, gfp_t gfp, unsigned int *nent_p)
+{
+	return sgl_alloc_order(length, 0, false, gfp, nent_p);
+}
+
+/**
+ * sgl_free_order - free a scatterlist and its pages
+ * @sgl: Scatterlist with one or more elements
+ * @order: Second argument for __free_pages()
+ */
+static inline void sgl_free_order(struct scatterlist *sgl, unsigned int order)
+{
+	sgl_free_n_order(sgl, UINT_MAX, order);
+}
+
+/**
+ * sgl_free - free a scatterlist and its pages
+ * @sgl: Scatterlist with one or more elements
+ */
+static inline void sgl_free(struct scatterlist *sgl)
+{
+	sgl_free_order(sgl, 0);
+}
+
 #endif /* CONFIG_SGL_ALLOC */
 
 size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e13a759c5c49..c637849482d3 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -537,21 +537,6 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 }
 EXPORT_SYMBOL(sgl_alloc_order);
 
-/**
- * sgl_alloc - allocate a scatterlist and its pages
- * @length: Length in bytes of the scatterlist
- * @gfp: Memory allocation flags
- * @nent_p: [out] Number of entries in the scatterlist
- *
- * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
- */
-struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
-			      unsigned int *nent_p)
-{
-	return sgl_alloc_order(length, 0, false, gfp, nent_p);
-}
-EXPORT_SYMBOL(sgl_alloc);
-
 /**
  * sgl_free_n_order - free a scatterlist and its pages
  * @sgl: Scatterlist with one or more elements
@@ -583,27 +568,6 @@ void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
 }
 EXPORT_SYMBOL(sgl_free_n_order);
 
-/**
- * sgl_free_order - free a scatterlist and its pages
- * @sgl: Scatterlist with one or more elements
- * @order: Second argument for __free_pages()
- */
-void sgl_free_order(struct scatterlist *sgl, unsigned int order)
-{
-	sgl_free_n_order(sgl, UINT_MAX, order);
-}
-EXPORT_SYMBOL(sgl_free_order);
-
-/**
- * sgl_free - free a scatterlist and its pages
- * @sgl: Scatterlist with one or more elements
- */
-void sgl_free(struct scatterlist *sgl)
-{
-	sgl_free_order(sgl, 0);
-}
-EXPORT_SYMBOL(sgl_free);
-
 #endif /* CONFIG_SGL_ALLOC */
 
 void __sg_page_iter_start(struct sg_page_iter *piter,
-- 
2.14.1
