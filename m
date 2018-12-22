Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EBF2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393049AbeLWAdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 19:33:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387711AbeLWAdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 19:33:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03C9AE84DC7BB;
        Sat, 22 Dec 2018 16:46:56 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 22 Dec 2018 16:46:46 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <yangerkun@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] debugfs: remove inc_nlink in debugfs_create_automount
Date:   Sat, 22 Dec 2018 16:45:36 +0800
Message-ID: <20181222084536.21305-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inc_nlink in debugfs_create_automount, or this inode will never
be free.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/debugfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..9294238e364f 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -551,12 +551,11 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
 	dentry->d_fsdata = (void *)f;
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-- 
2.14.4

