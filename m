Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15ADC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B0D20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B0D20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbeGJSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389184AbeGJSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3A8FE3D;
        Tue, 10 Jul 2018 18:34:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.14 43/53] dax: change bdev_dax_supported() to support boolean returns
Date:   Tue, 10 Jul 2018 20:25:19 +0200
Message-Id: <20180710182501.227362691@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit 80660f20252d6f76c9f203874ad7c7a4a8508cf8 upstream.

The function return values are confusing with the way the function is
named. We expect a true or false return value but it actually returns
0/-errno.  This makes the code very confusing. Changing the return values
to return a bool where if DAX is supported then return true and no DAX
support returns false.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/dax/super.c |   14 +++++++-------
 fs/ext2/super.c     |    3 +--
 fs/ext4/super.c     |    3 +--
 fs/xfs/xfs_ioctl.c  |    4 ++--
 fs/xfs/xfs_super.c  |   12 ++++++------
 include/linux/dax.h |    8 ++++----
 6 files changed, 21 insertions(+), 23 deletions(-)

--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -79,9 +79,9 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
  * This is a library function for filesystems to check if the block device
  * can be mounted with dax option.
  *
- * Return: negative errno if unsupported, 0 if supported.
+ * Return: true if supported, false if unsupported
  */
-int __bdev_dax_supported(struct block_device *bdev, int blocksize)
+bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
 	pgoff_t pgoff;
@@ -94,21 +94,21 @@ int __bdev_dax_supported(struct block_de
 	if (blocksize != PAGE_SIZE) {
 		pr_debug("%s: error: unsupported blocksize for dax\n",
 				bdevname(bdev, buf));
-		return -EINVAL;
+		return false;
 	}
 
 	err = bdev_dax_pgoff(bdev, 0, PAGE_SIZE, &pgoff);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
-		return err;
+		return false;
 	}
 
 	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
 	if (!dax_dev) {
 		pr_debug("%s: error: device does not support dax\n",
 				bdevname(bdev, buf));
-		return -EOPNOTSUPP;
+		return false;
 	}
 
 	id = dax_read_lock();
@@ -120,10 +120,10 @@ int __bdev_dax_supported(struct block_de
 	if (len < 1) {
 		pr_debug("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len);
-		return len < 0 ? len : -EIO;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 EXPORT_SYMBOL_GPL(__bdev_dax_supported);
 #endif
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -953,8 +953,7 @@ static int ext2_fill_super(struct super_
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
-		err = bdev_dax_supported(sb->s_bdev, blocksize);
-		if (err)
+		if (!bdev_dax_supported(sb->s_bdev, blocksize))
 			goto failed_mount;
 	}
 
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3770,8 +3770,7 @@ static int ext4_fill_super(struct super_
 					" that may contain inline data");
 			goto failed_mount;
 		}
-		err = bdev_dax_supported(sb->s_bdev, blocksize);
-		if (err)
+		if (!bdev_dax_supported(sb->s_bdev, blocksize))
 			goto failed_mount;
 	}
 
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1101,8 +1101,8 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (fa->fsx_xflags & FS_XFLAG_DAX) {
 		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
 			return -EINVAL;
-		if (bdev_dax_supported(xfs_find_bdev_for_inode(VFS_I(ip)),
-				sb->s_blocksize) < 0)
+		if (!bdev_dax_supported(xfs_find_bdev_for_inode(VFS_I(ip)),
+				sb->s_blocksize))
 			return -EINVAL;
 	}
 
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1640,17 +1640,17 @@ xfs_fs_fill_super(
 		sb->s_flags |= SB_I_VERSION;
 
 	if (mp->m_flags & XFS_MOUNT_DAX) {
-		int	error2 = 0;
+		bool rtdev_is_dax = false, datadev_is_dax;
 
 		xfs_warn(mp,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 
-		error = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
-				sb->s_blocksize);
+		datadev_is_dax = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
+			sb->s_blocksize);
 		if (mp->m_rtdev_targp)
-			error2 = bdev_dax_supported(mp->m_rtdev_targp->bt_bdev,
-					sb->s_blocksize);
-		if (error && error2) {
+			rtdev_is_dax = bdev_dax_supported(
+				mp->m_rtdev_targp->bt_bdev, sb->s_blocksize);
+		if (!rtdev_is_dax && !datadev_is_dax) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
 			mp->m_flags &= ~XFS_MOUNT_DAX;
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -40,8 +40,8 @@ static inline void put_dax(struct dax_de
 
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
-int __bdev_dax_supported(struct block_device *bdev, int blocksize);
-static inline int bdev_dax_supported(struct block_device *bdev, int blocksize)
+bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
+static inline bool bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	return __bdev_dax_supported(bdev, blocksize);
 }
@@ -58,10 +58,10 @@ static inline void fs_put_dax(struct dax
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 #else
-static inline int bdev_dax_supported(struct block_device *bdev,
+static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
 {
-	return -EOPNOTSUPP;
+	return false;
 }
 
 static inline struct dax_device *fs_dax_get_by_host(const char *host)


