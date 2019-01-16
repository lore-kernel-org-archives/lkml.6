Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9AAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145B020873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAPBjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:39:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28899 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727551AbfAPBjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:39:35 -0500
X-UUID: a9757a92b2cc4c2a946cb0ce9f3a4739-20190116
X-UUID: a9757a92b2cc4c2a946cb0ce9f3a4739-20190116
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 544583588; Wed, 16 Jan 2019 09:39:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 09:39:28 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 09:39:28 +0800
From:   CK Hu <ck.hu@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=F8nnes?= <noralf@tronnes.org>,
        Frank Wunderlich <frank-w@public-files.de>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 1/2] drm/mediatek: Implement gem prime vmap/vunmap function
Date:   Wed, 16 Jan 2019 09:39:23 +0800
Message-ID: <20190116013924.11345-1-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some application which need kernel virtual address, such as fbcon,
implement these function to map/unmap kernel virtual address of prime
buffer.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 46 ++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_gem.h |  3 ++
 3 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6422e99952fe..6ec4ca070382 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -341,6 +341,8 @@ static struct drm_driver mtk_drm_driver = {
 	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
 	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
+	.gem_prime_vmap = mtk_drm_gem_prime_vmap,
+	.gem_prime_vunmap = mtk_drm_gem_prime_vunmap,
 	.fops = &mtk_drm_fops,
 
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 259b7b0de1d2..38483e9ee071 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -241,3 +241,49 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 	kfree(mtk_gem);
 	return ERR_PTR(ret);
 }
+
+void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
+	struct sg_table *sgt;
+	struct sg_page_iter iter;
+	unsigned int npages;
+	unsigned int i = 0;
+
+	if (mtk_gem->kvaddr)
+		return mtk_gem->kvaddr;
+
+	sgt = mtk_gem_prime_get_sg_table(obj);
+	if (IS_ERR(sgt))
+		return NULL;
+
+	npages = obj->size >> PAGE_SHIFT;
+	mtk_gem->pages = kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
+	if (!mtk_gem->pages)
+		goto out;
+
+	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
+		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
+		if (i > npages)
+			break;
+	}
+	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
+			       pgprot_writecombine(PAGE_KERNEL));
+
+out:
+	kfree((void *)sgt);
+
+	return mtk_gem->kvaddr;
+}
+
+void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
+
+	if (!mtk_gem->pages)
+		return;
+
+	vunmap(vaddr);
+	mtk_gem->kvaddr = 0;
+	kfree((void *)mtk_gem->pages);
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
index 534639b43a1c..c047a7ef294f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
@@ -37,6 +37,7 @@ struct mtk_drm_gem_obj {
 	dma_addr_t		dma_addr;
 	unsigned long		dma_attrs;
 	struct sg_table		*sg;
+	struct page		**pages;
 };
 
 #define to_mtk_gem_obj(x)	container_of(x, struct mtk_drm_gem_obj, base)
@@ -52,5 +53,7 @@ int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj,
 struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 			struct dma_buf_attachment *attach, struct sg_table *sg);
+void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj);
+void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
 #endif
-- 
2.18.1

