Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D779C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253A020839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrb2+SjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253A020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeKLISF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbeKLISE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60F1223D0;
        Sun, 11 Nov 2018 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975288;
        bh=vXVjGoar1jJGjJ5wVEmOd00Dqxu2arR3UStjlA9+UHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrb2+SjIiT9/KaFOWBFNOuA15Kj97Y0dhc4K7ohfMk23O4vqHb/zUTui0IY5Yv+Kf
         v4AEI08qkrZrdtNzXilU0mEbMCm7ur/VyPdTuvhH8ev0XOevzu/UkuO/ZEPd95gPl3
         82LZz7MuwijfroBKGHmKqLJ4cfpGr4RC5xBPtj+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org,
        syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com
Subject: [PATCH 4.19 226/361] ext4: fix EXT4_IOC_SWAP_BOOT
Date:   Sun, 11 Nov 2018 14:19:33 -0800
Message-Id: <20181111221651.118847765@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 18aded17492088962ef43f00825179598b3e8c58 upstream.

The code EXT4_IOC_SWAP_BOOT ioctl hasn't been updated in a while, and
it's a bit broken with respect to more modern ext4 kernels, especially
metadata checksums.

Other problems fixed with this commit:

* Don't allow installing a DAX, swap file, or an encrypted file as a
  boot loader.

* Respect the immutable and append-only flags.

* Wait until any DIO operations are finished *before* calling
  truncate_inode_pages().

* Don't swap inode->i_flags, since these flags have nothing to do with
  the inode blocks --- and it will give the IMA/audit code heartburn
  when the inode is evicted.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Reported-by: syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -67,7 +67,6 @@ static void swap_inode_data(struct inode
 	ei1 = EXT4_I(inode1);
 	ei2 = EXT4_I(inode2);
 
-	swap(inode1->i_flags, inode2->i_flags);
 	swap(inode1->i_version, inode2->i_version);
 	swap(inode1->i_blocks, inode2->i_blocks);
 	swap(inode1->i_bytes, inode2->i_bytes);
@@ -85,6 +84,21 @@ static void swap_inode_data(struct inode
 	i_size_write(inode2, isize);
 }
 
+static void reset_inode_seed(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	__le32 inum = cpu_to_le32(inode->i_ino);
+	__le32 gen = cpu_to_le32(inode->i_generation);
+	__u32 csum;
+
+	if (!ext4_has_metadata_csum(inode->i_sb))
+		return;
+
+	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&inum, sizeof(inum));
+	ei->i_csum_seed = ext4_chksum(sbi, csum, (__u8 *)&gen, sizeof(gen));
+}
+
 /**
  * Swap the information from the given @inode and the inode
  * EXT4_BOOT_LOADER_INO. It will basically swap i_data and all other
@@ -102,10 +116,13 @@ static long swap_inode_boot_loader(struc
 	struct inode *inode_bl;
 	struct ext4_inode_info *ei_bl;
 
-	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode))
+	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode) ||
+	    IS_SWAPFILE(inode) || IS_ENCRYPTED(inode) ||
+	    ext4_has_inline_data(inode))
 		return -EINVAL;
 
-	if (!inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
+	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
+	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO);
@@ -120,13 +137,13 @@ static long swap_inode_boot_loader(struc
 	 * that only 1 swap_inode_boot_loader is running. */
 	lock_two_nondirectories(inode, inode_bl);
 
-	truncate_inode_pages(&inode->i_data, 0);
-	truncate_inode_pages(&inode_bl->i_data, 0);
-
 	/* Wait for all existing dio workers */
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);
 
+	truncate_inode_pages(&inode->i_data, 0);
+	truncate_inode_pages(&inode_bl->i_data, 0);
+
 	handle = ext4_journal_start(inode_bl, EXT4_HT_MOVE_EXTENTS, 2);
 	if (IS_ERR(handle)) {
 		err = -EINVAL;
@@ -159,6 +176,8 @@ static long swap_inode_boot_loader(struc
 
 	inode->i_generation = prandom_u32();
 	inode_bl->i_generation = prandom_u32();
+	reset_inode_seed(inode);
+	reset_inode_seed(inode_bl);
 
 	ext4_discard_preallocations(inode);
 
@@ -169,6 +188,7 @@ static long swap_inode_boot_loader(struc
 			inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
+		ext4_mark_inode_dirty(handle, inode);
 	} else {
 		err = ext4_mark_inode_dirty(handle, inode_bl);
 		if (err < 0) {
@@ -178,6 +198,7 @@ static long swap_inode_boot_loader(struc
 			/* Revert all changes: */
 			swap_inode_data(inode, inode_bl);
 			ext4_mark_inode_dirty(handle, inode);
+			ext4_mark_inode_dirty(handle, inode_bl);
 		}
 	}
 	ext4_journal_stop(handle);


