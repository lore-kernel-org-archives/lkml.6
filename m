Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91DFC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8165A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498570;
	bh=UWH2TC2pRDdl9d3AqWLosnPdQ2oaKAxu+4cL3c0jQu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErF4c8w9cQcV4iggOTwyVMWuL0WHPeDUPPXLQCq0ICCHt+zvp2XO44PU7NSSGbZID
	 TfP/avTSyJGMmCgF4x4YdrfvOzYJnmW6NrUhK1+OZ/ehOvTx/scdnkaCX/8toOlwjS
	 9o55zU+zYCG9sme5mJvJMWj5Y3YVv1FI1cpdXZUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbfBROCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbfBROCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77E9E2070D;
        Mon, 18 Feb 2019 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498566;
        bh=UWH2TC2pRDdl9d3AqWLosnPdQ2oaKAxu+4cL3c0jQu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+L1O2/n9JBfxhHklLQwKyAQHBPKEoOqX7Dqv8/wiy2tu1oFaJ6I2/yFXRI4YUGG2
         ZEY6ktJSPA/5xzS/ICRISRBW1cCh/xjLnqzFGE0i5sJMZJUQ5KiGFs6Y83uq+8hUn9
         mBZ0wqBdJF+uPQf8ASx69FHWtehcAju1uAIEtFpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/143] f2fs: move dir data flush to write checkpoint process
Date:   Mon, 18 Feb 2019 14:42:25 +0100
Message-Id: <20190218133529.788746982@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b61ac5b720146c619c7cdf17eff2551b934399e5 ]

This patch move dir data flush to write checkpoint process, by
doing this, it may reduce some time for dir fsync.

pre:
	-f2fs_do_sync_file enter
		-file_write_and_wait_range  <- flush & wait
		-write_checkpoint
			-do_checkpoint	    <- wait all
	-f2fs_do_sync_file exit

now:
	-f2fs_do_sync_file enter
		-write_checkpoint
			-block_operations   <- flush dir & no wait
			-do_checkpoint	    <- wait all
	-f2fs_do_sync_file exit

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 96bfd9f0ea02..bee3bc7a16ac 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -200,6 +200,9 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	trace_f2fs_sync_file_enter(inode);
 
+	if (S_ISDIR(inode->i_mode))
+		goto go_write;
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(fi, FI_NEED_IPU);
-- 
2.19.1



