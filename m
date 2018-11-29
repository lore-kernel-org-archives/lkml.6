Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E4A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="klbOWp1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E4A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbeK3CHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbeK3BXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0E0208E7;
        Thu, 29 Nov 2018 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501084;
        bh=ICTylHP/XZIiWhY7b/M9Evh6H8xIdUeCXumnl4B1Nxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klbOWp1w71GrTxzOO1SlPRcV41VRpTzraJF46Ieyf8LDF66XKQU6yEt0MHvdGHfUU
         ZHtzgaeDFeuwd92GlsiBABDeS77aHZqUI1b4tZBWxb/mTBSNIzJ7dZHlK2HpX8Zydx
         ZD3ZObT2yy8mAO+F3PdSUYq18s91KtpkyPqnQnbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tigran Aivazian <aivazian.tigran@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 06/86] bfs: add sanity check at bfs_fill_super()
Date:   Thu, 29 Nov 2018 15:11:31 +0100
Message-Id: <20181129140110.438088150@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 9f2df09a33aa2c76ce6385d382693f98d7f2f07e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/bfs/inode.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -350,7 +350,8 @@ static int bfs_fill_super(struct super_b
 
 	s->s_magic = BFS_MAGIC;
 
-	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end)) {
+	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
+	    le32_to_cpu(bfs_sb->s_start) < BFS_BSIZE) {
 		printf("Superblock is corrupted\n");
 		goto out1;
 	}
@@ -359,9 +360,11 @@ static int bfs_fill_super(struct super_b
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
 


