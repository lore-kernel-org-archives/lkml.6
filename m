Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5889C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54EA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXRcGOp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAWOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:19:31 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48577 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAWOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:19:29 -0500
Received: by mail-qt1-f201.google.com with SMTP id q3so2521361qtq.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lauieMoR6mplnrnDEREtCol1sUo9ohBTLyuY9w4HtBk=;
        b=NXRcGOp5W5Ssjdh3Im3Z6KMuxPIaY9k5ldjq4SRdmNCOnYgCcA5lIJLgLRLj36spUX
         UbMAcl+XB4V4C6lt9183RWMPeYmk540xiY2xVHZxA7pY+42d2MgiejxOa9Y6IgH95SGV
         nTKW346QZR2DroQ/8eYPtxcU/Hj3CsdDh0TvVRF6Ociu/5f7Je6KbSZ9Ruv0CSwg5EwJ
         tgfUVQXfOmvVogpiVDfWgk8sj2bgzrqetbaPWo+X3rdYa4y1yHPar9/HIRUwVZK8qFiv
         1MoDIgCfpStQSaOMi16hRjHmzeVRvPs1NhUOd1vdXGeMCXoHtZvwKRja+lpUPM3k9xwz
         Dlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lauieMoR6mplnrnDEREtCol1sUo9ohBTLyuY9w4HtBk=;
        b=O5g+yvNVqk1SlFb3H9dBVs41BosPBdzEoNOUnhEWFlTOIpbxHf8wpS7svUtVHePd5k
         pxyjBFESW71xTlXGh8cxU4m+zA6p5zV/E9wgif3nyGoy0jp2F92jOKIbkzDWooeptq6n
         Y3H9jlm3z/qncCY2VO7RqEP1PfcLjM36uKV4rIlBOIZtDSpvSePigUtUc5A3A9etkCSP
         2wLDR0Yaud1c65LZc0iUbLfgrDyj3MSUq/Pj6IzBVCnTLBFldpNNEyJ17bf0BCyY1mLr
         ba94OWBrpIG65G7O5S60qWfSVApfybm1u7mFYPCL8/ct4hTFOOeDjavzy+rJ8IE9TG9m
         PhdQ==
X-Gm-Message-State: AJcUukcchhpyrv/Sbh+E9gi2rUlcES1cKMQ57j465St5yr8y92GfuPTe
        5hBtHXLvdajJeJZN6JrBOTkqNi9Vgg==
X-Google-Smtp-Source: ALg8bN6uQhEi6JiUzSDcrTrYhpjw86tPlBRanZqgED1nJ/llFX5lNdsCGTm29Inx0W31X+gU+g32wKfqYA==
X-Received: by 2002:aed:39c7:: with SMTP id m65mr1644915qte.2.1548253168224;
 Wed, 23 Jan 2019 06:19:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:19:18 +0100
In-Reply-To: <20190123141918.238286-1-jannh@google.com>
Message-Id: <20190123141918.238286-2-jannh@google.com>
Mime-Version: 1.0
References: <20190123141918.238286-1-jannh@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 2/2] pipe: stop using ->can_merge
From:   Jann Horn <jannh@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        jannh@google.com
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro pointed out that since there is only one pipe buffer type to which
new data can be appended, it isn't necessary to have a ->can_merge field in
struct pipe_buf_operations, we can just check for a magic type.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/pipe.c                 | 20 ++++++++++++++++----
 fs/splice.c               |  4 ----
 include/linux/pipe_fs_i.h |  7 -------
 kernel/relay.c            |  1 -
 kernel/trace/trace.c      |  2 --
 net/smc/smc_rx.c          |  1 -
 6 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index c51750ed4011..0ff09b490ddf 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -226,8 +226,8 @@ void generic_pipe_buf_release(struct pipe_inode_info *pipe,
 }
 EXPORT_SYMBOL(generic_pipe_buf_release);
 
+/* New data written to a pipe may be appended to a buffer with this type. */
 static const struct pipe_buf_operations anon_pipe_buf_ops = {
-	.can_merge = 1,
 	.confirm = generic_pipe_buf_confirm,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
@@ -235,7 +235,6 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 };
 
 static const struct pipe_buf_operations anon_pipe_buf_nomerge_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
@@ -243,19 +242,32 @@ static const struct pipe_buf_operations anon_pipe_buf_nomerge_ops = {
 };
 
 static const struct pipe_buf_operations packet_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
 	.get = generic_pipe_buf_get,
 };
 
+/**
+ * pipe_buf_mark_unmergeable - mark a &struct pipe_buffer as unmergeable
+ * @buf:	the buffer to mark
+ *
+ * Description:
+ *	This function ensures that no future writes will be merged into the
+ *	given &struct pipe_buffer. This is necessary when multiple pipe buffers
+ *	share the same backing page.
+ */
 void pipe_buf_mark_unmergeable(struct pipe_buffer *buf)
 {
 	if (buf->ops == &anon_pipe_buf_ops)
 		buf->ops = &anon_pipe_buf_nomerge_ops;
 }
 
+static bool pipe_buf_can_merge(struct pipe_buffer *buf)
+{
+	return buf->ops == &anon_pipe_buf_ops;
+}
+
 static ssize_t
 pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -393,7 +405,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		struct pipe_buffer *buf = pipe->bufs + lastbuf;
 		int offset = buf->offset + buf->len;
 
-		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE) {
+		if (pipe_buf_can_merge(buf) && offset + chars <= PAGE_SIZE) {
 			ret = pipe_buf_confirm(pipe, buf);
 			if (ret)
 				goto out;
diff --git a/fs/splice.c b/fs/splice.c
index 90c29675d573..fc71e9733f7a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -138,7 +138,6 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 }
 
 const struct pipe_buf_operations page_cache_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = page_cache_pipe_buf_confirm,
 	.release = page_cache_pipe_buf_release,
 	.steal = page_cache_pipe_buf_steal,
@@ -156,7 +155,6 @@ static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations user_page_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = page_cache_pipe_buf_release,
 	.steal = user_page_pipe_buf_steal,
@@ -326,7 +324,6 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 EXPORT_SYMBOL(generic_file_splice_read);
 
 const struct pipe_buf_operations default_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = generic_pipe_buf_release,
 	.steal = generic_pipe_buf_steal,
@@ -341,7 +338,6 @@ static int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
 
 /* Pipe buffer operations for a socket and similar. */
 const struct pipe_buf_operations nosteal_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = generic_pipe_buf_release,
 	.steal = generic_pipe_buf_nosteal,
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 3ecd7ea212ae..787d224ff43e 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -73,13 +73,6 @@ struct pipe_inode_info {
  * in fs/pipe.c for the pipe and generic variants of these hooks.
  */
 struct pipe_buf_operations {
-	/*
-	 * This is set to 1, if the generic pipe read/write may coalesce
-	 * data into an existing buffer. If this is set to 0, a new pipe
-	 * page segment is always used for new data.
-	 */
-	int can_merge;
-
 	/*
 	 * ->confirm() verifies that the data in the pipe buffer is there
 	 * and that the contents are good. If the pages in the pipe belong
diff --git a/kernel/relay.c b/kernel/relay.c
index 04f248644e06..db3e419c25a6 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1175,7 +1175,6 @@ static void relay_pipe_buf_release(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations relay_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = relay_pipe_buf_release,
 	.steal = generic_pipe_buf_steal,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..f380139e972c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5823,7 +5823,6 @@ static void tracing_spd_release_pipe(struct splice_pipe_desc *spd,
 }
 
 static const struct pipe_buf_operations tracing_pipe_buf_ops = {
-	.can_merge		= 0,
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= generic_pipe_buf_release,
 	.steal			= generic_pipe_buf_steal,
@@ -6843,7 +6842,6 @@ static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
 
 /* Pipe buffer operations for a buffer. */
 static const struct pipe_buf_operations buffer_pipe_buf_ops = {
-	.can_merge		= 0,
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= buffer_pipe_buf_release,
 	.steal			= generic_pipe_buf_steal,
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index bbcf0fe4ae10..413a6abf227e 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -136,7 +136,6 @@ static int smc_rx_pipe_buf_nosteal(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations smc_pipe_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = smc_rx_pipe_buf_release,
 	.steal = smc_rx_pipe_buf_nosteal,
-- 
2.20.1.321.g9e740568ce-goog

