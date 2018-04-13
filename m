Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeDMP3T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:29:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750761AbeDMP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:29:17 -0400
Date: Fri, 13 Apr 2018 17:29:13 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: syzbot <syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: KASAN: slab-out-of-bounds Write in perf_callchain_user
Message-ID: <20180413152913.GA9167@krava>
References: <001a1140f656c722960569a3d857@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1140f656c722960569a3d857@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 03:02:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 17dec0a949153d9ac00760ba2f5b78cb583e995f (Wed Apr 4 02:15:32 2018 +0000)
> Merge branch 'userns-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=7c449856228b63ac951e
> 
> So far this crash happened 2 times on bpf-next.
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4514433808203776
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5570436679073792
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-2735707888269579554
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in perf_callchain_store
> include/linux/perf_event.h:1147 [inline]
> BUG: KASAN: slab-out-of-bounds in perf_callchain_user+0xe31/0xfe0
> arch/x86/events/core.c:2485
> Write of size 8 at addr ffff8801d87f2d40 by task udevd/2377
> 
> CPU: 0 PID: 2377 Comm: udevd Not tainted 4.16.0+ #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
>  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
>  perf_callchain_store include/linux/perf_event.h:1147 [inline]
>  perf_callchain_user+0xe31/0xfe0 arch/x86/events/core.c:2485
>  get_perf_callchain+0x798/0xb20 kernel/events/callchain.c:227
>  perf_callchain kernel/events/core.c:6354 [inline]
>  perf_prepare_sample+0x123d/0x1900 kernel/events/core.c:6380
>  __perf_event_output kernel/events/core.c:6494 [inline]
>  perf_event_output_forward+0x10a/0x2b0 kernel/events/core.c:6512
>  __perf_event_overflow+0x231/0x4b0 kernel/events/core.c:7748
>  perf_swevent_overflow+0xad/0x150 kernel/events/core.c:7824
>  perf_swevent_event+0x1f0/0x2e0 kernel/events/core.c:7857
>  perf_tp_event+0x4da/0xc30 kernel/events/core.c:8280
>  perf_trace_run_bpf_submit+0x23f/0x370 kernel/events/core.c:8254
>  perf_trace_lock_acquire+0x4f1/0x980 include/trace/events/lock.h:13
>  trace_lock_acquire include/trace/events/lock.h:13 [inline]
>  lock_acquire+0x38e/0x520 kernel/locking/lockdep.c:3919
>  finish_lock_switch kernel/sched/core.c:2602 [inline]
>  finish_task_switch+0x1c2/0x820 kernel/sched/core.c:2701
>  context_switch kernel/sched/core.c:2851 [inline]
>  __schedule+0x80f/0x1e40 kernel/sched/core.c:3490
>  schedule+0xef/0x430 kernel/sched/core.c:3549
>  schedule_hrtimeout_range_clock+0x3c0/0x470 kernel/time/hrtimer.c:1883
>  schedule_hrtimeout_range+0x2a/0x40 kernel/time/hrtimer.c:1940
>  ep_poll+0xf2e/0x11d0 fs/eventpoll.c:1812
>  do_epoll_wait+0x1b0/0x200 fs/eventpoll.c:2191
>  SYSC_epoll_wait fs/eventpoll.c:2201 [inline]
>  SyS_epoll_wait+0x2c/0x40 fs/eventpoll.c:2198
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x7fe39adf3943
> RSP: 002b:00007ffc13750708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
> RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fe39adf3943
> RDX: 0000000000000008 RSI: 00007ffc13750800 RDI: 000000000000000a
> RBP: 0000000001b676c0 R08: 0000000000000000 R09: 00007fe39ae3ca60
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000a56
> R13: 0000000000000000 R14: 0000000001b674a0 R15: 0000000001b4e250
> 
> Allocated by task 4544:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:552
>  __do_kmalloc_node mm/slab.c:3670 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3677
>  kmalloc_node include/linux/slab.h:554 [inline]
>  alloc_callchain_buffers kernel/events/callchain.c:91 [inline]
>  get_callchain_buffers+0x31a/0x4b0 kernel/events/callchain.c:138
>  perf_event_alloc.part.91+0x2274/0x30a0 kernel/events/core.c:10047
>  perf_event_alloc kernel/events/core.c:10376 [inline]
>  SYSC_perf_event_open+0xa8a/0x2fa0 kernel/events/core.c:10477
>  SyS_perf_event_open+0x35/0x40 kernel/events/core.c:10366
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7

I think we miss the max-stack check for the initial event
that creates the buffers.. that allows us to create event
with max-stack value bigger than the global max:


[root@ibm-x3650m4-01 perf]# sysctl -a | grep perf_event_max_stack
kernel.perf_event_max_stack = 127

[root@ibm-x3650m4-01 perf]# ./perf record -vv -C 1 -e cycles/max-stack=256/ kill 
Using CPUID GenuineIntel-6-2D
------------------------------------------------------------
perf_event_attr:
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  sample_max_stack                 256
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4


note the '-C 1', which forces perf record to create just single event,
otherwise it opens event for every cpu and then the test fails on the
second event and all's fine

attached change should fix it.. I'm running some more tests
and will post full patch later

thanks,
jirka


---
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 772a43fea825..0d97e3fda920 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -119,19 +119,21 @@ int get_callchain_buffers(int event_max_stack)
 		goto exit;
 	}
 
-	if (count > 1) {
-		/* If the allocation failed, give up */
-		if (!callchain_cpus_entries)
-			err = -ENOMEM;
-		/*
-		 * If requesting per event more than the global cap,
-		 * return a different error to help userspace figure
-		 * this out.
-		 *
-		 * And also do it here so that we have &callchain_mutex held.
-		 */
-		if (event_max_stack > sysctl_perf_event_max_stack)
-			err = -EOVERFLOW;
+	/*
+	 * If requesting per event more than the global cap,
+	 * return a different error to help userspace figure
+	 * this out.
+	 *
+	 * And also do it here so that we have &callchain_mutex held.
+	 */
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
+		goto exit;
+	}
+
+	/* If the allocation failed, give up */
+	if (count > 1 && !callchain_cpus_entries) {
+		err = -ENOMEM;
 		goto exit;
 	}
 
