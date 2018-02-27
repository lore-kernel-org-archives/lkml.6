Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeB0Llz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:41:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752097AbeB0Lly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:41:54 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support hot file extension
Date: Tue, 27 Feb 2018 19:41:25 +0800
Message-ID: <20180227114125.58964-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to recognize hot file extension in f2fs, so that we
can allocate proper hot segment location for its data, which can lead to
better hot/cold seperation in filesystem.

In addition, we changes a bit on query/add/del operation method for
extension_list sysfs entry as below:

- Query: cat /sys/fs/f2fs/<disk>/extension_list
- Add: echo 'extension' > /sys/fs/f2fs/<disk>/extension_list
- Del: echo '!extension' > /sys/fs/f2fs/<disk>/extension_list
- Add: echo '[h/c]extension' > /sys/fs/f2fs/<disk>/extension_list
- Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
- [h] means add/del hot file extension
- [c] means add/del cold file extension

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++-
 fs/f2fs/f2fs.h                          |  6 ++-
 fs/f2fs/namei.c                         | 79 ++++++++++++++++++++++++---------
 fs/f2fs/sysfs.c                         | 30 ++++++++++---
 include/linux/f2fs_fs.h                 |  3 +-
 5 files changed, 94 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 7fa84e349ad9..540553c933b6 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -199,5 +199,7 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:
 		 Used to control configure extension list:
 		 - Query: cat /sys/fs/f2fs/<disk>/extension_list
-		 - Add: echo 'extension' > /sys/fs/f2fs/<disk>/extension_list
-		 - Del: echo '!extension' > /sys/fs/f2fs/<disk>/extension_list
+		 - Add: echo '[h/c]extension' > /sys/fs/f2fs/<disk>/extension_list
+		 - Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
+		 - [h] means add/del hot file extension
+		 - [c] means add/del cold file extension
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2e9b257dda70..6c643b367f2e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -581,6 +581,7 @@ enum {
 #define FADVISE_ENCRYPT_BIT	0x04
 #define FADVISE_ENC_NAME_BIT	0x08
 #define FADVISE_KEEP_SIZE_BIT	0x10
+#define FADVISE_HOT_BIT		0x20
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
@@ -595,6 +596,9 @@ enum {
 #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
 #define file_keep_isize(inode)	is_file(inode, FADVISE_KEEP_SIZE_BIT)
 #define file_set_keep_isize(inode) set_file(inode, FADVISE_KEEP_SIZE_BIT)
+#define file_is_hot(inode)	is_file(inode, FADVISE_HOT_BIT)
+#define file_set_hot(inode)	set_file(inode, FADVISE_HOT_BIT)
+#define file_clear_hot(inode)	clear_file(inode, FADVISE_HOT_BIT)
 
 #define DEF_DIR_LEVEL		0
 
@@ -2638,7 +2642,7 @@ void handle_failed_inode(struct inode *inode);
  * namei.c
  */
 int update_extension_list(struct f2fs_sb_info *sbi, const char *name,
-								bool set);
+							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
 
 /*
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7b8f8b13bca9..639422d8af48 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -142,7 +142,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	return ERR_PTR(err);
 }
 
-static int is_multimedia_file(const unsigned char *s, const char *sub)
+static int is_extension_exist(const unsigned char *s, const char *sub)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
@@ -168,33 +168,59 @@ static int is_multimedia_file(const unsigned char *s, const char *sub)
 /*
  * Set multimedia files as cold files for hot/cold data separation
  */
-static inline void set_cold_files(struct f2fs_sb_info *sbi, struct inode *inode,
+static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 		const unsigned char *name)
 {
 	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
-	int i, count;
+	int i, cold_count, hot_count;
 
 	down_read(&sbi->sb_lock);
 
-	count = le32_to_cpu(sbi->raw_super->extension_count);
+	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+	hot_count = sbi->raw_super->hot_ext_count;
 
-	for (i = 0; i < count; i++) {
-		if (is_multimedia_file(name, extlist[i])) {
+	for (i = 0; i < cold_count + hot_count; i++) {
+		if (!is_extension_exist(name, extlist[i]))
+			continue;
+		if (i < cold_count)
 			file_set_cold(inode);
-			break;
-		}
+		else
+			file_set_hot(inode);
+		break;
 	}
 
 	up_read(&sbi->sb_lock);
 }
 
-int update_extension_list(struct f2fs_sb_info *sbi, const char *name, bool set)
+int update_extension_list(struct f2fs_sb_info *sbi, const char *name,
+							bool hot, bool set)
 {
 	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
-	int count = le32_to_cpu(sbi->raw_super->extension_count);
+	int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+	int hot_count = sbi->raw_super->hot_ext_count;
+	int total_count = cold_count + hot_count;
+	int start, count;
 	int i;
 
-	for (i = 0; i < count; i++) {
+	if (set) {
+		if (total_count == F2FS_MAX_EXTENSION)
+			return -EINVAL;
+	} else {
+		if (!hot && !cold_count)
+			return -EINVAL;
+		if (hot && !hot_count)
+			return -EINVAL;
+	}
+
+	if (hot) {
+		start = cold_count;
+		count = total_count;
+	} else {
+		start = 0;
+		count = cold_count;
+	}
+
+	for (i = start; i < count; i++) {
 		if (strcmp(name, extlist[i]))
 			continue;
 
@@ -202,20 +228,33 @@ int update_extension_list(struct f2fs_sb_info *sbi, const char *name, bool set)
 			return -EINVAL;
 
 		memcpy(extlist[i], extlist[i + 1],
-				F2FS_EXTENSION_LEN * (count - i - 1));
-		memset(extlist[count - 1], 0, F2FS_EXTENSION_LEN);
-		sbi->raw_super->extension_count = cpu_to_le32(count - 1);
+				F2FS_EXTENSION_LEN * (total_count - i - 1));
+		memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
+		if (hot)
+			sbi->raw_super->hot_ext_count = hot_count - 1;
+		else
+			sbi->raw_super->extension_count =
+						cpu_to_le32(cold_count - 1);
 		return 0;
 	}
 
 	if (!set)
 		return -EINVAL;
 
-	if (count == F2FS_MAX_EXTENSION)
-		return -EINVAL;
-
-	strncpy(extlist[count], name, strlen(name));
-	sbi->raw_super->extension_count = cpu_to_le32(count + 1);
+	if (hot) {
+		strncpy(extlist[count], name, strlen(name));
+		sbi->raw_super->hot_ext_count = hot_count + 1;
+	} else {
+		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
+
+		memcpy(buf, &extlist[cold_count],
+				F2FS_EXTENSION_LEN * hot_count);
+		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
+		strncpy(extlist[cold_count], name, strlen(name));
+		memcpy(&extlist[cold_count + 1], buf,
+				F2FS_EXTENSION_LEN * hot_count);
+		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
+	}
 	return 0;
 }
 
@@ -239,7 +278,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		return PTR_ERR(inode);
 
 	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
-		set_cold_files(sbi, inode, dentry->d_name.name);
+		set_file_temperature(sbi, inode, dentry->d_name.name);
 
 	inode->i_op = &f2fs_file_inode_operations;
 	inode->i_fop = &f2fs_file_operations;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b5ddeefca59a..e185155b655c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -145,10 +145,19 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "extension_list")) {
 		__u8 (*extlist)[F2FS_EXTENSION_LEN] =
 					sbi->raw_super->extension_list;
-		int count = le32_to_cpu(sbi->raw_super->extension_count);
+		int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+		int hot_count = sbi->raw_super->hot_ext_count;
 		int len = 0, i;
 
-		for (i = 0; i < count; i++)
+		len += snprintf(buf + len, PAGE_SIZE - len,
+						"cold file extenstion:\n");
+		for (i = 0; i < cold_count; i++)
+			len += snprintf(buf + len, PAGE_SIZE - len, "%s\n",
+								extlist[i]);
+
+		len += snprintf(buf + len, PAGE_SIZE - len,
+						"hot file extenstion:\n");
+		for (i = cold_count; i < cold_count + hot_count; i++)
 			len += snprintf(buf + len, PAGE_SIZE - len, "%s\n",
 								extlist[i]);
 		return len;
@@ -174,9 +183,18 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "extension_list")) {
 		const char *name = strim((char *)buf);
-		bool set = true;
+		bool set = true, hot;
+
+		if (!strncmp(name, "[h]", 3))
+			hot = true;
+		else if (!strncmp(name, "[c]", 3))
+			hot = false;
+		else
+			return -EINVAL;
+
+		name += 3;
 
-		if (name[0] == '!') {
+		if (*name == '!') {
 			name++;
 			set = false;
 		}
@@ -186,13 +204,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 
 		down_write(&sbi->sb_lock);
 
-		ret = update_extension_list(sbi, name, set);
+		ret = update_extension_list(sbi, name, hot, set);
 		if (ret)
 			goto out;
 
 		ret = f2fs_commit_super(sbi, false);
 		if (ret)
-			update_extension_list(sbi, name, !set);
+			update_extension_list(sbi, name, hot, !set);
 out:
 		up_write(&sbi->sb_lock);
 		return ret ? ret : count;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c52f6081891b..c6859efb597c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -113,7 +113,8 @@ struct f2fs_super_block {
 	struct f2fs_device devs[MAX_DEVICES];	/* device list */
 	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
 	__le16 extra_nsize;		/* extra node size */
-	__u8 reserved[313];		/* valid reserved region */
+	__u8 hot_ext_count;		/* # of hot file extension */
+	__u8 reserved[312];		/* valid reserved region */
 } __packed;
 
 /*
-- 
2.15.0.55.gc2ece9dc4de6
