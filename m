Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbeEHSFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755687AbeEHSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:51 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 43/76] fs/jbd2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:03 -0700
Message-Id: <20180508180436.716-44-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/jbd2/journal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 3fbf48ec2188..e1834a69cd41 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1262,12 +1262,16 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 	}
 
 	jbd_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
-		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
-		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
-
-	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
-			inode->i_sb->s_blocksize);
+		  inode_sb(inode)->s_id, inode->i_ino,
+		  (long long) inode->i_size,
+		  inode_sb(inode)->s_blocksize_bits,
+		  inode_sb(inode)->s_blocksize);
+
+	journal = journal_init_common(inode_sb(inode)->s_bdev,
+				      inode_sb(inode)->s_bdev,
+				      blocknr,
+				      inode->i_size >> inode_sb(inode)->s_blocksize_bits,
+				      inode_sb(inode)->s_blocksize);
 	if (!journal)
 		return NULL;
 
@@ -2233,7 +2237,7 @@ void jbd2_journal_ack_err(journal_t *journal)
 
 int jbd2_journal_blocks_per_page(struct inode *inode)
 {
-	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	return 1 << (PAGE_SHIFT - inode_sb(inode)->s_blocksize_bits);
 }
 
 /*
-- 
2.15.1
