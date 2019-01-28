Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58613C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206BE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693139;
	bh=9CW1jHP1+fXCRtdVo8AeabgMBAMwavZinzhqf6gsV8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mt0UAAww+W3veJLEkHwuDN8sipDn6K2lA/GMcYtQX+IAl4zFJ8hDX+JtnZ5080/T6
	 LrcJoB1AvgVHMGCOJ4dPLPbyjVqc5vKOvcFkBjW+AXdGCQykPR3HXKM09SejmMySlQ
	 iZIb9GTipvOhoysw05NujcOenp8+y4vvBkeWpwPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbfA1QcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390287AbfA1Q0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6162175B;
        Mon, 28 Jan 2019 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692807;
        bh=9CW1jHP1+fXCRtdVo8AeabgMBAMwavZinzhqf6gsV8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDQrUL/7M4Fl2J999L79bdWT/bqpm8NRfTN3VOzjM9ywzmAu0fYOq6p9pP849R/Ho
         9e5SEi15WfCRg4qbC2x3SrGz22zlZ6wvmexbr1OVt31/dpQOA44IX34UvWUohkKrUY
         PvtJgJOkPyMRGI7Sw31ozpc3fbq4EVQcRryFknUk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunlei He <heyunlei@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 3.18 16/61] f2fs: move dir data flush to write checkpoint process
Date:   Mon, 28 Jan 2019 11:25:38 -0500
Message-Id: <20190128162623.59854-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
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
index 8e68bb64f835..c4ba75acc6e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -153,6 +153,9 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	trace_f2fs_sync_file_enter(inode);
 
+	if (S_ISDIR(inode->i_mode))
+		goto go_write;
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(fi, FI_NEED_IPU);
-- 
2.19.1

