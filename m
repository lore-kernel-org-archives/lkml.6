Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbeBLPEZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:04:25 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42442 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeBLPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:04:20 -0500
X-Google-Smtp-Source: AH8x227hNz+ApXd8GDRn/qgz2UwFW/z8mRoZkvnQtFkPTymRi8awCLB6/4b5jSGdqly0WvrXoPEBd0g6VJjGpf6+wds=
MIME-Version: 1.0
In-Reply-To: <001a1144d1c890d9fa055f73370d@google.com>
References: <001a1144d1c890d9fa055f73370d@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 16:03:58 +0100
Message-ID: <CACT4Y+Z5Cj1ecjvD0W826ktHaYuZ8Pz0V7Vf9fjbxPQNg5YPaw@mail.gmail.com>
Subject: Re: possible deadlock in perf_trace_init (2)
To: syzbot
        <bot+7e57fd0c3d95aeefc7adc62e882baeae78e6d7fb@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2017 at 6:49 PM, syzbot
<bot+7e57fd0c3d95aeefc7adc62e882baeae78e6d7fb@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> d127129e85a020879f334154300ddd3f7ec21c1e
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
>
> Unfortunately, I don't have any reproducer for this bug yet.

Another perf deadlock that involves splice, so:

#syz dup: possible deadlock in perf_event_ctx_lock_nested


> ======================================================
> WARNING: possible circular locking dependency detected
> 4.15.0-rc1-next-20171129+ #55 Not tainted
> ------------------------------------------------------
> syz-executor1/4270 is trying to acquire lock:
>  (event_mutex){+.+.}, at: [<ffffffff817809f8>] perf_trace_init+0x58/0xab0
> kernel/trace/trace_event_perf.c:216
>
> but task is already holding lock:
>  (&ctx->mutex){+.+.}, at: [<ffffffff818740eb>] perf_event_init_context
> kernel/events/core.c:10898 [inline]
>  (&ctx->mutex){+.+.}, at: [<ffffffff818740eb>]
> perf_event_init_task+0x25b/0x890 kernel/events/core.c:10973
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #8 (&ctx->mutex){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        perf_event_ctx_lock_nested+0x21b/0x450 kernel/events/core.c:1249
>        perf_event_ctx_lock kernel/events/core.c:1262 [inline]
>        perf_read+0xb9/0x970 kernel/events/core.c:4507
>        do_loop_readv_writev fs/read_write.c:673 [inline]
>        do_iter_read+0x3db/0x5b0 fs/read_write.c:897
>        vfs_readv+0x121/0x1c0 fs/read_write.c:959
>        kernel_readv fs/splice.c:361 [inline]
>        default_file_splice_read+0x508/0xae0 fs/splice.c:416
>        do_splice_to+0x110/0x170 fs/splice.c:880
>        do_splice fs/splice.c:1173 [inline]
>        SYSC_splice fs/splice.c:1402 [inline]
>        SyS_splice+0x11a8/0x1630 fs/splice.c:1382
>        entry_SYSCALL_64_fastpath+0x1f/0x96
>
> -> #7 (&pipe->mutex/1){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        pipe_lock_nested fs/pipe.c:67 [inline]
>        pipe_lock+0x56/0x70 fs/pipe.c:75
>        iter_file_splice_write+0x264/0xf30 fs/splice.c:699
>        do_splice_from fs/splice.c:851 [inline]
>        do_splice fs/splice.c:1147 [inline]
>        SYSC_splice fs/splice.c:1402 [inline]
>        SyS_splice+0x7d5/0x1630 fs/splice.c:1382
>        entry_SYSCALL_64_fastpath+0x1f/0x96
>
> -> #6 (sb_writers){.+.+}:
>        finish_lock_switch kernel/sched/sched.h:1360 [inline]
>        finish_task_switch+0x1aa/0x740 kernel/sched/core.c:2667
>
> -> #5 ((completion)&req.done){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        complete_acquire include/linux/completion.h:40 [inline]
>        __wait_for_common kernel/sched/completion.c:109 [inline]
>        wait_for_common kernel/sched/completion.c:123 [inline]
>        wait_for_completion+0xcb/0x7b0 kernel/sched/completion.c:144
>        devtmpfs_create_node+0x32b/0x4a0 drivers/base/devtmpfs.c:115
>        device_add+0x120f/0x1640 drivers/base/core.c:1824
>        device_create_groups_vargs+0x1f3/0x250 drivers/base/core.c:2430
>        device_create_vargs drivers/base/core.c:2470 [inline]
>        device_create+0xda/0x110 drivers/base/core.c:2506
>        msr_device_create+0x26/0x40 arch/x86/kernel/msr.c:188
>        cpuhp_invoke_callback+0x2ea/0x1d20 kernel/cpu.c:182
>        cpuhp_thread_fun+0x48e/0x7e0 kernel/cpu.c:571
>        smpboot_thread_fn+0x450/0x7c0 kernel/smpboot.c:164
>        kthread+0x37a/0x440 kernel/kthread.c:238
>        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:517
>
> -> #4 (cpuhp_state-up){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        cpuhp_lock_acquire kernel/cpu.c:85 [inline]
>        cpuhp_invoke_ap_callback kernel/cpu.c:605 [inline]
>        cpuhp_issue_call+0x1e5/0x520 kernel/cpu.c:1495
>        __cpuhp_setup_state_cpuslocked+0x282/0x600 kernel/cpu.c:1642
>        __cpuhp_setup_state+0xb0/0x140 kernel/cpu.c:1671
>        cpuhp_setup_state include/linux/cpuhotplug.h:201 [inline]
>        page_writeback_init+0x4d/0x71 mm/page-writeback.c:2081
>        pagecache_init+0x48/0x4f mm/filemap.c:976
>        start_kernel+0x6bc/0x74f init/main.c:698
>        x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>        x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
>
> -> #3 (cpuhp_state_mutex){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        __cpuhp_setup_state_cpuslocked+0x5b/0x600 kernel/cpu.c:1617
>        __cpuhp_setup_state+0xb0/0x140 kernel/cpu.c:1671
>        cpuhp_setup_state_nocalls include/linux/cpuhotplug.h:229 [inline]
>        kvm_guest_init+0x1f3/0x20f arch/x86/kernel/kvm.c:528
>        setup_arch+0x17e8/0x1a02 arch/x86/kernel/setup.c:1266
>        start_kernel+0xa5/0x74f init/main.c:533
>        x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>        x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
>
> -> #2 (cpu_hotplug_lock.rw_sem){++++}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> [inline]
>        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>        cpus_read_lock+0x42/0x90 kernel/cpu.c:293
>        static_key_slow_inc+0x9d/0x3c0 kernel/jump_label.c:123
>        tracepoint_add_func kernel/tracepoint.c:222 [inline]
>        tracepoint_probe_register_prio+0x80d/0x9a0 kernel/tracepoint.c:282
>        tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:303
>        trace_event_reg+0x167/0x320 kernel/trace/trace_events.c:305
>        perf_trace_event_reg kernel/trace/trace_event_perf.c:122 [inline]
>        perf_trace_event_init kernel/trace/trace_event_perf.c:197 [inline]
>        perf_trace_init+0x4ef/0xab0 kernel/trace/trace_event_perf.c:221
>        perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7956
>        perf_try_init_event+0xc9/0x1f0 kernel/events/core.c:9189
>        perf_init_event kernel/events/core.c:9227 [inline]
>        perf_event_alloc+0x1cc6/0x2b00 kernel/events/core.c:9491
>        SYSC_perf_event_open+0x84e/0x2e00 kernel/events/core.c:9946
>        SyS_perf_event_open+0x39/0x50 kernel/events/core.c:9832
>        entry_SYSCALL_64_fastpath+0x1f/0x96
>
> -> #1 (tracepoints_mutex){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        tracepoint_probe_register_prio+0xa0/0x9a0 kernel/tracepoint.c:278
>        tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:303
>        trace_event_reg+0x167/0x320 kernel/trace/trace_events.c:305
>        perf_trace_event_reg kernel/trace/trace_event_perf.c:122 [inline]
>        perf_trace_event_init kernel/trace/trace_event_perf.c:197 [inline]
>        perf_trace_init+0x4ef/0xab0 kernel/trace/trace_event_perf.c:221
>        perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7956
>        perf_try_init_event+0xc9/0x1f0 kernel/events/core.c:9189
>        perf_init_event kernel/events/core.c:9227 [inline]
>        perf_event_alloc+0x1cc6/0x2b00 kernel/events/core.c:9491
>        SYSC_perf_event_open+0x84e/0x2e00 kernel/events/core.c:9946
>        SyS_perf_event_open+0x39/0x50 kernel/events/core.c:9832
>        entry_SYSCALL_64_fastpath+0x1f/0x96
>
> -> #0 (event_mutex){+.+.}:
>        check_prevs_add kernel/locking/lockdep.c:2031 [inline]
>        validate_chain kernel/locking/lockdep.c:2473 [inline]
>        __lock_acquire+0x3498/0x47f0 kernel/locking/lockdep.c:3500
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        perf_trace_init+0x58/0xab0 kernel/trace/trace_event_perf.c:216
>        perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7956
>        perf_try_init_event+0xc9/0x1f0 kernel/events/core.c:9189
>        perf_init_event kernel/events/core.c:9211 [inline]
>        perf_event_alloc+0x1005/0x2b00 kernel/events/core.c:9491
>        inherit_event.isra.92+0x15b/0x920 kernel/events/core.c:10705
>        inherit_group kernel/events/core.c:10796 [inline]
>        inherit_task_group.isra.94.part.95+0x73/0x240
> kernel/events/core.c:10854
>        inherit_task_group kernel/events/core.c:10834 [inline]
>        perf_event_init_context kernel/events/core.c:10905 [inline]
>        perf_event_init_task+0x348/0x890 kernel/events/core.c:10973
>        copy_process.part.35+0x1748/0x4b30 kernel/fork.c:1776
>        copy_process kernel/fork.c:1615 [inline]
>        _do_fork+0x1ef/0xf10 kernel/fork.c:2096
>        SYSC_clone kernel/fork.c:2203 [inline]
>        SyS_clone+0x37/0x50 kernel/fork.c:2197
>        do_syscall_64+0x26c/0x920 arch/x86/entry/common.c:285
>        return_from_SYSCALL_64+0x0/0x75
>
> other info that might help us debug this:
>
> Chain exists of:
>   event_mutex --> &pipe->mutex/1 --> &ctx->mutex
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&ctx->mutex);
>                                lock(&pipe->mutex/1);
>                                lock(&ctx->mutex);
>   lock(event_mutex);
>
>  *** DEADLOCK ***
>
> 2 locks held by syz-executor1/4270:
>  #0:  (&ctx->mutex){+.+.}, at: [<ffffffff818740eb>] perf_event_init_context
> kernel/events/core.c:10898 [inline]
>  #0:  (&ctx->mutex){+.+.}, at: [<ffffffff818740eb>]
> perf_event_init_task+0x25b/0x890 kernel/events/core.c:10973
>  #1:  (&pmus_srcu){....}, at: [<ffffffff818570b5>]
> perf_event_alloc+0xf55/0x2b00 kernel/events/core.c:9487
>
> stack backtrace:
> CPU: 1 PID: 4270 Comm: syz-executor1 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_circular_bug+0x42d/0x610 kernel/locking/lockdep.c:1271
>  check_prev_add+0x666/0x15f0 kernel/locking/lockdep.c:1914
>  check_prevs_add kernel/locking/lockdep.c:2031 [inline]
>  validate_chain kernel/locking/lockdep.c:2473 [inline]
>  __lock_acquire+0x3498/0x47f0 kernel/locking/lockdep.c:3500
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>  __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  perf_trace_init+0x58/0xab0 kernel/trace/trace_event_perf.c:216
>  perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7956
>  perf_try_init_event+0xc9/0x1f0 kernel/events/core.c:9189
>  perf_init_event kernel/events/core.c:9211 [inline]
>  perf_event_alloc+0x1005/0x2b00 kernel/events/core.c:9491
>  inherit_event.isra.92+0x15b/0x920 kernel/events/core.c:10705
>  inherit_group kernel/events/core.c:10796 [inline]
>  inherit_task_group.isra.94.part.95+0x73/0x240 kernel/events/core.c:10854
>  inherit_task_group kernel/events/core.c:10834 [inline]
>  perf_event_init_context kernel/events/core.c:10905 [inline]
>  perf_event_init_task+0x348/0x890 kernel/events/core.c:10973
>  copy_process.part.35+0x1748/0x4b30 kernel/fork.c:1776
>  copy_process kernel/fork.c:1615 [inline]
>  _do_fork+0x1ef/0xf10 kernel/fork.c:2096
>  SYSC_clone kernel/fork.c:2203 [inline]
>  SyS_clone+0x37/0x50 kernel/fork.c:2197
>  do_syscall_64+0x26c/0x920 arch/x86/entry/common.c:285
>  entry_SYSCALL64_slow_path+0x25/0x25
> RIP: 0033:0x455369
> RSP: 002b:0000000000a6f748 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f790b89c700 RCX: 0000000000455369
> RDX: 00007f790b89c9d0 RSI: 00007f790b89bdb0 RDI: 00000000003d0f00
> RBP: 0000000000a6f880 R08: 00007f790b89c700 R09: 00007f790b89c700
> R10: 00007f790b89c9d0 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000a6f7ff R14: 00007f790b89c9c0 R15: 0000000000000014
> rfkill: input handler disabled
> rfkill: input handler enabled
> device lo entered promiscuous mode
> encrypted_key: insufficient parameters specified
> encrypted_key: insufficient parameters specified
> device gre0 entered promiscuous mode
> print_req_error: I/O error, dev loop0, sector 4
> print_req_error: I/O error, dev loop0, sector 4
> binder: 4590:4594 transaction failed 29189/-22, size 0-32 line 2832
> binder: 4590:4594 transaction failed 29189/-22, size 0-32 line 2832
> kauditd_printk_skb: 427 callbacks suppressed
> audit: type=1326 audit(1511971831.715:438): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=kernel pid=4761 comm="syz-executor0"
> exe="/root/syz-executor0" sig=31 arch=c000003e syscall=202 compat=0
> ip=0x4529d9 code=0xffff0000
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4825 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4834 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4834 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4834 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4834 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4834 comm=syz-executor0
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4888 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4888 comm=syz-executor0
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4888 comm=syz-executor0
> CPU: 1 PID: 4882 Comm: syz-executor1 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:425 [inline]
>  slab_alloc mm/slab.c:3372 [inline]
>  kmem_cache_alloc+0x47/0x760 mm/slab.c:3546
>  ptlock_alloc+0x24/0x70 mm/memory.c:4673
>  ptlock_init include/linux/mm.h:1790 [inline]
>  pgtable_page_ctor include/linux/mm.h:1824 [inline]
>  pte_alloc_one+0x59/0x100 arch/x86/mm/pgtable.c:32
>  do_huge_pmd_anonymous_page+0xbbe/0x19e0 mm/huge_memory.c:692
>  create_huge_pmd mm/memory.c:3816 [inline]
>  __handle_mm_fault+0x1bd6/0x3e60 mm/memory.c:4019
>  handle_mm_fault+0x38f/0x930 mm/memory.c:4085
>  __do_page_fault+0x5c9/0xc90 arch/x86/mm/fault.c:1429
>  do_page_fault+0xee/0x720 arch/x86/mm/fault.c:1504
>  page_fault+0x4c/0x60 arch/x86/entry/entry_64.S:1230
> RIP: 0033:0x401819
> RSP: 002b:00007f790b8bcb90 EFLAGS: 00010246
> RAX: 0000000020000000 RBX: 000000000000004a RCX: 0000000000000000
> RDX: 209c2a81117b8a5f RSI: 0000000000000000 RDI: 00007f790b8bd608
> RBP: 000000002078d000 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000004a R11: 0000000000000000 R12: 00000000006f54e8
> R13: 0000000000000013 R14: 00007f790b8bd6d4 R15: ffffffffffffffff
> oom_reaper: reaped process 4882 (syz-executor1), now anon-rss:0kB,
> file-rss:0kB, shmem-rss:0kB
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=4888 comm=syz-executor0
> QAT: Invalid ioctl
> QAT: Invalid ioctl
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 5697 Comm: syz-executor7 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:425 [inline]
>  slab_alloc mm/slab.c:3372 [inline]
>  kmem_cache_alloc+0x47/0x760 mm/slab.c:3546
>  ptlock_alloc+0x24/0x70 mm/memory.c:4673
>  ptlock_init include/linux/mm.h:1790 [inline]
>  pgtable_page_ctor include/linux/mm.h:1824 [inline]
>  pte_alloc_one+0x59/0x100 arch/x86/mm/pgtable.c:32
>  __do_huge_pmd_anonymous_page mm/huge_memory.c:567 [inline]
>  do_huge_pmd_anonymous_page+0x554/0x19e0 mm/huge_memory.c:731
>  create_huge_pmd mm/memory.c:3816 [inline]
>  __handle_mm_fault+0x1bd6/0x3e60 mm/memory.c:4019
>  handle_mm_fault+0x38f/0x930 mm/memory.c:4085
>  __do_page_fault+0x5c9/0xc90 arch/x86/mm/fault.c:1429
>  do_page_fault+0xee/0x720 arch/x86/mm/fault.c:1504
>  page_fault+0x2c/0x60 arch/x86/entry/entry_64.S:1230
> RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20
> arch/x86/lib/copy_user_64.S:180
> RSP: 0018:ffff8801c917fd88 EFLAGS: 00010202
> RAX: ffffed003922ffda RBX: 0000000000000078 RCX: 0000000000000078
> RDX: 0000000000000078 RSI: ffff8801c917fe58 RDI: 0000000020dcbfbc
> RBP: ffff8801c917fdb8 R08: ffffed003922ffda R09: ffffed003922ffda
> R10: 000000000000000f R11: ffffed003922ffd9 R12: 0000000020dcbfbc
> R13: ffff8801c917fe58 R14: 00007ffffffff000 R15: 0000000020dcc034
>  copy_to_user include/linux/uaccess.h:155 [inline]
>  copy_msqid_to_user.constprop.9+0x22/0x30 ipc/msg.c:288
>  SYSC_msgctl+0x212/0x290 ipc/msg.c:557
>  SyS_msgctl+0x24/0x30 ipc/msg.c:528
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x4529d9
> RSP: 002b:00007f7af2813c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000047
> RAX: ffffffffffffffda RBX: 00007f7af2813aa0 RCX: 00000000004529d9
> RDX: 0000000020dcbfbc RSI: 0000000000000002 RDI: 0000000000000000
> RBP: 00007f7af2813a90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004b759b
> R13: 00007f7af2813bc8 R14: 00000000004b759b R15: 0000000000000000
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 5810 Comm: syz-executor2 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:425 [inline]
>  slab_alloc mm/slab.c:3372 [inline]
>  kmem_cache_alloc+0x47/0x760 mm/slab.c:3546
>  __sigqueue_alloc+0x329/0x660 kernel/signal.c:386
>  __send_signal+0x2e8/0x17a0 kernel/signal.c:1041
>  send_signal+0x4a/0xc0 kernel/signal.c:1107
>  specific_send_sig_info kernel/signal.c:1152 [inline]
>  force_sig_info+0x242/0x340 kernel/signal.c:1204
>  force_sig_info_fault.constprop.32+0x289/0x450 arch/x86/mm/fault.c:223
>  __bad_area_nosemaphore+0x1d2/0x3e0 arch/x86/mm/fault.c:923
>  __bad_area+0x151/0x1f0 arch/x86/mm/fault.c:957
>  bad_area_access_error+0x166/0x240 arch/x86/mm/fault.c:996
>  __do_page_fault+0x3d1/0xc90 arch/x86/mm/fault.c:1409
>  do_page_fault+0xee/0x720 arch/x86/mm/fault.c:1504
>  page_fault+0x4c/0x60 arch/x86/entry/entry_64.S:1230
> RIP: 0033:0x44c5a0
> RSP: 002b:00007f771dbdd788 EFLAGS: 00010206
> RAX: 00007f771dbdd830 RBX: 0000000000758020 RCX: 0000000000000003
> RDX: 0000000000000400 RSI: 0000000020fd7ff0 RDI: 00007f771dbdd830
> RBP: 00000000000005a5 R08: 0000000000000400 R09: 0000000000000000
> R10: 0000000020fd7ff3 R11: 0000000000000000 R12: 00000000006f5818
> R13: 0000000000000014 R14: 00007f771dbde6d4 R15: ffffffffffffffff
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 5826 Comm: syz-executor2 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:425 [inline]
>  slab_alloc mm/slab.c:3372 [inline]
>  kmem_cache_alloc+0x47/0x760 mm/slab.c:3546
>  getname_flags+0xcb/0x580 fs/namei.c:138
>  getname+0x19/0x20 fs/namei.c:209
>  do_sys_open+0x2e7/0x6d0 fs/open.c:1053
>  SYSC_open fs/open.c:1077 [inline]
>  SyS_open+0x2d/0x40 fs/open.c:1072
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x40cd11
> RSP: 002b:00007f771dbdd780 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 000000000040cd11
> RDX: 0000000000000000 RSI: 0000000072be4c3d RDI: 00007f771dbdd830
> RBP: 00000000000005a5 R08: 00007f771dbdd790 R09: 00000000000005a5
> R10: 0000000020fd7ff3 R11: 0000000000000293 R12: 00000000006f5818
> R13: 0000000000000014 R14: 00007f771dbde6d4 R15: ffffffffffffffff
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 1
> CPU: 1 PID: 5857 Comm: syz-executor2 Not tainted 4.15.0-rc1-next-20171129+
> #55
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:2943 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4196 [inline]
>  __alloc_pages_nodemask+0x338/0xd80 mm/page_alloc.c:4235
>  __alloc_pages include/linux/gfp.h:456 [inline]
>  __alloc_pages_node include/linux/gfp.h:469 [inline]
>  kmem_getpages mm/slab.c:1414 [inline]
>  cache_grow_begin+0x72/0x570 mm/slab.c:2672
>  cache_alloc_refill mm/slab.c:3039 [inline]
>  ____cache_alloc mm/slab.c:3121 [inline]
>  __do_cache_alloc mm/slab.c:3343 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  kmem_cache_alloc+0x403/0x760 mm/slab.c:3546
>  getname_flags+0xcb/0x580 fs/namei.c:138
>  getname+0x19/0x20 fs/namei.c:209
>  do_sys_open+0x2e7/0x6d0 fs/open.c:1053
>  SYSC_open fs/open.c:1077 [inline]
>  SyS_open+0x2d/0x40 fs/open.c:1072
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x40cd11
> RSP: 002b:00007f771dbdd780 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 000000000040cd11
> RDX: 0000000000000000 RSI: 0000000072be4c3d RDI: 00007f771dbdd830
> RBP: 00000000000005a5 R08: 00007f771dbdd790 R09: 00000000000005a5
> R10: 0000000020fd7ff3 R11: 0000000000000293 R12: 00000000006f5818
> R13: 0000000000000014 R14: 00007f771dbde6d4 R15: ffffffffffffffff
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1144d1c890d9fa055f73370d%40google.com.
> For more options, visit https://groups.google.com/d/optout.
