Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDFNV7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:21:59 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:42733 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeDFNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:21:57 -0400
X-Google-Smtp-Source: AIpwx49N5P8QmpfZiV9x4RXnmJZp3tgt/WUTX8goJb8oYGNFgkGL5EbMosD2rLpvW+0GXfmZ10rwJR+GUQvdd577/2k=
MIME-Version: 1.0
In-Reply-To: <s5hzi2gjy3h.wl-tiwai@suse.de>
References: <00000000000078359d056928b7ea@google.com> <s5hzi2gjy3h.wl-tiwai@suse.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Apr 2018 15:21:36 +0200
Message-ID: <CACT4Y+bJJ+g6t6J4XF7av_PGcYm2R1Kd0YVxt5+eojJK416SzA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in __snd_pcm_lib_xfer (2)
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 2:52 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 06 Apr 2018 09:08:01 +0200,
> syzbot wrote:
>>
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> e02d37bf55a9a36f22427fd6dd733fe104d817b6 (Thu Apr 5 17:42:07 2018 +0000)
>> Merge tag 'sound-4.17-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=7e3f31a52646f939c052
>>
>> So far this crash happened 43 times on upstream.
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=5148264345108480
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=-4805825610197092128
>> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> INFO: rcu_sched self-detected stall on CPU
>>       1-...!: (124999 ticks this GP) idle=522/1/4611686018427387906
>> softirq=65432/65432 fqs=169
>>        (t=125000 jiffies g=35384 c=35383 q=537)
>> rcu_sched kthread starved for 124294 jiffies! g35384 c35383 f0x0
>> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
>> RCU grace-period kthread stack dump:
>> rcu_sched       R  running task    23768     9      2 0x80000000
>> Call Trace:
>>  context_switch kernel/sched/core.c:2848 [inline]
>>  __schedule+0x807/0x1e40 kernel/sched/core.c:3490
>>  schedule+0xef/0x430 kernel/sched/core.c:3549
>>  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
>>  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
>>  kthread+0x345/0x410 kernel/kthread.c:238
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
>> NMI backtrace for cpu 1
>> CPU: 1 PID: 15299 Comm: syz-executor3 Not tainted 4.16.0+ #2
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS  Google 01/01/2011
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
>>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>>  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
>>  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
>>  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
>>  __rcu_pending kernel/rcu/tree.c:3356 [inline]
>>  rcu_pending kernel/rcu/tree.c:3401 [inline]
>>  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
>>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>>  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
>>  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
>>  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
>>  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
>>  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
>>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
>>  </IRQ>
>> RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:793 [inline]
>> RIP: 0010:snd_pcm_stream_unlock_irq+0xb7/0xf0 sound/core/pcm_native.c:166
>> RSP: 0018:ffff8801c3f27560 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>> RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc900038d5000
>> RDX: 0000000000040000 RSI: ffffffff859ca760 RDI: ffffffff88b172b8
>> RBP: ffff8801c3f27568 R08: ffff8801abf86af8 R09: 0000000000000006
>> R10: ffff8801abf86280 R11: 0000000000000000 R12: 0000000000000004
>> R13: 00000000ffffffe0 R14: ffff8801d7d9e1c0 R15: ffff8801ceac6940
>>  __snd_pcm_lib_xfer+0x739/0x1d10 sound/core/pcm_lib.c:2246
>>  snd_pcm_oss_write3+0xe9/0x220 sound/core/oss/pcm_oss.c:1236
>>  io_playback_transfer+0x274/0x310 sound/core/oss/io.c:47
>>  snd_pcm_plug_write_transfer+0x36c/0x470 sound/core/oss/pcm_plugin.c:619
>>  snd_pcm_oss_write2+0x25c/0x460 sound/core/oss/pcm_oss.c:1365
>>  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1415 [inline]
>>  snd_pcm_oss_write+0x764/0xa20 sound/core/oss/pcm_oss.c:2774
>>  __vfs_write+0x10b/0x880 fs/read_write.c:485
>>  vfs_write+0x1f8/0x560 fs/read_write.c:549
>>  ksys_write+0xf9/0x250 fs/read_write.c:598
>>  SYSC_write fs/read_write.c:610 [inline]
>>  SyS_write+0x24/0x30 fs/read_write.c:607
>>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> RIP: 0033:0x4552d9
>> RSP: 002b:00007f1568de6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 00007f1568de76d4 RCX: 00000000004552d9
>> RDX: 0000000000000060 RSI: 0000000020000000 RDI: 0000000000000013
>> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000000006c0 R14: 00000000006fd2a0 R15: 0000000000000000
>
> Hmm, a problem that appears like the issue we've already fixed strikes
> back.  Maybe because of the recent my code change for further
> hardening of PCM OSS.
>
> If there is a reproducer, I'd take a deeper look, but currently I
> couldn't see the obvious cause, and all reproducers in the past seem
> working.  So if you get any reproducer, please let me know.
>
> There are a couple of pending small fixes that might cure this, and
> I'm going to submit & merge before 4.17-rc1, in anyway.


Hi Takashi,

syzbot will notify when/if a reproducer is available.

It happens pretty actively, so if it is cured by any commits, we will
see it stop happening here:
https://syzkaller.appspot.com/bug?extid=7e3f31a52646f939c052

There is also a bunch of similarly looking rcu stalls (also in sound
and started happening all at once):
https://syzkaller.appspot.com/bug?id=f087e17667da6944617675babc90277bc5a7b34e
https://syzkaller.appspot.com/bug?id=55381513d03b0098c2905ae1a48b4cc7c3b25a22
https://syzkaller.appspot.com/bug?id=f9364472bcbd3cb1738f774dd3711668cb402216

With high probability it is something that was just merged upstream.
