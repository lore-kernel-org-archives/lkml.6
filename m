Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D032084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D032084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeKBGyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:54:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeKBGyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:54:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKq2-0008KU-RG
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:14 +0000
Received: by mail-it1-f198.google.com with SMTP id q184-v6so491388itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssHBrVY4nRWUii0FegPmCz0YBObhDZI10ZPtWTEhtfI=;
        b=SCpMUYDhCSuZS8iaIoe+q/NHLi1DId32G2nIIWi60K3UQQ05wztkMh7cN/gPfHaD3W
         HSRsX2Rg9Vedm0lLXKIFUKXKr5ENPanGLn1/GpNQKsFDCHEEYvwgeXQtFFx+yXIPer9Q
         qgz87HoAaJCG0Lt2Hw4lnjZEa4dATOto4cuH0eWHDkLy7nmXc300w+aYy3SwinCoNCin
         j4+4ovDSuskLexm9UkyOrHQBj7NPGDlbXYW6nLH74wf5PXwknrnLsTd9waRFWlpMb/z9
         yWvXGOuql+QDHynuH4p56B4eKf+7gD+N/ZVw9Pc4zXNhlVf+XvEVNLRZTswo2RYkYwiO
         wxEg==
X-Gm-Message-State: AGRZ1gJL9n1aLaMUMWPlwdkI4iGZuEwyu7wmUk05leHS66lr7rh/SKgE
        lmn/fsyUSzMyyjmJ57da3aPNRQHGryeOhfJ/f+Ru4k61DcUaVy9ZG8ODUYz8NRuZf+a+SSIxPLz
        Dy9tmK/3DGbPhKyBUaJmt0g8B//S98QOlv0OdAwPwBw==
X-Received: by 2002:a02:b45a:: with SMTP id w26-v6mr7736308jaj.45.1541108953134;
        Thu, 01 Nov 2018 14:49:13 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dDaKJBrDdhw3VjHDkfjLz9RNuSjLwQJnSQr8NDzg7HqjE4SQHD+0DRV/mB/BZFSFmo+fiPXg==
X-Received: by 2002:a02:b45a:: with SMTP id w26-v6mr7736291jaj.45.1541108952698;
        Thu, 01 Nov 2018 14:49:12 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id o10-v6sm9449349iob.43.2018.11.01.14.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:49:11 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 6/6] shiftfs: support nested shiftfs mounts
Date:   Thu,  1 Nov 2018 16:48:56 -0500
Message-Id: <20181101214856.4563-7-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shiftfs mounts cannot be nested for two reasons -- global
CAP_SYS_ADMIN is required to set up a mark mount, and a single
functional shiftfs mount meets the filesystem stacking depth
limit.

The CAP_SYS_ADMIN requirement can be relaxed. All of the kernel
ids in a mount must be within that mount's s_user_ns, so all that
is needed is CAP_SYS_ADMIN within that s_user_ns.

The stack depth issue can be worked around with a couple of
adjustments. First, a mark mount doesn't really need to count
against the stacking depth as it doesn't contribute to the call
stack depth during filesystem operations. Therefore the mount
over the mark mount only needs to count as one more than the
lower filesystems stack depth.

Second, when the lower mount is shiftfs we can just skip down to
that mount's lower filesystem and shift ids relative to that.
There is no reason to shift ids twice, and the lower path has
already been marked safe for id shifting by a user privileged
towards all ids in that mount's user ns.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/shiftfs.c | 68 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index b19af7b2fe75..008ace2842b9 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -930,7 +930,7 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
 	struct shiftfs_data *data = raw_data;
 	char *name = kstrdup(data->path, GFP_KERNEL);
 	int err = -ENOMEM;
-	struct shiftfs_super_info *ssi = NULL;
+	struct shiftfs_super_info *ssi = NULL, *mp_ssi;
 	struct path path;
 	struct dentry *dentry;
 
@@ -946,11 +946,7 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
 	if (err)
 		goto out;
 
-	/* to mark a mount point, must be real root */
-	if (ssi->mark && !capable(CAP_SYS_ADMIN))
-		goto out;
-
-	/* else to mount a mark, must be userns admin */
+	/* to mount a mark, must be userns admin */
 	if (!ssi->mark && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		goto out;
 
@@ -962,41 +958,66 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
 
 	if (!S_ISDIR(path.dentry->d_inode->i_mode)) {
 		err = -ENOTDIR;
-		goto out_put;
-	}
-
-	sb->s_stack_depth = path.dentry->d_sb->s_stack_depth + 1;
-	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-		printk(KERN_ERR "shiftfs: maximum stacking depth exceeded\n");
-		err = -EINVAL;
-		goto out_put;
+		goto out_put_path;
 	}
 
 	if (ssi->mark) {
+		struct super_block *lower_sb = path.mnt->mnt_sb;
+
+		/* to mark a mount point, must root wrt lower s_user_ns */
+		if (!ns_capable(lower_sb->s_user_ns, CAP_SYS_ADMIN))
+			goto out_put_path;
+
+
 		/*
 		 * this part is visible unshifted, so make sure no
 		 * executables that could be used to give suid
 		 * privileges
 		 */
 		sb->s_iflags = SB_I_NOEXEC;
-		ssi->mnt = path.mnt;
-		dentry = path.dentry;
-	} else {
-		struct shiftfs_super_info *mp_ssi;
 
+		/*
+		 * Handle nesting of shiftfs mounts by referring this mark
+		 * mount back to the original mark mount. This is more
+		 * efficient and alleviates concerns about stack depth.
+		 */
+		if (lower_sb->s_magic == SHIFTFS_MAGIC) {
+			mp_ssi = lower_sb->s_fs_info;
+
+			/* Doesn't make sense to mark a mark mount */
+			if (mp_ssi->mark) {
+				err = -EINVAL;
+				goto out_put_path;
+			}
+
+			ssi->mnt = mntget(mp_ssi->mnt);
+			dentry = dget(path.dentry->d_fsdata);
+		} else {
+			ssi->mnt = mntget(path.mnt);
+			dentry = dget(path.dentry);
+		}
+	} else {
 		/*
 		 * this leg executes if we're admin capable in
 		 * the namespace, so be very careful
 		 */
 		if (path.dentry->d_sb->s_magic != SHIFTFS_MAGIC)
-			goto out_put;
+			goto out_put_path;
 		mp_ssi = path.dentry->d_sb->s_fs_info;
 		if (!mp_ssi->mark)
-			goto out_put;
+			goto out_put_path;
 		ssi->mnt = mntget(mp_ssi->mnt);
 		dentry = dget(path.dentry->d_fsdata);
-		path_put(&path);
 	}
+
+	sb->s_stack_depth = dentry->d_sb->s_stack_depth + 1;
+	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+		printk(KERN_ERR "shiftfs: maximum stacking depth exceeded\n");
+		err = -EINVAL;
+		goto out_put_mnt;
+	}
+
+	path_put(&path);
 	ssi->userns = get_user_ns(dentry->d_sb->s_user_ns);
 	sb->s_fs_info = ssi;
 	sb->s_magic = SHIFTFS_MAGIC;
@@ -1009,7 +1030,10 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
 
 	return 0;
 
- out_put:
+ out_put_mnt:
+	mntput(ssi->mnt);
+	dput(dentry);
+ out_put_path:
 	path_put(&path);
  out:
 	kfree(name);
-- 
2.19.1

