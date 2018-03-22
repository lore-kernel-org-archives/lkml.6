Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCVTn7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:43:59 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45599 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeCVTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:43:52 -0400
X-Google-Smtp-Source: AG47ELsHp4p+tt+epQFP9tJv8Fr4pT6oLxBFWOXwpcO0RTlHbcwRrbS7BJW8fom9CHFbEcKwsAVCTg==
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Recent kernel change causing "rcu_sched detected stalls on
 CPUs/tasks"
Message-ID: <abc00d05-6c96-ee4e-3111-5fb5c0ec1c83@gmail.com>
Date: Thu, 22 Mar 2018 20:43:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to get the following sporadic errors. Maybe related:
When working with putty on the console then console frequently hangs
for few seconds.
linux-next from March 2nd still works fine.
Platform is x86_64, Zotac CI-321 with Intel 2961Y.


[ 9755.298719] INFO: rcu_sched detected stalls on CPUs/tasks:
[ 9755.298823] 	0-...!: (9 GPs behind) idle=018/0/0 softirq=38150/38158 fqs=0 
[ 9755.299006] 	(detected by 1, t=39181 jiffies, g=16091, c=16090, q=10)
[ 9755.299068] Sending NMI from CPU 1 to CPUs 0:
[ 9755.299126] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x76/0x120
[ 9755.300139] rcu_sched kthread starved for 39182 jiffies! g16091 c16090 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[ 9755.300215] RCU grace-period kthread stack dump:
[ 9755.300254] rcu_sched       I    0    10      2 0x80000000
[ 9755.300307] Call Trace:
[ 9755.300345]  __schedule+0x27e/0xac0
[ 9755.300387]  ? trace_hardirqs_on_caller+0xef/0x180
[ 9755.300432]  schedule+0x2e/0x90
[ 9755.300465]  schedule_timeout+0x1d4/0x570
[ 9755.300510]  ? __next_timer_interrupt+0xd0/0xd0
[ 9755.300553]  rcu_gp_kthread+0x491/0x7d0
[ 9755.300594]  kthread+0x127/0x140
[ 9755.300628]  ? call_rcu_sched+0x20/0x20
[ 9755.300667]  ? kthread_create_worker_on_cpu+0x40/0x40
[ 9755.300713]  ret_from_fork+0x3a/0x50
[10478.726348] INFO: rcu_sched self-detected stall on CPU
[10478.726384] INFO: rcu_sched detected stalls on CPUs/tasks:
[10478.726417] 	0-...!: (1 GPs behind) idle=d36/0/1 softirq=38536/38591 fqs=0 
[10478.726511] 	
[10478.726523] 	0-...!: (1 GPs behind) idle=d36/0/1 softirq=38536/38591 fqs=0 
[10478.726591]  (t=42485 jiffies g=16264 c=16263 q=6)
[10478.726605] rcu_sched kthread starved for 42485 jiffies! g16264 c16263 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[10478.726641] 	
[10478.726712] RCU grace-period kthread stack dump:
[10478.726718] rcu_sched       I
[10478.726738] (detected by 1, t=42485 jiffies, g=16264, c=16263, q=6)
[10478.726746] Sending NMI from CPU 1 to CPUs 0:
[10478.726783]     0    10      2 0x80000000
[10478.727240] Call Trace:
[10478.727273]  __schedule+0x27e/0xac0
[10478.727311]  ? trace_hardirqs_on_caller+0xef/0x180
[10478.727357]  schedule+0x2e/0x90
[10478.727390]  schedule_timeout+0x1d4/0x570
[10478.727433]  ? __next_timer_interrupt+0xd0/0xd0
[10478.727475]  rcu_gp_kthread+0x491/0x7d0
[10478.727517]  kthread+0x127/0x140
[10478.727551]  ? call_rcu_sched+0x20/0x20
[10478.727590]  ? kthread_create_worker_on_cpu+0x40/0x40
[10478.727635]  ret_from_fork+0x3a/0x50
[10478.727829] NMI backtrace for cpu 0
[10478.727833] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc6-next-20180321+ #2
[10478.727835] Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
[10478.727837] RIP: 0010:console_unlock+0x79/0x640
[10478.727839] RSP: 0018:ffff96349ba03d00 EFLAGS: 00000097
[10478.727844] RAX: ffffffff8c2b9a1b RBX: 0000000000000046 RCX: 000000001da029fb
[10478.727846] RDX: 0000000000000001 RSI: 00000000683da59d RDI: ffffffff8d04e1e0
[10478.727848] RBP: ffff96349ba03d38 R08: 0000000000000294 R09: 0000000000000000
[10478.727850] R10: ffff96349ba03c70 R11: 000000000000000c R12: 0000000000000000
[10478.727853] R13: 0000000000000046 R14: ffffffff8d0d9fe0 R15: 000000000000001d
[10478.727855] FS:  0000000000000000(0000) GS:ffff96349ba00000(0000) knlGS:0000000000000000
[10478.727857] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10478.727859] CR2: 00007fc0e849b010 CR3: 000000008c40f004 CR4: 00000000000606f0
[10478.727861] Call Trace:
[10478.727862]  <IRQ>
[10478.727864]  vprintk_emit+0x223/0x410
[10478.727866]  vprintk_default+0x1a/0x20
[10478.727868]  vprintk_func+0x22/0x60
[10478.727870]  printk+0x3e/0x46
[10478.727871]  sched_show_task+0x155/0x220
[10478.727873]  rcu_check_gp_kthread_starvation+0xb9/0xda
[10478.727875]  rcu_check_callbacks+0x743/0x980
[10478.727877]  ? trace_hardirqs_off+0xd/0x10
[10478.727879]  ? tick_sched_do_timer+0x40/0x40
[10478.727881]  update_process_times+0x2a/0x50
[10478.727882]  tick_sched_handle+0x34/0x40
[10478.727884]  tick_sched_timer+0x34/0x80
[10478.727886]  __hrtimer_run_queues+0x101/0x520
[10478.727888]  ? trace_hardirqs_off+0xd/0x10
[10478.727890]  hrtimer_interrupt+0xc9/0x210
[10478.727892]  smp_apic_timer_interrupt+0x79/0x2b0
[10478.727893]  apic_timer_interrupt+0xf/0x20
[10478.727895]  </IRQ>
[10478.727897] RIP: 0010:cpuidle_enter_state+0xa5/0x370
[10478.727899] RSP: 0018:ffffffff8d003e28 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
[10478.727903] RAX: ffffffff8d014500 RBX: 000000000000695a RCX: 0000000000000000
[10478.727905] RDX: 0000000000000046 RSI: 0000000000000001 RDI: ffffffff8d014500
[10478.727907] RBP: ffffffff8d003e68 R08: 0000000000065840 R09: 0000000000000000
[10478.727910] R10: 0000000000000000 R11: 0000000000000000 R12: ffff96349ba28770
[10478.727912] R13: 0000000000000001 R14: ffffffff8d082e38 R15: 0000000000000000
[10478.727914]  ? cpuidle_enter_state+0xa0/0x370
[10478.727915]  cpuidle_enter+0x12/0x20
[10478.727917]  call_cpuidle+0x1e/0x40
[10478.727919]  do_idle+0x179/0x1c0
[10478.727921]  cpu_startup_entry+0x18/0x20
[10478.727922]  rest_init+0xc2/0xd0
[10478.727924]  start_kernel+0x3e8/0x3f5
[10478.727926]  x86_64_start_reservations+0x24/0x26
[10478.727928]  x86_64_start_kernel+0x6f/0x72
[10478.727930]  secondary_startup_64+0xa5/0xb0
[10478.727931] Code: 00 00 9c 8f 45 d0 fa e8 76 1d ff ff e8 31 1a 00 00 48 c7 c7 e0 e1 04 8d e8 25 74 4f 00 4c 8b 05 56 0a b2 01 4c 39 05 f7 01 ae 01 <74> 0b 4c 89 05 ee 01 ae 01 c6 45 cf 01 48 8b 0d 2b 0a b2 01 48 
[10478.728026] rcu_sched kthread starved for 42485 jiffies! g16264 c16263 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
[10478.728028] NMI backtrace for cpu 0
[10478.728037] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc6-next-20180321+ #2
[10478.728061] RCU grace-period kthread stack dump:
[10478.728067] rcu_sched       R
[10478.728122] Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
[10478.728126] Call Trace:
[10478.728182]   running task        0    10      2 0x80000000
[10478.728224]  <IRQ>
[10478.728262] Call Trace:
[10478.728279]  __schedule+0x27e/0xac0
[10478.728321]  dump_stack+0x70/0xa5
[10478.728332]  nmi_cpu_backtrace+0xbe/0xc0
[10478.728388]  ? trace_hardirqs_on_caller+0xef/0x180
[10478.728433]  ? lapic_can_unplug_cpu+0xa0/0xa0
[10478.728443]  nmi_trigger_cpumask_backtrace+0x98/0xd0
[10478.728497]  schedule+0x2e/0x90
[10478.728548]  arch_trigger_cpumask_backtrace+0x14/0x20
[10478.728605]  schedule_timeout+0x1d4/0x570
[10478.728617]  ? __next_timer_interrupt+0xd0/0xd0
[10478.728656]  rcu_dump_cpu_stacks+0xa7/0xd9
[10478.728665]  rcu_check_callbacks+0x74b/0x980
[10478.728717]  rcu_gp_kthread+0x491/0x7d0
[10478.728741]  ? trace_hardirqs_off+0xd/0x10
[10478.728750]  ? tick_sched_do_timer+0x40/0x40
[10478.728774]  kthread+0x127/0x140
[10478.728800]  update_process_times+0x2a/0x50
[10478.728809]  tick_sched_handle+0x34/0x40
[10478.728839]  ? call_rcu_sched+0x20/0x20
[10478.728848]  ? kthread_create_worker_on_cpu+0x40/0x40
[10478.728876]  tick_sched_timer+0x34/0x80
[10478.728883]  __hrtimer_run_queues+0x101/0x520
[10478.728914]  ret_from_fork+0x3a/0x50
[10478.728944]  ? trace_hardirqs_off+0xd/0x10
[10478.728953]  hrtimer_interrupt+0xc9/0x210
[10478.731180]  smp_apic_timer_interrupt+0x79/0x2b0
[10478.731223]  apic_timer_interrupt+0xf/0x20
[10478.731259]  </IRQ>
[10478.731287] RIP: 0010:cpuidle_enter_state+0xa5/0x370
[10478.731328] RSP: 0018:ffffffff8d003e28 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
[10478.731392] RAX: ffffffff8d014500 RBX: 000000000000695a RCX: 0000000000000000
[10478.731446] RDX: 0000000000000046 RSI: 0000000000000001 RDI: ffffffff8d014500
[10478.731500] RBP: ffffffff8d003e68 R08: 0000000000065840 R09: 0000000000000000
[10478.731554] R10: 0000000000000000 R11: 0000000000000000 R12: ffff96349ba28770
[10478.731607] R13: 0000000000000001 R14: ffffffff8d082e38 R15: 0000000000000000
[10478.731666]  ? cpuidle_enter_state+0xa0/0x370
[10478.731706]  cpuidle_enter+0x12/0x20
[10478.731742]  call_cpuidle+0x1e/0x40
[10478.731776]  do_idle+0x179/0x1c0
[10478.731810]  cpu_startup_entry+0x18/0x20
[10478.731850]  rest_init+0xc2/0xd0
[10478.731885]  start_kernel+0x3e8/0x3f5
[10478.731922]  x86_64_start_reservations+0x24/0x26
[10478.731965]  x86_64_start_kernel+0x6f/0x72
[10478.732006]  secondary_startup_64+0xa5/0xb0
[15106.895191] INFO: rcu_sched detected stalls on CPUs/tasks:
[15106.895264] 	0-...!: (1 GPs behind) idle=850/0/0 softirq=46299/46345 fqs=0 
[15106.895318] 	(detected by 1, t=49858 jiffies, g=17103, c=17102, q=6)
[15106.895378] Sending NMI from CPU 1 to CPUs 0:
[15106.895436] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x76/0x120
[15106.896428] rcu_sched kthread starved for 49859 jiffies! g17103 c17102 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[15106.896507] RCU grace-period kthread stack dump:
[15106.896546] rcu_sched       I    0    10      2 0x80000000
[15106.896599] Call Trace:
[15106.896639]  __schedule+0x27e/0xac0
[15106.896680]  ? trace_hardirqs_on_caller+0xef/0x180
[15106.896726]  schedule+0x2e/0x90
[15106.896760]  schedule_timeout+0x1d4/0x570
[15106.896805]  ? __next_timer_interrupt+0xd0/0xd0
[15106.896848]  rcu_gp_kthread+0x491/0x7d0
[15106.896889]  kthread+0x127/0x140
[15106.896923]  ? call_rcu_sched+0x20/0x20
[15106.896962]  ? kthread_create_worker_on_cpu+0x40/0x40
[15106.897009]  ret_from_fork+0x3a/0x50
[18580.113132] INFO: rcu_sched detected stalls on CPUs/tasks:
[18580.113213] 	0-...!: (1 GPs behind) idle=d36/0/1 softirq=52012/52014 fqs=0 
[18580.113272] 	(detected by 1, t=42478 jiffies, g=17532, c=17531, q=6)
[18580.113342] Sending NMI from CPU 1 to CPUs 0:
[18580.113397] NMI backtrace for cpu 0
[18580.113406] CPU: 0 PID: 25 Comm: kworker/0:2 Not tainted 4.16.0-rc6-next-20180321+ #2
[18580.113409] Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
[18580.113426] Workqueue: events check_corruption
[18580.113438] RIP: 0010:check_for_bios_corruption+0x5a/0xf0
[18580.113442] RSP: 0018:ffffae9a006fbe10 EFLAGS: 00000246
[18580.113447] RAX: 0000000000000000 RBX: ffff963380008c18 RCX: 0000000000000000
[18580.113449] RDX: 0000000000000001 RSI: ffffffff8d04f8a0 RDI: ffffffff8d02f600
[18580.113452] RBP: ffffae9a006fbe40 R08: ffffffff80000000 R09: 0000000000000000
[18580.113455] R10: ffffae9a006fbde8 R11: 0000000000000004 R12: 00000000000073e8
[18580.113458] R13: ffffffff8d202340 R14: 0000000000000000 R15: 0000000080000000
[18580.113462] FS:  0000000000000000(0000) GS:ffff96349ba00000(0000) knlGS:0000000000000000
[18580.113466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18580.113469] CR2: 00007fc0e793d3b0 CR3: 000000008c40f005 CR4: 00000000000606f0
[18580.113471] Call Trace:
[18580.113484]  check_corruption+0x9/0x40
[18580.113495]  process_one_work+0x24c/0x670
[18580.113504]  worker_thread+0x35/0x3f0
[18580.113512]  kthread+0x127/0x140
[18580.113520]  ? process_one_work+0x670/0x670
[18580.113527]  ? kthread_create_worker_on_cpu+0x40/0x40
[18580.113536]  ret_from_fork+0x3a/0x50
[18580.113539] Code: 8d 53 45 31 f6 41 bf 00 00 00 80 48 83 ec 08 4d 8b 65 08 48 8b 1d 37 c3 ba 00 49 03 5d 00 4d 85 e4 74 12 48 8b 0b 48 85 c9 75 50 <48> 83 c3 08 49 83 ec 08 75 ee 41 83 c6 01 49 83 c5 10 44 39 35 
[18580.114401] rcu_sched kthread starved for 42479 jiffies! g17532 c17531 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[18580.115131] RCU grace-period kthread stack dump:
[18580.115171] rcu_sched       R  running task        0    10      2 0x80000000
[18580.115239] Call Trace:
[18580.115279]  __schedule+0x27e/0xac0
[18580.115321]  ? trace_hardirqs_on_caller+0xef/0x180
[18580.115368]  schedule+0x2e/0x90
[18580.115401]  schedule_timeout+0x1d4/0x570
[18580.115447]  ? __next_timer_interrupt+0xd0/0xd0
[18580.115490]  rcu_gp_kthread+0x491/0x7d0
[18580.115531]  kthread+0x127/0x140
[18580.115565]  ? call_rcu_sched+0x20/0x20
[18580.115604]  ? kthread_create_worker_on_cpu+0x40/0x40
[18580.115651]  ret_from_fork+0x3a/0x50
[19077.707886] INFO: rcu_sched detected stalls on CPUs/tasks:
[19077.707958] 	0-...!: (1 GPs behind) idle=0b4/0/0 softirq=52380/52381 fqs=0 
[19077.708012] 	(detected by 1, t=59990 jiffies, g=17586, c=17585, q=8)
[19077.708073] Sending NMI from CPU 1 to CPUs 0:
[19077.708131] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x76/0x120
[19077.709123] rcu_sched kthread starved for 59991 jiffies! g17586 c17585 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[19077.709201] RCU grace-period kthread stack dump:
[19077.709241] rcu_sched       I    0    10      2 0x80000000
[19077.709294] Call Trace:
[19077.709334]  __schedule+0x27e/0xac0
[19077.709376]  ? trace_hardirqs_on_caller+0xef/0x180
[19077.709421]  schedule+0x2e/0x90
[19077.709455]  schedule_timeout+0x1d4/0x570
[19077.709500]  ? __next_timer_interrupt+0xd0/0xd0
[19077.709543]  rcu_gp_kthread+0x491/0x7d0
[19077.709584]  kthread+0x127/0x140
[19077.709618]  ? call_rcu_sched+0x20/0x20
[19077.709657]  ? kthread_create_worker_on_cpu+0x40/0x40
[19077.709704]  ret_from_fork+0x3a/0x50
[22729.821902] INFO: rcu_sched self-detected stall on CPU
[22729.821937] INFO: rcu_sched detected stalls on CPUs/tasks:
[22729.821971] 	0-...!: (1 GPs behind) idle=24a/1/4611686018427387906 softirq=56015/56021 fqs=0 
[22729.822016] 	 (t=51485 jiffies g=18062 c=18061 q=5)
[22729.822099] 	0-...!: (1 GPs behind) idle=24a/1/4611686018427387906 softirq=56015/56021 fqs=0 
[22729.822132] rcu_sched kthread starved for 51485 jiffies! g18062 c18061 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[22729.822137] RCU grace-period kthread stack dump:
[22729.822200] 	
[22729.822273] rcu_sched       I    0    10      2 0x80000000
[22729.822316] (detected by 1, t=51485 jiffies, g=18062, c=18061, q=5)
[22729.822324] Sending NMI from CPU 1 to CPUs 0:
[22729.822341] Call Trace:
[22729.822832]  __schedule+0x27e/0xac0
[22729.822870]  ? trace_hardirqs_on_caller+0xef/0x180
[22729.822916]  schedule+0x2e/0x90
[22729.822949]  schedule_timeout+0x1d4/0x570
[22729.822991]  ? __next_timer_interrupt+0xd0/0xd0
[22729.823033]  rcu_gp_kthread+0x491/0x7d0
[22729.823073]  kthread+0x127/0x140
[22729.823107]  ? call_rcu_sched+0x20/0x20
[22729.823145]  ? kthread_create_worker_on_cpu+0x40/0x40
[22729.823191]  ret_from_fork+0x3a/0x50
[22729.823385] NMI backtrace for cpu 0
[22729.823388] CPU: 0 PID: 25 Comm: kworker/0:2 Not tainted 4.16.0-rc6-next-20180321+ #2
[22729.823391] Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
[22729.823393] RIP: 0010:console_unlock+0xd1/0x640
[22729.823395] RSP: 0018:ffff96349ba03c20 EFLAGS: 00000082
[22729.823399] RAX: ffffffff8c2b9a1b RBX: ffffffff8ddaa62c RCX: 0000000000000361
[22729.823402] RDX: ffffffff8dd9a450 RSI: 0000000000000048 RDI: 00000000000101dc
[22729.823404] RBP: ffff96349ba03c58 R08: 0000000000000364 R09: 0000000000000007
[22729.823406] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[22729.823408] R13: 0000000000000046 R14: ffffffff8d0d9fe0 R15: 000000000000000b
[22729.823410] FS:  0000000000000000(0000) GS:ffff96349ba00000(0000) knlGS:0000000000000000
[22729.823413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22729.823415] CR2: 0000000000000130 CR3: 000000008c40f006 CR4: 00000000000606f0
[22729.823416] Call Trace:
[22729.823418]  <IRQ>
[22729.823420]  vprintk_emit+0x223/0x410
[22729.823422]  vprintk_default+0x1a/0x20
[22729.823424]  vprintk_func+0x22/0x60
[22729.823425]  printk+0x3e/0x46
[22729.823427]  ? console_unlock+0x5fd/0x640
[22729.823429]  show_trace_log_lvl+0x6e/0x300
[22729.823431]  ? vprintk_default+0x1a/0x20
[22729.823432]  ? vprintk_func+0x22/0x60
[22729.823434]  show_stack+0x2f/0x40
[22729.823436]  sched_show_task+0x16e/0x220
[22729.823438]  rcu_check_gp_kthread_starvation+0xb9/0xda
[22729.823440]  rcu_check_callbacks+0x743/0x980
[22729.823442]  ? trace_hardirqs_off+0xd/0x10
[22729.823443]  ? tick_sched_do_timer+0x40/0x40
[22729.823445]  update_process_times+0x2a/0x50
[22729.823447]  tick_sched_handle+0x34/0x40
[22729.823449]  tick_sched_timer+0x34/0x80
[22729.823451]  __hrtimer_run_queues+0x101/0x520
[22729.823453]  ? trace_hardirqs_off+0xd/0x10
[22729.823454]  hrtimer_interrupt+0xc9/0x210
[22729.823456]  smp_apic_timer_interrupt+0x79/0x2b0
[22729.823458]  apic_timer_interrupt+0xf/0x20
[22729.823460]  </IRQ>
[22729.823462] RIP: 0010:_raw_spin_unlock_irq+0x2f/0x40
[22729.823464] RSP: 0018:ffffae9a006fbeb0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[22729.823468] RAX: ffff96349afa2b00 RBX: ffff96349ba20700 RCX: 0000000000000000
[22729.823470] RDX: 0000000000000046 RSI: 0000000000000001 RDI: ffff96349afa2b00
[22729.823472] RBP: ffffae9a006fbeb8 R08: 0000000000000000 R09: 0000000000000000
[22729.823474] R10: 0000000000000000 R11: 0000000000000000 R12: ffff96349af25c30
[22729.823477] R13: ffff96349ba20700 R14: ffff96349ba20750 R15: ffff96349af25c00
[22729.823478]  worker_thread+0xba/0x3f0
[22729.823480]  kthread+0x127/0x140
[22729.823482]  ? process_one_work+0x670/0x670
[22729.823484]  ? kthread_create_worker_on_cpu+0x40/0x40
[22729.823486]  ret_from_fork+0x3a/0x50
[22729.823487] Code: 03 00 00 44 0f b6 15 23 06 e2 00 8b 3d f9 09 b2 01 45 31 db 48 8b 15 f7 46 d9 00 44 8b 0d 38 48 d9 00 89 fb 48 01 d3 0f b7 73 08 <66> 85 f6 48 0f 44 da 0f b6 43 0f c0 e8 05 0f b6 c0 44 39 c8 7c 
[22729.823582] rcu_sched kthread starved for 51485 jiffies! g18062 c18061 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
[22729.823584] NMI backtrace for cpu 0
[22729.823593] CPU: 0 PID: 25 Comm: kworker/0:2 Not tainted 4.16.0-rc6-next-20180321+ #2
[22729.823617] RCU grace-period kthread stack dump:
[22729.823623] rcu_sched       R
[22729.823679] Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
[22729.823695] Call Trace:
[22729.823739]   running task        0    10      2 0x80000000
[22729.823782]  <IRQ>
[22729.823819] Call Trace:
[22729.823836]  __schedule+0x27e/0xac0
[22729.823878]  dump_stack+0x70/0xa5
[22729.823889]  nmi_cpu_backtrace+0xbe/0xc0
[22729.823944]  ? trace_hardirqs_on_caller+0xef/0x180
[22729.823990]  ? lapic_can_unplug_cpu+0xa0/0xa0
[22729.824000]  nmi_trigger_cpumask_backtrace+0x98/0xd0
[22729.824054]  schedule+0x2e/0x90
[22729.824104]  arch_trigger_cpumask_backtrace+0x14/0x20
[22729.824161]  schedule_timeout+0x1d4/0x570
[22729.824173]  ? __next_timer_interrupt+0xd0/0xd0
[22729.824212]  rcu_dump_cpu_stacks+0xa7/0xd9
[22729.824221]  rcu_check_callbacks+0x74b/0x980
[22729.824273]  rcu_gp_kthread+0x491/0x7d0
[22729.824296]  ? trace_hardirqs_off+0xd/0x10
[22729.824306]  ? tick_sched_do_timer+0x40/0x40
[22729.824330]  kthread+0x127/0x140
[22729.824356]  update_process_times+0x2a/0x50
[22729.824365]  tick_sched_handle+0x34/0x40
[22729.824394]  ? call_rcu_sched+0x20/0x20
[22729.824404]  ? kthread_create_worker_on_cpu+0x40/0x40
[22729.824431]  tick_sched_timer+0x34/0x80
[22729.824439]  __hrtimer_run_queues+0x101/0x520
[22729.824469]  ret_from_fork+0x3a/0x50
[22729.824503]  ? trace_hardirqs_off+0xd/0x10
[22729.826703]  hrtimer_interrupt+0xc9/0x210
[22729.826744]  smp_apic_timer_interrupt+0x79/0x2b0
[22729.826787]  apic_timer_interrupt+0xf/0x20
[22729.826822]  </IRQ>
[22729.826850] RIP: 0010:_raw_spin_unlock_irq+0x2f/0x40
[22729.826891] RSP: 0018:ffffae9a006fbeb0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[22729.826955] RAX: ffff96349afa2b00 RBX: ffff96349ba20700 RCX: 0000000000000000
[22729.827009] RDX: 0000000000000046 RSI: 0000000000000001 RDI: ffff96349afa2b00
[22729.827063] RBP: ffffae9a006fbeb8 R08: 0000000000000000 R09: 0000000000000000
[22729.827117] R10: 0000000000000000 R11: 0000000000000000 R12: ffff96349af25c30
[22729.827171] R13: ffff96349ba20700 R14: ffff96349ba20750 R15: ffff96349af25c00
[22729.827232]  worker_thread+0xba/0x3f0
[22729.827270]  kthread+0x127/0x140
[22729.827306]  ? process_one_work+0x670/0x670
[22729.827346]  ? kthread_create_worker_on_cpu+0x40/0x40
[22729.827391]  ret_from_fork+0x3a/0x50
[45584.732020] clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc' as unstable because the skew is too large:
[45584.732178] clocksource:                       'hpet' wd_now: f7640fac wd_last: d616ddff mask: ffffffff
[45584.732234] clocksource:                       'tsc' cs_now: 2d80e82d6501 cs_last: 2d2a49cd275b mask: ffffffffffffffff
[45584.732585] tsc: Marking TSC unstable due to clocksource watchdog
[45584.733147] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[45584.733275] sched_clock: Marking unstable (45576934247406, 7737020246)<-(45584732356690, 785036)
[45584.672583] clocksource: Switched to clocksource hpet
[70247.757041] INFO: rcu_sched detected stalls on CPUs/tasks:
[70247.757114] 	0-...!: (9 GPs behind) idle=2f4/0/0 softirq=127686/127689 fqs=0 
[70247.757169] 	(detected by 1, t=45569 jiffies, g=37994, c=37993, q=7)
[70247.757230] Sending NMI from CPU 1 to CPUs 0:
[70247.757288] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x76/0x120
[70247.757908] rcu_sched kthread starved for 45570 jiffies! g37994 c37993 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[70247.757908] RCU grace-period kthread stack dump:
[70247.757908] rcu_sched       I    0    10      2 0x80000000
[70247.757908] Call Trace:
[70247.757908]  __schedule+0x27e/0xac0
[70247.757908]  ? trace_hardirqs_on_caller+0xef/0x180
[70247.757908]  schedule+0x2e/0x90
[70247.757908]  schedule_timeout+0x1d4/0x570
[70247.757908]  ? __next_timer_interrupt+0xd0/0xd0
[70247.757908]  rcu_gp_kthread+0x491/0x7d0
[70247.757908]  kthread+0x127/0x140
[70247.757908]  ? call_rcu_sched+0x20/0x20
[70247.757908]  ? kthread_create_worker_on_cpu+0x40/0x40
[70247.757908]  ret_from_fork+0x3a/0x50
