Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbeBGQVl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:21:41 -0500
Received: from smtpbg64.qq.com ([103.7.28.238]:24344 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754138AbeBGQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:21:39 -0500
X-QQ-mid: esmtp12t1518020068tmxs0sz9h
X-QQ-SSF: A1000000000000F00H100700000000P
X-QQ-FEAT: p/Y2uUKTrszf1zoLIDBKKwowp20617zRB5Qv9lJcmrXxlGh8R4jmE6AtRjRyq
        SgJXzsqXltqg7SyeC1zs4G/+jKMvBB2dLGBiNt1ipJTpzzmGw55ZKwVNE3I/5UGnmzY+riD
        DLo2ie9xChOgbYimD3dHimb1Yp28XrmynmHpv9n3wLSRvcAD2TvB/eOtT/4RdcT/jELhFRd
        Um+KAjaMKaiv6gnM18U+IeIFZWmENEYFjmViWl1eWDTiF+U6BYAl9N8MrxK1u88GohS7iU4
        oK1BC0351a3ru2kFtky41TbXA=
X-QQ-GoodBg: 0
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com, Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v9 3/3] fs: fat: add ioctl method in fat filesystem driver
Date: Thu,  8 Feb 2018 00:14:07 +0800
Message-Id: <20180207161407.30507-4-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
References: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 fs/fat/file.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4724cc9ad650..e87c5ae9208e 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -15,11 +15,46 @@
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
+#include <linux/ctype.h>
 #include "fat.h"

 static long fat_fallocate(struct file *file, int mode,
			  loff_t offset, loff_t len);

+static int fat_generate_volume_name(char *label, unsigned long len)
+{
+	unsigned int i;
+
+	/* For reasons, refer to namei_msdos.c:msdos_format_name() */
+	if (label[0] == 0xE5)
+		label[0] = 0x05;
+
+	for (i = 0; i < len; ++i) {
+		char c = label[i];
+		/* valid character contains d-characters and all extended ASCII
+		 * characters.
+		 * remaining empty spaces are padded by 0x20.
+		 */
+		if (c <= 0x7f)
+			switch (label[i]) {
+			case 'a' ... 'z':
+				label[i] = __toupper(label[i]);
+			case 'A' ... 'Z':
+			case '0' ... '9':
+			case '_':
+			case 0x20:
+				continue;
+			case 0:
+				label[i] = 0x20;
+				continue;
+			default:
+				return -EINVAL;
+			}
+	}
+
+	return 0;
+}
+
 static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
 {
	u32 attr;
@@ -121,10 +156,116 @@ static int fat_ioctl_get_volume_id(struct inode *inode, u32 __user *user_attr)
	return put_user(sbi->vol_id, user_attr);
 }

+
+static int fat_ioctl_get_volume_label(struct inode *inode, u8 __user *label)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	int err;
+
+	inode = d_inode(sb->s_root);
+	inode_lock_shared(inode);
+
+	err = fat_get_volume_label_entry(inode, &bh, &de);
+	if (err)
+		goto out;
+
+	if (copy_to_user(label, de->name, MSDOS_NAME))
+		err = -EFAULT;
+
+	brelse(bh);
+out:
+	inode_unlock_shared(inode);
+
+	return err;
+}
+
+static int fat_ioctl_set_volume_label(struct file *file, u8 __user *label)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct timespec ts;
+	struct buffer_head *boot_bh;
+	struct buffer_head *vol_bh;
+	struct msdos_dir_entry *de;
+	struct fat_boot_sector *b;
+	u8 buf[MSDOS_NAME];
+	int err;
+
+	inode = d_inode(sb->s_root);
+
+	if (copy_from_user(buf, label, sizeof(buf))) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	err = fat_generate_volume_name(buf, sizeof(buf));
+	if (err)
+		goto out;
+
+	down_write(&sb->s_umount);
+	err = mnt_want_write_file(file);
+	if (err)
+		goto out;
+
+	inode_lock(inode);
+
+	/* Updates root directory's label */
+	err = fat_get_volume_label_entry(inode, &vol_bh, &de);
+	ts = current_time(inode);
+	if (err) {
+		/* Create volume label entry */
+		err = fat_add_volume_label_entry(inode, buf, &ts);
+		if (err)
+			goto out_vol_brelse;
+	} else {
+		/* Write to root directory */
+		memcpy(de->name, buf, sizeof(de->name));
+		inode->i_ctime = inode->i_mtime = inode->i_atime = ts;
+
+		mark_buffer_dirty(vol_bh);
+	}
+
+	/* Update sector's label */
+	boot_bh = sb_bread(sb, 0);
+	if (boot_bh == NULL) {
+		fat_msg(sb, KERN_ERR,
+			"unable to read boot sector to write volume label");
+		err = -EIO;
+		goto out_boot_brelse;
+	}
+
+	b = (struct fat_boot_sector *)boot_bh->b_data;
+	if (MSDOS_SB(sb)->fat_bits == 32)
+		memcpy(b->fat32.vol_label, buf, sizeof(buf));
+	else
+		memcpy(b->fat16.vol_label, buf, sizeof(buf));
+
+	mark_buffer_dirty(boot_bh);
+
+	/* Synchronize the data together */
+	err = sync_dirty_buffer(boot_bh);
+	if (err)
+		goto out_boot_brelse;
+
+out_boot_brelse:
+	brelse(boot_bh);
+out_vol_brelse:
+	brelse(vol_bh);
+
+	inode_unlock(inode);
+	mnt_drop_write_file(file);
+	up_write(&sb->s_umount);
+out:
+	return err;
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
	struct inode *inode = file_inode(filp);
	u32 __user *user_attr = (u32 __user *)arg;
+	u8 __user *user_vol_label = (u8 __user *)arg;

	switch (cmd) {
	case FAT_IOCTL_GET_ATTRIBUTES:
@@ -133,6 +274,10 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
		return fat_ioctl_set_attributes(filp, user_attr);
	case FAT_IOCTL_GET_VOLUME_ID:
		return fat_ioctl_get_volume_id(inode, user_attr);
+	case FAT_IOCTL_GET_VOLUME_LABEL:
+		return fat_ioctl_get_volume_label(inode, user_vol_label);
+	case FAT_IOCTL_SET_VOLUME_LABEL:
+		return fat_ioctl_set_volume_label(filp, user_vol_label);
	default:
		return -ENOTTY;	/* Inappropriate ioctl for device */
	}
--
2.14.3
