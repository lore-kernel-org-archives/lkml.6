Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8473C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB721852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203113;
	bh=RLv6CFxi1O6x2llBM7FCu3PlHR+p6Joxu18t2U5hK/o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QS/8b2NY1NphHLozgbkdI+Lpo/M6AZm7Bhdo/4bT+0xZkbvgxsY7vDKA4BGy5saR7
	 VH9n7RTeUa9KgORz8k5nEMp1Uon+8JzT7V70mZe3maw8j2E2Ln/jwvO5bFD3i66u8J
	 H44cshBmVXV4dhshJvX646ZMZ0Pet4UCdDA+Rnjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfBZRpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:45:10 -0500
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D052173C;
        Tue, 26 Feb 2019 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203109;
        bh=RLv6CFxi1O6x2llBM7FCu3PlHR+p6Joxu18t2U5hK/o=;
        h=From:To:Cc:Subject:Date:From;
        b=1GArn06cTd2b33bjiLCOMA/XIgKKUljw66jfdEpQ0f9+X50+3PuqrIgqAFHP64TQu
         3SMHxT3NTAi7/LopR4DcyZBEAbjHoGhs4w/UBe6tSqhomy8qrvkKfPyn5g5rT+N2HA
         ZxhPyOx/NoyO3qL95kE1UkTdhv0WEnGjsZx+FBzo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: give random value to i_generation
Date:   Tue, 26 Feb 2019 09:45:07 -0800
Message-Id: <20190226174507.76205-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This follows to give random number to i_generation along with commit
232530680290b ("ext4: improve smp scalability for inode generation")

This can be used for DUN for UFS HW encryption.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 --
 fs/f2fs/namei.c | 3 ++-
 fs/f2fs/super.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 19cbf17550c7..3007759dd2dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1242,8 +1242,6 @@ struct f2fs_sb_info {
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
-	u32 s_next_generation;			/* for NFS support */
-
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
 	/* # of allocated blocks */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 62d9829f3a6a..f218d9424d8b 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
+#include <linux/random.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/quotaops.h>
@@ -50,7 +51,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	F2FS_I(inode)->i_crtime = inode->i_mtime;
-	inode->i_generation = sbi->s_next_generation++;
+	inode->i_generation = prandom_u32();
 
 	if (S_ISDIR(inode->i_mode))
 		F2FS_I(inode)->i_current_depth = 1;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 45121190a2ba..42eb5c86330a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3129,7 +3129,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = sbi->max_file_blocks <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &f2fs_quota_operations;
-- 
2.19.0.605.g01d371f741-goog

