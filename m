Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDDPZG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:25:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56271 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeDDPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:25:04 -0400
Subject: Re: INFO: task hung in lo_ioctl
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        shli@fb.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
 <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 00:23:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be an AB-BA deadlock where the lockdep cannot report (due to use of nested lock?).

When PID=6540 was (reported as hung) at mutex_lock_nested(&lo->lo_ctl_mutex, 1) (id=43ca8836),
it was already holding down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING) (id=566d4c39).
But when PID=6541 was (which would have been reported as hung if sysctl_hung_task_panic
were not set) at down_read(&sb->s_umount) (id=566d4c39), it was already holding
mutex_lock_nested(&lo->lo_ctl_mutex, 1) (id=43ca8836).

----------------------------------------
INFO: task syz-executor0:6540 blocked for more than 120 seconds.
      Not tainted 4.16.0+ #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D23560  6540   4521 0x80000004
Call Trace:
 context_switch kernel/sched/core.c:2848 [inline]
 __schedule+0x8fb/0x1ef0 kernel/sched/core.c:3490
 schedule+0xf5/0x430 kernel/sched/core.c:3549
 schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3607
 __mutex_lock_common kernel/locking/mutex.c:833 [inline]
 __mutex_lock+0xb7f/0x1810 kernel/locking/mutex.c:893
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
 lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0x1759/0x1e00 block/ioctl.c:601
 ioctl_by_bdev+0xa5/0x110 fs/block_dev.c:2060
 isofs_get_last_session fs/isofs/inode.c:567 [inline]
 isofs_fill_super+0x2ba9/0x3bc0 fs/isofs/inode.c:660
 mount_bdev+0x2b7/0x370 fs/super.c:1119
 isofs_mount+0x34/0x40 fs/isofs/inode.c:1560
 mount_fs+0x66/0x2d0 fs/super.c:1222

2 locks held by syz-executor0/6540:
 #0: 00000000566d4c39 (&type->s_umount_key#49/1){+.+.}, at: alloc_super fs/super.c:211 [inline]
 #0: 00000000566d4c39 (&type->s_umount_key#49/1){+.+.}, at: sget_userns+0x3b2/0xe60 fs/super.c:502 /* down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING); */
 #1: 0000000043ca8836 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
3 locks held by syz-executor7/6541:
 #0: 0000000043ca8836 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
 #1: 000000007bf3d3f9 (&bdev->bd_mutex){+.+.}, at: blkdev_reread_part+0x1e/0x40 block/ioctl.c:192
 #2: 00000000566d4c39 (&type->s_umount_key#50){.+.+}, at: __get_super.part.10+0x1d3/0x280 fs/super.c:663 /* down_read(&sb->s_umount); */
----------------------------------------

sget() is using down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING)
with a comment block asserting that there is no risk of deadlock

	/*
	 * sget() can have s_umount recursion.
	 *
	 * When it cannot find a suitable sb, it allocates a new
	 * one (this one), and tries again to find a suitable old
	 * one.
	 *
	 * In case that succeeds, it will acquire the s_umount
	 * lock of the old one. Since these are clearly distrinct
	 * locks, and this object isn't exposed yet, there's no
	 * risk of deadlocks.
	 *
	 * Annotate this by putting this lock in a different
	 * subclass.
	 */

but this object (id=566d4c39) is already locked by other thread.
What is happening here?
