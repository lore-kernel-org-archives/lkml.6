Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9967D25386
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9967D25386
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031866AbeGAQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031787AbeGAQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AAFEBAA6;
        Sun,  1 Jul 2018 16:40:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+ec3986119086fe4eec97@syzkaller.appspotmail.com>,
        John Muir <john@jmuir.com>, Csaba Henk <csaba@gluster.com>,
        Anand Avati <avati@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.17 042/220] fuse: dont keep dead fuse_conn at fuse_fill_super().
Date:   Sun,  1 Jul 2018 18:21:06 +0200
Message-Id: <20180701160910.085400391@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 543b8f8662fe6d21f19958b666ab0051af9db21a upstream.

syzbot is reporting use-after-free at fuse_kill_sb_blk() [1].
Since sb->s_fs_info field is not cleared after fc was released by
fuse_conn_put() when initialization failed, fuse_kill_sb_blk() finds
already released fc and tries to hold the lock. Fix this by clearing
sb->s_fs_info field after calling fuse_conn_put().

[1] https://syzkaller.appspot.com/bug?id=a07a680ed0a9290585ca424546860464dd9658db

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ec3986119086fe4eec97@syzkaller.appspotmail.com>
Fixes: 3b463ae0c626 ("fuse: invalidation reverse calls")
Cc: John Muir <john@jmuir.com>
Cc: Csaba Henk <csaba@gluster.com>
Cc: Anand Avati <avati@redhat.com>
Cc: <stable@vger.kernel.org> # v2.6.31
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1179,6 +1179,7 @@ static int fuse_fill_super(struct super_
 	fuse_dev_free(fud);
  err_put_conn:
 	fuse_conn_put(fc);
+	sb->s_fs_info = NULL;
  err_fput:
 	fput(file);
  err:


