Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeB1JEa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:04:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751819AbeB1JEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:04:14 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] mkfs.f2fs: support hot file extension
Date: Wed, 28 Feb 2018 17:03:43 +0800
Message-ID: <20180228090344.33741-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new option '-E' to accept user configured hot file
extension, in order to let kernel module handle hot/cold file's datas
separately better.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/f2fs_fs.h       |  2 +-
 mkfs/f2fs_format.c      | 83 +++++++++++++++++++++++++++++++++----------------
 mkfs/f2fs_format_main.c | 16 +++++++---
 3 files changed, 68 insertions(+), 33 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9968c917afcc..0e21d1ec53e5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -347,7 +347,7 @@ struct f2fs_configuration {
 	int32_t dump_fd;
 	struct device_info devices[MAX_DEVICES];
 	int ndevs;
-	char *extension_list;
+	char *extension_list[2];
 	const char *rootdev_name;
 	int dbg_lv;
 	int show_dentry;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 7a3617d4837b..3fc2f05437dd 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -68,6 +68,15 @@ const char *media_ext_lists[] = {
 	NULL
 };
 
+const char *hot_ext_lists[] = {
+	NULL
+};
+
+const char **default_ext_list[] = {
+	media_ext_lists,
+	hot_ext_lists
+};
+
 static bool is_extension_exist(const char *name)
 {
 	int i;
@@ -83,44 +92,64 @@ static bool is_extension_exist(const char *name)
 
 static void cure_extension_list(void)
 {
-	const char **extlist = media_ext_lists;
-	char *ext_str = c.extension_list;
+	const char **extlist;
+	char *ext_str;
 	char *ue;
 	int name_len;
-	int i = 0;
+	int i, pos = 0;
 
 	set_sb(extension_count, 0);
 	memset(sb->extension_list, 0, sizeof(sb->extension_list));
 
-	while (*extlist) {
-		name_len = strlen(*extlist);
-		memcpy(sb->extension_list[i++], *extlist, name_len);
-		extlist++;
-	}
-	set_sb(extension_count, i);
-
-	if (!ext_str)
-		return;
+	for (i = 0; i < 2; i++) {
+		ext_str = c.extension_list[i];
+		extlist = default_ext_list[i];
 
-	/* add user ext list */
-	ue = strtok(ext_str, ", ");
-	while (ue != NULL) {
-		name_len = strlen(ue);
-		if (name_len >= 8) {
-			MSG(0, "\tWarn: Extension name (%s) is too long\n", ue);
-			goto next;
+		while (*extlist) {
+			printf("default: i:%u, extlist:%s\n", i, *extlist);
+			name_len = strlen(*extlist);
+			memcpy(sb->extension_list[pos++], *extlist, name_len);
+			extlist++;
 		}
-		if (!is_extension_exist(ue))
-			memcpy(sb->extension_list[i++], ue, name_len);
+		if (i == 0)
+			set_sb(extension_count, pos);
+		else
+			sb->hot_ext_count = pos - get_sb(extension_count);;
+		if (i == 1)
+			printf("1hot count:%d\n", sb->hot_ext_count);
+		else
+			printf("1cold count:%d\n", get_sb(extension_count));
+		if (!ext_str)
+			continue;
+
+		/* add user ext list */
+		ue = strtok(ext_str, ", ");
+		while (ue != NULL) {
+			printf("private: i:%u, extlist:%s\n", i, ue);
+			name_len = strlen(ue);
+			if (name_len >= 8) {
+				MSG(0, "\tWarn: Extension name (%s) is too long\n", ue);
+				goto next;
+			}
+			if (!is_extension_exist(ue))
+				memcpy(sb->extension_list[pos++], ue, name_len);
 next:
-		ue = strtok(NULL, ", ");
-		if (i >= F2FS_MAX_EXTENSION)
-			break;
-	}
+			ue = strtok(NULL, ", ");
+			if (pos >= F2FS_MAX_EXTENSION)
+				break;
+		}
 
-	set_sb(extension_count, i);
+		if (i == 0)
+			set_sb(extension_count, pos);
+		else
+			sb->hot_ext_count = pos - get_sb(extension_count);
+		if (i == 1)
+			printf("2hot count:%d\n", sb->hot_ext_count);
+		else
+			printf("2cold count:%d\n", get_sb(extension_count));
 
-	free(c.extension_list);
+		free(c.extension_list[i]);
+	}
 }
 
 static void verify_cur_segs(void)
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 46a6335e833e..c051ba2f20b3 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -44,7 +44,8 @@ static void mkfs_usage()
 	MSG(0, "  -a heap-based allocation [default:0]\n");
 	MSG(0, "  -c [device path] up to 7 devices excepts meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
-	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
+	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
+	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
 	MSG(0, "  -f force overwrite the exist filesystem\n");
 	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -l label\n");
@@ -69,8 +70,10 @@ static void f2fs_show_info()
 		MSG(0, "Info: Disable heap-based policy\n");
 
 	MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
-	if (c.extension_list)
-		MSG(0, "Info: Add new extension list\n");
+	if (c.extension_list[0])
+		MSG(0, "Info: Add new cold file extension list\n");
+	if (c.extension_list[1])
+		MSG(0, "Info: Add new hot file extension list\n");
 
 	if (c.vol_label)
 		MSG(0, "Info: Label = %s\n", c.vol_label);
@@ -109,7 +112,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:il:mo:O:s:S:z:t:f";
+	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -137,7 +140,10 @@ static void f2fs_parse_options(int argc, char *argv[])
 			c.dbg_lv = atoi(optarg);
 			break;
 		case 'e':
-			c.extension_list = strdup(optarg);
+			c.extension_list[0] = strdup(optarg);
+			break;
+		case 'E':
+			c.extension_list[1] = strdup(optarg);
 			break;
 		case 'i':
 			MSG(0, "Warning: extend node bitmap feature needs 4.16+ kernel support\n");
-- 
2.15.0.55.gc2ece9dc4de6
