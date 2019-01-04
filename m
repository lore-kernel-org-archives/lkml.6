Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E27C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C836321871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575588;
	bh=SBQDwlOi/G6k1eUOiDde2puI7AVinMZsxhf5cirSruk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Rs160qNN0an6jRzQBFf7mZmwOhhScRLxZlaubeVR+72EypNySXdCfLpkHuthuIyDz
	 UL9rpleyY9MiiWuTkLhBXK4iLSPV/TyBQxMtG30W9mjuLNhQmKzvDGC5bHsQJS3eLd
	 m6pOFI/qlcv3gn+F8UNVoA9mnyA8Zd4IQfX2ejL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfADETr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfADETr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:19:47 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99032184B;
        Fri,  4 Jan 2019 04:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575586;
        bh=SBQDwlOi/G6k1eUOiDde2puI7AVinMZsxhf5cirSruk=;
        h=From:To:Cc:Subject:Date:From;
        b=BXS3uh1OFaXqlPDv2PPEMK/++OZ28quC2arB8QCIJDRV9VO/7usbbZvDj7qZK3bk8
         L019FoIMyszUMDpsjQQss3Y5Ft9j9OzJ9zDkGfOvYmGonLoXw/rHWikg5uB9a/eoBm
         U2wjjnK8xr39ByP9y2h87VnAhJES2X3ICLcbczQQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: export pin_file flag to user
Date:   Thu,  3 Jan 2019 20:19:45 -0800
Message-Id: <20190104041945.31802-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports pin_file status to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 3 ++-
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..036fd62010c1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2303,9 +2303,10 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
 #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
+#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
 #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
+#define F2FS_FL_USER_VISIBLE		0x704BDFFF /* User visible flags */
 #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2b45e75847..eb099f1ee937 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 		flags |= F2FS_ENCRYPT_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		flags |= F2FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		flags |= F2FS_PIN_FILE_FL;
 
 	flags &= F2FS_FL_USER_VISIBLE;
 
-- 
2.19.0.605.g01d371f741-goog

