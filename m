Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeEHFtt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:49:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752214AbeEHFts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:49:48 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to avoid race during access gc_thread pointer
Date: Tue, 8 May 2018 13:49:26 +0800
Message-ID: <20180508054926.31491-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A			Thread B
- f2fs_remount
 - stop_gc_thread
				- f2fs_sbi_store
   sbi->gc_thread = NULL;
				  access sbi->gc_thread->gc_*

Previously, we allocate memory for sbi->gc_thread based on background
gc thread mount option, the memory can be released if we turn off
that mount option, but still there are several places access gc_thread
pointer without considering race condition, result in NULL point
dereference.

In order to fix this issue, use sb->s_umount to exclude those operations.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to cover __struct_ptr() with sb->s_umount suggested by Jaegeuk.
 fs/f2fs/sysfs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7432192ebe17..79f4e4ac8200 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -168,7 +168,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
 }
 
-static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
+static ssize_t __f2fs_sbi_store(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi,
 			const char *buf, size_t count)
 {
@@ -261,6 +261,22 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	return count;
 }
 
+static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
+			struct f2fs_sb_info *sbi,
+			const char *buf, size_t count)
+{
+	ssize_t ret;
+	bool gc_entry = (a->struct_type == GC_THREAD);
+
+	if (gc_entry)
+		down_read(&sbi->sb->s_umount);
+	ret = __f2fs_sbi_store(a, sbi, buf, count);
+	if (gc_entry)
+		up_read(&sbi->sb->s_umount);
+
+	return ret;
+}
+
 static ssize_t f2fs_attr_show(struct kobject *kobj,
 				struct attribute *attr, char *buf)
 {
-- 
2.17.0.391.g1f1cddd558b5
