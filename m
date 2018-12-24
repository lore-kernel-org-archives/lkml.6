Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC1C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7EB21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d+91/6R+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d+91/6R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLXNHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:07:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbeLXNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:07:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C986B605A5; Mon, 24 Dec 2018 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545656822;
        bh=sIfV891+hw517QaoppaUN0xrQwbhK4uwlQ2erLrWpEs=;
        h=From:To:Cc:Subject:Date:From;
        b=d+91/6R+UGj9DcZreclAIt19cMFjWZ1X74jrdS22QjiG1uoKdxig08n/KjKIeogDz
         QTz6EgesoRclm9x+F+pTQKX1Q2lclJKc0g2VHwA4zI2CGw6ZTehOHL8xiAOYlQzHuP
         W4CoiQeD9PMKn/02td+lt8a3c50us6owObtre5Hs=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61BE3607CA;
        Mon, 24 Dec 2018 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545656822;
        bh=sIfV891+hw517QaoppaUN0xrQwbhK4uwlQ2erLrWpEs=;
        h=From:To:Cc:Subject:Date:From;
        b=d+91/6R+UGj9DcZreclAIt19cMFjWZ1X74jrdS22QjiG1uoKdxig08n/KjKIeogDz
         QTz6EgesoRclm9x+F+pTQKX1Q2lclJKc0g2VHwA4zI2CGw6ZTehOHL8xiAOYlQzHuP
         W4CoiQeD9PMKn/02td+lt8a3c50us6owObtre5Hs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61BE3607CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix use-after-free issue with sbi->stat_info
Date:   Mon, 24 Dec 2018 18:36:52 +0530
Message-Id: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() on sbi->node_inode can update sbi->stat_info
in the below context, if the f2fs_write_checkpoint()
has failed with error.

f2fs_balance_fs_bg+0x1ac/0x1ec
f2fs_write_node_pages+0x4c/0x260
do_writepages+0x80/0xbc
__writeback_single_inode+0xdc/0x4ac
writeback_single_inode+0x9c/0x144
write_inode_now+0xc4/0xec
iput+0x194/0x22c
f2fs_put_super+0x11c/0x1e8
generic_shutdown_super+0x70/0xf4
kill_block_super+0x2c/0x5c
kill_f2fs_super+0x44/0x50
deactivate_locked_super+0x60/0x8c
deactivate_super+0x68/0x74
cleanup_mnt+0x40/0x78

Fix this by moving f2fs_destroy_stats() further below iput().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e184ad4e..df41a3a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1058,9 +1058,6 @@ static void f2fs_put_super(struct super_block *sb)
 		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-	/* f2fs_write_checkpoint can update stat informaion */
-	f2fs_destroy_stats(sbi);
-
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
@@ -1080,6 +1077,12 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
 
+	/*
+	 * iput() can update stat information, if f2fs_write_checkpoint()
+	 * above failed with error.
+	 */
+	f2fs_destroy_stats(sbi);
+
 	/* destroy f2fs internal modules */
 	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_segment_manager(sbi);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

