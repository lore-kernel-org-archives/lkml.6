Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C024320645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfAOPp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:45:27 -0500
Received: from smtprz15.163.net ([106.3.154.248]:20781 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729878AbfAOPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:45:26 -0500
Received: from 172.25.16.148 (unknown [172.25.16.148])
        by freemail02.tom.com (Postfix) with ESMTP id AA24EB00CC2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:10:50 +0800 (CST)
Received: from 172.25.16.91 (HELO smtp.tom.com) ([172.25.16.91])
          by localhost (TOM SMTP Server) with SMTP ID 1819019534
          for <linux-kernel@vger.kernel.org>;
          Tue, 15 Jan 2019 22:10:50 +0800 (CST)
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 92D7EB00DA5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:10:49 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 868278162B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:10:49 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Bsx2FHegVke for <linux-kernel@vger.kernel.org>;
        Tue, 15 Jan 2019 22:10:48 +0800 (CST)
Received: from localhost (unknown [222.209.17.203])
        by antispam2.tom.com (Postfix) with ESMTPA id 3E2C8814D9;
        Tue, 15 Jan 2019 22:10:48 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.com, linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] ext2: Remove redundant check on s_inode_size
Date:   Tue, 15 Jan 2019 22:10:43 +0800
Message-Id: <1547561443-3411-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The case of (EXT2_INODE_SIZE(sb) == 0) is included in
(sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE).
So there is no need to check again.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 fs/ext2/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 73b2d52..c71c2e3 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1024,8 +1024,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
-	if (EXT2_INODE_SIZE(sb) == 0)
-		goto cantfind_ext2;
 	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
 	if (sbi->s_inodes_per_block == 0 || sbi->s_inodes_per_group == 0)
 		goto cantfind_ext2;
-- 
1.9.1

