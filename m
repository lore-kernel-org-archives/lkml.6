Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754007AbeD2QdF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:33:05 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41312 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbeD2QdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:33:02 -0400
X-Google-Smtp-Source: AB8JxZofhvdb9xHnDl811hw36ACTynZVI8fO2cGMbF+/ugE+aEHMJN/9NtB/d6zOIOoJVQjvRSooouo5YXilppbDwZ/I5rvhhxfY
MIME-Version: 1.0
Date: Sun, 29 Apr 2018 09:33:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000799e6c056aff4a6f@google.com>
Subject: INFO: rcu detected stall in skb_free_head
From: syzbot <syzbot+cac7c17ec0aca89d3c45@syzkaller.appspotmail.com>
To: avagin@virtuozzo.com, davem@davemloft.net, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018 +0000)
Merge branch 'parisc-4.17-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=cac7c17ec0aca89d3c45

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6517400396627968
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cac7c17ec0aca89d3c45@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	1-...!: (117917 ticks this GP) idle=036/1/4611686018427387906  
softirq=114416/114416 fqs=32
	 (t=125000 jiffies g=60712 c=60711 q=345938)
rcu_sched kthread starved for 124847 jiffies! g60712 c60711 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23592     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
NMI backtrace for cpu 1
CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.17.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events rht_deferred_worker
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
  __rcu_pending kernel/rcu/tree.c:3356 [inline]
  rcu_pending kernel/rcu/tree.c:3401 [inline]
  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:kfree+0x124/0x260 mm/slab.c:3814
RSP: 0018:ffff8801db105450 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffff88006c118040 RCX: 1ffff1003b3059e7
RDX: 0000000000000000 RSI: ffff8801d982cf90 RDI: 0000000000000286
RBP: ffff8801db105470 R08: ffff8801d982ce78 R09: 0000000000000002
R10: ffff8801d982c640 R11: 0000000000000000 R12: 0000000000000286
R13: ffff8801dac00ac0 R14: ffffffff85bd7b69 R15: ffff88006c0f8180
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x690/0x860 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x195/0x560 net/core/skbuff.c:659
  enqueue_to_backlog+0x2fc/0xc90 net/core/dev.c:3968
  netif_rx_internal+0x14d/0xae0 net/core/dev.c:4181
  netif_rx+0xba/0x400 net/core/dev.c:4206
  loopback_xmit+0x283/0x741 drivers/net/loopback.c:91
  __netdev_start_xmit include/linux/netdevice.h:4087 [inline]
  netdev_start_xmit include/linux/netdevice.h:4096 [inline]
  xmit_one net/core/dev.c:3053 [inline]
  dev_hard_start_xmit+0x264/0xc10 net/core/dev.c:3069
  __dev_queue_xmit+0x2724/0x34c0 net/core/dev.c:3584
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3617
  neigh_hh_output include/net/neighbour.h:472 [inline]
  neigh_output include/net/neighbour.h:480 [inline]
  ip_finish_output2+0x1046/0x1840 net/ipv4/ip_output.c:229
  ip_finish_output+0x828/0xf80 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip_output+0x21b/0x850 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  ip_queue_xmit+0x9d7/0x1f70 net/ipv4/ip_output.c:504
  sctp_v4_xmit+0x108/0x140 net/sctp/protocol.c:983
  sctp_packet_transmit+0x26f6/0x3ba0 net/sctp/output.c:650
  sctp_outq_flush+0x1373/0x4370 net/sctp/outqueue.c:1197
  sctp_outq_uncork+0x6a/0x80 net/sctp/outqueue.c:776
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x596/0x7160 net/sctp/sm_sideeffect.c:1191
  sctp_generate_heartbeat_event+0x218/0x450 net/sctp/sm_sideeffect.c:406
  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1046
  </IRQ>
  do_softirq.part.17+0x14d/0x190 kernel/softirq.c:329
  do_softirq arch/x86/include/asm/preempt.h:23 [inline]
  __local_bh_enable_ip+0x1ec/0x230 kernel/softirq.c:182
  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:176 [inline]
  _raw_spin_unlock_bh+0x30/0x40 kernel/locking/spinlock.c:200
  spin_unlock_bh include/linux/spinlock.h:355 [inline]
  rhashtable_rehash_chain lib/rhashtable.c:292 [inline]
  rhashtable_rehash_table lib/rhashtable.c:333 [inline]
  rht_deferred_worker+0x1058/0x1fb0 lib/rhashtable.c:432
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 126s!
BUG: workqueue lockup - pool cpus=0-1 flags=0x4 nice=0 stuck for 126s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=8/256
     in-flight: 24:rht_deferred_worker
     pending: rht_deferred_worker, defense_work_handler,  
defense_work_handler, perf_sched_delayed, defense_work_handler,  
switchdev_deferred_process_work, cache_reap
   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=11/256
     pending: jump_label_update_timeout, defense_work_handler,  
defense_work_handler, defense_work_handler, defense_work_handler,  
defense_work_handler, defense_work_handler, check_corruption,  
key_garbage_collector, vmstat_shepherd, cache_reap
workqueue events_long: flags=0x0
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256
     pending: br_fdb_cleanup, br_fdb_cleanup, br_fdb_cleanup
   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=5/256
     pending: br_fdb_cleanup, br_fdb_cleanup, br_fdb_cleanup,  
br_fdb_cleanup, br_fdb_cleanup
workqueue events_unbound: flags=0x2
   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/512
     in-flight: 10434:fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
     pending: neigh_periodic_work
   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256
     pending: check_lifetime, gc_worker, do_cache_clean, neigh_periodic_work
workqueue rcu_gp: flags=0x8
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
     pending: process_srcu
workqueue mm_percpu_wq: flags=0x8
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
     pending: vmstat_update
   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
     pending: vmstat_update
workqueue writeback: flags=0x4e
   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256
     in-flight: 13940:wb_workfn
workqueue kblockd: flags=0x18
   pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=2/256
     pending: blk_mq_timeout_work, blk_mq_timeout_work
workqueue dm_bufio_cache: flags=0x8
   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
     pending: work_fn
workqueue ipv6_addrconf: flags=0x40008
   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1
     pending: addrconf_verify_work
workqueue krdsd: flags=0xe000a
   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/1
     in-flight: 301:rds_connect_worker
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=127s workers=3 idle: 4831 4860
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=8 idle: 301 22 6 7437  
6882 50


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
