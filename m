Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8AAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1E218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JNm5bluO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfABLc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:32:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40539 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:32:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so25879387edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRM+HCzdoA/no8KVicekhOw/lDWf1KgmSHeBIpaEkmQ=;
        b=JNm5bluOKux7yvGbilhwZOLTAmXdz8yaYH/fzUXQFi8aLjNbFSzNH69THV0XAhOmxJ
         xIFDXs0uafNZCpdrzP1ZIN+0UM95aexouuQaHFrNYJRc1eMD6aMmGhvsU6HBwxVIVpJW
         +36jgyBHEwnG54rag0gi+H9Syosla/vLe05ydn6HQc7+S7/fRjJ7fyZ0LHZpBrej1e4u
         NRPEzLt4Codt/UlQuj+PR/GMu2X5n0BrZw9k+vQFiGjN3JK3uyFeN4TYVzDEqYF9VH5Q
         9UpffTvsl3MNcERWQfPzQxQO8RmeIOhc+7oj90xPWkEiv9iyZy+hmtxNAyGghQqNGpo0
         9JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRM+HCzdoA/no8KVicekhOw/lDWf1KgmSHeBIpaEkmQ=;
        b=Bg8RhicEJS+f7XxYhVmd+CBx9r/UODS58gi3NA1XdBqlqnHgw5WV7BtDPBmtUA8rKi
         oXzscN+Km50OUhQ9zhjAEE9W89DY0F5USfOQJG7sT8qaXVoczG5XZO39flJvq8onaaby
         OK/p1atmLNL32bBobPcO+alnGSamKj6J2I8ArUWa2jgUBIRkexi3liwXBMK1mmLOMdf1
         TsT0mKt11uLD3Ky9hKj8+TQaEOgrDXRTH3XMAbTTE141PSTcAHOht9+s8PJnpSPeYQLg
         V0z5coSYZV+r7jiqf5EAKcZTvmWDcZSsOvWryHg0NTg2jf/UeP+Fpx6nVpHe1nzWvBja
         2NOQ==
X-Gm-Message-State: AA+aEWY0orPEyk/wTztpsL6GnUaAdjwK4ukAAfN+ZR+GZnPg2NfkytPK
        TYule+pUG+M7PISyRFuyTAUnmA==
X-Google-Smtp-Source: AFSGD/VdT2uo21Rbb/PGqBWgjb7iUXNEE3w7XRZGO9BuMaOpYLeD4Gje7vksftpWz3riQGRbCDguXQ==
X-Received: by 2002:a50:903c:: with SMTP id b57mr39778443eda.161.1546428746678;
        Wed, 02 Jan 2019 03:32:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:700b:b2fa:de8a:175d])
        by smtp.gmail.com with ESMTPSA id a17-v6sm10690738ejr.55.2019.01.02.03.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 03:32:26 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, dan.carpenter@oracle.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 1/2] binderfs: implement "max" mount option
Date:   Wed,  2 Jan 2019 12:32:18 +0100
Message-Id: <20190102113219.3716-1-christian@brauner.io>
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
v2:
- grab mutex to decrement device_count in the one place where it was
  missing (cf. [changelog-3]).
v1:
- split reserving devices for the binderfs instance in the initial ipc
  namespace into a separate patch (cf. [changelog-1])
- s/</<=/g for capping at max=<count>
- use simple int instead of atomic_t for counting devices since we're
  incrementing and decrementing under a mutex anyway (cf. [1])
- correctly use match_int() (cf. [changelog-2])
v0:
- patch introduced

[changelog-1]: https://lore.kernel.org/lkml/20181223112944.GC27818@kroah.com/
[changelog-2]: https://lore.kernel.org/lkml/20181223135755.sqnv5ave62jtj4se@brauner.io/
[changelog-3]: https://lore.kernel.org/lkml/20190102091731.GB3781@kadam/
---
 drivers/android/binderfs.c | 104 ++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7496b10532aa..386e286f077f 100644
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
@@ -110,10 +132,17 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
-	mutex_unlock(&binderfs_minors_mutex);
-	if (minor < 0)
+	if (++info->device_count <= info->mount_opts.max)
+		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
+				      GFP_KERNEL);
+	else
+		minor = -ENOSPC;
+	if (minor < 0) {
+		--info->device_count;
+		mutex_unlock(&binderfs_minors_mutex);
 		return minor;
+	}
+	mutex_unlock(&binderfs_minors_mutex);
 
 	ret = -ENOMEM;
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
@@ -187,6 +216,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	kfree(name);
 	kfree(device);
 	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
 	ida_free(&binderfs_minors, minor);
 	mutex_unlock(&binderfs_minors_mutex);
 	iput(inode);
@@ -232,6 +262,7 @@ static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
 static void binderfs_evict_inode(struct inode *inode)
 {
 	struct binder_device *device = inode->i_private;
+	struct binderfs_info *info = BINDERFS_I(inode);
 
 	clear_inode(inode);
 
@@ -239,6 +270,7 @@ static void binderfs_evict_inode(struct inode *inode)
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
 	ida_free(&binderfs_minors, device->miscdev.minor);
 	mutex_unlock(&binderfs_minors_mutex);
 
@@ -246,9 +278,65 @@ static void binderfs_evict_inode(struct inode *inode)
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
@@ -409,6 +497,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
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

