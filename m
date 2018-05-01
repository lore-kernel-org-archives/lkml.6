Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeEAKDI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:03:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:13308 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEAKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:03:07 -0400
Subject: Re: KASAN: use-after-free Read in fuse_kill_sb_blk
To: syzbot <syzbot+ec3986119086fe4eec97@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        Anand Avati <avati@redhat.com>, Csaba Henk <csaba@gluster.com>,
        John Muir <john@jmuir.com>
References: <0000000000002aeada056b10e833@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <37d2030a-124c-9927-aa48-bb769da792cf@I-love.SAKURA.ne.jp>
Date: Tue, 1 May 2018 19:03:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000002aeada056b10e833@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 606d54cd24b5b00e7a7e3597aabbe89719defc56 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 1 May 2018 13:12:14 +0900
Subject: [PATCH] fuse: don't keep dead fuse_conn at fuse_fill_super().

syzbot is reporting use-after-free at fuse_kill_sb_blk() [1].
Since sb->s_fs_info field is not cleared after fc was released by
fuse_conn_put() when initialization failed, fuse_kill_sb_blk() finds
already released fc and tries to hold the lock. Fix this by clearing
sb->s_fs_info field after calling fuse_conn_put().

[1] https://syzkaller.appspot.com/bug?id=a07a680ed0a9290585ca424546860464dd9658db

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ec3986119086fe4eec97@syzkaller.appspotmail.com>
Fixes: 3b463ae0c6264f70 ("fuse: invalidation reverse calls")
Cc: John Muir <john@jmuir.com>
Cc: Csaba Henk <csaba@gluster.com>
Cc: Anand Avati <avati@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ef30995..9b37cf8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1179,6 +1179,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fuse_dev_free(fud);
  err_put_conn:
 	fuse_conn_put(fc);
+	sb->s_fs_info = NULL;
  err_fput:
 	fput(file);
  err:
-- 
1.8.3.1
