Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B834D214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B834D214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeIRWM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbeIRWM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 593B58666B;
        Tue, 18 Sep 2018 16:39:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79E417DEE4;
        Tue, 18 Sep 2018 16:39:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180918090722.GA463@jagdpanzerIV>
References: <20180918090722.GA463@jagdpanzerIV> <20180911220743.GA13208@roeck-us.net> <20180911174641.GA15149@roeck-us.net> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk> <27113.1536702746@warthog.procyon.org.uk> <32382.1536707855@warthog.procyon.org.uk> <20180911235403.GA10107@roeck-us.net>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     dhowells@redhat.com, Guenter Roeck <linux@roeck-us.net>,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock creation/configuration context [ver #11]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27018.1537288742.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 17:39:02 +0100
Message-ID: <27019.1537288742@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Sep 2018 16:39:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I need to include something like the attached change in this patch.
Changes also need to be made to proc and cgroup.

David
---
commit 1a336480a0f664b3e1988a581bccd4fa10d98764
Author: David Howells <dhowells@redhat.com>
Date:   Tue Sep 18 17:25:23 2018 +0100

    fix remount

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a82679441031..1f36b72e3ee9 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,8 +42,6 @@ struct legacy_fs_context {
 	enum legacy_fs_param	param_type;
 };
 
-static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry);
-
 static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
@@ -293,7 +291,6 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 		break;
 	}
 
-
 	/* TODO: Make all filesystems support this unconditionally */
 	init_fs_context = fc->fs_type->init_fs_context;
 	if (!init_fs_context)
@@ -662,12 +659,20 @@ const struct fs_context_operations legacy_fs_context_ops = {
  * Initialise a legacy context for a filesystem that doesn't support
  * fs_context.
  */
-static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
+int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
 {
+	switch (fc->purpose) {
+	default:
+		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
+					 GFP_KERNEL);
+		if (!fc->fs_private)
+			return -ENOMEM;
+		break;
 
-	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
-	if (!fc->fs_private)
-		return -ENOMEM;
+	case FS_CONTEXT_FOR_UMOUNT:
+	case FS_CONTEXT_FOR_EMERGENCY_RO:
+		break;
+	}
 
 	fc->ops = &legacy_fs_context_ops;
 	return 0;
diff --git a/fs/internal.h b/fs/internal.h
index d25cb82af69d..fc2da60abbcd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,7 @@ extern void __init chrdev_init(void);
  * fs_context.c
  */
 extern const struct fs_context_operations legacy_fs_context_ops;
+extern int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry);
 
 /*
  * fsopen.c
diff --git a/fs/namespace.c b/fs/namespace.c
index ddb2c3b88cd6..86b60566fcdf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1429,9 +1429,19 @@ static int do_umount_root(struct super_block *sb)
 	};
 
 	down_write(&sb->s_umount);
-	if (!sb_rdonly(sb))
-		/* Might want to call ->init_fs_context(). */
-		ret = reconfigure_super(&fc);
+	if (!sb_rdonly(sb)) {
+		int ret;
+
+		if (fc.fs_type->init_fs_context)
+			ret = fc.fs_type->init_fs_context(&fc, NULL);
+		else
+			ret = legacy_init_fs_context(&fc, NULL);
+
+		if (ret == 0) {
+			ret = reconfigure_super(&fc);
+			fc.ops->free(&fc);
+		}
+	}
 	up_write(&sb->s_umount);
 	return ret;
 }
@@ -2396,7 +2406,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 
 	err = security_fs_context_validate(fc);
 	if (err)
-		return err;
+		goto err_fc;
 
 	down_write(&sb->s_umount);
 	err = -EPERM;
diff --git a/fs/super.c b/fs/super.c
index e00b03249bfa..df8c4cebd000 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1026,12 +1026,20 @@ static void do_emergency_remount_callback(struct super_block *sb)
 
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
-	    !sb_rdonly(sb))
-		/* Might want to call ->init_fs_context(). */
+	    !sb_rdonly(sb)) {
+		int ret;
+
+		if (fc.fs_type->init_fs_context)
+			ret = fc.fs_type->init_fs_context(&fc, NULL);
+		else
+			ret = legacy_init_fs_context(&fc, NULL);
+
 		/*
 		 * What lock protects sb->s_flags??
 		 */
-		reconfigure_super(&fc);
+		if (ret == 0)
+			reconfigure_super(&fc);
+	}
 	up_write(&sb->s_umount);
 }
 
