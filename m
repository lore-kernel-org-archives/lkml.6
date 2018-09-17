Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B96ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB1214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DB1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIQMtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:49:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeIQMtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:49:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 57585C9C8B6C1;
        Mon, 17 Sep 2018 15:23:35 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 15:23:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] ext4: fix to propagate error from dquot_initialize()
Date:   Mon, 17 Sep 2018 15:22:46 +0800
Message-ID: <20180917072246.25457-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ext4_ioctl_setproject(), we forgot to check error return from
dquot_initialize(), if we ignore such error, later, quota info can
be out-of-update, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/ext4/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a7074115d6f6..e6d11cb07e87 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -364,7 +364,9 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 		brelse(iloc.bh);
 	}
 
-	dquot_initialize(inode);
+	err = dquot_initialize(inode);
+	if (err)
+		goto out_unlock;
 
 	handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 		EXT4_QUOTA_INIT_BLOCKS(sb) +
-- 
2.18.0.rc1

