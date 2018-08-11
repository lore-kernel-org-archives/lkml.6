Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E7EC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5C821AA9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp3B/jrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5C821AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeHKSRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeHKSRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:17:34 -0400
Received: from localhost.localdomain (unknown [49.77.226.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DBE821AA7;
        Sat, 11 Aug 2018 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534002178;
        bh=z4EkJbflWfaAxKMXiZ79k8gMGWD3Tnqmvb/hsDud/H0=;
        h=From:To:Cc:Subject:Date:From;
        b=Gp3B/jrE59+iFK5zj3rufjofER8Y39WtZSynS4K18RSi0eBRJE9dAbnOVZ10y+EX6
         w9FGN/KpiUIocewcDPjetwCMjm8Omj+T0G367SZQ4Z8Yh6xff1XAccNIGN+9IlJWRD
         mFHBer4HNZni43M00ogT/iQZJ6rPVT3XstSyDhbI=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to skip verifying block address for non-regular inode
Date:   Sat, 11 Aug 2018 23:42:09 +0800
Message-Id: <20180811154209.2985-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

generic/184 1s ... [failed, exit status 1]- output mismatch
    --- tests/generic/184.out	2015-01-11 16:52:27.643681072 +0800
     QA output created by 184 - silence is golden
    +rm: cannot remove '/mnt/f2fs/null': Bad address
    +mknod: '/mnt/f2fs/null': Bad address
    +chmod: cannot access '/mnt/f2fs/null': Bad address
    +./tests/generic/184: line 36: /mnt/f2fs/null: Bad address
    ...

F2FS-fs (zram0): access invalid blkaddr:259
EIP: f2fs_is_valid_blkaddr+0x14b/0x1b0 [f2fs]
 f2fs_iget+0x927/0x1010 [f2fs]
 f2fs_lookup+0x26e/0x630 [f2fs]
 __lookup_slow+0xb3/0x140
 lookup_slow+0x31/0x50
 walk_component+0x185/0x1f0
 path_lookupat+0x51/0x190
 filename_lookup+0x7f/0x140
 user_path_at_empty+0x36/0x40
 vfs_statx+0x61/0xc0
 __do_sys_stat64+0x29/0x40
 sys_stat64+0x13/0x20
 do_fast_syscall_32+0xaa/0x22c
 entry_SYSENTER_32+0x53/0x86

In f2fs_iget(), we will check inode's first block address, if it is valid,
we will set FI_FIRST_BLOCK_WRITTEN flag in inode.

But we should only do this for regular inode, otherwise, like special
inode, i_addr[0] is used for storing device info instead of block address,
it will fail checking flow obviously.

So for non-regular inode, let's skip verifying address and setting flag.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 44e7689dcf3e..d80d6d5c7d43 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -371,13 +371,15 @@ static int do_read_inode(struct inode *inode)
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
-	err = __written_first_block(sbi, ri);
-	if (err < 0) {
-		f2fs_put_page(node_page, 1);
-		return err;
+	if (S_ISREG(inode->i_mode)) {
+		err = __written_first_block(sbi, ri);
+		if (err < 0) {
+			f2fs_put_page(node_page, 1);
+			return err;
+		}
+		if (!err)
+			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 	}
-	if (!err)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
-- 
2.18.0

