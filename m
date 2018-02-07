Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbeBGQOh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:14:37 -0500
Received: from smtpbg303.qq.com ([184.105.206.26]:55702 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754543AbeBGQOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:14:34 -0500
X-QQ-mid: esmtp12t1518020064tzdj8o17v
X-QQ-SSF: A1000000000000F00H100700000000P
X-QQ-FEAT: /2O7Dyku7/OR9GGXdPiTjC5lyVXN+Ep+5RBLlTKfD7tApXQWZDS4nOfmkir6R
        lQ/hhfaMMiK3TDnDYIow3GLo/u13JcJBjrQvm5YOTd7C/LAoVLnzwOo0w8VaOuSaWNMws9e
        MoXNKDWVMYDGQjPutEV4TYHS/U054KBqdDgXyfX6G+KFjPaDur9ml0V8bMRP+CNsDplINwH
        Omy7wpUYZnysJSHTzUr9Knw+91MkeY1G6Gw/cysWgBn5AEp8pBTpgGjcohuFV3feo/WsIn3
        4AapE6HeTva3yS/RH1MVUEfWV1/Bq3cRJFVQ==
X-QQ-GoodBg: 0
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com, Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v9 2/3] fs: fat: Add volume label entry method function
Date: Thu,  8 Feb 2018 00:14:06 +0800
Message-Id: <20180207161407.30507-3-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
References: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: 0763023B8F0B412B9F8088E0A9644A15
X-QQ-LocalIP: 10.208.130.95
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 fs/fat/dir.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 8e100c3bf72c..d5286402c829 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -881,6 +881,53 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
	return -ENOENT;
 }

+int fat_get_volume_label_entry(struct inode *dir, struct buffer_head **bh,
+			       struct msdos_dir_entry **de)
+{
+	loff_t pos = 0;
+
+	*bh = NULL;
+	*de = NULL;
+	while (fat_get_entry(dir, &pos, bh, de) >= 0) {
+		if (((*de)->attr & ATTR_VOLUME) && ((*de)->attr != ATTR_EXT) &&
+		    !IS_FREE((*de)->name))
+			return 0;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(fat_get_volume_label_entry);
+
+int fat_add_volume_label_entry(struct inode *dir, const unsigned char *name,
+			       struct timespec *ts)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct msdos_dir_entry de;
+	struct fat_slot_info sinfo;
+	__le16 time, date;
+	int err;
+
+	memcpy(de.name, name, MSDOS_NAME);
+	de.attr = ATTR_VOLUME;
+	de.lcase = 0;
+	fat_time_unix2fat(sbi, ts, &time, &date, NULL);
+	de.cdate = de.adate = 0;
+	de.ctime = 0;
+	de.ctime_cs = 0;
+	de.time = time;
+	de.date = date;
+	fat_set_start(&de, 0);
+	de.size = 0;
+
+	err = fat_add_entries(dir, &de, 1, &sinfo);
+	if (err)
+		return err;
+
+	brelse(sinfo.bh);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_add_volume_label_entry);
+
 /*
  * The ".." entry can not provide the "struct fat_slot_info" information
  * for inode, nor a usable i_pos. So, this function provides some information
--
2.14.3
