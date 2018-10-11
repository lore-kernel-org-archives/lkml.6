Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71721C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387262147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zzeoxHot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387262147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeJKXIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:35 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89BB20652;
        Thu, 11 Oct 2018 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272452;
        bh=GGslipa6pwvP0jui1aMfPdD+sBkfeyTrt+Z5GLiQcyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzeoxHotVoYGpw6bMIjefs1G2webhuQLKcHoEFscJQKWpAkqd7DOKmFIDxrDKiyId
         0Pkt1MLUoCNQxsRG/FqQhPK67qYkqwP8ay4BH/t5aaM5dQ+49WBD8IrIhCz5TILx8w
         vE0n+oKl+/YZtzDBrMpnLWx1Nf3gInF/P/K3YFZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 115/120] ext4: add more inode number paranoia checks
Date:   Thu, 11 Oct 2018 17:34:56 +0200
Message-Id: <20181011152554.547506359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h  |    5 -----
 fs/ext4/inode.c |    3 ++-
 fs/ext4/super.c |    5 +++++
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1386,11 +1386,6 @@ static inline struct timespec ext4_curre
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
@@ -3737,7 +3737,8 @@ static int __ext4_get_inode_loc(struct i
 	int			inodes_per_block, inode_offset;
 
 	iloc->bh = NULL;
-	if (!ext4_valid_inum(sb, inode->i_ino))
+	if (inode->i_ino < EXT4_ROOT_INO ||
+	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
 		return -EIO;
 
 	iloc->block_group = (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3794,6 +3794,11 @@ static int ext4_fill_super(struct super_
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


