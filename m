Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeDFMFu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:05:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24110 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeDFMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:05:49 -0400
Subject: Re: INFO: task hung in lo_ioctl
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@fb.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>, shli@fb.com,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Nikanth Karthikesan <knikanth@suse.de>
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
 <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
Date: Fri, 6 Apr 2018 21:04:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/04/05 0:23, Tetsuo Handa wrote:
> This seems to be an AB-BA deadlock where the lockdep cannot report (due to use of nested lock?).
> What is happening here?
> 

This patch does not directly fix the bug syzbot is reporting, but could be relevant.
Maybe try replacing mutex_lock_killable_nested() with mutex_lock_killable() and
check what the lockdep will say?



>From 0b006d536b2e439f347eb857e482fc304e84fd1d Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 6 Apr 2018 20:52:10 +0900
Subject: [PATCH] block/loop: fix lock imbalance bug at lo_ioctl

Commit 2d1d4c1e591fd40b ("loop: don't call into filesystem while holding
lo_ctl_mutex") introduced mutex lock imbalance bug where syzbot would
trigger. The caller of loop_get_status64() assumes that mutex_unlock() is
already called by loop_get_status() but loop_get_status64() does not
always call loop_get_status().

Commit f028f3b2f987ebc6 ("loop: fix circular locking in loop_clr_fd()")
also dropped the mutex for deadlock avoidance reason. But we should
recheck whether we have to drop the mutex. Dropping the mutex at the
middle of an ioctl() request is not nice, but syzbot is reporting a
deadlock inside loop_reread_partitions() which is called by loop_set_fd()
and loop_change_fd().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 2d1d4c1e591fd40b ("loop: don't call into filesystem while holding lo_ctl_mutex")
Cc: Omar Sandoval <osandov@fb.com>
Cc: Nikanth Karthikesan <knikanth@suse.de>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/block/loop.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 264abaa..64033e7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1362,7 +1362,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 
 	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
 	if (err)
-		goto out_unlocked;
+		return err;
 
 	switch (cmd) {
 	case LOOP_SET_FD:
@@ -1372,10 +1372,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		err = loop_change_fd(lo, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		/* loop_clr_fd would have unlocked lo_ctl_mutex on success */
 		err = loop_clr_fd(lo);
-		if (!err)
-			goto out_unlocked;
 		break;
 	case LOOP_SET_STATUS:
 		err = -EPERM;
@@ -1385,8 +1382,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1395,8 +1391,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1415,9 +1410,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&lo->lo_ctl_mutex);
-
-out_unlocked:
+	/* Temporary hack for handling lock imbalance. */
+	if (__mutex_owner(&lo->lo_ctl_mutex) == current)
+		mutex_unlock(&lo->lo_ctl_mutex);
 	return err;
 }
 
-- 
1.8.3.1
