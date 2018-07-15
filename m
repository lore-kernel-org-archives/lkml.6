Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A114ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C746208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C746208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeGOOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:43:16 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46020 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeGOOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:43:16 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id D19F7197480;
        Sun, 15 Jul 2018 23:20:07 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6FEK6o2007984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jul 2018 23:20:07 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6FEK6YZ027459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jul 2018 23:20:06 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w6FEK6IB027458;
        Sun, 15 Jul 2018 23:20:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to return negative number not equal to -1
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
Date:   Sun, 15 Jul 2018 23:20:06 +0900
In-Reply-To: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
        (Anatoly Trosinenko's message of "Sat, 14 Jul 2018 15:24:17 +0300")
Message-ID: <878t6c7f8p.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatoly Trosinenko <anatoly.trosinenko@gmail.com> writes:

> How to reproduce:
> 1) Compile v4.18-rc4 kernel with the attached config
> 1) Unpack the attached FS image (128 Mb) and mount it as vfat to /mnt
> 2) Compile and run vfat-bug.c
>
> What is expected:
> `write` returns either -1 or small positive number.
>
> What happens:
> The -13619152 aka 0xffffffffff303030 is returned.

This patch returns better error (-EIO) for me. (But note, the corrupted
FS image doesn't guarantee POSIX behavior.)

Thanks.


[PATCH] fat: Validate ->i_start before using

On corrupted FATfs may have invalid ->i_start. To handle it, this
checks ->i_start before using, and return proper error code.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c  |   19 ++++++++++++-------
 fs/fat/fat.h    |    7 +++++++
 fs/fat/fatent.c |    6 +++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff -puN fs/fat/cache.c~fat-validate-i_start fs/fat/cache.c
--- linux/fs/fat/cache.c~fat-validate-i_start	2018-07-15 23:03:25.167171670 +0900
+++ linux-hirofumi/fs/fat/cache.c	2018-07-15 23:03:25.171171666 +0900
@@ -225,7 +225,8 @@ static inline void cache_init(struct fat
 int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 {
 	struct super_block *sb = inode->i_sb;
-	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
 	struct fat_entry fatent;
 	struct fat_cache_id cid;
 	int nr;
@@ -234,6 +235,12 @@ int fat_get_cluster(struct inode *inode,
 
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
 
@@ -250,9 +257,8 @@ int fat_get_cluster(struct inode *inode,
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
@@ -262,9 +268,8 @@ int fat_get_cluster(struct inode *inode,
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
diff -puN fs/fat/fat.h~fat-validate-i_start fs/fat/fat.h
--- linux/fs/fat/fat.h~fat-validate-i_start	2018-07-15 23:03:25.168171670 +0900
+++ linux-hirofumi/fs/fat/fat.h	2018-07-15 23:03:25.171171666 +0900
@@ -348,6 +348,13 @@ static inline void fatent_brelse(struct
 	fatent->fat_inode = NULL;
 }
 
+static inline bool fat_valid_entry(struct msdos_sb_info *sbi, int entry)
+{
+	if (entry < FAT_START_ENT || sbi->max_cluster <= entry)
+		return false;
+	return true;
+}
+
 extern void fat_ent_access_init(struct super_block *sb);
 extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
 			int entry);
diff -puN fs/fat/fatent.c~fat-validate-i_start fs/fat/fatent.c
--- linux/fs/fat/fatent.c~fat-validate-i_start	2018-07-15 23:03:25.169171668 +0900
+++ linux-hirofumi/fs/fat/fatent.c	2018-07-15 23:03:25.171171666 +0900
@@ -24,7 +24,7 @@ static void fat12_ent_blocknr(struct sup
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = entry + (entry >> 1);
-	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
+	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -34,7 +34,7 @@ static void fat_ent_blocknr(struct super
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = (entry << sbi->fatent_shift);
-	WARN_ON(entry < FAT_START_ENT || sbi->max_cluster <= entry);
+	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
 }
@@ -354,7 +354,7 @@ int fat_ent_read(struct inode *inode, st
 	int err, offset;
 	sector_t blocknr;
 
-	if (entry < FAT_START_ENT || sbi->max_cluster <= entry) {
+	if (!fat_valid_entry(sbi, entry)) {
 		fatent_brelse(fatent);
 		fat_fs_error(sb, "invalid access to FAT (entry 0x%08x)", entry);
 		return -EIO;
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
