Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC643C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D412086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D412086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIFNgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeIFNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:36:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FB4CF0EB2B8;
        Thu,  6 Sep 2018 17:02:20 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 17:02:12 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2 dhowells/mount-api] staging: erofs: update .mount and .remount_sb
Date:   Thu, 6 Sep 2018 17:01:48 +0800
Message-ID: <1536224508-66168-2-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
References: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .mount and .remount_sb after
commit ("vfs: Require specification of size of
mount data for internal mounts") in reference to
drivers/usb/gadget/function/f_fs.c.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/super.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 2df9768..98614f1 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -480,7 +480,7 @@ struct erofs_mount_private {
 
 /* support mount_bdev() with options */
 static int erofs_fill_super(struct super_block *sb,
-	void *_priv, int silent)
+	void *_priv, size_t data_size, int silent)
 {
 	struct erofs_mount_private *priv = _priv;
 
@@ -488,9 +488,9 @@ static int erofs_fill_super(struct super_block *sb,
 		priv->options, silent);
 }
 
-static struct dentry *erofs_mount(
-	struct file_system_type *fs_type, int flags,
-	const char *dev_name, void *data)
+static struct dentry *erofs_mount(struct file_system_type *fs_type,
+				  int flags, const char *dev_name,
+				  void *data, size_t data_size)
 {
 	struct erofs_mount_private priv = {
 		.dev_name = dev_name,
@@ -498,7 +498,7 @@ static struct dentry *erofs_mount(
 	};
 
 	return mount_bdev(fs_type, flags, dev_name,
-		&priv, erofs_fill_super);
+		&priv, sizeof(priv), erofs_fill_super);
 }
 
 static void erofs_kill_sb(struct super_block *sb)
@@ -623,7 +623,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int erofs_remount(struct super_block *sb, int *flags, char *data)
+static int erofs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	BUG_ON(!sb_rdonly(sb));
 
-- 
1.9.1

