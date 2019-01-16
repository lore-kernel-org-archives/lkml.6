Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B102086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbfAPJBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:01:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391561AbfAPJBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:01:37 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A05631AD5A103EDC139;
        Wed, 16 Jan 2019 17:01:34 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.206)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 16 Jan 2019 17:01:28
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4/5] staging: erofs: staticize erofs_shrink_count, erofs_shrink_scan
Date:   Wed, 16 Jan 2019 16:59:55 +0800
Message-ID: <20190116085956.21004-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190116085956.21004-1-gaoxiang25@huawei.com>
References: <20190116085956.21004-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move erofs_shrinker_info to utils.c and therefore
no need to globalize erofs_shrink_count and erofs_shrink_scan.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h |  5 +----
 drivers/staging/erofs/super.c    |  6 ------
 drivers/staging/erofs/utils.c    | 14 ++++++++++----
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 967ec1a56726..304c79d253ae 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -589,10 +589,7 @@ extern struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
 extern void erofs_register_super(struct super_block *sb);
 extern void erofs_unregister_super(struct super_block *sb);
 
-extern unsigned long erofs_shrink_count(struct shrinker *shrink,
-	struct shrink_control *sc);
-extern unsigned long erofs_shrink_scan(struct shrinker *shrink,
-	struct shrink_control *sc);
+extern struct shrinker erofs_shrinker_info;
 
 #ifndef lru_to_page
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 69e1840d3842..af5140eede18 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -539,12 +539,6 @@ static void erofs_kill_sb(struct super_block *sb)
 	kill_block_super(sb);
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
-
 static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 5695efaeb43a..5f61f99f4c10 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -270,14 +270,14 @@ void erofs_unregister_super(struct super_block *sb)
 	spin_unlock(&erofs_sb_list_lock);
 }
 
-unsigned long erofs_shrink_count(struct shrinker *shrink,
-				 struct shrink_control *sc)
+static unsigned long erofs_shrink_count(struct shrinker *shrink,
+					struct shrink_control *sc)
 {
 	return atomic_long_read(&erofs_global_shrink_cnt);
 }
 
-unsigned long erofs_shrink_scan(struct shrinker *shrink,
-				struct shrink_control *sc)
+static unsigned long erofs_shrink_scan(struct shrinker *shrink,
+				       struct shrink_control *sc)
 {
 	struct erofs_sb_info *sbi;
 	struct list_head *p;
@@ -333,3 +333,9 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
+struct shrinker erofs_shrinker_info = {
+	.scan_objects = erofs_shrink_scan,
+	.count_objects = erofs_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
-- 
2.14.4

