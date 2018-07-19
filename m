Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E294ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D892084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbVaCAKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D892084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbeGSQm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbeGSQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:42:25 -0400
Received: from localhost.localdomain (unknown [49.65.250.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45FB2084C;
        Thu, 19 Jul 2018 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532015916;
        bh=QyFVj8Ss2S4aHtpMzpRgE8mnzoUQkqeoGmuG3jSoUpw=;
        h=From:To:Cc:Subject:Date:From;
        b=cbVaCAKLp4YMTxyvZHYrjteDPqACXHjjQyXm7NwZe2tjhf5o8u1kfEdG7nxaWjAb9
         K+r+MCPFcDBQXjbcs63+9EPV65gZgnqrUeOKK0qlX97o8Nrs31DH/HvhUZSVTmWkdY
         4cuZc/vVH31R7JY60VBul9K7psgvNzfolJ6348V0=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: restrict setting up inode.i_advise
Date:   Thu, 19 Jul 2018 23:57:54 +0800
Message-Id: <20180719155754.15678-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In order to give advise to f2fs to recognize hot/cold file, it is possible
that we can set specific bit in inode.i_advise through setxattr(), but
there are several bits which are used internally, such as encrypt_bit,
keep_size_bit, they should never be changed through setxattr().

So that this patch 1) adds FADVISE_MODIFIABLE_BITS to filter modifiable
bits user given, 2) supports to clear {hot,cold}_file bits.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/xattr.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ff3b80da32f3..5501532d7039 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -609,6 +609,8 @@ enum {
 #define FADVISE_HOT_BIT		0x20
 #define FADVISE_VERITY_BIT	0x40	/* reserved */
 
+#define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
+
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 708271871f94..34c98de6144e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -100,12 +100,22 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		const char *name, const void *value,
 		size_t size, int flags)
 {
+	unsigned char old_advise = F2FS_I(inode)->i_advise;
+	unsigned char new_advise;
+
 	if (!inode_owner_or_capable(inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
 
-	F2FS_I(inode)->i_advise |= *(char *)value;
+	new_advise = *(char *)value;
+	if (new_advise & ~FADVISE_MODIFIABLE_BITS)
+		return -EINVAL;
+
+	new_advise = new_advise & FADVISE_MODIFIABLE_BITS;
+	new_advise |= old_advise & ~FADVISE_MODIFIABLE_BITS;
+
+	F2FS_I(inode)->i_advise = new_advise;
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
-- 
2.16.2.17.g38e79b1fd

