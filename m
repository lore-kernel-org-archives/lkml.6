Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0455ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6515321526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6515321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbeITU4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51917 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeITU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2-v6so10428663wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=THDz0P+2hLPCqDegCGQZClg3PBDMfTh1+DDdNthUPK8=;
        b=MX3KP9lVop73CiXCpF3VR/pFsHrNucXsCePHpKF5OOEq6XMTYzwaOBgEftJ8a6aqGm
         TdFE1NOOC47P7hu/9jHLc+f2G4KOBU9cU7BywvL6WNw8aadjfHifC6xgVD9ZBlKLR4HC
         MSkokWZHlByb9S5A5KLpGbb/q0UbyZC1tYWvGvTgvPiXDNbu/hOYn1N3kjj4otUeRLt0
         NcGr69YwEMYnYj+e3kBKMIc6dUGFseCfFAvWtUN0FRR5xRJANewJZTNAW3Y51ziU6sGY
         +ETBnAF5CmBnKBJcsvBWPLCYOC2SYfpZUF0o+1Dv0BJQFtqxnSMZYiaPVB8BbyHivgxJ
         jeww==
X-Gm-Message-State: ABuFfoiIq8RP6hyplZw0/15xfxbM5dZ1OJI8T6Gv80hyIM2M06gL11n3
        z1s3lyjMg33pdh84Tw1FaHiyIg==
X-Google-Smtp-Source: ACcGV63Mg8o3TM2GsrIXvR4H5/dIWJJS5rDgdAGMmH1h385n8FsTCtzFOCexf7d5i4sqAzp9pvyURw==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr3348417wmg.82.1537456343911;
        Thu, 20 Sep 2018 08:12:23 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:23 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mount: fix regression in setting "subtype" from legacy API
Date:   Thu, 20 Sep 2018 17:12:11 +0200
Message-Id: <20180920151214.15484-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subtype was initilized at the wrong place from the wrong source
(fstype->fs_type->name, which does not ever contain a subtype).

Set subtype from do_new_mount(), where it actually does something.
Verified with fuse.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 34 ----------------------------------
 fs/namespace.c  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index ceaf42559016..c0ecbb1ecdfe 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -684,27 +684,6 @@ static int legacy_validate(struct fs_context *fc)
 				     ctx->secdata);
 }
 
-/*
- * Determine the superblock subtype.
- */
-static int legacy_set_subtype(struct fs_context *fc)
-{
-	const char *subtype = strchr(fc->fs_type->name, '.');
-
-	if (subtype) {
-		subtype++;
-		if (!subtype[0])
-			return -EINVAL;
-	} else {
-		subtype = "";
-	}
-
-	fc->subtype = kstrdup(subtype, GFP_KERNEL);
-	if (!fc->subtype)
-		return -ENOMEM;
-	return 0;
-}
-
 /*
  * Get a mountable root with the legacy mount command.
  */
@@ -713,7 +692,6 @@ static int legacy_get_tree(struct fs_context *fc)
 	struct legacy_fs_context *ctx = fc->fs_private;
 	struct super_block *sb;
 	struct dentry *root;
-	int ret;
 
 	root = fc->fs_type->mount(fc->fs_type, fc->sb_flags,
 				      fc->source, ctx->legacy_data,
@@ -724,20 +702,8 @@ static int legacy_get_tree(struct fs_context *fc)
 	sb = root->d_sb;
 	BUG_ON(!sb);
 
-	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
-	    !fc->subtype) {
-		ret = legacy_set_subtype(fc);
-		if (ret < 0)
-			goto err_sb;
-	}
-
 	fc->root = root;
 	return 0;
-
-err_sb:
-	dput(root);
-	deactivate_locked_super(sb);
-	return ret;
 }
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index 865b6f2c5e7d..7671c1f6fc22 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2617,6 +2617,7 @@ static int do_new_mount(struct path *mountpoint, const char *fstype,
 {
 	struct file_system_type *fs_type;
 	struct fs_context *fc;
+	const char *subtype = NULL;
 	int err;
 
 	if (!fstype)
@@ -2627,6 +2628,19 @@ static int do_new_mount(struct path *mountpoint, const char *fstype,
 	if (!fs_type)
 		goto out;
 
+	if (fs_type->fs_flags & FS_HAS_SUBTYPE) {
+		subtype = strchr(fstype, '.');
+		if (subtype) {
+			subtype++;
+			if (!subtype[0]) {
+				put_filesystem(fs_type);
+				return -EINVAL;
+			}
+		} else {
+			subtype = "";
+		}
+	}
+
 	fc = vfs_new_fs_context(fs_type, NULL, sb_flags, sb_flags,
 				FS_CONTEXT_FOR_USER_MOUNT);
 	put_filesystem(fs_type);
@@ -2635,6 +2649,13 @@ static int do_new_mount(struct path *mountpoint, const char *fstype,
 		goto out;
 	}
 
+	if (subtype) {
+		fc->subtype = kstrdup(subtype, GFP_KERNEL);
+		err = -ENOMEM;
+		if (!fc->subtype)
+			goto out;
+	}
+
 	if (name) {
 		err = vfs_parse_fs_string(fc, "source", name, strlen(name));
 		if (err < 0)
-- 
2.14.3

