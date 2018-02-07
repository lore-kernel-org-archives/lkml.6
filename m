Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeBGQOb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:14:31 -0500
Received: from smtpbg299.qq.com ([184.105.67.99]:43342 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754231AbeBGQO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:14:29 -0500
X-QQ-mid: esmtp12t1518020059t5ga0a41y
X-QQ-SSF: A1000000000000F00H100700000000P
X-QQ-FEAT: oIoGrveFQB8YDzSZzuIXcgIgppLtkDRxiEQpqo4e9cuxnvy0TmWT4TzswnCW+
        +gF4uKJmP8rv+HDIcWva9ecqqYv3TkzucQeoUb5JxercmIpFskgMX/u/C8a5bhhQ55Yyda3
        b2gmyoNtCHptOYK8M8PwC5o+LDLcy5cxlMY+HVXnRpuDeeGqjfAwjlkxWHy/4QrtUICoyoY
        brNak6EkFuw9oo6Q6dAZsNw4OlDBNEuR/FQFcyn54y0qdfCL96zUB+bx50+FDlNqIk9joa6
        I4bXoh6j/DKwDDUwFMCOaL12s=
X-QQ-GoodBg: 0
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com, Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v9 1/3] fs: fat: Add fat filesystem partition volume label in local structure
Date: Thu,  8 Feb 2018 00:14:05 +0800
Message-Id: <20180207161407.30507-2-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
References: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: 9A9689CB74C443B29225D4876FA74BB5
X-QQ-LocalIP: 10.198.131.167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 fs/fat/fat.h                  | 6 ++++++
 fs/fat/inode.c                | 6 ++++++
 include/uapi/linux/msdos_fs.h | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 8fc1093da47d..11cf31802489 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -300,6 +300,12 @@ extern int fat_dir_empty(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const unsigned char *name,
		    struct fat_slot_info *sinfo);
+extern int fat_get_volume_label_entry(struct inode *dir,
+				      struct buffer_head **bh,
+				      struct msdos_dir_entry **de);
+extern int fat_add_volume_label_entry(struct inode *dir,
+				      const unsigned char *name,
+				      struct timespec *ts);
 extern int fat_scan_logstart(struct inode *dir, int i_logstart,
			     struct fat_slot_info *sinfo);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..cae8215035af 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -46,12 +46,14 @@ struct fat_bios_param_block {

	u8	fat16_state;
	u32	fat16_vol_id;
+	u8      fat16_vol_label[11];

	u32	fat32_length;
	u32	fat32_root_cluster;
	u16	fat32_info_sector;
	u8	fat32_state;
	u32	fat32_vol_id;
+	u8      fat32_vol_label[11];
 };

 static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
@@ -1461,12 +1463,16 @@ static int fat_read_bpb(struct super_block *sb, struct fat_boot_sector *b,

	bpb->fat16_state = b->fat16.state;
	bpb->fat16_vol_id = get_unaligned_le32(b->fat16.vol_id);
+	memcpy(bpb->fat16_vol_label, b->fat16.vol_label,
+	       sizeof(bpb->fat16_vol_label));

	bpb->fat32_length = le32_to_cpu(b->fat32.length);
	bpb->fat32_root_cluster = le32_to_cpu(b->fat32.root_cluster);
	bpb->fat32_info_sector = le16_to_cpu(b->fat32.info_sector);
	bpb->fat32_state = b->fat32.state;
	bpb->fat32_vol_id = get_unaligned_le32(b->fat32.vol_id);
+	memcpy(bpb->fat32_vol_label, b->fat32.vol_label,
+	       sizeof(bpb->fat32_vol_label));

	/* Validate this looks like a FAT filesystem BPB */
	if (!bpb->fat_reserved) {
diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
index a45d0754102e..90d2d6f3d908 100644
--- a/include/uapi/linux/msdos_fs.h
+++ b/include/uapi/linux/msdos_fs.h
@@ -107,6 +107,8 @@ struct __fat_dirent {
 #define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
 /*Android kernel has used 0x12, so we use 0x13*/
 #define FAT_IOCTL_GET_VOLUME_ID		_IOR('r', 0x13, __u32)
+#define FAT_IOCTL_GET_VOLUME_LABEL	_IOR('r', 0x14, __u8[11])
+#define FAT_IOCTL_SET_VOLUME_LABEL	_IOW('r', 0x15, __u8[11])

 struct fat_boot_sector {
	__u8	ignored[3];	/* Boot strap short or near jump */
--
2.14.3
