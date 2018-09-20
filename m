Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EAEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252AA2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RrvuHAdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252AA2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbeIUAoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:44:09 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:55120 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeIUAoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:44:09 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1537469950;
        bh=0o/45yM+Eb14/1daEP+Aq3odELgSpHRK/o4tBf07UlE=;
        h=From:To:Cc:Subject:Date:From;
        b=RrvuHAdQIm3lrXRYh3vnQ1V9FjMPT9J6FA1vh5NumjVegrcpxXchf01/sZ/p5CokD
         m1+iLo8w+mkUoWt+3C+E4CpBaXyBBOHpa/sf/QcmcC3UAQ4ZWPIy6nDFu+o87Fzd1A
         Hr72PXeN/Ag3ot7RrtjseUggk39eafDgBYXGdKeQ=
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] staging: erofs: fix undeclared symbols
Date:   Thu, 20 Sep 2018 20:58:56 +0200
Message-Id: <20180920185856.14322-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all internal symbols to the internal header file and add a missing
"static" declaration.
This fixes the sparse warnings like the following:

drivers/staging/erofs/unzip_lz4.c:230:5: warning: symbol 'z_erofs_unzip_lz4' was not declared. Should it be static?

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/staging/erofs/data.c          |  5 -----
 drivers/staging/erofs/internal.h      | 14 ++++++++++++++
 drivers/staging/erofs/super.c         |  5 -----
 drivers/staging/erofs/unzip_vle.c     |  2 +-
 drivers/staging/erofs/unzip_vle_lz4.c |  2 --
 drivers/staging/erofs/utils.c         |  2 --
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index ac263a180253..9bfcc549bbf0 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -137,11 +137,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
-extern int z_erofs_map_blocks_iter(struct inode *,
-	struct erofs_map_blocks *, struct page **, int);
-#endif
-
 int erofs_map_blocks_iter(struct inode *inode,
 	struct erofs_map_blocks *map,
 	struct page **mpage_ret, int flags)
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 367b39fe46e5..d4c4c87bcd35 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -547,6 +547,20 @@ extern unsigned long erofs_shrink_count(struct shrinker *shrink,
 	struct shrink_control *sc);
 extern unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	struct shrink_control *sc);
+extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+
+#ifdef CONFIG_EROFS_FS_ZIP
+/* super.c */
+extern int z_erofs_init_zip_subsystem(void);
+extern void z_erofs_exit_zip_subsystem(void);
+
+/* unzip_vle.c */
+extern int z_erofs_map_blocks_iter(struct inode *,
+	struct erofs_map_blocks *, struct page **, int);
+
+/* unzip_lz4.c */
+extern int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen);
+#endif
 
 #ifndef lru_to_page
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 2df9768edac9..c41d92e0cb3c 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -521,11 +521,6 @@ static struct file_system_type erofs_fs_type = {
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
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8721f0a41d15..a0d6c620051f 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -517,7 +517,7 @@ static void __z_erofs_vle_work_release(struct z_erofs_vle_workgroup *grp,
 	erofs_workgroup_put(&grp->obj);
 }
 
-void z_erofs_vle_work_release(struct z_erofs_vle_work *work)
+static void z_erofs_vle_work_release(struct z_erofs_vle_work *work)
 {
 	struct z_erofs_vle_workgroup *grp =
 		z_erofs_vle_work_workgroup(work, true);
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f5b665f15be5..e30e6e2ef05b 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -99,8 +99,6 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 	return 0;
 }
 
-extern int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen);
-
 int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 				  unsigned clusterpages,
 				  struct page **pages,
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 595cf90af9bb..26b9f97f258a 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -99,8 +99,6 @@ int erofs_register_workgroup(struct super_block *sb,
 	return err;
 }
 
-extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
-
 int erofs_workgroup_put(struct erofs_workgroup *grp)
 {
 	int count = atomic_dec_return(&grp->refcount);
-- 
2.19.0

