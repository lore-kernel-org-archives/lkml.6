Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9543C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91882087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91882087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJIUrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:47:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbeJIUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:47:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15138B01B94ED;
        Tue,  9 Oct 2018 21:30:08 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 9 Oct 2018
 21:30:01 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: add the missing __init tags
Date:   Tue, 9 Oct 2018 21:43:53 +0800
Message-ID: <20181009134353.23409-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append __init to `erofs_init_inode_cache',
`z_erofs_init_zip_subsystem' and move these
declarations to internal.h.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h  |  6 ++++++
 drivers/staging/erofs/super.c     | 13 +------------
 drivers/staging/erofs/unzip_vle.c |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index c2cc4a016d9e..5096b27bcf0d 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -284,6 +284,12 @@ static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->max_sync_decompress_pages;
 }
 
+int __init z_erofs_init_zip_subsystem(void);
+void z_erofs_exit_zip_subsystem(void);
+#else
+/* dummy initializer/finalizer for the decompression subsystem */
+static inline int z_erofs_init_zip_subsystem(void) { return 0; }
+static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 51b076255988..f69e619807a1 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -29,7 +29,7 @@ static void init_once(void *ptr)
 	inode_init_once(&vi->vfs_inode);
 }
 
-static int erofs_init_inode_cache(void)
+static int __init erofs_init_inode_cache(void)
 {
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 		sizeof(struct erofs_vnode), 0,
@@ -559,11 +559,6 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
-#ifdef CONFIG_EROFS_FS_ZIP
-extern int z_erofs_init_zip_subsystem(void);
-extern void z_erofs_exit_zip_subsystem(void);
-#endif
-
 static int __init erofs_module_init(void)
 {
 	int err;
@@ -579,11 +574,9 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto shrinker_err;
 
-#ifdef CONFIG_EROFS_FS_ZIP
 	err = z_erofs_init_zip_subsystem();
 	if (err)
 		goto zip_err;
-#endif
 
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
@@ -593,10 +586,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
-#ifdef CONFIG_EROFS_FS_ZIP
 	z_erofs_exit_zip_subsystem();
 zip_err:
-#endif
 	unregister_shrinker(&erofs_shrinker_info);
 shrinker_err:
 	erofs_exit_inode_cache();
@@ -607,9 +598,7 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
-#ifdef CONFIG_EROFS_FS_ZIP
 	z_erofs_exit_zip_subsystem();
-#endif
 	unregister_shrinker(&erofs_shrinker_info);
 	erofs_exit_inode_cache();
 	infoln("successfully finalize erofs");
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 337a82dafa1d..79d3ba62b298 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -42,7 +42,7 @@ static inline int init_unzip_workqueue(void)
 	return z_erofs_workqueue != NULL ? 0 : -ENOMEM;
 }
 
-int z_erofs_init_zip_subsystem(void)
+int __init z_erofs_init_zip_subsystem(void)
 {
 	z_erofs_workgroup_cachep =
 		kmem_cache_create("erofs_compress",
-- 
2.14.4

