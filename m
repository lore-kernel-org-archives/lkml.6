Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3027FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01D720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeIMSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:45:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:45:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8222CF3;
        Thu, 13 Sep 2018 13:35:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 23/78] fat: validate ->i_start before using
Date:   Thu, 13 Sep 2018 15:31:10 +0200
Message-Id: <20180913131807.288656192@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

[ Upstream commit 0afa9626667c3659ef8bd82d42a11e39fedf235c ]

On corrupted FATfs may have invalid ->i_start.  To handle it, this checks
->i_start before using, and return proper error code.

Link: http://lkml.kernel.org/r/87o9f8y1t5.fsf_-_@mail.parknet.co.jp
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Tested-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fat/cache.c  |   19 ++++++++++++-------
 fs/fat/fat.h    |    5 +++++
 fs/fat/fatent.c |    6 +++---
 3 files changed, 20 insertions(+), 10 deletions(-)

--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -224,7 +224,8 @@ static inline void cache_init(struct fat
 int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 {
 	struct super_block *sb = inode->i_sb;
-	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
 	struct fat_entry fatent;
 	struct fat_cache_id cid;
 	int nr;
@@ -233,6 +234,12 @@ int fat_get_cluster(struct inode *inode,
 
 	*fclus = 0;
 	*dclus = MSDOS_I(inode)->i_start;
+	if (!fat_valid_entry(sbi, *dclus)) {
+		fat_fs_error_ratelimit(sb,
+			"%s: invalid start cluster (i_pos %lld, start %08x)",
+			__func__, MSDOS_I(inode)->i_pos, *dclus);
+		return -EIO;
+	}
 	if (cluster == 0)
 		return 0;
 
@@ -249,9 +256,8 @@ int fat_get_cluster(struct inode *inode,
 		/* prevent the infinite loop of cluster chain */
 		if (*fclus > limit) {
 			fat_fs_error_ratelimit(sb,
-					"%s: detected the cluster chain loop"
-					" (i_pos %lld)", __func__,
-					MSDOS_I(inode)->i_pos);
+				"%s: detected the cluster chain loop (i_pos %lld)",
+				__func__, MSDOS_I(inode)->i_pos);
 			nr = -EIO;
 			goto out;
 		}
@@ -261,9 +267,8 @@ int fat_get_cluster(struct inode *inode,
 			goto out;
 		else if (nr == FAT_ENT_FREE) {
 			fat_fs_error_ratelimit(sb,
-				       "%s: invalid cluster chain (i_pos %lld)",
-				       __func__,
-				       MSDOS_I(inode)->i_pos);
+				"%s: invalid cluster chain (i_pos %lld)",
+				__func__, MSDOS_I(inode)->i_pos);
 			nr = -EIO;
 			goto out;
 		} else if (nr == FAT_ENT_EOF) {
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -347,6 +347,11 @@ static inline void fatent_brelse(struct
 	fatent->fat_inode = NULL;
 }
 
+static inline bool fat_valid_entry(struct msdos_sb_info *sbi, int entry)
+{
+	return FAT_START_ENT <= entry && entry < sbi->max_cluster;
+}
+
 extern void fat_ent_access_init(struct super_block *sb);
 extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
 			int entry);
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -23,7 +23,7 @@ static void fat12_ent_blocknr(struct sup
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = entry + (entry >> 1);
-	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
+	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -33,7 +33,7 @@ static void fat_ent_blocknr(struct super
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = (entry << sbi->fatent_shift);
-	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
+	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -353,7 +353,7 @@ int fat_ent_read(struct inode *inode, st
 	int err, offset;
 	sector_t blocknr;
 
-	if (entry < FAT_START_ENT || sbi->max_cluster <= entry) {
+	if (!fat_valid_entry(sbi, entry)) {
 		fatent_brelse(fatent);
 		fat_fs_error(sb, "invalid access to FAT (entry 0x%08x)", entry);
 		return -EIO;


