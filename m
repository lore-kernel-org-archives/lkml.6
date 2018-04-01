Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeDAIQE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:16:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:39832 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeDAIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:16:01 -0400
X-Google-Smtp-Source: AIpwx49GyQeLU7PFiD46IatFbojxsA5MLFXDmP7RiSS4IWX8KR0shrbHTJWyY5vZQBeJ4lqxyB8ZX1QiQXq7fxKnYXQZnGuJNYIX
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 01:16:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113de6546d13ac0568c51530@google.com>
Subject: INFO: rcu detected stall in sch_direct_xmit
From: syzbot <syzbot+536ae84aa971d463d902@syzkaller.appspotmail.com>
To: davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on net-next commit
18845557fd6fc1998f2d0d8c30467f86db587529 (Thu Mar 29 20:24:06 2018 +0000)
Merge tag 'wireless-drivers-next-for-davem-2018-03-29' of  
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=536ae84aa971d463d902

So far this crash happened 112 times on net-next.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4584417414610944
Kernel config: https://syzkaller.appspot.com/x/.config?id=-37309782588693906
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+536ae84aa971d463d902@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

device bridge0 entered promiscuous mode
INFO: rcu_sched self-detected stall on CPU
	1-...!: (1 GPs behind) idle=cfa/1/4611686018427387906 softirq=96595/96596  
fqs=30
	 (t=125000 jiffies g=45745 c=45744 q=716)
rcu_sched kthread starved for 124864 jiffies! g45745 c45744 f0x0  
RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
rcu_sched       I24616     8      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2862 [inline]
  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
  schedule+0xf5/0x430 kernel/sched/core.c:3499
  schedule_timeout+0x118/0x230 kernel/time/timer.c:1801
  rcu_gp_kthread+0x9dd/0x18e0 kernel/rcu/tree.c:2230
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
NMI backtrace for cpu 1
CPU: 1 PID: 12481 Comm: syz-executor5 Not tainted 4.16.0-rc6+ #286
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x186/0x1de kernel/rcu/tree.c:1375
  print_cpu_stall kernel/rcu/tree.c:1524 [inline]
  check_cpu_stall.isra.61+0xbb8/0x15b0 kernel/rcu/tree.c:1592
  __rcu_pending kernel/rcu/tree.c:3361 [inline]
  rcu_pending kernel/rcu/tree.c:3423 [inline]
  rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2763
  update_process_times+0x30/0x60 kernel/time/timer.c:1636
  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
  __run_hrtimer kernel/time/hrtimer.c:1349 [inline]
  __hrtimer_run_queues+0x39c/0xec0 kernel/time/hrtimer.c:1411
  hrtimer_interrupt+0x2a5/0x6f0 kernel/time/hrtimer.c:1469
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
  </IRQ>
RIP: 0010:atomic_read arch/x86/include/asm/atomic.h:27 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:68 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x12d/0xfa0  
kernel/locking/qspinlock.c:305
RSP: 0018:ffff8801a69da1d0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
RAX: 0000000000000001 RBX: ffff8801c135c140 RCX: dffffc0000000000
RDX: 0000000000000004 RSI: ffff8801a69da2a0 RDI: ffff8801c135c140
RBP: ffff8801a69da548 R08: ffffffff85142d51 R09: 0000000000000000
R10: ffff8801a69da468 R11: ffff8801c135c158 R12: ffffed0034d3b454
R13: ffff8801a69da520 R14: 1ffff10034d3b440 R15: 0000000000000003
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:669 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:30 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:90 [inline]
  do_raw_spin_lock+0x185/0x220 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:310 [inline]
  __netif_tx_lock include/linux/netdevice.h:3575 [inline]
  sch_direct_xmit+0x361/0x1140 net/sched/sch_generic.c:325
  qdisc_restart net/sched/sch_generic.c:393 [inline]
  __qdisc_run+0x57d/0x18e0 net/sched/sch_generic.c:401
  __dev_xmit_skb net/core/dev.c:3241 [inline]
  __dev_queue_xmit+0xb8b/0x2fc0 net/core/dev.c:3549
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3614
  br_dev_queue_push_xmit+0x196/0x5a0 net/bridge/br_forward.c:55
  NF_HOOK include/linux/netfilter.h:288 [inline]
  br_forward_finish+0xc8/0x530 net/bridge/br_forward.c:67
  NF_HOOK include/linux/netfilter.h:288 [inline]
  __br_forward+0x533/0xc80 net/bridge/br_forward.c:112
  br_flood+0x665/0x770 net/bridge/br_forward.c:225
  br_dev_xmit+0xa68/0x1550 net/bridge/br_device.c:87
  __netdev_start_xmit include/linux/netdevice.h:4080 [inline]
  netdev_start_xmit include/linux/netdevice.h:4089 [inline]
  xmit_one net/core/dev.c:3050 [inline]
  dev_hard_start_xmit+0x24e/0xac0 net/core/dev.c:3066
  __dev_queue_xmit+0x26bf/0x2fc0 net/core/dev.c:3581
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3614
  neigh_hh_output include/net/neighbour.h:472 [inline]
  neigh_output include/net/neighbour.h:480 [inline]
  ip_finish_output2+0xf4d/0x1550 net/ipv4/ip_output.c:229
  ip_finish_output+0x864/0xd60 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip_mc_output+0x271/0x1350 net/ipv4/ip_output.c:390
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
  iptunnel_xmit+0x556/0x810 net/ipv4/ip_tunnel_core.c:91
  ip_tunnel_xmit+0x177b/0x3550 net/ipv4/ip_tunnel.c:768
  __gre_xmit+0x546/0x8b0 net/ipv4/ip_gre.c:449
  erspan_xmit+0x779/0x22a0 net/ipv4/ip_gre.c:731
  __netdev_start_xmit include/linux/netdevice.h:4080 [inline]
  netdev_start_xmit include/linux/netdevice.h:4089 [inline]
  xmit_one net/core/dev.c:3050 [inline]
  dev_hard_start_xmit+0x24e/0xac0 net/core/dev.c:3066
  sch_direct_xmit+0x40d/0x1140 net/sched/sch_generic.c:327
  qdisc_restart net/sched/sch_generic.c:393 [inline]
  __qdisc_run+0x57d/0x18e0 net/sched/sch_generic.c:401
  __dev_xmit_skb net/core/dev.c:3241 [inline]
  __dev_queue_xmit+0xb8b/0x2fc0 net/core/dev.c:3549
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3614
  br_dev_queue_push_xmit+0x196/0x5a0 net/bridge/br_forward.c:55
  NF_HOOK include/linux/netfilter.h:288 [inline]
  br_forward_finish+0xc8/0x530 net/bridge/br_forward.c:67
  NF_HOOK include/linux/netfilter.h:288 [inline]
  __br_forward+0x533/0xc80 net/bridge/br_forward.c:112
  br_flood+0x665/0x770 net/bridge/br_forward.c:225
  br_dev_xmit+0xa68/0x1550 net/bridge/br_device.c:87
  __netdev_start_xmit include/linux/netdevice.h:4080 [inline]
  netdev_start_xmit include/linux/netdevice.h:4089 [inline]
  xmit_one net/core/dev.c:3050 [inline]
  dev_hard_start_xmit+0x24e/0xac0 net/core/dev.c:3066
  __dev_queue_xmit+0x26bf/0x2fc0 net/core/dev.c:3581
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3614
  neigh_resolve_output+0x5e2/0xa00 net/core/neighbour.c:1350
  neigh_output include/net/neighbour.h:482 [inline]
  ip_finish_output2+0x91a/0x1550 net/ipv4/ip_output.c:229
  ip_finish_output+0x864/0xd60 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip_mc_output+0x271/0x1350 net/ipv4/ip_output.c:390
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
  ip_queue_xmit+0x8c0/0x1920 net/ipv4/ip_output.c:504
  sctp_v4_xmit+0x108/0x140 net/sctp/protocol.c:942
  sctp_packet_transmit+0x22a5/0x37c0 net/sctp/output.c:642
  sctp_outq_flush+0xabb/0x4060 net/sctp/outqueue.c:911
  sctp_outq_uncork+0x5a/0x70 net/sctp/outqueue.c:776
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x4e0/0x7040 net/sctp/sm_sideeffect.c:1191
  sctp_primitive_ASSOCIATE+0x9d/0xd0 net/sctp/primitive.c:88
  sctp_sendmsg_to_asoc+0x14bf/0x1ec0 net/sctp/socket.c:1900
  sctp_sendmsg+0xc50/0x1ad0 net/sctp/socket.c:2088
  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:639
  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2047
  __sys_sendmsg+0xe5/0x210 net/socket.c:2081
  SYSC_sendmsg net/socket.c:2092 [inline]
  SyS_sendmsg+0x2d/0x50 net/socket.c:2088
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4548b9
RSP: 002b:00007f43d1e5dc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f43d1e5e6d4 RCX: 00000000004548b9
RDX: 0000000000000040 RSI: 0000000020001f00 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004e3 R14: 00000000006f95e8 R15: 0000000000000000


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
