Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeDUS17 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 14:27:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33027 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeDUS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 14:27:57 -0400
X-Google-Smtp-Source: AIpwx4/g4Ntd/nk8e5BR/3z9NuC2iClZylcSVJu4kuZCRlBXqoOxEmd6LHc6NrBdKrOeERre6K+hew==
Date: Sat, 21 Apr 2018 11:29:10 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <syzbot+7b44b47914a5b3dc2038ff8f39e13a0e0f9e5f78@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible deadlock in ftrace_profile_set_filter (2)
Message-ID: <20180421182910.GD1098@sol.localdomain>
References: <001a113f2964b64d9f055f7068a4@google.com>
 <f4f5e803bcb8934e190563610bfb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f5e803bcb8934e190563610bfb@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 09:49:00AM -0800, syzbot wrote:
> syzbot has found reproducer for the following crash on
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/master commit
> ebdd7b491b8a65d65936e07004caabca4a3c94a0 (Sun Jan 21 23:21:31 2018 +0000)
> Merge branch 'mlxsw-Add-support-for-mirror-action-with-flower'
> 
> So far this crash happened 3 times on
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/master,
> linux-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+7b44b47914a5b3dc2038ff8f39e13a0e0f9e5f78@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.15.0-rc8+ #1 Not tainted
> ------------------------------------------------------
> syzkaller301315/3887 is trying to acquire lock:
>  (event_mutex){+.+.}, at: [<00000000dfa1326b>]
> ftrace_profile_set_filter+0x7a/0x270 kernel/trace/trace_events_filter.c:2266
> 
> but task is already holding lock:
>  (&cpuctx_mutex){+.+.}, at: [<00000000e276bad6>]
> perf_event_ctx_lock_nested+0x21b/0x450 kernel/events/core.c:1249
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&cpuctx_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        perf_event_init_cpu+0xb6/0x160 kernel/events/core.c:11076
>        perf_event_init+0x4e9/0x549 kernel/events/core.c:11123
>        start_kernel+0x4cc/0x819 init/main.c:627
>        x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>        x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
> 
> -> #3 (pmus_lock){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        perf_event_init_cpu+0x2f/0x160 kernel/events/core.c:11070
>        cpuhp_invoke_callback+0x2ea/0x1d20 kernel/cpu.c:182
>        cpuhp_up_callbacks kernel/cpu.c:477 [inline]
>        _cpu_up+0x216/0x510 kernel/cpu.c:1036
>        do_cpu_up+0x73/0xa0 kernel/cpu.c:1066
>        cpu_up+0x18/0x20 kernel/cpu.c:1074
>        smp_init+0x13a/0x152 kernel/smp.c:578
>        kernel_init_freeable+0x2fe/0x521 init/main.c:1067
>        kernel_init+0x13/0x180 init/main.c:999
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:541
> 
> -> #2 (cpu_hotplug_lock.rw_sem){++++}:
>        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> [inline]
>        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>        cpus_read_lock+0x42/0x90 kernel/cpu.c:293
>        static_key_slow_inc+0x9d/0x3c0 kernel/jump_label.c:123
>        tracepoint_add_func kernel/tracepoint.c:223 [inline]
>        tracepoint_probe_register_prio+0x80d/0x9a0 kernel/tracepoint.c:283
>        tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:304
>        trace_event_reg+0x167/0x320 kernel/trace/trace_events.c:305
>        perf_trace_event_reg kernel/trace/trace_event_perf.c:122 [inline]
>        perf_trace_event_init kernel/trace/trace_event_perf.c:197 [inline]
>        perf_trace_init+0x4ef/0xab0 kernel/trace/trace_event_perf.c:221
>        perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7959
>        perf_try_init_event+0xc9/0x1f0 kernel/events/core.c:9192
>        perf_init_event kernel/events/core.c:9230 [inline]
>        perf_event_alloc+0x1cc6/0x2b00 kernel/events/core.c:9494
>        SYSC_perf_event_open+0x84e/0x2e00 kernel/events/core.c:9949
> 

No longer occurring, fix was commit 43fa87f7deed52e8c8:

#syz fix: perf/core: Fix another perf,trace,cpuhp lock inversion

- Eric
