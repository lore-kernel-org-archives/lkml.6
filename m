Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A5EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E272083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E272083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeJOUAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:00:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbeJOUAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:00:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D44D1ADC0;
        Mon, 15 Oct 2018 12:15:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 777301E3616; Mon, 15 Oct 2018 14:15:41 +0200 (CEST)
Date:   Mon, 15 Oct 2018 14:15:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in fanotify_handle_event
Message-ID: <20181015121541.GC30927@quack2.suse.cz>
References: <00000000000036c76a057842c97f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000036c76a057842c97f@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon 15-10-18 04:32:02, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    90ad18418c2d Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f1776e400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=29143581b0ded3213e99
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123459d6400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com

Syzbot has apparently generated fanotify watch for FAN_OPEN_PERM event and
then the process got stuck waiting for userspace to respond to that event -
which never happened. So everything works as designed here - the process
placing FAN_OPEN_PERM mark is responsible for replying to the generated
events as all opens hang waiting for responses. That's why the
functionality is behind CAP_SYS_ADMIN after all... Could we fix syzbot to
actually generate replies for these events?

								Honza
> 
> INFO: task syz-executor3:23598 blocked for more than 140 seconds.
>       Not tainted 4.19.0-rc7+ #59
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor3   D24888 23598   5550 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2825 [inline]
>  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
>  schedule+0xfe/0x460 kernel/sched/core.c:3517
>  fanotify_get_response fs/notify/fanotify/fanotify.c:68 [inline]
>  fanotify_handle_event+0x7fb/0x9a0 fs/notify/fanotify/fanotify.c:245
>  send_to_group fs/notify/fsnotify.c:234 [inline]
>  fsnotify+0x87f/0x12f0 fs/notify/fsnotify.c:367
>  fsnotify_perm include/linux/fsnotify.h:52 [inline]
>  security_file_open+0x16f/0x1b0 security/security.c:986
>  do_dentry_open+0x331/0x1250 fs/open.c:758
>  vfs_open+0xa0/0xd0 fs/open.c:880
>  do_last fs/namei.c:3418 [inline]
>  path_openat+0x12bf/0x5160 fs/namei.c:3534
>  do_filp_open+0x255/0x380 fs/namei.c:3564
>  do_sys_open+0x568/0x700 fs/open.c:1063
>  ksys_open include/linux/syscalls.h:1276 [inline]
>  __do_sys_creat fs/open.c:1121 [inline]
>  __se_sys_creat fs/open.c:1119 [inline]
>  __x64_sys_creat+0x61/0x80 fs/open.c:1119
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: Bad RIP value.
> RSP: 002b:00007efe2663bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457569
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
> RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe2663c6d4
> R13: 00000000004bdb2f R14: 00000000004cc688 R15: 00000000ffffffff
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/984:
>  #0: 0000000045bbc556 (rcu_read_lock){....}, at:
> debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4435
> 1 lock held by rsyslogd/5369:
>  #0: 00000000c6b46b4b (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200
> fs/file.c:766
> 2 locks held by getty/5491:
>  #0: 000000007c8f39bf (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000ab767e83 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5492:
>  #0: 000000005a020001 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 000000001a016d07 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5493:
>  #0: 00000000317a902c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000de804861 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5494:
>  #0: 00000000bd67aa3a (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000c6fa2e6f (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5495:
>  #0: 00000000d69ad6b3 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000b28afab5 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5496:
>  #0: 00000000f21d8abe (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000ed3e038f (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/5497:
>  #0: 000000005843227c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x32/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 000000005ec4a201 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 1 lock held by syz-executor3/23598:
>  #0: 0000000008161dc8 (sb_writers#4){.+.+}, at: sb_start_write
> include/linux/fs.h:1566 [inline]
>  #0: 0000000008161dc8 (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0
> fs/namespace.c:360
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 984 Comm: khungtaskd Not tainted 4.19.0-rc7+ #59
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.3+0x63/0xa2 lib/nmi_backtrace.c:101
>  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
>  watchdog+0xb3e/0x1050 kernel/hung_task.c:265
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10
> arch/x86/include/asm/irqflags.h:57
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
