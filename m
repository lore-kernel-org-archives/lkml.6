Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80726C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A2720BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeGJS20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbeGJS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 584D8EB8;
        Tue, 10 Jul 2018 18:28:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.4 29/47] ext4: add more inode number paranoia checks
Date:   Tue, 10 Jul 2018 20:24:53 +0200
Message-Id: <20180710182338.365010112@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit c37e9e013469521d9adb932d17a1795c139b36db upstream.

If there is a directory entry pointing to a system inode (such as a
journal inode), complain and declare the file system to be corrupted.

Also, if the superblock's first inode number field is too small,
refuse to mount the file system.

This addresses CVE-2018-10882.

https://bugzilla.kernel.org/show_bug.cgi?id=200069

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h  |    5 -----
 fs/ext4/inode.c |    3 ++-
 fs/ext4/super.c |    5 +++++
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1468,11 +1468,6 @@ static inline struct timespec ext4_curre
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 {
 	return ino == EXT4_ROOT_INO ||
-		ino == EXT4_USR_QUOTA_INO ||
-		ino == EXT4_GRP_QUOTA_INO ||
-		ino == EXT4_BOOT_LOADER_INO ||
-		ino == EXT4_JOURNAL_INO ||
-		ino == EXT4_RESIZE_INO ||
 		(ino >= EXT4_FIRST_INO(sb) &&
 		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3991,7 +3991,8 @@ static int __ext4_get_inode_loc(struct i
 	int			inodes_per_block, inode_offset;
 
 	iloc->bh = NULL;
-	if (!ext4_valid_inum(sb, inode->i_ino))
+	if (inode->i_ino < EXT4_ROOT_INO ||
+	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
 		return -EFSCORRUPTED;
 
 	iloc->block_group = (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3549,6 +3549,11 @@ static int ext4_fill_super(struct super_
 	} else {
 		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
 		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
+			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
+				 sbi->s_first_ino);
+			goto failed_mount;
+		}
 		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
 		    (!is_power_of_2(sbi->s_inode_size)) ||
 		    (sbi->s_inode_size > blocksize)) {


