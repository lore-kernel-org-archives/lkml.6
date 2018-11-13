Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A380C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F16223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBLNOgPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F16223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbeKMPtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733145AbeKMPtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:20 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB60822524;
        Tue, 13 Nov 2018 05:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088373;
        bh=QAT9fTD95TS5jamSpFERc++ey7kIJucfRfG8yO8dfck=;
        h=From:To:Cc:Subject:Date:From;
        b=YBLNOgPfeSadUJUV/dvyJ7s2elS2ukBj05Bp8ycmT7dhKU0ob1KHM7LgXn+Ns19ie
         U79GWhN7IddUMuzzAbKXnMsqbfCU19m2FmwKBToPszRrQE/oP6+U/vWSKs81jjRrDp
         5ez9ck4lTWr+q1uG6FLcINCogsY4mWlCO9M2cAoo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tigran Aivazian <aivazian.tigran@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 1/9] bfs: add sanity check at bfs_fill_super()
Date:   Tue, 13 Nov 2018 00:52:44 -0500
Message-Id: <20181113055252.79406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 9f2df09a33aa2c76ce6385d382693f98d7f2f07e ]

syzbot is reporting too large memory allocation at bfs_fill_super() [1].
Since file system image is corrupted such that bfs_sb->s_start == 0,
bfs_fill_super() is trying to allocate 8MB of continuous memory. Fix
this by adding a sanity check on bfs_sb->s_start, __GFP_NOWARN and
printf().

[1] https://syzkaller.appspot.com/bug?id=16a87c236b951351374a84c8a32f40edbc034e96

Link: http://lkml.kernel.org/r/1525862104-3407-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/bfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 90bc079d9982..0ee38b284ad7 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -349,7 +349,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 
 	s->s_magic = BFS_MAGIC;
 
-	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end)) {
+	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
+	    le32_to_cpu(bfs_sb->s_start) < BFS_BSIZE) {
 		printf("Superblock is corrupted\n");
 		goto out1;
 	}
@@ -358,9 +359,11 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 					sizeof(struct bfs_inode)
 					+ BFS_ROOT_INO - 1;
 	imap_len = (info->si_lasti / 8) + 1;
-	info->si_imap = kzalloc(imap_len, GFP_KERNEL);
-	if (!info->si_imap)
+	info->si_imap = kzalloc(imap_len, GFP_KERNEL | __GFP_NOWARN);
+	if (!info->si_imap) {
+		printf("Cannot allocate %u bytes\n", imap_len);
 		goto out1;
+	}
 	for (i = 0; i < BFS_ROOT_INO; i++)
 		set_bit(i, info->si_imap);
 
-- 
2.17.1

