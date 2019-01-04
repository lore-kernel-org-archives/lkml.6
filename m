Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5FC43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF89921872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575628;
	bh=mlLVY9MqbVHb8bI0TwX3rMy3o/jIUMtDDglKrkebEDo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ON3J0eaE5peA9jX1/w2D9jwOjpNxFu0xj4B/KURKLaL9oTqmfU84FANdZuws+zrh6
	 99pH/C/EvQ3vK26qLrQGW5qnLSjmypwyltUpe06SWiTL50FqULYW6UVEvUToXM9O2Q
	 kckDJMYs8P75mIG7EwmoMiLlLaIDuhFN9n5CBDYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfADEU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfADEU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:20:27 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986B82184B;
        Fri,  4 Jan 2019 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575626;
        bh=mlLVY9MqbVHb8bI0TwX3rMy3o/jIUMtDDglKrkebEDo=;
        h=From:To:Cc:Subject:Date:From;
        b=qnxSib9qGSKV5/GgEEyulX9k+qkTpjJc1AsD5/iesCTEd+JyABYQD7VLjIK/row3w
         5pubBZ7GRD6W5us79QYbK6LjopDQq2xW0LpsFNcQbdYtTdCLLVMOrNbOPVDexFTGKv
         IOTZdVxRhiaWnz5IWFhOmv9slWqejbEbFNQV0HMw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] f2fs: wait on atomic writes to count F2FS_CP_WB_DATA
Date:   Thu,  3 Jan 2019 20:20:24 -0800
Message-Id: <20190104042025.31982-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we can get wrong counts incurring checkpoint hang.

IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bba56b39dcc5..ae2b45e75847 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1750,10 +1750,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (!get_dirty_pages(inode))
-		goto skip_flush;
-
-	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
+	/*
+	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
+	 * f2fs_is_atomic_file.
+	 */
+	if (get_dirty_pages(inode))
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
@@ -1761,7 +1763,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-skip_flush:
+
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-- 
2.19.0.605.g01d371f741-goog

