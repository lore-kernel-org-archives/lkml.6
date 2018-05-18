Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeERMfp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbeERMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:26 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 10/11] ext2: have sync_fs op report writeback errors when passed a since pointer
Date: Fri, 18 May 2018 08:34:14 -0400
Message-Id: <20180518123415.28181-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ext2/super.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 0700f3264c7e..51b548cfebb1 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1264,6 +1264,7 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
  */
 static int ext2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
+	int ret;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
 
@@ -1280,7 +1281,13 @@ static int ext2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 	}
 	spin_unlock(&sbi->s_lock);
 	ext2_sync_super(sb, es, wait);
-	return __sync_blockdev(sb->s_bdev, wait);
+	ret = __sync_blockdev(sb->s_bdev, wait);
+	if (since) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
 }
 
 static int ext2_freeze(struct super_block *sb)
-- 
2.17.0
