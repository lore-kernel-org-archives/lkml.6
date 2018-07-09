Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1626C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797E62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797E62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGIMbM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:31:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932568AbeGIMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92E1A83207;
        Mon,  9 Jul 2018 12:31:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC5E351E4;
        Mon,  9 Jul 2018 12:31:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180708210154.10423-8-ebiggers3@gmail.com>
References: <20180708210154.10423-8-ebiggers3@gmail.com> <20180708210154.10423-1-ebiggers3@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 07/18] fs_context: fix double free of legacy_fs_context data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3013.1531139469.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 09 Jul 2018 13:31:09 +0100
Message-ID: <3014.1531139469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 12:31:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 12:31:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> sys_fsmount() calls fc->ops->free() to free the data, zeroes
> ->fs_private, then proceeds to reuse the context.  But legacy_fs_context
> doesn't use ->fs_private, so we need to handle zeroing it too; otherwise
> there's a double free of legacy_fs_context::{legacy_data,secdata}.

I think the attached is better.  I stopped embedding the fs_context in the
xxx_fs_context to make certain things simpler, but I missed the legacy
wrapper.

David
---
diff --git a/fs/fs_context.c b/fs/fs_context.c
index f91facc769f7..ab93a0b73dc6 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -34,7 +34,6 @@ enum legacy_fs_param {
 };
 
 struct legacy_fs_context {
-	struct fs_context	fc;
 	char			*legacy_data;	/* Data page for legacy filesystems */
 	char			*secdata;
 	size_t			data_size;
@@ -239,12 +238,21 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 				      enum fs_context_purpose purpose)
 {
 	struct fs_context *fc;
-	int ret;
+	int ret = -ENOMEM;
 
-	fc = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
+	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
 
+	if (!fs_type->init_fs_context) {
+		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
+					 GFP_KERNEL);
+		if (!fc->fs_private)
+			goto err_fc;
+
+		fc->ops = &legacy_fs_context_ops;
+	}
+
 	fc->purpose	= purpose;
 	fc->sb_flags	= sb_flags;
 	fc->fs_type	= get_filesystem(fs_type);
@@ -277,8 +285,6 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 		ret = fc->fs_type->init_fs_context(fc, reference);
 		if (ret < 0)
 			goto err_fc;
-	} else {
-		fc->ops = &legacy_fs_context_ops;
 	}
 
 	/* Do the security check last because ->init_fs_context may change the
@@ -395,7 +401,7 @@ EXPORT_SYMBOL(put_fs_context);
  */
 static void legacy_fs_context_free(struct fs_context *fc)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx = fc->fs_private;
 
 	free_secdata(ctx->secdata);
 	switch (ctx->param_type) {
@@ -408,6 +414,8 @@ static void legacy_fs_context_free(struct fs_context *fc)
 		kfree(ctx->legacy_data);
 		break;
 	}
+
+	kfree(ctx);
 }
 
 /*
@@ -415,20 +423,28 @@ static void legacy_fs_context_free(struct fs_context *fc)
  */
 static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
-	struct legacy_fs_context *src_ctx = container_of(src_fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx;
+	struct legacy_fs_context *src_ctx = src_fc->fs_private;
+
+	ctx = kmemdup(src_ctx, sizeof(*src_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
 
 	switch (ctx->param_type) {
 	case LEGACY_FS_MONOLITHIC_PARAMS:
 	case LEGACY_FS_INDIVIDUAL_PARAMS:
 		ctx->legacy_data = kmemdup(src_ctx->legacy_data,
 					   src_ctx->data_size, GFP_KERNEL);
-		if (!ctx->legacy_data)
+		if (!ctx->legacy_data) {
+			kfree(ctx);
 			return -ENOMEM;
+		}
 		/* Fall through */
 	default:
 		break;
 	}
+
+	fc->fs_private = ctx;
 	return 0;
 }
 
@@ -438,7 +454,7 @@ static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_f
  */
 static int legacy_parse_option(struct fs_context *fc, char *opt, size_t len)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx = fc->fs_private;
 	unsigned int size = ctx->data_size;
 
 	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS &&
@@ -471,7 +487,7 @@ static int legacy_parse_option(struct fs_context *fc, char *opt, size_t len)
  */
 static int legacy_parse_monolithic(struct fs_context *fc, void *data, size_t data_size)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx = fc->fs_private;
 
 	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS) {
 		pr_warn("VFS: Can't mix monolithic and individual options\n");
@@ -507,7 +523,7 @@ static int legacy_parse_monolithic(struct fs_context *fc, void *data, size_t dat
  */
 static int legacy_validate(struct fs_context *fc)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx = fc->fs_private;
 
 	switch (ctx->param_type) {
 	case LEGACY_FS_UNSET_PARAMS:
@@ -520,7 +536,7 @@ static int legacy_validate(struct fs_context *fc)
 		break;
 	}
 
-	if (ctx->fc.fs_type->fs_flags & FS_BINARY_MOUNTDATA)
+	if (fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)
 		return 0;
 
 	ctx->secdata = alloc_secdata();
@@ -557,13 +573,13 @@ static int legacy_set_subtype(struct fs_context *fc)
  */
 static int legacy_get_tree(struct fs_context *fc)
 {
-	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *ctx = fc->fs_private;
 	struct super_block *sb;
 	struct dentry *root;
 	int ret;
 
-	root = ctx->fc.fs_type->mount(ctx->fc.fs_type, ctx->fc.sb_flags,
-				      ctx->fc.source, ctx->legacy_data,
+	root = fc->fs_type->mount(fc->fs_type, fc->sb_flags,
+				      fc->source, ctx->legacy_data,
 				      ctx->data_size);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
@@ -571,14 +587,14 @@ static int legacy_get_tree(struct fs_context *fc)
 	sb = root->d_sb;
 	BUG_ON(!sb);
 
-	if ((ctx->fc.fs_type->fs_flags & FS_HAS_SUBTYPE) &&
+	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
 	    !fc->subtype) {
 		ret = legacy_set_subtype(fc);
 		if (ret < 0)
 			goto err_sb;
 	}
 
-	ctx->fc.root = root;
+	fc->root = root;
 	return 0;
 
 err_sb:
