Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FA4218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DZrXM28k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbeLUNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:39:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33474 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLUNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:39:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so4719131eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+VY3zf/nmrL1czfGr0TGy1mwmyDR4wWasYxmsNKmlM=;
        b=DZrXM28kUPvEwXiOjY7C4XAnvNaIosMMU0yt23kdqYEjB4W3ObD9pGLmdbEMrXfvjm
         LUmdLIHrtq7uw2GO1j8pP5LBCj8IWizdUh88xFxPfnbUxZM0V8PBzIdqJxHY1iPsipM5
         Xbg+HDBq/kvBJjuymVverrfP8fGKRXR/Gtn90BKqZ3FZZZEvweEbw/dshfrsVsYn5VIH
         8FT2rGEWSI2hwicz3EITO4z/6JgKGcLCQrFDTJ/e7rfc6aK+vcDDgpw2E2MTNsggQ1IS
         EdAst5ibs8r692Uiu3qtFF9EEgnQy4r7wnO69YQWrjD4vky7bSGc0UA03Xo8Y891h2XV
         O+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+VY3zf/nmrL1czfGr0TGy1mwmyDR4wWasYxmsNKmlM=;
        b=AdoWW8EUlxOkGSNiAa0U+JnpOvqX+RJLtXYWxh6jTr5J+BwkVQQAWhVSfEXAXJqcL+
         G9Jmv12Hu+LzRvSp+htvJ1iyxrTGz5YK+yXFoomCkESOqbGlYEzq53BfeMfonGC+skyI
         ATK3lwpdCDgbOsdZVepDieqOrzCnZZTW0UkVl9NNQDeQdWl3LPRu3fl4LxPBaE79wmP9
         OpDn5edmIYt1Tk/xZE2AAUbNnY72bNZYsatwl7dRkxjp80hrbZjCbv0SLfzl6h0UIwXl
         VvgGu9fl5xI8B8ahNDqhXizdjMqzIzM/4cWa1AH9tNqPUQ4yGLQf9/DGyPy8aCPEyySq
         eQDw==
X-Gm-Message-State: AA+aEWaonoB6K5Id/VXTvGJ01mbu/0hljHHtNH/CtOP0FRtx1C5qzKJL
        OXeum0Rd7FoLUlt/d1gcq+dRJQ==
X-Google-Smtp-Source: AFSGD/VJ2xhM2ioiJCf3OBOzvbjcb8HjT6Lts839W9GNAxBb1dRfi0/gfwnawUEOAisRJieQedA+iw==
X-Received: by 2002:a17:906:2e4f:: with SMTP id r15-v6mr2121065eji.198.1545399560561;
        Fri, 21 Dec 2018 05:39:20 -0800 (PST)
Received: from localhost.localdomain (x4d0d79a8.dyn.telefonica.de. [77.13.121.168])
        by smtp.gmail.com with ESMTPSA id c53sm7130073ede.26.2018.12.21.05.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:39:19 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] binderfs: implement sysctls
Date:   Fri, 21 Dec 2018 14:39:09 +0100
Message-Id: <20181221133909.18794-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements three sysctls that have very specific goals:

1. /proc/sys/fs/binder/max:
   Allow global root to globally limit the number of allocatable binder
   devices.
2. /proc/sys/fs/binder/nr:
   Allow global root to easily detect how many binder devices are currently
   in use across all binderfs mounts.
3. /proc/sys/fs/binder/reserved:
   Ensure that global root can reserve binder devices for the initial
   binderfs mount in the initial ipc namespace to prevent DOS attacks.

This is equivalent to sysctls of devpts.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c | 81 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7496b10532aa..5ff015f82314 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -64,6 +64,71 @@ struct binderfs_info {
 
 };
 
+/* Global default limit on the number of binder devices. */
+static int device_limit = 4096;
+
+/*
+ * Number of binder devices reserved for the initial binderfs mount in the
+ * initial ipc namespace.
+ */
+static int device_reserve = 1024;
+
+/* Dummy sysctl minimum. */
+static int device_limit_min;
+
+/* Cap sysctl at BINDERFS_MAX_MINOR. */
+static int device_limit_max = BINDERFS_MAX_MINOR;
+
+/* Current number of allocated binder devices. */
+static atomic_t device_count = ATOMIC_INIT(0);
+
+static struct ctl_table binderfs_table[] = {
+	{
+		.procname	= "max",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.data		= &device_limit,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &device_limit_min,
+		.extra2		= &device_limit_max,
+	},
+	{
+		.procname	= "reserve",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.data		= &device_reserve,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &device_limit_min,
+		.extra2		= &device_limit_max,
+	},
+	{
+		.procname	= "nr",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.data		= &device_count,
+		.proc_handler	= proc_dointvec,
+	},
+	{}
+};
+
+static struct ctl_table binderfs_fs_table[] = {
+	{
+		.procname	= "binder",
+		.mode		= 0555,
+		.child		= binderfs_table,
+	},
+	{}
+};
+
+static struct ctl_table binderfs_root_table[] = {
+	{
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= binderfs_fs_table,
+	},
+	{}
+};
+
 static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
 {
 	return inode->i_sb->s_fs_info;
@@ -107,13 +172,21 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	struct inode *inode = NULL;
 	struct super_block *sb = ref_inode->i_sb;
 	struct binderfs_info *info = sb->s_fs_info;
+	bool use_reserved = (info->ipc_ns == &init_ipc_ns);
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
+	if (atomic_inc_return(&device_count) <
+	    (device_limit - (use_reserved ? 0 : device_reserve)))
+		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
+				      GFP_KERNEL);
+	else
+		minor = -ENOSPC;
 	mutex_unlock(&binderfs_minors_mutex);
-	if (minor < 0)
+	if (minor < 0) {
+		atomic_dec(&device_count);
 		return minor;
+	}
 
 	ret = -ENOMEM;
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
@@ -187,6 +260,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	kfree(name);
 	kfree(device);
 	mutex_lock(&binderfs_minors_mutex);
+	atomic_dec(&device_count);
 	ida_free(&binderfs_minors, minor);
 	mutex_unlock(&binderfs_minors_mutex);
 	iput(inode);
@@ -239,6 +313,7 @@ static void binderfs_evict_inode(struct inode *inode)
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
+	atomic_dec(&device_count);
 	ida_free(&binderfs_minors, device->miscdev.minor);
 	mutex_unlock(&binderfs_minors_mutex);
 
@@ -536,6 +611,8 @@ static int __init init_binderfs(void)
 		binderfs_mnt = NULL;
 		unregister_filesystem(&binder_fs_type);
 		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
+	} else {
+		register_sysctl_table(binderfs_root_table);
 	}
 
 	return ret;
-- 
2.19.1

