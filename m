Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ACC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5E82087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5E82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJOPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:24:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbeJOPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:24:25 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90C521CDC8C3B;
        Mon, 15 Oct 2018 15:40:17 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 15 Oct 2018
 15:40:10 +0800
From:   ZhuangShengen <zhuangshengen@huawei.com>
To:     <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <arnd@arndb.de>, <boris.brezillon@bootlin.com>,
        <viro@zeniv.linux.org.uk>, <houtao1@huawei.com>,
        <zhuangshengen@huawei.com>
Subject: [PATCH] jffs2: modify the mtime and ctime when truncate file
Date:   Mon, 15 Oct 2018 15:42:01 +0800
Message-ID: <1539589321-103638-1-git-send-email-zhuangshengen@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall truncate don't modify the mtime or ctime of the file.
The reason is that it only check the ATTR_MTIME or ATTR_CTIME flag
in function jffs2_do_setattr,and the syscall truncate has not set these
two flags in VFS layer.

Fix the problem by checking the ATTR_SIZE flag when modify the
mtime or ctime of the file in jffs2_do_setattr.

This fix solve the same problem with commit 3972f2603d85 ("btrfs:
update timestamps on truncate()")

Signed-off-by: ZhuangShengen <zhuangshengen@huawei.com>
---
 fs/jffs2/fs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04ec..98261f6 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -113,8 +113,10 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 
 	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
 	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
-	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
-	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	ri->mtime = cpu_to_je32(I_SEC((ivalid & (ATTR_SIZE | ATTR_MTIME)) ?
+		iattr->ia_mtime:inode->i_mtime));
+	ri->ctime = cpu_to_je32(I_SEC((ivalid & (ATTR_SIZE | ATTR_CTIME)) ?
+		iattr->ia_ctime:inode->i_ctime));
 
 	ri->offset = cpu_to_je32(0);
 	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
-- 
2.7.4

