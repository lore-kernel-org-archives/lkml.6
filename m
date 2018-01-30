Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeA3XYn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:24:43 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:41547 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeA3XYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:24:41 -0500
X-Google-Smtp-Source: AH8x225Xu5iJlYWySuOJTiAiflM/FXkC599hHkaOaTNncXTNRnM0SjF7uuCUc/SBWXK62X2pyQv9pg==
Date: Tue, 30 Jan 2018 15:24:38 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+b14bbacd2ed3d2168c88dfe9ea6459c89377072a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in __wake_up_common
Message-ID: <20180130232438.fm3sats7rgb56u42@gmail.com>
References: <f403045fbfa04275f10560ffd90b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f403045fbfa04275f10560ffd90b@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2017 at 03:01:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> binder: 21356:21382 ioctl 40046207 0 returned -16
> binder: undelivered TRANSACTION_ERROR: 29201
> general protection fault: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 21428 Comm: syz-executor2 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__wake_up_common+0x69/0x150 kernel/sched/wait.c:97
> RSP: 0018:ffffc90000ecfcb0 EFLAGS: 00010046
> RAX: 7501a8c8458b90f3 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff8127b3e0
> RBP: ffffc90000ecfcf8 R08: ffffffff8127b3e0 R09: ffffc90000ecfd10
> R10: ffffc90000ecfc70 R11: ffff88020def2400 R12: ffff880210591010
> R13: ffffc90000ecfd10 R14: 000000008944ea89 R15: 7501a8c8458b90db
> FS:  00007f0471478700(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000718020 CR3: 000000020d514004 CR4: 00000000001606e0
> DR0: 0000000020000008 DR1: 0000000020000008 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  __wake_up_common_lock+0x6c/0x90 kernel/sched/wait.c:125
>  __wake_up+0xe/0x10 kernel/sched/wait.c:149
>  sbitmap_queue_wake_all+0x5d/0x80 lib/sbitmap.c:493
>  blk_mq_tag_wakeup_all+0x2e/0x40 block/blk-mq-tag.c:43
>  blk_mq_wake_waiters+0x60/0x80 block/blk-mq.c:259
>  blk_set_queue_dying+0x6e/0x130 block/blk-core.c:633
>  blk_cleanup_queue+0x33/0x2d0 block/blk-core.c:665
>  loop_remove+0x19/0x50 drivers/block/loop.c:1861
>  loop_control_ioctl+0x19a/0x1a0 drivers/block/loop.c:1960
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0xaf/0x840 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a09
> RSP: 002b:00007f0471477c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452a09
> RDX: ffffffffffffffff RSI: 0000000000004c81 RDI: 0000000000000013
> RBP: 000000000000039b R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f2728
> R13: 00000000ffffffff R14: 00007f04714786d4 R15: 0000000000000000
> Code: 83 c4 38 89 55 c0 49 39 c4 74 4c 49 8b 40 18 31 db 4c 8d 78 e8 45 8b
> 30 41 f6 c6 04 75 4b 48 8b 4d c8 8b 55 d0 4c 89 c7 8b 75 d4 <41> ff 50 10 85
> c0 78 24 74 0c 41 83 e6 01 74 06 83 6d c0 01 74
> RIP: __wake_up_common+0x69/0x150 kernel/sched/wait.c:97 RSP:
> ffffc90000ecfcb0
> ---[ end trace a0a1bc51887f1c44 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
