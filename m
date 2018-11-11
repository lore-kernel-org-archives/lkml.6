Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A79C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B45208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B45208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeKLG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:28:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49568 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729532AbeKLFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:08 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000l8-AX; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Us-Nl; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Miklos Szeredi" <mszeredi@redhat.com>,
        "syzbot" <syzbot+ec3986119086fe4eec97@syzkaller.appspotmail.com>,
        "Anand Avati" <avati@redhat.com>, "Csaba Henk" <csaba@gluster.com>,
        "John Muir" <john@jmuir.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.919103908@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/366] fuse: don't keep dead fuse_conn at
 fuse_fill_super().
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1125,6 +1125,7 @@ static int fuse_fill_super(struct super_
  err_put_conn:
 	fuse_bdi_destroy(fc);
 	fuse_conn_put(fc);
+	sb->s_fs_info = NULL;
  err_fput:
 	fput(file);
  err:

