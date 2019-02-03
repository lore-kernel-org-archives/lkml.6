Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B14C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9A72073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfBCOcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:32:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55376 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729884AbfBCOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:22 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdA-0006IZ-IY; Sun, 03 Feb 2019 14:20:20 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rT-GC; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.566367983@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 054/305] ext4: fix EXT4_IOC_SWAP_BOOT
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Reported-by: syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com
[bwh: Backported to 3.16:
 - Drop IS_ENCRYPTED() check
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/ioctl.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -64,7 +64,6 @@ static void swap_inode_data(struct inode
 	ei1 = EXT4_I(inode1);
 	ei2 = EXT4_I(inode2);
 
-	memswap(&inode1->i_flags, &inode2->i_flags, sizeof(inode1->i_flags));
 	memswap(&inode1->i_version, &inode2->i_version,
 		  sizeof(inode1->i_version));
 	memswap(&inode1->i_blocks, &inode2->i_blocks,
@@ -86,6 +85,21 @@ static void swap_inode_data(struct inode
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
@@ -104,10 +118,13 @@ static long swap_inode_boot_loader(struc
 	struct ext4_inode_info *ei_bl;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode))
+	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode) ||
+	    IS_SWAPFILE(inode) ||
+	    ext4_has_inline_data(inode))
 		return -EINVAL;
 
-	if (!inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
+	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
+	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO);
@@ -122,15 +139,15 @@ static long swap_inode_boot_loader(struc
 	 * that only 1 swap_inode_boot_loader is running. */
 	lock_two_nondirectories(inode, inode_bl);
 
-	truncate_inode_pages(&inode->i_data, 0);
-	truncate_inode_pages(&inode_bl->i_data, 0);
-
 	/* Wait for all existing dio workers */
 	ext4_inode_block_unlocked_dio(inode);
 	ext4_inode_block_unlocked_dio(inode_bl);
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);
 
+	truncate_inode_pages(&inode->i_data, 0);
+	truncate_inode_pages(&inode_bl->i_data, 0);
+
 	handle = ext4_journal_start(inode_bl, EXT4_HT_MOVE_EXTENTS, 2);
 	if (IS_ERR(handle)) {
 		err = -EINVAL;
@@ -166,6 +183,8 @@ static long swap_inode_boot_loader(struc
 	inode->i_generation = sbi->s_next_generation++;
 	inode_bl->i_generation = sbi->s_next_generation++;
 	spin_unlock(&sbi->s_next_gen_lock);
+	reset_inode_seed(inode);
+	reset_inode_seed(inode_bl);
 
 	ext4_discard_preallocations(inode);
 
@@ -176,6 +195,7 @@ static long swap_inode_boot_loader(struc
 			inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
+		ext4_mark_inode_dirty(handle, inode);
 	} else {
 		err = ext4_mark_inode_dirty(handle, inode_bl);
 		if (err < 0) {
@@ -185,6 +205,7 @@ static long swap_inode_boot_loader(struc
 			/* Revert all changes: */
 			swap_inode_data(inode, inode_bl);
 			ext4_mark_inode_dirty(handle, inode);
+			ext4_mark_inode_dirty(handle, inode_bl);
 		}
 	}
 	ext4_journal_stop(handle);

