Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCJSnO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:43:14 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46197 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeCJSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:30 -0500
X-Google-Smtp-Source: AG47ELtW5kq5E8kWAoShZI9KIDZrbQJS2hZ1SubjjMPCYIXnMfghYatQ+mtO5glfniRibrK/OMF18Q==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 12/83] Add timing for mount and init.
Date: Sat, 10 Mar 2018 10:17:53 -0800
Message-Id: <1520705944-6723-13-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/super.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/nova/super.c b/fs/nova/super.c
index 9295d23..3efb560 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -347,6 +347,9 @@ static struct nova_inode *nova_init(struct super_block *sb,
 	struct nova_inode *root_i, *pi;
 	struct nova_super_block *super;
 	struct nova_sb_info *sbi = NOVA_SB(sb);
+	timing_t init_time;
+
+	NOVA_START_TIMING(new_init_t, init_time);
 
 	nova_info("creating an empty nova of size %lu\n", size);
 	sbi->num_blocks = ((unsigned long)(size) >> PAGE_SHIFT);
@@ -357,6 +360,7 @@ static struct nova_inode *nova_init(struct super_block *sb,
 
 	if (!nova_check_size(sb, size)) {
 		nova_warn("Specified NOVA size too small 0x%lx.\n", size);
+		NOVA_END_TIMING(new_init_t, init_time);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -399,6 +403,7 @@ static struct nova_inode *nova_init(struct super_block *sb,
 	PERSISTENT_MARK();
 	PERSISTENT_BARRIER();
 	nova_info("NOVA initialization finish\n");
+	NOVA_END_TIMING(new_init_t, init_time);
 	return root_i;
 }
 
@@ -473,15 +478,22 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 	unsigned long blocksize;
 	u32 random = 0;
 	int retval = -EINVAL;
+	timing_t mount_time;
+
+	NOVA_START_TIMING(mount_t, mount_time);
 
 	BUILD_BUG_ON(sizeof(struct nova_super_block) > NOVA_SB_SIZE);
 
 	sbi = kzalloc(sizeof(struct nova_sb_info), GFP_KERNEL);
-	if (!sbi)
+	if (!sbi) {
+		NOVA_END_TIMING(mount_t, mount_time);
 		return -ENOMEM;
+	}
+
 	sbi->nova_sb = kzalloc(sizeof(struct nova_super_block), GFP_KERNEL);
 	if (!sbi->nova_sb) {
 		kfree(sbi);
+		NOVA_END_TIMING(mount_t, mount_time);
 		return -ENOMEM;
 	}
 
@@ -591,6 +603,7 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 		nova_update_mount_time(sb);
 
 	retval = 0;
+	NOVA_END_TIMING(mount_t, mount_time);
 	return retval;
 
 out:
@@ -600,6 +613,7 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 	kfree(sbi->nova_sb);
 	kfree(sbi);
 	nova_dbg("%s failed: return %d\n", __func__, retval);
+	NOVA_END_TIMING(mount_t, mount_time);
 	return retval;
 }
 
@@ -701,6 +715,9 @@ static struct file_system_type nova_fs_type = {
 static int __init init_nova_fs(void)
 {
 	int rc = 0;
+	timing_t init_time;
+
+	NOVA_START_TIMING(init_t, init_time);
 
 	nova_dbg("%s: %d cpus online\n", __func__, num_online_cpus());
 	if (arch_has_clwb())
@@ -711,17 +728,19 @@ static int __init init_nova_fs(void)
 
 	rc = init_inodecache();
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = register_filesystem(&nova_fs_type);
 	if (rc)
 		goto out1;
 
+out:
+	NOVA_END_TIMING(init_t, init_time);
 	return rc;
 
 out1:
 	destroy_inodecache();
-	return rc;
+	goto out;
 }
 
 static void __exit exit_nova_fs(void)
-- 
2.7.4
