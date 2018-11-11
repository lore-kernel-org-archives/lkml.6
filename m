Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38963C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0145F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbeKLF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbeKLF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000oJ-RG; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Pa-N3; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Amir Goldstein" <amir73il@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.8078898@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 044/366] ext4: factor out helper ext4_sample_last_mounted()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 833a950882d33a7dfc319d5e152fdf35028936eb upstream.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
[bwh: Backported to 3.16:
 - Move up declaration of ret in ext4_file_open()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/file.c | 82 ++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -208,52 +208,64 @@ static int ext4_file_mmap(struct file *f
 	return 0;
 }
 
-static int ext4_file_open(struct inode * inode, struct file * filp)
+static int ext4_sample_last_mounted(struct super_block *sb,
+				    struct vfsmount *mnt)
 {
-	struct super_block *sb = inode->i_sb;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	struct vfsmount *mnt = filp->f_path.mnt;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct path path;
 	char buf[64], *cp;
+	handle_t *handle;
+	int err;
+
+	if (likely(sbi->s_mount_flags & EXT4_MF_MNTDIR_SAMPLED))
+		return 0;
+
+	if (sb->s_flags & MS_RDONLY)
+		return 0;
+
+	sbi->s_mount_flags |= EXT4_MF_MNTDIR_SAMPLED;
+	/*
+	 * Sample where the filesystem has been mounted and
+	 * store it in the superblock for sysadmin convenience
+	 * when trying to sort through large numbers of block
+	 * devices or filesystem images.
+	 */
+	memset(buf, 0, sizeof(buf));
+	path.mnt = mnt;
+	path.dentry = mnt->mnt_root;
+	cp = d_path(&path, buf, sizeof(buf));
+	if (IS_ERR(cp))
+		return 0;
+
+	handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, 1);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	if (err)
+		goto out;
+	strlcpy(sbi->s_es->s_last_mounted, cp,
+		sizeof(sbi->s_es->s_last_mounted));
+	ext4_handle_dirty_super(handle, sb);
+out:
+	ext4_journal_stop(handle);
+	return err;
+}
+
+static int ext4_file_open(struct inode * inode, struct file * filp)
+{
+	int ret;
+
+	ret = ext4_sample_last_mounted(inode->i_sb, filp->f_path.mnt);
+	if (ret)
+		return ret;
 
-	if (unlikely(!(sbi->s_mount_flags & EXT4_MF_MNTDIR_SAMPLED) &&
-		     !(sb->s_flags & MS_RDONLY))) {
-		sbi->s_mount_flags |= EXT4_MF_MNTDIR_SAMPLED;
-		/*
-		 * Sample where the filesystem has been mounted and
-		 * store it in the superblock for sysadmin convenience
-		 * when trying to sort through large numbers of block
-		 * devices or filesystem images.
-		 */
-		memset(buf, 0, sizeof(buf));
-		path.mnt = mnt;
-		path.dentry = mnt->mnt_root;
-		cp = d_path(&path, buf, sizeof(buf));
-		if (!IS_ERR(cp)) {
-			handle_t *handle;
-			int err;
-
-			handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, 1);
-			if (IS_ERR(handle))
-				return PTR_ERR(handle);
-			BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-			err = ext4_journal_get_write_access(handle, sbi->s_sbh);
-			if (err) {
-				ext4_journal_stop(handle);
-				return err;
-			}
-			strlcpy(sbi->s_es->s_last_mounted, cp,
-				sizeof(sbi->s_es->s_last_mounted));
-			ext4_handle_dirty_super(handle, sb);
-			ext4_journal_stop(handle);
-		}
-	}
 	/*
 	 * Set up the jbd2_inode if we are opening the inode for
 	 * writing and the journal is present
 	 */
 	if (filp->f_mode & FMODE_WRITE) {
-		int ret = ext4_inode_attach_jinode(inode);
+		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
 			return ret;
 	}

