Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E607C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1327F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1327F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeKUAvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:51:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbeKUAvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:51:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 671489FF50029;
        Tue, 20 Nov 2018 22:21:39 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:21:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 07/10] staging: erofs: separate into init_once / always
Date:   Tue, 20 Nov 2018 22:34:22 +0800
Message-ID: <20181120143425.43637-8-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`z_erofs_vle_workgroup' is heavily generated in the decompression,
for example, it resets 32 bytes redundantly for 64-bit platforms
even through Z_EROFS_VLE_INLINE_PAGEVECS + Z_EROFS_CLUSTER_MAX_PAGES,
default 4, pages are stored in `z_erofs_vle_workgroup'.

As an another example, `struct mutex' takes 72 bytes for our kirin
64-bit platforms, it's unnecessary to be reseted at first and
be initialized each time.

Let's avoid filling all `z_erofs_vle_workgroup' with 0 at first
since most fields are reinitialized to meaningful values later,
and pagevec is no need to initialized at all.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index ede3383ac601..4e5843e8ee35 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -43,12 +43,38 @@ static inline int init_unzip_workqueue(void)
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
+static void init_once(void *ptr)
+{
+	struct z_erofs_vle_workgroup *grp = ptr;
+	struct z_erofs_vle_work *const work =
+		z_erofs_vle_grab_primary_work(grp);
+	unsigned int i;
+
+	mutex_init(&work->lock);
+	work->nr_pages = 0;
+	work->vcnt = 0;
+	for (i = 0; i < Z_EROFS_CLUSTER_MAX_PAGES; ++i)
+		grp->compressed_pages[i] = NULL;
+}
+
+static void init_always(struct z_erofs_vle_workgroup *grp)
+{
+	struct z_erofs_vle_work *const work =
+		z_erofs_vle_grab_primary_work(grp);
+
+	atomic_set(&grp->obj.refcount, 1);
+	grp->flags = 0;
+
+	DBG_BUGON(work->nr_pages);
+	DBG_BUGON(work->vcnt);
+}
+
 int __init z_erofs_init_zip_subsystem(void)
 {
 	z_erofs_workgroup_cachep =
 		kmem_cache_create("erofs_compress",
 				  Z_EROFS_WORKGROUP_SIZE, 0,
-				  SLAB_RECLAIM_ACCOUNT, NULL);
+				  SLAB_RECLAIM_ACCOUNT, init_once);
 
 	if (z_erofs_workgroup_cachep) {
 		if (!init_unzip_workqueue())
@@ -370,10 +396,11 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 	BUG_ON(grp);
 
 	/* no available workgroup, let's allocate one */
-	grp = kmem_cache_zalloc(z_erofs_workgroup_cachep, GFP_NOFS);
+	grp = kmem_cache_alloc(z_erofs_workgroup_cachep, GFP_NOFS);
 	if (unlikely(!grp))
 		return ERR_PTR(-ENOMEM);
 
+	init_always(grp);
 	grp->obj.index = f->idx;
 	grp->llen = map->m_llen;
 
@@ -381,7 +408,6 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 		(map->m_flags & EROFS_MAP_ZIPPED) ?
 			Z_EROFS_VLE_WORKGRP_FMT_LZ4 :
 			Z_EROFS_VLE_WORKGRP_FMT_PLAIN);
-	atomic_set(&grp->obj.refcount, 1);
 
 	/* new workgrps have been claimed as type 1 */
 	WRITE_ONCE(grp->next, *f->owned_head);
@@ -394,8 +420,6 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 	work = z_erofs_vle_grab_primary_work(grp);
 	work->pageofs = f->pageofs;
 
-	mutex_init(&work->lock);
-
 	if (gnew) {
 		int err = erofs_register_workgroup(f->sb, &grp->obj, 0);
 
-- 
2.14.4

