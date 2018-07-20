Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D302084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLgdjqW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D302084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGTJtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:49:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33720 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeGTJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:49:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id u14-v6so1292627lfu.0;
        Fri, 20 Jul 2018 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ug+pzugMyEUosqLHfKVNMVB2P6QlHUd8/pZDApMTf+g=;
        b=mLgdjqW8uUGpmEN9mKCq+UhYAdpuoQnvtk8gd/8yq+T1t8L0iLfTehIkCJtqAKDEwX
         c6khHG+Xy5bR8wIvikjtHpKdI/opqYJBpFVkMLOkKX1PKl3Nf40r0RKX0sm+/U6217ZT
         QZ10xgTR7wKiWjI0/vnVqwFomZfwX+NJZ2BBcco3WupT47FRr4H+WAsF+5n5OtcUNqj9
         YDkHesMm8OBl54Roa4YOETsbkIDTuW4CEc9S98k2W8Q4GC/dmaITJXscMSW6fdA1LV5N
         8/WmPXw5pAYgogi1DgD8TRhdFC91kqkNqRB4Gwsztr0xQJKebC1hwYwETba/tBk9n92x
         ycoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ug+pzugMyEUosqLHfKVNMVB2P6QlHUd8/pZDApMTf+g=;
        b=cVwJqDPOKJfT0t8Q4schrK4p0JW/dEuJoB0TzvEDXjmj38Q8zow6kSdovTgCxKtZmp
         HkO5mFeNSu4NcrESsAB9DkVnbdnFAhrlsG1EYyhjTCbtirdDAcNdmy/SKkZ+GB7dSjCL
         41IiiwrBeKy7z3fZ7kdxE0qW8xceeZO6NYI4igD5j4We1S4P6zGBY6jVQ7IHhsCqdFC4
         CbpfgzpNuo+h8F3CUwvGXaZQFxgWY+ugduKfHW1v1CmJWD748PpuT1ZPYwByZpM3xyFE
         dv+8m5/EZippFfuqbtPQBi+V/8irKyf+cryFpOn6tSLo3Te3I86xfu9HGLOf2irjOCDS
         Eh1Q==
X-Gm-Message-State: AOUpUlHUyDzWqE0AuWcv7i63Mh5PQ+9dimLIwIsmG56u7Arck3K9S/n7
        h28L4EPv7I271qLnrYOyACQ=
X-Google-Smtp-Source: AAOMgpd3thKEdUimnhtZWbMQeLfcPVmVUQ8I8A1WrHkX/qVssMcnJ7Y9kh74cnSIEliUHyJ9r8cBQA==
X-Received: by 2002:a19:cc0f:: with SMTP id c15-v6mr811968lfg.145.1532077330747;
        Fri, 20 Jul 2018 02:02:10 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id w2-v6sm252394lje.73.2018.07.20.02.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 02:02:09 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 8/8] xen/gntdev: Implement dma-buf import functionality
Date:   Fri, 20 Jul 2018 12:01:50 +0300
Message-Id: <20180720090150.24560-9-andr2000@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720090150.24560-1-andr2000@gmail.com>
References: <20180720090150.24560-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

1. Import a dma-buf with the file descriptor provided and export
   granted references to the pages of that dma-buf into the array
   of grant references.

2. Add API to close all references to an imported buffer, so it can be
   released by the owner. This is only valid for buffers created with
   IOCTL_GNTDEV_DMABUF_IMP_TO_REFS.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev-dmabuf.c | 239 +++++++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index cc4f16c81919..e4c9f1f74476 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -21,6 +21,15 @@
 #include "gntdev-common.h"
 #include "gntdev-dmabuf.h"
 
+#ifndef GRANT_INVALID_REF
+/*
+ * Note on usage of grant reference 0 as invalid grant reference:
+ * grant reference 0 is valid, but never exposed to a driver,
+ * because of the fact it is already in use/reserved by the PV console.
+ */
+#define GRANT_INVALID_REF	0
+#endif
+
 struct gntdev_dmabuf {
 	struct gntdev_dmabuf_priv *priv;
 	struct dma_buf *dmabuf;
@@ -35,6 +44,14 @@ struct gntdev_dmabuf {
 			struct gntdev_priv *priv;
 			struct gntdev_grant_map *map;
 		} exp;
+		struct {
+			/* Granted references of the imported buffer. */
+			grant_ref_t *refs;
+			/* Scatter-gather table of the imported buffer. */
+			struct sg_table *sgt;
+			/* dma-buf attachment of the imported buffer. */
+			struct dma_buf_attachment *attach;
+		} imp;
 	} u;
 
 	/* Number of pages this buffer has. */
@@ -59,6 +76,8 @@ struct gntdev_dmabuf_priv {
 	struct list_head exp_list;
 	/* List of wait objects. */
 	struct list_head exp_wait_list;
+	/* List of imported DMA buffers. */
+	struct list_head imp_list;
 	/* This is the lock which protects dma_buf_xxx lists. */
 	struct mutex lock;
 };
@@ -491,21 +510,230 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 
 /* DMA buffer import support. */
 
+static int
+dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
+				int count, int domid)
+{
+	grant_ref_t priv_gref_head;
+	int i, ret;
+
+	ret = gnttab_alloc_grant_references(count, &priv_gref_head);
+	if (ret < 0) {
+		pr_debug("Cannot allocate grant references, ret %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < count; i++) {
+		int cur_ref;
+
+		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
+		if (cur_ref < 0) {
+			ret = cur_ref;
+			pr_debug("Cannot claim grant reference, ret %d\n", ret);
+			goto out;
+		}
+
+		gnttab_grant_foreign_access_ref(cur_ref, domid,
+						xen_page_to_gfn(pages[i]), 0);
+		refs[i] = cur_ref;
+	}
+
+	return 0;
+
+out:
+	gnttab_free_grant_references(priv_gref_head);
+	return ret;
+}
+
+static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (refs[i] != GRANT_INVALID_REF)
+			gnttab_end_foreign_access(refs[i], 0, 0UL);
+}
+
+static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
+{
+	kfree(gntdev_dmabuf->pages);
+	kfree(gntdev_dmabuf->u.imp.refs);
+	kfree(gntdev_dmabuf);
+}
+
+static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
+{
+	struct gntdev_dmabuf *gntdev_dmabuf;
+	int i;
+
+	gntdev_dmabuf = kzalloc(sizeof(*gntdev_dmabuf), GFP_KERNEL);
+	if (!gntdev_dmabuf)
+		goto fail;
+
+	gntdev_dmabuf->u.imp.refs = kcalloc(count,
+					    sizeof(gntdev_dmabuf->u.imp.refs[0]),
+					    GFP_KERNEL);
+	if (!gntdev_dmabuf->u.imp.refs)
+		goto fail;
+
+	gntdev_dmabuf->pages = kcalloc(count,
+				       sizeof(gntdev_dmabuf->pages[0]),
+				       GFP_KERNEL);
+	if (!gntdev_dmabuf->pages)
+		goto fail;
+
+	gntdev_dmabuf->nr_pages = count;
+
+	for (i = 0; i < count; i++)
+		gntdev_dmabuf->u.imp.refs[i] = GRANT_INVALID_REF;
+
+	return gntdev_dmabuf;
+
+fail:
+	dmabuf_imp_free_storage(gntdev_dmabuf);
+	return ERR_PTR(-ENOMEM);
+}
+
 static struct gntdev_dmabuf *
 dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 		   int fd, int count, int domid)
 {
-	return ERR_PTR(-ENOMEM);
+	struct gntdev_dmabuf *gntdev_dmabuf, *ret;
+	struct dma_buf *dma_buf;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+	struct sg_page_iter sg_iter;
+	int i;
+
+	dma_buf = dma_buf_get(fd);
+	if (IS_ERR(dma_buf))
+		return ERR_CAST(dma_buf);
+
+	gntdev_dmabuf = dmabuf_imp_alloc_storage(count);
+	if (IS_ERR(gntdev_dmabuf)) {
+		ret = gntdev_dmabuf;
+		goto fail_put;
+	}
+
+	gntdev_dmabuf->priv = priv;
+	gntdev_dmabuf->fd = fd;
+
+	attach = dma_buf_attach(dma_buf, dev);
+	if (IS_ERR(attach)) {
+		ret = ERR_CAST(attach);
+		goto fail_free_obj;
+	}
+
+	gntdev_dmabuf->u.imp.attach = attach;
+
+	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		ret = ERR_CAST(sgt);
+		goto fail_detach;
+	}
+
+	/* Check number of pages that imported buffer has. */
+	if (attach->dmabuf->size != gntdev_dmabuf->nr_pages << PAGE_SHIFT) {
+		ret = ERR_PTR(-EINVAL);
+		pr_debug("DMA buffer has %zu pages, user-space expects %d\n",
+			 attach->dmabuf->size, gntdev_dmabuf->nr_pages);
+		goto fail_unmap;
+	}
+
+	gntdev_dmabuf->u.imp.sgt = sgt;
+
+	/* Now convert sgt to array of pages and check for page validity. */
+	i = 0;
+	for_each_sg_page(sgt->sgl, &sg_iter, sgt->nents, 0) {
+		struct page *page = sg_page_iter_page(&sg_iter);
+		/*
+		 * Check if page is valid: this can happen if we are given
+		 * a page from VRAM or other resources which are not backed
+		 * by a struct page.
+		 */
+		if (!pfn_valid(page_to_pfn(page))) {
+			ret = ERR_PTR(-EINVAL);
+			goto fail_unmap;
+		}
+
+		gntdev_dmabuf->pages[i++] = page;
+	}
+
+	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
+						      gntdev_dmabuf->u.imp.refs,
+						      count, domid));
+	if (IS_ERR(ret))
+		goto fail_end_access;
+
+	pr_debug("Imported DMA buffer with fd %d\n", fd);
+
+	mutex_lock(&priv->lock);
+	list_add(&gntdev_dmabuf->next, &priv->imp_list);
+	mutex_unlock(&priv->lock);
+
+	return gntdev_dmabuf;
+
+fail_end_access:
+	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs, count);
+fail_unmap:
+	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
+fail_detach:
+	dma_buf_detach(dma_buf, attach);
+fail_free_obj:
+	dmabuf_imp_free_storage(gntdev_dmabuf);
+fail_put:
+	dma_buf_put(dma_buf);
+	return ret;
 }
 
-static u32 *dmabuf_imp_get_refs(struct gntdev_dmabuf *gntdev_dmabuf)
+/*
+ * Find the hyper dma-buf by its file descriptor and remove
+ * it from the buffer's list.
+ */
+static struct gntdev_dmabuf *
+dmabuf_imp_find_unlink(struct gntdev_dmabuf_priv *priv, int fd)
 {
-	return NULL;
+	struct gntdev_dmabuf *q, *gntdev_dmabuf, *ret = ERR_PTR(-ENOENT);
+
+	mutex_lock(&priv->lock);
+	list_for_each_entry_safe(gntdev_dmabuf, q, &priv->imp_list, next) {
+		if (gntdev_dmabuf->fd == fd) {
+			pr_debug("Found gntdev_dmabuf in the import list\n");
+			ret = gntdev_dmabuf;
+			list_del(&gntdev_dmabuf->next);
+			break;
+		}
+	}
+	mutex_unlock(&priv->lock);
+	return ret;
 }
 
 static int dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
 {
-	return -EINVAL;
+	struct gntdev_dmabuf *gntdev_dmabuf;
+	struct dma_buf_attachment *attach;
+	struct dma_buf *dma_buf;
+
+	gntdev_dmabuf = dmabuf_imp_find_unlink(priv, fd);
+	if (IS_ERR(gntdev_dmabuf))
+		return PTR_ERR(gntdev_dmabuf);
+
+	pr_debug("Releasing DMA buffer with fd %d\n", fd);
+
+	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs,
+				      gntdev_dmabuf->nr_pages);
+
+	attach = gntdev_dmabuf->u.imp.attach;
+
+	if (gntdev_dmabuf->u.imp.sgt)
+		dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
+					 DMA_BIDIRECTIONAL);
+	dma_buf = attach->dmabuf;
+	dma_buf_detach(attach->dmabuf, attach);
+	dma_buf_put(dma_buf);
+
+	dmabuf_imp_free_storage(gntdev_dmabuf);
+	return 0;
 }
 
 /* DMA buffer IOCTL support. */
@@ -582,7 +810,7 @@ long gntdev_ioctl_dmabuf_imp_to_refs(struct gntdev_priv *priv,
 	if (IS_ERR(gntdev_dmabuf))
 		return PTR_ERR(gntdev_dmabuf);
 
-	if (copy_to_user(u->refs, dmabuf_imp_get_refs(gntdev_dmabuf),
+	if (copy_to_user(u->refs, gntdev_dmabuf->u.imp.refs,
 			 sizeof(*u->refs) * op.count) != 0) {
 		ret = -EFAULT;
 		goto out_release;
@@ -616,6 +844,7 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
 	mutex_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->exp_list);
 	INIT_LIST_HEAD(&priv->exp_wait_list);
+	INIT_LIST_HEAD(&priv->imp_list);
 
 	return priv;
 }
-- 
2.18.0

