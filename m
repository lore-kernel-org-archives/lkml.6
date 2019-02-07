Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA14C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C1721872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:45:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39519 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:45:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so335004wmh.4;
        Thu, 07 Feb 2019 07:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBhpBEdDKiEIXTAd5hjHfwwSdcRwGfi1+myONUyDRjE=;
        b=i/rNlqqmeyUUuXKrxkOrCUKzuPJpJXFrYG0sP0NNjeV95VymRh4zvJ72xWFtjIB5F5
         absEVK4TbYGZTMzHFrfakreb5zoKuUJ/07aIPjMAJs5TMMdxxKaicSoXRHM+D3Ad5+AE
         TzyL4qQO92ENQVepFod/h2oGW13CE46HL5N5igVeZdaeImioQurJe8UVkaAhNNaNPxnP
         AkwsRCp/GEyJBBqM1UerMzyW3j9yA2Wo0HuB1OSf+7hq0jrkfZrwf/FPyHKJGkZ22FAp
         BMjExw7vk6ipfsfDsz5zPCHidsLtoTyjYkxgC3fWbb2bTOKBhsKBzcvREAfCHjCpc+da
         GC6A==
X-Gm-Message-State: AHQUAuZmd3t9ntudKCMm5qpeW3ySqlMcRr57z3lEaPP/M/nAfJ3MBjrF
        eaItVQlrduUjePRlJzjPq7yWkjqsHA==
X-Google-Smtp-Source: AHgI3Ib6/Ofhen0bQxmo2x1yjHI1ZRur+tMji1iUrXIYTYisbYtx8LwBNTbRSX5D5IyBOChj68/tBQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr7828392wmi.61.1549554326386;
        Thu, 07 Feb 2019 07:45:26 -0800 (PST)
Received: from box.eng.vmware.com ([146.247.46.5])
        by smtp.gmail.com with ESMTPSA id z26sm2030274wml.44.2019.02.07.07.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:45:25 -0800 (PST)
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fs: Make splice() and tee() take into account O_NONBLOCK flag on pipes
Date:   Thu,  7 Feb 2019 17:45:19 +0200
Message-Id: <20190207154519.8635-1-kaslevs@vmware.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of splice() and tee() ignores O_NONBLOCK set on pipe
file descriptors and checks only the SPLICE_F_NONBLOCK flag for blocking on pipe
arguments. This is inconsistent since splice()-ing from/to non-pipe file
descriptors does take O_NONBLOCK into consideration.

Fix this by promoting O_NONBLOCK, when set on a pipe, to SPLICE_F_NONBLOCK.

Some context for how the current implementation of splice() leads to
inconsistent behavior. In the ongoing work[1] to add VM tracing capability to
trace-cmd we stream tracing data over named FIFOs or vsockets from guests back
to the host.

When we receive SIGINT from user to stop tracing, we set O_NONBLOCK on the input
file descriptor and set SPLICE_F_NONBLOCK for the next call to splice(). If
splice() was blocked waiting on data from the input FIFO, after SIGINT splice()
restarts with the same arguments (no SPLICE_F_NONBLOCK) and blocks again instead
of returning -EAGAIN when no data is available.

This differs from the splice() behavior when reading from a vsocket or when
we're doing a traditional read()/write() loop (trace-cmd's --nosplice argument).

With this patch applied we get the same behavior in all situations after setting
O_NONBLOCK which also matches the behavior of doing a read()/write() loop
instead of splice().

This change does have potential of breaking users who don't expect EAGAIN from
splice() when SPLICE_F_NONBLOCK is not set. OTOH programs that set O_NONBLOCK
and don't anticipate EAGAIN are arguably buggy[2].

[1] https://github.com/skaslev/trace-cmd/tree/vsock
[2] https://github.com/torvalds/linux/blob/d47e3da1759230e394096fd742aad423c291ba48/fs/read_write.c#L1425

Signed-off-by: Slavomir Kaslev <kaslevs@vmware.com>
---
 fs/splice.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index de2ede048473..6a1761b74f8d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1123,6 +1123,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (ipipe == opipe)
 			return -EINVAL;
 
+		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
 
@@ -1148,6 +1151,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (unlikely(ret < 0))
 			return ret;
 
+		if (in->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		file_start_write(out);
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
@@ -1172,6 +1178,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 			offset = in->f_pos;
 		}
 
+		if (out->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
 		if (!ret)
@@ -1717,6 +1726,9 @@ static long do_tee(struct file *in, struct file *out, size_t len,
 	 * copying the data.
 	 */
 	if (ipipe && opipe && ipipe != opipe) {
+		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		/*
 		 * Keep going, unless we encounter an error. The ipipe/opipe
 		 * ordering doesn't really matter.
-- 
2.19.1

