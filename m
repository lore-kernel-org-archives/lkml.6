Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7761EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226C1208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sadefe/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226C1208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeFLNm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:42:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37891 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeFLNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:42:25 -0400
Received: by mail-lf0-f68.google.com with SMTP id i83-v6so36081382lfh.5;
        Tue, 12 Jun 2018 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIUZAJgVzdLEdBHsV3gbQ3mhrd7xJYIXzXJBfM2EHTA=;
        b=sadefe/2+7UMNK0nmxNsZFFqYDV9DD8I0C51Zb72Wdp6PTyLDGu7WUSHeU4Q31rFdm
         b7pzgE9JL1jmteUcUovg+c1plwaQj38rmPwx6XEDJIux5KOS2QuVg6Q3aH9TsRnVod04
         Igk0sxRaQpO+lEd9OHcmXz2LUC3UILnlh/cgvkdmaRX88/d/kdyVFnp07YV+1PlLGBMj
         KEzaiw3O0vNGXb4R/OyHyGCOEmDQbuAMHrVu5dfwKWkaFWTXEywGITokj0NkV4zND6Xt
         rVEBssIsESrlEKm/covplfeOrczw5l/KMEGJVHe6Dt24zcoEIY0u5/Iq5V1j4zAAeaqc
         xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIUZAJgVzdLEdBHsV3gbQ3mhrd7xJYIXzXJBfM2EHTA=;
        b=rKlUp+gwdjbeQX46G9LabO3nBR0Xt+yA20lJQGddXoJirxcCdnkIS2VAXxNzcE2PsA
         AYXC0Nc44kVuq0cAxajldUxmNJ4ziGd26yUWeijP0AqufWVmgccPK/yrxHRdiHy+OreB
         YqcGtyk5CxLaxckSpoAGlE7wg3fNv3zutduTI7cUiZ9ULglvDwdNX02zfM5f63LT5H6f
         PWsJOgB5eIXauxw/IevcZWWA4ib7x5ea7D+iqqxs8ayI2G6+z6Rtnh+90kb5H7C/AB8p
         DIEMt6XJKDiAL/Gf6JCk631JgqYucRiWMLISdcef0uUwjkDlF+83mgKmUTZqc1M2l3rv
         XjQw==
X-Gm-Message-State: APt69E2vkzxQopBPstadDFRNmzb3NZk3NduwbMF0CpqKQWi15A/Rvvdn
        jUm4RBO6ngxmgm1c6z+FDS8=
X-Google-Smtp-Source: ADUXVKJqQZT+qLFiWoL7HvaFfiYxvHR81p1D6cAC/fOrl3eR6yP9cgNe1Nw6BJXA/JmWOX+V543WLA==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr267836lff.5.1528810943453;
        Tue, 12 Jun 2018 06:42:23 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id x18-v6sm46692ljh.63.2018.06.12.06.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 06:42:22 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3 9/9] xen/gntdev: Implement dma-buf import functionality
Date:   Tue, 12 Jun 2018 16:42:00 +0300
Message-Id: <20180612134200.17456-10-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612134200.17456-1-andr2000@gmail.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
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
---
 drivers/xen/gntdev-dmabuf.c | 240 +++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 84cba67c6ad7..4d250eb8babc 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -17,6 +17,15 @@
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
@@ -31,6 +40,14 @@ struct gntdev_dmabuf {
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
@@ -55,6 +72,8 @@ struct gntdev_dmabuf_priv {
 	struct list_head exp_list;
 	/* List of wait objects. */
 	struct list_head exp_wait_list;
+	/* List of imported DMA buffers. */
+	struct list_head imp_list;
 	/* This is the lock which protects dma_buf_xxx lists. */
 	struct mutex lock;
 };
@@ -500,21 +519,237 @@ int gntdev_dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 
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
 struct gntdev_dmabuf *
 gntdev_dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
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
+}
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
 
 u32 *gntdev_dmabuf_imp_get_refs(struct gntdev_dmabuf *gntdev_dmabuf)
 {
+	if (gntdev_dmabuf)
+		return gntdev_dmabuf->u.imp.refs;
+
 	return NULL;
 }
 
+/*
+ * Find the hyper dma-buf by its file descriptor and remove
+ * it from the buffer's list.
+ */
+static struct gntdev_dmabuf *
+dmabuf_imp_find_unlink(struct gntdev_dmabuf_priv *priv, int fd)
+{
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
+}
+
 int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
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
+	attach = gntdev_dmabuf->u.imp.attach;
+
+	if (gntdev_dmabuf->u.imp.sgt)
+		dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
+					 DMA_BIDIRECTIONAL);
+	dma_buf = attach->dmabuf;
+	dma_buf_detach(attach->dmabuf, attach);
+	dma_buf_put(dma_buf);
+
+	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs,
+				      gntdev_dmabuf->nr_pages);
+	dmabuf_imp_free_storage(gntdev_dmabuf);
+	return 0;
 }
 
 struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
@@ -528,6 +763,7 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
 	mutex_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->exp_list);
 	INIT_LIST_HEAD(&priv->exp_wait_list);
+	INIT_LIST_HEAD(&priv->imp_list);
 
 	return priv;
 }
-- 
2.17.1

