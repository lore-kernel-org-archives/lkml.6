Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDJKzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:55:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:30787 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeDJKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:55:15 -0400
Subject: Re: INFO: task hung in __blkdev_get
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Vyukov <dvyukov@google.com>, Ming Lei <tom.leiming@gmail.com>,
        mingo@redhat.com, peterz@infradead.org,
        syzbot
        <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Omar Sandoval <osandov@fb.com>
References: <f403043a9be410acd1055fe5f72e@google.com>
 <652eab47-81b5-3249-3c78-427eeec45fbc@I-love.SAKURA.ne.jp>
 <2e093801-6d71-6747-42df-52f191811ad0@I-love.SAKURA.ne.jp>
 <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <59a08949-7e2f-42ff-edda-f24a6c624551@I-love.SAKURA.ne.jp>
Date: Tue, 10 Apr 2018 19:55:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since syzbot is reporting so many hung up bug which involves /dev/loopX ,
is it possible to "temporarily" apply below patch for testing under syzbot
( after "block/loop: fix deadlock after loop_set_status" and
"loop: fix LOOP_GET_STATUS lock imbalance" in linux-block.git#for-linus
are merged into linux.git )?

I haven't got a smoking gun by lockdep, but I noticed that

  [upstream] INFO: task hung in lo_open (2)
  https://syzkaller.appspot.com/bug?id=1f93b57f496d969efb9fb24167f6f9de5ee068fd

contained "lo->lo_ctl_mutex => bdev->bd_mutex" locking order

  2 locks held by syz-executor6/15084:
   #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000cc154b8d>] lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
   #1:  (&bdev->bd_mutex){+.+.}, at: [<0000000058b7c5b5>] blkdev_reread_part+0x1e/0x40 block/ioctl.c:192

while commit f028f3b2f987ebc6 ("loop: fix circular locking in loop_clr_fd()")
says that

  * Calling fput holding lo_ctl_mutex triggers a circular
  * lock dependency possibility warning as fput can take
  * bd_mutex which is usually taken before lo_ctl_mutex.

which implies that the locking order should be "bdev->bd_mutex => lo->lo_ctl_mutex"
and also says that use of "_nested" version might mask some other real bugs
which could be the bug syzbot is frequently reporting as hung tasks...

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 264abaa..5559b15 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1360,7 +1360,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable(&lo->lo_ctl_mutex);
 	if (err)
 		goto out_unlocked;
 
