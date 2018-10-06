Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74EC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBD20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6a6nvTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBBD20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJGM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 08:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeJGM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 08:58:40 -0400
Received: from localhost.localdomain (unknown [49.77.226.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48542084D;
        Sun,  7 Oct 2018 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538891552;
        bh=cyZCOvFsG1gKU7bXDPUZ7sUZqeWIxW0eVZJv3krqXRw=;
        h=From:To:Cc:Subject:Date:From;
        b=R6a6nvTRVqaZ9EKTX6w1eAbFyyocKAAWCBDweV/WZefDbwjkm0sPeKl93Rd1r3WwK
         eRLCRf69paCWgB7TnTPXloGJY8qTSb3Z+VHerAvUABizSVZEiXNICxuUWJompbbMxX
         4Y5brEeyeWJKETG64pVQ1i1e0tiDwz4Szq4SqRuQ=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to recover inode->i_flags of inode block during POR
Date:   Sun,  7 Oct 2018 03:03:38 +0800
Message-Id: <20181006190338.4037-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Testcase to reproduce this bug:
1. mkfs.f2fs /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr +a /mnt/f2fs/file
6. xfs_io -a /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. xfs_io /mnt/f2fs/file

There is no error when opening this file w/o O_APPEND, but actually,
we expect the correct result should be:

/mnt/f2fs/file: Operation not permitted

The root cause is, in recover_inode(), we recover inode->i_flags more
than F2FS_I(inode)->i_flags, so fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index af66d6f5683b..eeee3756c3a9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -275,6 +275,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
+	f2fs_set_inode_flags(inode);
 	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
 				le16_to_cpu(raw->i_gc_failures);
 
-- 
2.18.0

