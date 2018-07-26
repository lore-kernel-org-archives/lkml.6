Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830E2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGZNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:44:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729962AbeGZNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:44:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3166A7D7C5EE1;
        Thu, 26 Jul 2018 20:27:47 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:27:43 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 20/25] staging: erofs: introduce superblock registration
Date:   Thu, 26 Jul 2018 20:22:03 +0800
Message-ID: <1532607728-103372-21-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to introducing shrinker solution for erofs,
let's manage all mounted erofs instances at first.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h |  6 ++++++
 drivers/staging/erofs/super.c    |  4 ++++
 drivers/staging/erofs/utils.c    | 17 +++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index e61d417..18e7b9c 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -64,6 +64,9 @@ struct erofs_fault_info {
 typedef u64 erofs_nid_t;
 
 struct erofs_sb_info {
+	/* list for all registered superblocks, mainly for shrinker */
+	struct list_head list;
+
 	u32 blocks;
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -410,6 +413,9 @@ static inline void erofs_vunmap(const void *mem, unsigned int count)
 /* utils.c */
 extern struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
 
+extern void erofs_register_super(struct super_block *sb);
+extern void erofs_unregister_super(struct super_block *sb);
+
 #ifndef lru_to_page
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
 #endif
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 054375d..f455d71 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -326,6 +326,8 @@ static int erofs_read_super(struct super_block *sb,
 	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
 	sbi->dev_name[PATH_MAX - 1] = '\0';
 
+	erofs_register_super(sb);
+
 	/*
 	 * We already have a positive dentry, which was instantiated
 	 * by d_make_root. Just need to d_rehash it.
@@ -373,6 +375,8 @@ static void erofs_put_super(struct super_block *sb)
 	infoln("unmounted for %s", sbi->dev_name);
 	__putname(sbi->dev_name);
 
+	erofs_unregister_super(sb);
+
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 3dec4f8..6748def 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -29,3 +29,20 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
+static DEFINE_MUTEX(erofs_sb_list_lock);
+static LIST_HEAD(erofs_sb_list);
+
+void erofs_register_super(struct super_block *sb)
+{
+	mutex_lock(&erofs_sb_list_lock);
+	list_add(&EROFS_SB(sb)->list, &erofs_sb_list);
+	mutex_unlock(&erofs_sb_list_lock);
+}
+
+void erofs_unregister_super(struct super_block *sb)
+{
+	mutex_lock(&erofs_sb_list_lock);
+	list_del(&EROFS_SB(sb)->list);
+	mutex_unlock(&erofs_sb_list_lock);
+}
+
-- 
1.9.1

