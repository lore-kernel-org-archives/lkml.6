Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E755A2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693578;
	bh=HMtL02IVAJyaGrxJQsQj9MCv2tEZWouVGzwDkdpYC+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UNGRfXUdxHBfqfrLo3O3rTXebcCdzuZ1aQVVxNxmlGG+CWekCi1oyQPPA5J0Esvu0
	 Y9SCXYYUeJtx8tj6pQOuHeEhlEdFDyZnZxHzv/rMCxIvIBEjLSyjxlDRNnIHOngSvr
	 9kYutUJzxio81nLbXgDqnCbnjJTVxi2xC4Pzc48k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfA1Qjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388984AbfA1QYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F19620879;
        Mon, 28 Jan 2019 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692672;
        bh=HMtL02IVAJyaGrxJQsQj9MCv2tEZWouVGzwDkdpYC+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YswhwWKmop4un9XN4/ppoRP/6U1T+np7hMqHWA2vgJtX424bPg7mEnJ54ljm0WinW
         J0Ez/+ck65QE+ZlXrEEdWqr18pOVVFXOjdLa8rVX/C2gKK9I8ZNy6KXUCJRLQ7tn5r
         p0Hvad6HDVygNjsUxwd0EPTnqsyRCA2JxDqy491g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunlei He <heyunlei@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 20/80] f2fs: move dir data flush to write checkpoint process
Date:   Mon, 28 Jan 2019 11:23:01 -0500
Message-Id: <20190128162401.58841-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlei He <heyunlei@huawei.com>

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

