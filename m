Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3540CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF2A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF2A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLLDuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:50:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeLLDuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:50:35 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B322043946855;
        Wed, 12 Dec 2018 11:50:30 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 12 Dec 2018
 11:50:26 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] f2fs: remove codes of unused wio_mutex
Date:   Wed, 12 Dec 2018 11:50:20 +0800
Message-ID: <1544586620-124300-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1540368582-14312-1-git-send-email-yunlong.song@huawei.com>
References: <1540368582-14312-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: delete comments in f2fs.h: "/* bio ordering for NODE/DATA */"

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 --
 fs/f2fs/super.c | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e03197..195850e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1170,8 +1170,6 @@ struct f2fs_sb_info {
 
 	/* for bio operations */
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
-	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
-						/* bio ordering for NODE/DATA */
 	/* keep migration IO order for LFS mode */
 	struct rw_semaphore io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2c..2d18de5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2674,7 +2674,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
-	int i, j;
+	int i;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -2710,9 +2710,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-	for (i = 0; i < NR_PAGE_TYPE - 1; i++)
-		for (j = HOT; j < NR_TEMP_TYPE; j++)
-			mutex_init(&sbi->wio_mutex[i][j]);
 	init_rwsem(&sbi->io_order_lock);
 	spin_lock_init(&sbi->cp_lock);
 
-- 
1.8.5.2

