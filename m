Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D51820868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D51820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeICVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeICVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B2EB1CF3;
        Mon,  3 Sep 2018 16:51:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 3.18 43/56] fuse: Dont access pipe->buffers without pipe_lock()
Date:   Mon,  3 Sep 2018 18:49:33 +0200
Message-Id: <20180903164926.203528598@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit a2477b0e67c52f4364a47c3ad70902bc2a61bd4c upstream.

fuse_dev_splice_write() reads pipe->buffers to determine the size of
'bufs' array before taking the pipe_lock(). This is not safe as
another thread might change the 'pipe->buffers' between the allocation
and taking the pipe_lock(). So we end up with too small 'bufs' array.

Move the bufs allocations inside pipe_lock()/pipe_unlock() to fix this.

Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org> # v2.6.35
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1913,11 +1913,14 @@ static ssize_t fuse_dev_splice_write(str
 	if (!fc)
 		return -EPERM;
 
+	pipe_lock(pipe);
+
 	bufs = kmalloc(pipe->buffers * sizeof(struct pipe_buffer), GFP_KERNEL);
-	if (!bufs)
+	if (!bufs) {
+		pipe_unlock(pipe);
 		return -ENOMEM;
+	}
 
-	pipe_lock(pipe);
 	nbuf = 0;
 	rem = 0;
 	for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)


