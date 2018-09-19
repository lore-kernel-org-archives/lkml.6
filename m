Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C155ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2040E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2040E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeISL0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:26:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeISL0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:26:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2EF54B0392C;
        Wed, 19 Sep 2018 13:50:23 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 19 Sep
 2018 13:50:14 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        Du Wei <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4/6] staging: erofs: cleanup `z_erofs_vle_normalaccess_readpages'
Date:   Wed, 19 Sep 2018 13:49:08 +0800
Message-ID: <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces `__should_decompress_synchronously' to
cleanup `z_erofs_vle_normalaccess_readpages'.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h  | 11 +++++++++++
 drivers/staging/erofs/super.c     |  5 +++++
 drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index cfcc6db..c84eb97 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -95,6 +95,9 @@ struct erofs_sb_info {
 	/* the dedicated workstation for compression */
 	struct radix_tree_root workstn_tree;
 
+	/* threshold for decompression synchronously */
+	unsigned int max_sync_decompress_pages;
+
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	struct inode *managed_cache;
 #endif
@@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
 	struct page *page);
 #endif
 
+#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
+
+static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
+						     unsigned int nr)
+{
+	return nr <= sbi->max_sync_decompress_pages;
+}
+
 #endif
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 802202c..5b87f59 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -162,6 +162,11 @@ static void erofs_build_fault_attr(struct erofs_sb_info *sbi,
 
 static void default_options(struct erofs_sb_info *sbi)
 {
+	/* set up some FS parameters */
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->max_sync_decompress_pages = DEFAULT_MAX_SYNC_DECOMPRESS_PAGES;
+#endif
+
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
 #endif
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 9fe18cd3..337a82d 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1308,12 +1308,14 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	return 0;
 }
 
-static inline int __z_erofs_vle_normalaccess_readpages(
-	struct file *filp,
-	struct address_space *mapping,
-	struct list_head *pages, unsigned int nr_pages, bool sync)
+static int z_erofs_vle_normalaccess_readpages(struct file *filp,
+					      struct address_space *mapping,
+					      struct list_head *pages,
+					      unsigned int nr_pages)
 {
 	struct inode *const inode = mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
+	const bool sync = __should_decompress_synchronously(sbi, nr_pages);
 
 	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
 	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
@@ -1372,16 +1374,6 @@ static inline int __z_erofs_vle_normalaccess_readpages(
 	return 0;
 }
 
-static int z_erofs_vle_normalaccess_readpages(
-	struct file *filp,
-	struct address_space *mapping,
-	struct list_head *pages, unsigned int nr_pages)
-{
-	return __z_erofs_vle_normalaccess_readpages(filp,
-		mapping, pages, nr_pages,
-		nr_pages < 4 /* sync */);
-}
-
 const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 	.readpage = z_erofs_vle_normalaccess_readpage,
 	.readpages = z_erofs_vle_normalaccess_readpages,
-- 
1.9.1

