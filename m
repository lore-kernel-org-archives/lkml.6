Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDRJgk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:36:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:46333 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbeDRJgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:36:38 -0400
Date: Wed, 18 Apr 2018 11:36:36 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+e38306788a2e7102a3b6@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, dan.carpenter@oracle.com, dwindsor@gmail.com,
        elena.reshetova@intel.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in fsnotify_mark_destroy_workfn
Message-ID: <20180418093636.alasuzdjwjb2qovv@quack2.suse.cz>
References: <000000000000ba999f056a150015@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ba999f056a150015@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue 17-04-18 18:02:02, syzbot wrote:
> syzbot hit the following crash on upstream commit
> a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018 +0000)
> Merge branch 'parisc-4.17-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=e38306788a2e7102a3b6
> 
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5126465372815360
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5956756370882560
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e38306788a2e7102a3b6@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 

Removed binder messages from the lockup splat so that it's more readable.

> INFO: task kworker/u4:4:853 blocked for more than 120 seconds.
>       Not tainted 4.17.0-rc1+ #6
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u4:4    D11512   853      2 0x80000000
> Workqueue: events_unbound fsnotify_mark_destroy_workfn
> Call Trace:
>  context_switch kernel/sched/core.c:2848 [inline]
>  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
>  schedule+0xef/0x430 kernel/sched/core.c:3549
>  schedule_timeout+0x1b5/0x240 kernel/time/timer.c:1777
>  do_wait_for_common kernel/sched/completion.c:83 [inline]
>  __wait_for_common kernel/sched/completion.c:104 [inline]
>  wait_for_common kernel/sched/completion.c:115 [inline]
>  wait_for_completion+0x3e7/0x870 kernel/sched/completion.c:136
>  __synchronize_srcu+0x189/0x240 kernel/rcu/srcutree.c:924
>  synchronize_srcu+0x408/0x54f kernel/rcu/srcutree.c:1002
>  fsnotify_mark_destroy_workfn+0x1aa/0x530 fs/notify/mark.c:759
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

OK, so we are waiting for the grace period on fsnotify_mark_srcu. Seems
like someone is holding fsnotify_mark_srcu too long or srcu period cannot
finish for some other reason. However the reproducer basically contains
only one binder ioctl and I have no idea how that's connected with fsnotify
in any way. So either the reproducer is wrong, or binder is corrupting
memory and fsnotify is just a victim, or something like that...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
