Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeDJBjD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:39:03 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:49286 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDJBjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:39:02 -0400
X-Google-Smtp-Source: AIpwx4+RcFNd15khDL05GEywCBzib8cCCyrUDApSu6o18HyVxE1HK1aDoM6Mvfuzbg9jcRMhwW6a3QMELjh5THwxtkeSmAKn0WQp
MIME-Version: 1.0
Date: Mon, 09 Apr 2018 18:39:01 -0700
In-Reply-To: <00000000000078359d056928b7ea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046a7c805697496e1@google.com>
Subject: Re: INFO: rcu detected stall in __snd_pcm_lib_xfer (2)
From: syzbot <syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com>
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
fd40ffc72e2f74c7db61e400903e7d50a88bc0b0 (Mon Apr 9 18:36:05 2018 +0000)
selinux: fix missing dput() before selinuxfs unmount
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=7e3f31a52646f939c052

So far this crash happened 731 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5746654556717056
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5437811310198784
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5066563195502592
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-771321277174894814
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

INFO: rcu_sched self-detected stall on CPU
	0-....: (124999 ticks this GP) idle=1f2/1/4611686018427387906  
softirq=10492/10492 fqs=31246
	 (t=125000 jiffies g=4909 c=4908 q=3)
NMI backtrace for cpu 0
CPU: 0 PID: 4481 Comm: syzkaller419220 Not tainted 4.16.0+ #14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:793 [inline]
RIP: 0010:snd_pcm_stream_unlock_irq+0xb7/0xf0 sound/core/pcm_native.c:166
RSP: 0018:ffff8801ac8a6b60 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801a89e2700 RBX: 0000000000000000 RCX: 1ffff1003513c5f3
RDX: 0000000000000000 RSI: ffffffff85a14e10 RDI: ffffffff88b17bf8
RBP: ffff8801ac8a6b68 R08: ffff8801a89e2f78 R09: 0000000000000006
R10: ffff8801a89e2700 R11: 0000000000000000 R12: 0000000000000004
R13: 00000000ffffffe0 R14: ffff8801d9a6ac00 R15: ffff8801ceb2f200
  __snd_pcm_lib_xfer+0x739/0x1d10 sound/core/pcm_lib.c:2246
  snd_pcm_oss_write3+0xe9/0x220 sound/core/oss/pcm_oss.c:1236
  snd_pcm_oss_write2+0x34c/0x460 sound/core/oss/pcm_oss.c:1373
  snd_pcm_oss_sync1+0x332/0x5a0 sound/core/oss/pcm_oss.c:1606
  snd_pcm_oss_sync.isra.29+0x790/0x980 sound/core/oss/pcm_oss.c:1682
  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2559
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x449eb9
RSP: 002b:00007f302d286da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dcc5c RCX: 0000000000449eb9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dcc5c
RBP: 00000000006dcc58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0100000000000000
R13: 7073642f7665642f R14: 646e732f7665642f R15: 0000000000000009
