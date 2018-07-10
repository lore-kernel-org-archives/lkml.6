Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C36420878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C36420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeGJICX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:02:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932743AbeGJICG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E845040122D4;
        Tue, 10 Jul 2018 08:02:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0591F2026D6B;
        Tue, 10 Jul 2018 08:02:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180710011741.GA1014@sol.localdomain>
References: <20180710011741.GA1014@sol.localdomain> <20180708210154.10423-8-ebiggers3@gmail.com> <20180708210154.10423-1-ebiggers3@gmail.com> <3014.1531139469@warthog.procyon.org.uk>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 07/18] fs_context: fix double free of legacy_fs_context data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25102.1531209724.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 10 Jul 2018 09:02:04 +0100
Message-ID: <25103.1531209724@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 08:02:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 08:02:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Why isn't this done in the same place that ->init_fs_context() would otherwise
> be called?  It logically does the same thing, right?

Fair point.  How about the attached incremental change?  It breaks the legacy
context initialisation out into its own init function and just sets that as
the default if the fs doesn't supply its own.

It also makes the freeing conditional.

David
---
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 8af0542ab8b6..f388ab29d37d 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,6 +42,7 @@ struct legacy_fs_context {
 	enum legacy_fs_param	param_type;
 };
 
+static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry);
 static const struct fs_context_operations legacy_fs_context_ops;
 
 static const match_table_t common_set_sb_flag = {
@@ -239,6 +240,7 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 				      unsigned int sb_flags,
 				      enum fs_context_purpose purpose)
 {
+	int (*init_fs_context)(struct fs_context *, struct dentry *);
 	struct fs_context *fc;
 	int ret = -ENOMEM;
 
@@ -246,15 +248,6 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
 
-	if (!fs_type->init_fs_context) {
-		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
-					 GFP_KERNEL);
-		if (!fc->fs_private)
-			goto err_fc;
-
-		fc->ops = &legacy_fs_context_ops;
-	}
-
 	fc->purpose	= purpose;
 	fc->sb_flags	= sb_flags;
 	fc->fs_type	= get_filesystem(fs_type);
@@ -285,11 +278,13 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 
 
 	/* TODO: Make all filesystems support this unconditionally */
-	if (fc->fs_type->init_fs_context) {
-		ret = fc->fs_type->init_fs_context(fc, reference);
-		if (ret < 0)
-			goto err_fc;
-	}
+	init_fs_context = fc->fs_type->init_fs_context;
+	if (!init_fs_context)
+		init_fs_context = legacy_init_fs_context;
+
+	ret = (*init_fs_context)(fc, reference);
+	if (ret < 0)
+		goto err_fc;
 
 	/* Do the security check last because ->init_fs_context may change the
 	 * namespace subscriptions.
@@ -499,19 +494,21 @@ static void legacy_fs_context_free(struct fs_context *fc)
 {
 	struct legacy_fs_context *ctx = fc->fs_private;
 
-	free_secdata(ctx->secdata);
-	switch (ctx->param_type) {
-	case LEGACY_FS_UNSET_PARAMS:
-	case LEGACY_FS_NO_PARAMS:
-		break;
-	case LEGACY_FS_MAGIC_PARAMS:
-		break; /* ctx->data is a weird pointer */
-	default:
-		kfree(ctx->legacy_data);
-		break;
-	}
+	if (ctx) {
+		free_secdata(ctx->secdata);
+		switch (ctx->param_type) {
+		case LEGACY_FS_UNSET_PARAMS:
+		case LEGACY_FS_NO_PARAMS:
+			break;
+		case LEGACY_FS_MAGIC_PARAMS:
+			break; /* ctx->data is a weird pointer */
+		default:
+			kfree(ctx->legacy_data);
+			break;
+		}
 
-	kfree(ctx);
+		kfree(ctx);
+	}
 }
 
 /*
@@ -707,3 +704,18 @@ static const struct fs_context_operations legacy_fs_context_ops = {
 	.validate		= legacy_validate,
 	.get_tree		= legacy_get_tree,
 };
+
+/*
+ * Initialise a legacy context for a filesystem that doesn't support
+ * fs_context.
+ */
+static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
+{
+
+	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
+	if (!fc->fs_private)
+		return -ENOMEM;
+
+	fc->ops = &legacy_fs_context_ops;
+	return 0;
+}
