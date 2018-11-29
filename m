Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB395C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9522133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU6Yrwih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9522133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeK2REU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeK2RET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:19 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250052133F;
        Thu, 29 Nov 2018 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471208;
        bh=r5NdYZc29/u2tP7cREPgP6768x9pRFyKpQDS/MKWgfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IU6Yrwihy5+wMzhwccwnyFd0R5lPjVlAKzpTY3yFMb978s+S4tDvTIxRXeRr95v94
         4HJhD5TPlEOs7j1XIzUFUBRg84zSONWB4SCCthqxwOD400V58Uxb3wsKS2Ke36Zxxb
         sDC/DBd8uX20QxmSebPrRiJhPFN0l7vh44S5tm7s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 53/68] iomap: dio data corruption and spurious errors when pipes fill
Date:   Thu, 29 Nov 2018 00:55:44 -0500
Message-Id: <20181129055559.159228-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 4721a6010990971440b4ffefbdf014976b8eda2f ]

When doing direct IO to a pipe for do_splice_direct(), then pipe is
trivial to fill up and overflow as it can only hold 16 pages. At
this point bio_iov_iter_get_pages() then returns -EFAULT, and we
abort the IO submission process. Unfortunately, iomap_dio_rw()
propagates the error back up the stack.

The error is converted from the EFAULT to EAGAIN in
generic_file_splice_read() to tell the splice layers that the pipe
is full. do_splice_direct() completely fails to handle EAGAIN errors
(it aborts on error) and returns EAGAIN to the caller.

copy_file_write() then completely fails to handle EAGAIN as well,
and so returns EAGAIN to userspace, having failed to copy the data
it was asked to.

Avoid this whole steaming pile of fail by having iomap_dio_rw()
silently swallow EFAULT errors and so do short reads.

To make matters worse, iomap_dio_actor() has a stale data exposure
bug bio_iov_iter_get_pages() fails - it does not zero the tail block
that it may have been left uncovered by partial IO. Fix the error
handling case to drop to the sub-block zeroing rather than
immmediately returning the -EFAULT error.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 82e35265679d..e2e4a1154c90 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1581,7 +1581,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
-	int nr_pages, ret;
+	int nr_pages, ret = 0;
 	size_t copied = 0;
 
 	if ((pos | length | align) & ((1 << blkbits) - 1))
@@ -1646,8 +1646,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		ret = bio_iov_iter_get_pages(bio, &iter);
 		if (unlikely(ret)) {
+			/*
+			 * We have to stop part way through an IO. We must fall
+			 * through to the sub-block tail zeroing here, otherwise
+			 * this short IO may expose stale data in the tail of
+			 * the block we haven't written data to.
+			 */
 			bio_put(bio);
-			return copied ? copied : ret;
+			goto zero_tail;
 		}
 
 		n = bio->bi_iter.bi_size;
@@ -1684,6 +1690,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	 * the block tail in the latter case, we can expose stale data via mmap
 	 * reads of the EOF block.
 	 */
+zero_tail:
 	if (need_zeroout ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
@@ -1691,7 +1698,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		if (pad)
 			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
 	}
-	return copied;
+	return copied ? copied : ret;
 }
 
 static loff_t
@@ -1866,6 +1873,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				dio->wait_for_completion = true;
 				ret = 0;
 			}
+
+			/*
+			 * Splicing to pipes can fail on a full pipe. We have to
+			 * swallow this to make it look like a short IO
+			 * otherwise the higher splice layers will completely
+			 * mishandle the error and stop moving data.
+			 */
+			if (ret == -EFAULT)
+				ret = 0;
 			break;
 		}
 		pos += ret;
-- 
2.17.1

