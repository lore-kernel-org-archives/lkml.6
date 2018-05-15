Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeEOKLv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:11:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26336 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeEOKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:11:49 -0400
Subject: [PATCH] hfsplus: stop workqueue when fill_super() failed
To: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
References: <089e08e567a5b24ae90568bb75d6@google.com>
Cc: akpm@linux-foundation.org, dhowells@redhat.com,
        ernesto.mnd.fernandez@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp>
Date: Tue, 15 May 2018 19:11:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <089e08e567a5b24ae90568bb75d6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From ffd64dcf946502e7bb1d23c021ee9a4fc92f9312 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 15 May 2018 12:23:03 +0900
Subject: [PATCH] hfsplus: stop workqueue when fill_super() failed

syzbot is reporting ODEBUG messages at hfsplus_fill_super() [1].
This is because hfsplus_fill_super() forgot to call
cancel_delayed_work_sync().

As far as I can see, it is hfsplus_mark_mdb_dirty() from
hfsplus_new_inode() in hfsplus_fill_super() that calls
queue_delayed_work(). Therefore, I assume that hfsplus_new_inode() does not
fail if queue_delayed_work() was called, and the out_put_hidden_dir label
is the appropriate location to call cancel_delayed_work_sync().

[1] https://syzkaller.appspot.com/bug?id=a66f45e96fdbeb76b796bf46eb25ea878c42a6c9

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hfsplus/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 9e690ae..80abba5 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -590,6 +590,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_put_hidden_dir:
+	cancel_delayed_work_sync(&sbi->sync_work);
 	iput(sbi->hidden_dir);
 out_put_root:
 	dput(sb->s_root);
-- 
1.8.3.1
