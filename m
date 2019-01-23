Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF02C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320D620870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lu+BVVEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAWOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:19:26 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:45237 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAWOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:19:25 -0500
Received: by mail-yw1-f74.google.com with SMTP id k69so1173407ywa.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YdTZcj4awLkuiDDlEY8FD2E/jDvXKOg3LBytxcu7mVU=;
        b=lu+BVVEYMxAL/KrTfwYAlxgvot43Q/Mns6Yeh7/yIyOJV29nPKkT9lUxroKxb1UTol
         x9WSGCNTyweuQ4Hv7kKPhavqo3M7SpYnWEQ0s8ku/f0CqSEnBbHwYRgaVRV0bqutWRSZ
         EXrhfRZFq4j8oePmj/cTz1Ji8I+p+TjhJcb2hdlEB5PrA9mM2+Rbev3Q+Y3LUkDrwkz7
         bIWaMraK7RIayMEV4HxHAU0EJlK3mh+/KfeeF9jBtoqcGBZQr/Goc6Nd7KYVB+wUk8HI
         iFFmaDZS2ne8zreF9mb5yh00ekU7dqZwcXid8gI60csUYzoo3zuXVpq6hiXtI6BRLclb
         H6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YdTZcj4awLkuiDDlEY8FD2E/jDvXKOg3LBytxcu7mVU=;
        b=ZXZRpEY3lqFMpnVcwqHrhT3TRC/G1fpk0uD1E7PrxDiQd11hck4adDnLh1ySmSZReS
         xDlrbakXb3VAu4+iUd15DY4vpR4qOS8BP7jX6roMhYS2HlX6dpK0WIabmtT0Rj5o48mS
         oZYx29oxls5slBsaamM4phpy7CV3tImUPoakmlg3wB9kj0QFAEhqqzA0+qiShYUeJbKw
         fS1bG0APH9dCp86BRW5zY76r+tzyRzXTYlHxBTKvUdLBOajR4xcuGCd9dpNWptB+hlGK
         n8RjtVH6mG3V1jTCsqDqG/Fo1KQcHeNyZdg1RaOFOv2tdAej+ksznyyE1OY2HQ1LF1No
         V+rg==
X-Gm-Message-State: AJcUukenKYTEQgZy5uDsokbIE6pIv4P3wdHgro11u4VJxV/t4c+MvLWR
        vuDZhjtfZzk4k1dH5v0nWDBSItrRzw==
X-Google-Smtp-Source: ALg8bN7juJ6hMcbdu4GR7lWA1uM1JYyMs7fQif2GCpFQfVJXuVsShRI+e6riORdnPK9ZF0h4hlvldL61lA==
X-Received: by 2002:a25:3b03:: with SMTP id i3mr686453yba.57.1548253163833;
 Wed, 23 Jan 2019 06:19:23 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:19:17 +0100
Message-Id: <20190123141918.238286-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 1/2] splice: don't merge into linked buffers
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

Before this patch, it was possible for two pipes to affect each other after
data had been transferred between them with tee():

============
$ cat tee_test.c

int main(void) {
  int pipe_a[2];
  if (pipe(pipe_a)) err(1, "pipe");
  int pipe_b[2];
  if (pipe(pipe_b)) err(1, "pipe");
  if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
  if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
  if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");

  char buf[5];
  if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
  buf[4] = 0;
  printf("got back: '%s'\n", buf);
}
$ gcc -o tee_test tee_test.c
$ ./tee_test
got back: 'abxx'
$
============

As suggested by Al Viro, fix it by creating a separate type for
non-mergeable pipe buffers, then changing the types of buffers in
splice_pipe_to_pipe() and link_pipe().

Cc: <stable@vger.kernel.org>
Fixes: 7c77f0b3f920 ("splice: implement pipe to pipe splicing")
Fixes: 70524490ee2e ("[PATCH] splice: add support for sys_tee()")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jann Horn <jannh@google.com>
---
Al wasn't entirely happy with the approach I took for v1, so sending a
different fix here.

 fs/pipe.c                 | 14 ++++++++++++++
 fs/splice.c               |  4 ++++
 include/linux/pipe_fs_i.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index bdc5d3c0977d..c51750ed4011 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -234,6 +234,14 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 	.get = generic_pipe_buf_get,
 };
 
+static const struct pipe_buf_operations anon_pipe_buf_nomerge_ops = {
+	.can_merge = 0,
+	.confirm = generic_pipe_buf_confirm,
+	.release = anon_pipe_buf_release,
+	.steal = anon_pipe_buf_steal,
+	.get = generic_pipe_buf_get,
+};
+
 static const struct pipe_buf_operations packet_pipe_buf_ops = {
 	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
@@ -242,6 +250,12 @@ static const struct pipe_buf_operations packet_pipe_buf_ops = {
 	.get = generic_pipe_buf_get,
 };
 
+void pipe_buf_mark_unmergeable(struct pipe_buffer *buf)
+{
+	if (buf->ops == &anon_pipe_buf_ops)
+		buf->ops = &anon_pipe_buf_nomerge_ops;
+}
+
 static ssize_t
 pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
diff --git a/fs/splice.c b/fs/splice.c
index de2ede048473..90c29675d573 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1597,6 +1597,8 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			 */
 			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+			pipe_buf_mark_unmergeable(obuf);
+
 			obuf->len = len;
 			opipe->nrbufs++;
 			ibuf->offset += obuf->len;
@@ -1671,6 +1673,8 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		 */
 		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+		pipe_buf_mark_unmergeable(obuf);
+
 		if (obuf->len > len)
 			obuf->len = len;
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5a3bb3b7c9ad..3ecd7ea212ae 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -182,6 +182,7 @@ void generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
+void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
-- 
2.20.1.321.g9e740568ce-goog

