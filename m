Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC3C21848
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="EDjPzL/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeLWOgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 09:36:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 09:36:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9610104wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMPCyexFArIlmzV3SBFrwhtxdqPJ5BqcjwAO0VGGBnU=;
        b=EDjPzL/3d6eML0ZO3C/Lct/D9ctykIjIn39lD4xDyPHMwgK/XApmIcIVYKYQP7Ednc
         f6/XsN6hbAGAHVuM//PNTNYqtsSjRXd/S/TXAMX8YaFjh8830cIi3ZyeT75npx2c6BZP
         ml8O7n68siBijml2NU2TRkho35VMIh+SMy626dDYGjWD7L4oaERWZDKz8LaehWbcqg2/
         qcd5NhG8M/XE1NUr3cZK/V6LrqYdVH/HH9ucF1cBXDZAysAi1N69PEjqgChTCRGtlt5n
         TclN9eUucKeSxcM+sgYT4ZTHKi/Wq+tNp6FVIT2/r/Oxz3NQKZjB5SaLsxhQWegGoy1+
         i0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMPCyexFArIlmzV3SBFrwhtxdqPJ5BqcjwAO0VGGBnU=;
        b=nFiC5qreA1aclIG+hMZ3bowPv0T6402aHYpGGMoOwSh0miIxr56Qrt8mG17E6LJN2Y
         URUj/F8wW8SyHGwY3IyRMW5doGidRUn7WSwAOOvvelSMB2IDWe+aPPowVvvvPspw8zvV
         ESyvPvd/ae3bROfbzeK9bo33bbwF3dX2FsZuF9aOxpihMGtn3pOYXRJz9wRta3A/gFI+
         0On8TKsYqp5sh6rsAjJULH6fwublsa0bUDsW9IlBC7q7/g2vkmUHw65JOGIYULnM7fCK
         uETIl866owo1fhcgPJNfeTE2rxsQh4PhrgJga9IKSOsREytFqsPe/sEjn75i/rXflECA
         p2PQ==
X-Gm-Message-State: AJcUukcfWPU3ANL4FnuEY7cSysLZe3Q8nFPBgSzbTumk2zMDha37l+fA
        csmzzlMz7QAVI0s0L0y1kaTcSQ==
X-Google-Smtp-Source: ALg8bN4q+1E9yzPUdSGnLGXvGB+PBfxH7DBEJlLVpU7BiFDMx7+uGshfzlbrUxx67x4LGM0ksQQE9Q==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr9132112wre.278.1545575764360;
        Sun, 23 Dec 2018 06:36:04 -0800 (PST)
Received: from localhost.localdomain (p5B12DA88.dip0.t-ipconnect.de. [91.18.218.136])
        by smtp.gmail.com with ESMTPSA id k23sm11646782wmj.32.2018.12.23.06.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 06:36:03 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH v1 1/2] binderfs: implement "max" mount option
Date:   Sun, 23 Dec 2018 15:35:49 +0100
Message-Id: <20181223143550.10672-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since binderfs can be mounted by userns root in non-initial user namespaces
some precautions are in order. First, a way to set a maximum on the number
of binder devices that can be allocated per binderfs instance and second, a
way to reserve a reasonable chunk of binderfs devices for the initial ipc
namespace.
A first approach as seen in [1] used sysctls similiar to devpts but was
shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
is an alternative approach which avoids sysctls completely and instead
switches to a single mount option.

Starting with this commit binderfs instances can be mounted with a limit on
the number of binder devices that can be allocated. The max=<count> mount
option serves as a per-instance limit. If max=<count> is set then only
<count> number of binder devices can be allocated in this binderfs
instance.

This allows to safely bind-mount binderfs instances into unprivileged user
namespaces since userns root in a non-initial user namespace cannot change
the mount option as long as it does not own the mount namespace the
binderfs mount was created in and hence cannot drain the host of minor
device numbers

[1]: https://lore.kernel.org/lkml/20181221133909.18794-1-christian@brauner.io/
[2]; https://lore.kernel.org/lkml/20181221163316.GA8517@kroah.com/
[3]: https://lore.kernel.org/lkml/CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com/
[4]: https://lore.kernel.org/lkml/20181221192044.5yvfnuri7gdop4rs@brauner.io/

Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v1:
- split reserving devices for the binderfs instance in the initial ipc
  namespace into a separate patch (cf. [1])
- s/</<=/g for capping at max=<count>
- use simple int instead of atomic_t for counting devices since we're
  incrementing and decrementing under a mutex anyway (cf. [1])
- correctly use match_int() (cf. [2])
v0:
- patch introduced

[1]: https://lore.kernel.org/lkml/20181223112944.GC27818@kroah.com/
[2]: https://lore.kernel.org/lkml/20181223135755.sqnv5ave62jtj4se@brauner.io/
---
 drivers/android/binderfs.c | 101 +++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7496b10532aa..873adda064ac 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -20,6 +20,7 @@
 #include <linux/parser.h>
 #include <linux/radix-tree.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock_types.h>
 #include <linux/stddef.h>
@@ -46,6 +47,24 @@ static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
 
+/**
+ * binderfs_mount_opts - mount options for binderfs
+ * @max: maximum number of allocatable binderfs binder devices
+ */
+struct binderfs_mount_opts {
+	int max;
+};
+
+enum {
+	Opt_max,
+	Opt_err
+};
+
+static const match_table_t tokens = {
+	{ Opt_max, "max=%d" },
+	{ Opt_err, NULL     }
+};
+
 /**
  * binderfs_info - information about a binderfs mount
  * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
@@ -55,13 +74,16 @@ static DEFINE_IDA(binderfs_minors);
  *                  created.
  * @root_gid:       gid that needs to be used when a new binder device is
  *                  created.
+ * @mount_opts:     The mount options in use.
+ * @device_count:   The current number of allocated binder devices.
  */
 struct binderfs_info {
 	struct ipc_namespace *ipc_ns;
 	struct dentry *control_dentry;
 	kuid_t root_uid;
 	kgid_t root_gid;
-
+	struct binderfs_mount_opts mount_opts;
+	int device_count;
 };
 
 static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
@@ -110,10 +132,16 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
+	if (++info->device_count <= info->mount_opts.max)
+		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
+				      GFP_KERNEL);
+	else
+		minor = -ENOSPC;
 	mutex_unlock(&binderfs_minors_mutex);
-	if (minor < 0)
+	if (minor < 0) {
+		--info->device_count;
 		return minor;
+	}
 
 	ret = -ENOMEM;
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
@@ -187,6 +215,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	kfree(name);
 	kfree(device);
 	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
 	ida_free(&binderfs_minors, minor);
 	mutex_unlock(&binderfs_minors_mutex);
 	iput(inode);
@@ -232,6 +261,7 @@ static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
 static void binderfs_evict_inode(struct inode *inode)
 {
 	struct binder_device *device = inode->i_private;
+	struct binderfs_info *info = BINDERFS_I(inode);
 
 	clear_inode(inode);
 
@@ -239,6 +269,7 @@ static void binderfs_evict_inode(struct inode *inode)
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
 	ida_free(&binderfs_minors, device->miscdev.minor);
 	mutex_unlock(&binderfs_minors_mutex);
 
@@ -246,9 +277,65 @@ static void binderfs_evict_inode(struct inode *inode)
 	kfree(device);
 }
 
+/**
+ * binderfs_parse_mount_opts - parse binderfs mount options
+ * @data: options to set (can be NULL in which case defaults are used)
+ */
+static int binderfs_parse_mount_opts(char *data,
+				     struct binderfs_mount_opts *opts)
+{
+	char *p;
+	opts->max = BINDERFS_MAX_MINOR;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		int max_devices;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_max:
+			if (match_int(&args[0], &max_devices) ||
+			    (max_devices < 0 ||
+			     (max_devices > BINDERFS_MAX_MINOR)))
+				return -EINVAL;
+
+			opts->max = max_devices;
+			break;
+		default:
+			pr_err("Invalid mount options\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int binderfs_remount(struct super_block *sb, int *flags, char *data)
+{
+	struct binderfs_info *info = sb->s_fs_info;
+	return binderfs_parse_mount_opts(data, &info->mount_opts);
+}
+
+static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
+{
+	struct binderfs_info *info;
+
+	info = root->d_sb->s_fs_info;
+	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
+		seq_printf(seq, ",max=%d", info->mount_opts.max);
+
+	return 0;
+}
+
 static const struct super_operations binderfs_super_ops = {
-	.statfs = simple_statfs,
-	.evict_inode = binderfs_evict_inode,
+	.evict_inode    = binderfs_evict_inode,
+	.remount_fs	= binderfs_remount,
+	.show_options	= binderfs_show_mount_opts,
+	.statfs         = simple_statfs,
 };
 
 static int binderfs_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -409,6 +496,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!info)
 		goto err_without_dentry;
 
+	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
+	if (ret)
+		goto err_without_dentry;
+
 	info->ipc_ns = ipc_ns;
 	info->root_gid = make_kgid(sb->s_user_ns, 0);
 	if (!gid_valid(info->root_gid))
-- 
2.19.1

