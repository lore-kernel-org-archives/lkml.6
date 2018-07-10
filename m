Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE01FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4BA2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4BA2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbeGJSd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbeGJSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E612CE3D;
        Tue, 10 Jul 2018 18:33:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 37/53] f2fs: truncate preallocated blocks in error case
Date:   Tue, 10 Jul 2018 20:25:13 +0200
Message-Id: <20180710182500.923996959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit dc7a10ddee0c56c6d891dd18de5c4ee9869545e0 upstream.

If write is failed, we must deallocate the blocks that we couldn't write.

Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/file.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2694,11 +2694,16 @@ static ssize_t f2fs_file_write_iter(stru
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
+		bool preallocated = false;
+		size_t target_size = 0;
 		int err;
 
 		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
 			set_inode_flag(inode, FI_NO_PREALLOC);
 
+		preallocated = true;
+		target_size = iocb->ki_pos + iov_iter_count(from);
+
 		err = f2fs_preallocate_blocks(iocb, from);
 		if (err) {
 			clear_inode_flag(inode, FI_NO_PREALLOC);
@@ -2710,6 +2715,10 @@ static ssize_t f2fs_file_write_iter(stru
 		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
+		/* if we couldn't write data, we should deallocate blocks. */
+		if (preallocated && i_size_read(inode) < target_size)
+			f2fs_truncate(inode);
+
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}


