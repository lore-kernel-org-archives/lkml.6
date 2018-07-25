Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A144FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F120883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN3axghO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeGYEcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeGYEcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:32:08 -0400
Received: from localhost (unknown [106.251.248.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DF620852;
        Wed, 25 Jul 2018 03:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532488952;
        bh=U3lTZyq7H7QwBGdH08Gj9k/QnIrE8jqvY6fG7ltmFi0=;
        h=From:To:Cc:Subject:Date:From;
        b=qN3axghO8rlwERsYAiGk9G1L8s/niHON7ut3w6Murm4AIvjECkvpZ6kxs+pEZENgy
         RSJI50/wqv0RWASsAkMIz2vtpttCYTITNcPR4dnCPWPoGwxPJJmUSjQ4QSj9Q6OUMa
         xnoJHLxFB/iEzmHh+l/5bNHEZaLUjqlmSnlNPZJA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc
Date:   Wed, 25 Jul 2018 12:22:28 +0900
Message-Id: <20180725032228.63492-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c    | 2 ++
 fs/f2fs/segment.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 84293423f830..3a5c35fa0603 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1754,6 +1754,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
 	inode_lock(inode);
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d28fa03a115f..17354089b4ab 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -445,7 +445,6 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int err;
 
-	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);
 
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
-- 
2.17.0.441.gb46fe60e1d-goog

