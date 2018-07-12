Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B85EA81CB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FA920BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/RaWb4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FA920BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeGLSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeGLSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:10:53 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628B820BF2;
        Thu, 12 Jul 2018 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531418415;
        bh=zFa7RrowQiTQdU6+PKVV+DslZdmsJuvekHF8TO1bghw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/RaWb4lX7VL9xXZgOFuqRGFhsJ/pW03/DCvJ7/P/8acL7eDv4Ar/W58ZcTpY+6oW
         R+1JQlyKsoII+eN+JrZBs4KIAFCiYrL1jwOQ+IdP9KIQefKMNRmswxPnGr7JaL/NgU
         3WKLuKf5PsosjXOPGQW0XHYhHyEKd0WbgLvFPk6w=
Date:   Thu, 12 Jul 2018 10:59:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev v2] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
Message-ID: <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes to support dio having unaligned buffers as buffered writes.

xfs_io -f -d -c "pwrite 0 512" $testfile
 -> okay

xfs_io -f -d -c "pwrite 1 512" $testfile
 -> EINVAL

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2 from v1:
 - return error depending on sector size

 fs/f2fs/data.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..5e53d210e222 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2371,14 +2371,20 @@ static int f2fs_write_end(struct file *file,
 static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 			   loff_t offset)
 {
-	unsigned blocksize_mask = inode->i_sb->s_blocksize - 1;
-
-	if (offset & blocksize_mask)
-		return -EINVAL;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		return -EINVAL;
-
+	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned blkbits = i_blkbits;
+	unsigned blocksize_mask = (1 << blkbits) - 1;
+	unsigned long align = offset | iov_iter_alignment(iter);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+
+	if (align & blocksize_mask) {
+		if (bdev)
+			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+		blocksize_mask = (1 << blkbits) - 1;
+		if (align & blocksize_mask)
+			return -EINVAL;
+		return 1;
+	}
 	return 0;
 }
 
@@ -2396,7 +2402,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
-		return err;
+		return err < 0 ? err : 0;
 
 	if (f2fs_force_buffered_io(inode, rw))
 		return 0;
-- 
2.17.0.441.gb46fe60e1d-goog

