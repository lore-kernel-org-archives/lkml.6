Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeCJSUh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:37 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46198 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeCJSUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:32 -0500
X-Google-Smtp-Source: AG47ELvy8q20JM2c6MBAJwGp0jKeQEZ6uuKt/Xr0oIjWavdeJX2Nm7UJUGSED6BHNdP8EUSFaOMiNQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 13/83] Add remount_fs and show_options methods.
Date: Sat, 10 Mar 2018 10:17:54 -0800
Message-Id: <1520705944-6723-14-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/super.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/nova/super.c b/fs/nova/super.c
index 3efb560..f41cc04 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -617,6 +617,59 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 	return retval;
 }
 
+static int nova_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct nova_sb_info *sbi = NOVA_SB(root->d_sb);
+
+	if (sbi->mode != (0777 | S_ISVTX))
+		seq_printf(seq, ",mode=%03o", sbi->mode);
+	if (uid_valid(sbi->uid))
+		seq_printf(seq, ",uid=%u", from_kuid(&init_user_ns, sbi->uid));
+	if (gid_valid(sbi->gid))
+		seq_printf(seq, ",gid=%u", from_kgid(&init_user_ns, sbi->gid));
+	if (test_opt(root->d_sb, ERRORS_RO))
+		seq_puts(seq, ",errors=remount-ro");
+	if (test_opt(root->d_sb, ERRORS_PANIC))
+		seq_puts(seq, ",errors=panic");
+	if (test_opt(root->d_sb, DAX))
+		seq_puts(seq, ",dax");
+
+	return 0;
+}
+
+static int nova_remount(struct super_block *sb, int *mntflags, char *data)
+{
+	unsigned long old_sb_flags;
+	unsigned long old_mount_opt;
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	int ret = -EINVAL;
+
+	/* Store the old options */
+	mutex_lock(&sbi->s_lock);
+	old_sb_flags = sb->s_flags;
+	old_mount_opt = sbi->s_mount_opt;
+
+	if (nova_parse_options(data, sbi, 1))
+		goto restore_opt;
+
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		      ((sbi->s_mount_opt & NOVA_MOUNT_POSIX_ACL) ?
+		       MS_POSIXACL : 0);
+
+	if ((*mntflags & MS_RDONLY) != (sb->s_flags & MS_RDONLY))
+		nova_update_mount_time(sb);
+
+	mutex_unlock(&sbi->s_lock);
+	ret = 0;
+	return ret;
+
+restore_opt:
+	sb->s_flags = old_sb_flags;
+	sbi->s_mount_opt = old_mount_opt;
+	mutex_unlock(&sbi->s_lock);
+	return ret;
+}
+
 static void nova_put_super(struct super_block *sb)
 {
 	struct nova_sb_info *sbi = NOVA_SB(sb);
@@ -697,6 +750,8 @@ static struct super_operations nova_sops = {
 	.alloc_inode	= nova_alloc_inode,
 	.destroy_inode	= nova_destroy_inode,
 	.put_super	= nova_put_super,
+	.remount_fs	= nova_remount,
+	.show_options	= nova_show_options,
 };
 
 static struct dentry *nova_mount(struct file_system_type *fs_type,
-- 
2.7.4
