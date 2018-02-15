Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163365AbeBOVdl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162678AbeBOVdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 04/11] fw_cfg: fix sparse warnings with fw_cfg_file
Date: Thu, 15 Feb 2018 22:33:05 +0100
Message-Id: <20180215213312.29234-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify fw_cfg_sysfs_entry to store entry values, instead of reusing
the restricted types.

Fixes warnings such as:

$ make C=1 CF=-D__CHECK_ENDIAN__ drivers/firmware/qemu_fw_cfg.o

drivers/firmware/qemu_fw_cfg.c:491:29: warning: incorrect type in assignment (different base types)
drivers/firmware/qemu_fw_cfg.c:491:29:    expected restricted __be32 [usertype] size
drivers/firmware/qemu_fw_cfg.c:491:29:    got unsigned int
drivers/firmware/qemu_fw_cfg.c:492:31: warning: incorrect type in assignment (different base types)
drivers/firmware/qemu_fw_cfg.c:492:31:    expected restricted __be16 [usertype] select
drivers/firmware/qemu_fw_cfg.c:492:31:    got int

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 6164731a3c35..6ee12c9e079a 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -193,7 +193,9 @@ static const struct {
 /* fw_cfg_sysfs_entry type */
 struct fw_cfg_sysfs_entry {
 	struct kobject kobj;
-	struct fw_cfg_file f;
+	u32 size;
+	u16 select;
+	char name[FW_CFG_MAX_FILE_PATH];
 	struct list_head list;
 };
 
@@ -257,17 +259,17 @@ struct fw_cfg_sysfs_attribute fw_cfg_sysfs_attr_##_attr = { \
 
 static ssize_t fw_cfg_sysfs_show_size(struct fw_cfg_sysfs_entry *e, char *buf)
 {
-	return sprintf(buf, "%u\n", e->f.size);
+	return sprintf(buf, "%u\n", e->size);
 }
 
 static ssize_t fw_cfg_sysfs_show_key(struct fw_cfg_sysfs_entry *e, char *buf)
 {
-	return sprintf(buf, "%u\n", e->f.select);
+	return sprintf(buf, "%u\n", e->select);
 }
 
 static ssize_t fw_cfg_sysfs_show_name(struct fw_cfg_sysfs_entry *e, char *buf)
 {
-	return sprintf(buf, "%s\n", e->f.name);
+	return sprintf(buf, "%s\n", e->name);
 }
 
 static FW_CFG_SYSFS_ATTR(size);
@@ -318,13 +320,13 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
 {
 	struct fw_cfg_sysfs_entry *entry = to_entry(kobj);
 
-	if (pos > entry->f.size)
+	if (pos > entry->size)
 		return -EINVAL;
 
-	if (count > entry->f.size - pos)
-		count = entry->f.size - pos;
+	if (count > entry->size - pos)
+		count = entry->size - pos;
 
-	fw_cfg_read_blob(entry->f.select, buf, pos, count);
+	fw_cfg_read_blob(entry->select, buf, pos, count);
 	return count;
 }
 
@@ -443,11 +445,13 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 		return -ENOMEM;
 
 	/* set file entry information */
-	memcpy(&entry->f, f, sizeof(struct fw_cfg_file));
+	entry->size = be32_to_cpu(f->size);
+	entry->select = be16_to_cpu(f->select);
+	memcpy(entry->name, f->name, FW_CFG_MAX_FILE_PATH);
 
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
-				   fw_cfg_sel_ko, "%d", entry->f.select);
+				   fw_cfg_sel_ko, "%d", entry->select);
 	if (err)
 		goto err_register;
 
@@ -457,7 +461,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 		goto err_add_raw;
 
 	/* try adding "/sys/firmware/qemu_fw_cfg/by_name/" symlink */
-	fw_cfg_build_symlink(fw_cfg_fname_kset, &entry->kobj, entry->f.name);
+	fw_cfg_build_symlink(fw_cfg_fname_kset, &entry->kobj, entry->name);
 
 	/* success, add entry to global cache */
 	fw_cfg_sysfs_cache_enlist(entry);
@@ -489,8 +493,6 @@ static int fw_cfg_register_dir_entries(void)
 	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
 
 	for (i = 0; i < count; i++) {
-		dir[i].size = be32_to_cpu(dir[i].size);
-		dir[i].select = be16_to_cpu(dir[i].select);
 		ret = fw_cfg_register_file(&dir[i]);
 		if (ret)
 			break;
-- 
2.16.1.73.g5832b7e9f2
