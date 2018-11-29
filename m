Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5321104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8b7p9lF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeK3BT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2915521019;
        Thu, 29 Nov 2018 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500866;
        bh=JJslii7tyNDQU4GMj5TtH7jMVIHsLFvplym59Dc5fPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8b7p9lFIP8rmeCtPBTpQgLohsSvuZAY58U+dCqu9KP4pa/Eh6hMju9UPWDJfGQVe
         DIxCEAcTc63ltXgFHRSUwilWdXmYhvYDBO5REqGaJ4s1qIy40gSRZnvxv4tztlEGgy
         2oMAOcr5QzqLA7ZsC3CyhnlUpyQnGjYjGZz3MzLI=
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
Subject: [PATCH 3.18 03/83] bfs: add sanity check at bfs_fill_super()
Date:   Thu, 29 Nov 2018 15:11:21 +0100
Message-Id: <20181129140138.222548542@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -349,7 +349,8 @@ static int bfs_fill_super(struct super_b
 
 	s->s_magic = BFS_MAGIC;
 
-	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end)) {
+	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
+	    le32_to_cpu(bfs_sb->s_start) < BFS_BSIZE) {
 		printf("Superblock is corrupted\n");
 		goto out1;
 	}
@@ -358,9 +359,11 @@ static int bfs_fill_super(struct super_b
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
 


