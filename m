Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C22C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49520661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957552;
	bh=ft8DRid6rnd4mPWKOrK5EQ/1DxC1Prx6Lwjqmc6xAMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TyjdWowk494mYuNDIo2yg3pUt500G67hnAki0oTZzaFsE7LnoeKFI2gJHa+CZSI+e
	 jDEDib6HAs9jo9otFoypXXV8MAp8KmovJFnCgnekpgiRYAS3Za9pd4ysj74yXaae+O
	 ruhxAnd52cTJK0SpKdOoZSxIIA5O4VD/dDiYdDEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfBWVFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfBWVFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C06720657;
        Sat, 23 Feb 2019 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955915;
        bh=ft8DRid6rnd4mPWKOrK5EQ/1DxC1Prx6Lwjqmc6xAMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVGhzOUky3w32UgLt7SXesILbcoFy2+bKaQ1jO7xJNk+aVJ2HIVlfZlFU5ZSqoBAB
         qt/HQ/+2bSsxqnZNLCyHwNivj8inpcWPf0Sps3sQKvA9+iOd1jzORgEdPWWgIFN7Il
         TI2q+jXflfEtZumDRh5vAjeI8qLAH1onQLWvnpkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 30/72] iomap: fix a use after free in iomap_dio_rw
Date:   Sat, 23 Feb 2019 16:03:40 -0500
Message-Id: <20190223210422.199966-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4ea899ead2786a30aaa8181fefa81a3df4ad28f6 ]

Introduce a local wait_for_completion variable to avoid an access to the
potentially freed dio struture after dropping the last reference count.

Also use the chance to document the completion behavior to make the
refcounting clear to the reader of the code.

Fixes: ff6a9292e6 ("iomap: implement direct I/O")
Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Chandan Rajendra <chandan@linux.ibm.com>
Tested-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 7793e9e42ad57..83d9a196fe3e1 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1806,6 +1806,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos, start = pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
+	bool wait_for_completion = is_sync_kiocb(iocb);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
@@ -1825,7 +1826,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->end_io = end_io;
 	dio->error = 0;
 	dio->flags = 0;
-	dio->wait_for_completion = is_sync_kiocb(iocb);
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
@@ -1880,7 +1880,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
 
-	if (iov_iter_rw(iter) == WRITE && !dio->wait_for_completion &&
+	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
@@ -1896,7 +1896,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
-				dio->wait_for_completion = true;
+				wait_for_completion = true;
 				ret = 0;
 			}
 			break;
@@ -1918,8 +1918,24 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
+	/*
+	 * We are about to drop our additional submission reference, which
+	 * might be the last reference to the dio.  There are three three
+	 * different ways we can progress here:
+	 *
+	 *  (a) If this is the last reference we will always complete and free
+	 *	the dio ourselves.
+	 *  (b) If this is not the last reference, and we serve an asynchronous
+	 *	iocb, we must never touch the dio after the decrement, the
+	 *	I/O completion handler will complete and free it.
+	 *  (c) If this is not the last reference, but we serve a synchronous
+	 *	iocb, the I/O completion handler will wake us up on the drop
+	 *	of the final reference, and we will complete and free it here
+	 *	after we got woken by the I/O completion handler.
+	 */
+	dio->wait_for_completion = wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!dio->wait_for_completion)
+		if (!wait_for_completion)
 			return -EIOCBQUEUED;
 
 		for (;;) {
@@ -1936,9 +1952,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		__set_current_state(TASK_RUNNING);
 	}
 
-	ret = iomap_dio_complete(dio);
-
-	return ret;
+	return iomap_dio_complete(dio);
 
 out_free_dio:
 	kfree(dio);
-- 
2.19.1

