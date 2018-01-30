Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeA3XpN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:45:13 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:38575 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeA3XpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:45:05 -0500
X-Google-Smtp-Source: AH8x225llIWALiOoOWVLW2DtilzlfmJNFBdL8QjgIkrSzQzHwwk3yteXJpIui9Z00qhEU9RcWaQDRw==
Date: Tue, 30 Jan 2018 15:45:02 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+118d758e6670956425a5384acd064695670f84c2@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: WARNING: bad unlock balance detected!
Message-ID: <20180130234502.5zytrohzkih27h3o@gmail.com>
References: <94eb2c03c9bcebb32a05605c101a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c03c9bcebb32a05605c101a@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2017 at 11:37:00PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> 
> =====================================
> WARNING: bad unlock balance detected!
> 4.15.0-rc3+ #217 Not tainted
> -------------------------------------
> syz-executor3/19522 is trying to release lock (mrt_lock) at:
> [<00000000adc671f1>] ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 2 locks held by syz-executor3/19522:
>  #0:  (&f->f_pos_lock){+.+.}, at: [<00000000cd36f0f9>]
> __fdget_pos+0x131/0x1a0 fs/file.c:770
>  #1:  (&p->lock){+.+.}, at: [<00000000c93d2595>] seq_lseek+0x58/0x3c0
> fs/seq_file.c:321
> 
> stack backtrace:
> CPU: 0 PID: 19522 Comm: syz-executor3 Not tainted 4.15.0-rc3+ #217
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_unlock_imbalance_bug+0x12f/0x140 kernel/locking/lockdep.c:3561
>  __lock_release kernel/locking/lockdep.c:3775 [inline]
>  lock_release+0x5f9/0xda0 kernel/locking/lockdep.c:4023
>  __raw_read_unlock include/linux/rwlock_api_smp.h:225 [inline]
>  _raw_read_unlock+0x1a/0x30 kernel/locking/spinlock.c:255
>  ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
>  traverse+0x3bc/0xa00 fs/seq_file.c:135
>  seq_lseek+0x136/0x3c0 fs/seq_file.c:331
>  proc_reg_llseek+0xf1/0x160 fs/proc/inode.c:203
>  vfs_llseek fs/read_write.c:300 [inline]
>  SYSC_lseek fs/read_write.c:313 [inline]
>  SyS_lseek+0xf1/0x170 fs/read_write.c:304
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007fda08e4bc58 EFLAGS: 00000212 ORIG_RAX: 0000000000000008
> RAX: ffffffffffffffda RBX: 00007fda08e4c700 RCX: 0000000000452a39
> RDX: 0000000000000001 RSI: 0000000000000020 RDI: 0000000000000013
> RBP: 0000000000a6f880 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
> R13: 0000000000a6f7ff R14: 00007fda08e4c9c0 R15: 0000000000000002
> BUG: scheduling while atomic: syz-executor3/19522/0x00000000
> INFO: lockdep is turned off.
> Modules linked in:
> Kernel panic - not syncing: scheduling while atomic
> 
> CPU: 0 PID: 19522 Comm: syz-executor3 Not tainted 4.15.0-rc3+ #217
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __schedule_bug+0x11f/0x130 kernel/sched/core.c:3177
>  schedule_debug kernel/sched/core.c:3194 [inline]
>  __schedule+0x131c/0x2060 kernel/sched/core.c:3299
>  schedule+0xf5/0x430 kernel/sched/core.c:3434
>  exit_to_usermode_loop+0x1d1/0x310 arch/x86/entry/common.c:151
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x490/0x550 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x94/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007fda08e4bc58 EFLAGS: 00000212 ORIG_RAX: 0000000000000008
> RAX: 0000000000000040 RBX: 00000000007580d8 RCX: 0000000000452a39
> RDX: 0000000000000001 RSI: 0000000000000020 RDI: 0000000000000013
> RBP: 000000000000038a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f3590
> R13: 00000000ffffffff R14: 00007fda08e4c6d4 R15: 0000000000000002
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

Duplicate of "WARNING: bad unlock balance in ipmr_mfc_seq_stop" which syzbot is
detecting under that crash signature now, so just invalidating this one: 

#syz invalid 
