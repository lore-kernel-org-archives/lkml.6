Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeBBX3n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:29:43 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42343 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeBBX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:29:37 -0500
X-Google-Smtp-Source: AH8x224zeAtqDgp+AzBPsQ93OaBudp1VOoKxus/NN3uHo+hHABszZhAmngqfPpUbrgr9I1d6Rz1AFQ==
Date: Fri, 2 Feb 2018 15:29:33 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: syzbot <syzbot+7dbcd2d3b85f9b608b23@syzkaller.appspotmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        daniel@iogearbox.net, edumazet@google.com
Subject: Re: suspicious RCU usage at ./include/linux/rcupdate.h:LINE (4)
Message-ID: <20180202232931.bqmlqc46namylfhn@ast-mbp>
References: <089e082d13a0528e4905643bf073@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e082d13a0528e4905643bf073@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:58:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> b2fe5fa68642860e7de76167c3111623aa0d5de1 (Wed Jan 31 22:31:10 2018 +0000)
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> 
> So far this crash happened 1575 times on bpf-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7dbcd2d3b85f9b608b23@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1517546098.866:9): avc:  denied  { prog_run } for
> pid=4159 comm="syzkaller076311"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf
> permissive=1
> 
> =============================
> WARNING: suspicious RCU usage
> 4.15.0+ #10 Not tainted
> -----------------------------
> ./include/linux/rcupdate.h:302 Illegal context switch in RCU read-side
> critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 3 locks held by syzkaller076311/4159:
>  #0:  (&ctx->mutex){+.+.}, at: [<0000000027c8872d>]
> perf_event_ctx_lock_nested+0x21b/0x450 kernel/events/core.c:1253
>  #1:  (bpf_event_mutex){+.+.}, at: [<0000000092294d8c>]
> perf_event_query_prog_array+0x10e/0x280 kernel/trace/bpf_trace.c:876
>  #2:  (rcu_read_lock){....}, at: [<000000002b518ca0>]
> bpf_prog_array_copy_to_user+0x0/0x4d0 kernel/bpf/core.c:1568
> 
> stack backtrace:
> CPU: 0 PID: 4159 Comm: syzkaller076311 Not tainted 4.15.0+ #10
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4592
>  rcu_preempt_sleep_check include/linux/rcupdate.h:301 [inline]
>  ___might_sleep+0x385/0x470 kernel/sched/core.c:6079
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6067
>  __might_fault+0xab/0x1d0 mm/memory.c:4532
>  _copy_to_user+0x2c/0xc0 lib/usercopy.c:25
>  copy_to_user include/linux/uaccess.h:155 [inline]
>  bpf_prog_array_copy_to_user+0x217/0x4d0 kernel/bpf/core.c:1587
>  bpf_prog_array_copy_info+0x17b/0x1c0 kernel/bpf/core.c:1685
>  perf_event_query_prog_array+0x196/0x280 kernel/trace/bpf_trace.c:877
>  _perf_ioctl kernel/events/core.c:4737 [inline]
>  perf_ioctl+0x3e1/0x1480 kernel/events/core.c:4757
>  vfs_ioctl fs/ioctl.c:46 [inline]

fyi
it was copy_to_user in rcu section bug.
Submitted a fix here:
https://patchwork.ozlabs.org/patch/868824/
