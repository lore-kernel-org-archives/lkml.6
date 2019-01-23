Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3787C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D37E2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAWDOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:14:15 -0500
Received: from mail5.windriver.com ([192.103.53.11]:54306 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfAWDOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:14:14 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0N3DG5g023752
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 22 Jan 2019 19:13:31 -0800
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 22 Jan
 2019 19:13:05 -0800
To:     <davem@davemloft.net>, <axboe@kernel.dk>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: LTP case read_all_proc fails on qemux86-64 since 5.0-rc1
Message-ID: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
Date:   Wed, 23 Jan 2019 11:13:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


LTP case read_all_proc(read_all -d /proc -q -r 10) often, but not every time, fails with the following call traces, since 600335205b8d "ide: convert to blk-mq"(5.0-rc1) till now(5.0-rc3).

qemu-system-x86_64 -drive file=rootfs.ext4,if=virtio,format=raw -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -nographic -m 16192 -smp cpus=12 -cpu core2duo -enable-kvm -serial mon:stdio -serial null -kernel bzImage -append 'root=/dev/vda rw highres=off console=ttyS0 mem=16192M'

tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
[   47.080156] Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
[   47.085330] ------------[ cut here ]------------
[   47.085810] kernel BUG at block/blk-mq.c:767!
[   47.086498] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   47.087022] CPU: 5 PID: 146 Comm: kworker/5:1H Not tainted 5.0.0-rc3 #1
[   47.087858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   47.088992] Workqueue: kblockd blk_mq_run_work_fn
[   47.089469] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.090035] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
[   47.091930] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
[   47.092458] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
[   47.093181] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
[   47.093906] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
[   47.094626] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
[   47.095347] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
[   47.096071] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
[   47.096898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.097477] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
[   47.098203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.098929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.099650] Call Trace:
[   47.099910]  <IRQ>
[   47.100128]  blk_mq_requeue_request+0x58/0x60
[   47.100576]  ide_requeue_and_plug+0x20/0x50
[   47.101014]  ide_intr+0x21a/0x230
[   47.101362]  ? idecd_open+0xc0/0xc0
[   47.101735]  __handle_irq_event_percpu+0x43/0x1e0
[   47.102214]  handle_irq_event_percpu+0x32/0x80
[   47.102668]  handle_irq_event+0x39/0x60
[   47.103074]  handle_edge_irq+0xe8/0x1c0
[   47.103470]  handle_irq+0x20/0x30
[   47.103819]  do_IRQ+0x46/0xe0
[   47.104128]  common_interrupt+0xf/0xf
[   47.104505]  </IRQ>
[   47.104731] RIP: 0010:ide_output_data+0xbc/0x100
[   47.105201] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
[   47.107092] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
[   47.107862] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
[   47.108581] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
[   47.109293] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
[   47.110016] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
[   47.110731] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
[   47.111446]  ide_transfer_pc+0x216/0x310
[   47.111848]  ? __const_udelay+0x3d/0x40
[   47.112236]  ? ide_execute_command+0x85/0xb0
[   47.112668]  ? ide_pc_intr+0x3f0/0x3f0
[   47.113051]  ? ide_check_atapi_device+0x110/0x110
[   47.113524]  ide_issue_pc+0x178/0x240
[   47.113901]  ide_cd_do_request+0x15c/0x350
[   47.114314]  ide_queue_rq+0x180/0x6b0
[   47.114686]  ? blk_mq_get_driver_tag+0xa1/0x110
[   47.115153]  blk_mq_dispatch_rq_list+0x90/0x550
[   47.115606]  ? __queue_delayed_work+0x63/0x90
[   47.116054]  ? deadline_fifo_request+0x41/0x90
[   47.116506]  blk_mq_do_dispatch_sched+0x80/0x100
[   47.116976]  blk_mq_sched_dispatch_requests+0xfc/0x170
[   47.117491]  __blk_mq_run_hw_queue+0x6f/0xd0
[   47.117941]  blk_mq_run_work_fn+0x1b/0x20
[   47.118342]  process_one_work+0x14c/0x450
[   47.118747]  worker_thread+0x4a/0x440
[   47.119125]  kthread+0x105/0x140
[   47.119456]  ? process_one_work+0x450/0x450
[   47.119880]  ? kthread_park+0x90/0x90
[   47.120251]  ret_from_fork+0x35/0x40
[   47.120619] Modules linked in:
[   47.120952] ---[ end trace 4562f716e88fdefe ]---
[   47.121423] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.121981] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
[   47.123851] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
[   47.124393] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
[   47.125108] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
[   47.125819] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
[   47.126539] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
[   47.127262] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
[   47.127988] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
[   47.128793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.129385] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
[   47.130104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.130823] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.131547] Kernel panic - not syncing: Fatal exception in interrupt
[   47.132609] Kernel Offset: 0x7c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   47.133679] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[   47.134432] ------------[ cut here ]------------
[   47.134898] sched: Unexpected reschedule of offline CPU#9!
[   47.135459] WARNING: CPU: 5 PID: 146 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3f/0x50
[   47.136622] Modules linked in:
[   47.136932] CPU: 5 PID: 146 Comm: kworker/5:1H Tainted: G      D           5.0.0-rc3 #1
[   47.137901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   47.139031] Workqueue: kblockd blk_mq_run_work_fn
[   47.139508] RIP: 0010:native_smp_send_reschedule+0x3f/0x50
[   47.140065] Code: c0 84 c0 74 17 48 8b 05 3f ab 03 01 be fd 00 00 00 48 8b 40 30 e8 f1 eb bb 00 5d c3 89 fe 48 c7 c7 b0 d1 bc 89 e8 01 4b0
[   47.141926] RSP: 0018:ffff9e1ea4b43910 EFLAGS: 00010086
[   47.142459] RAX: 0000000000000000 RBX: ffff9e1e9d518c00 RCX: 0000000000000006
[   47.143169] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff9e1ea4b55410
[   47.143881] RBP: ffff9e1ea4b43910 R08: 0000000000020ef2 R09: 0000000000000005
[   47.144595] R10: 0000000000000000 R11: ffff9e1ea4b43775 R12: ffff9e1e9d519294
[   47.145312] R13: 0000000000000009 R14: 0000000000000000 R15: 0000000000000001
[   47.146021] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
[   47.146830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.147410] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
[   47.148119] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.148828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.149543] Call Trace:
[   47.149794]  <IRQ>
[   47.150004]  try_to_wake_up+0x257/0x470
[   47.150400]  default_wake_function+0x12/0x20
[   47.150831]  autoremove_wake_function+0x12/0x40
[   47.151296]  __wake_up_common+0x8c/0x130
[   47.151696]  __wake_up_common_lock+0x80/0xc0
[   47.152129]  __wake_up+0x13/0x20
[   47.152469]  wake_up_klogd_work_func+0x40/0x70
[   47.152924]  irq_work_run_list+0x4e/0x80
[   47.153324]  irq_work_tick+0x40/0x50
[   47.153687]  update_process_times+0x42/0x60
[   47.154108]  tick_sched_handle.isra.6+0x34/0x40
[   47.154564]  tick_nohz_handler+0x5b/0x90
[   47.154956]  smp_apic_timer_interrupt+0x70/0x180
[   47.155422]  apic_timer_interrupt+0xf/0x20
[   47.155836] RIP: 0010:panic+0x238/0x284
[   47.156235] Code: 48 83 c3 64 eb b0 83 3d 11 e0 47 01 00 74 05 e8 62 3b 02 00 48 c7 c6 c0 56 0e 8a 48 c7 c7 48 35 bd 89 e8 12 e0 04 00 fb8
[   47.158092] RSP: 0018:ffff9e1ea4b43c08 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[   47.158856] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
[   47.159568] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff9e1ea4b55410
[   47.160283] RBP: ffff9e1ea4b43c80 R08: 0000000000020a2f R09: 0000000000000005
[   47.160997] R10: 0000000000000000 R11: ffff9e1ea4b43a8d R12: 0000000000000000
[   47.161713] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
[   47.162431]  ? apic_timer_interrupt+0xa/0x20
[   47.162861]  ? panic+0x235/0x284
[   47.163192]  oops_end+0x8e/0xa0
[   47.163520]  die+0x42/0x50
[   47.163795]  do_trap+0xdd/0x110
[   47.164119]  do_error_trap+0x7b/0xa0
[   47.164493]  ? blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.164983]  do_invalid_op+0x3b/0x50
[   47.165345]  ? blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.165835]  invalid_op+0x14/0x20
[   47.166173] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.166727] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8
[   47.168581] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
[   47.169109] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
[   47.169823] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
[   47.170542] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
[   47.171249] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
[   47.171960] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
[   47.172677]  blk_mq_requeue_request+0x58/0x60
[   47.173119]  ide_requeue_and_plug+0x20/0x50
[   47.173548]  ide_intr+0x21a/0x230
[   47.173887]  ? idecd_open+0xc0/0xc0
[   47.174241]  __handle_irq_event_percpu+0x43/0x1e0
[   47.174720]  handle_irq_event_percpu+0x32/0x80
[   47.175163]  handle_irq_event+0x39/0x60
[   47.175554]  handle_edge_irq+0xe8/0x1c0
[   47.175943]  handle_irq+0x20/0x30
[   47.176280]  do_IRQ+0x46/0xe0
[   47.176586]  common_interrupt+0xf/0xf
[   47.176956]  </IRQ>
[   47.177173] RIP: 0010:ide_output_data+0xbc/0x100
[   47.177649] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
[   47.179512] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
[   47.180269] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
[   47.180982] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
[   47.181694] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
[   47.182403] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
[   47.183119] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
[   47.183838]  ide_transfer_pc+0x216/0x310
[   47.184231]  ? __const_udelay+0x3d/0x40
[   47.184625]  ? ide_execute_command+0x85/0xb0
[   47.185058]  ? ide_pc_intr+0x3f0/0x3f0
[   47.185440]  ? ide_check_atapi_device+0x110/0x110
[   47.185915]  ide_issue_pc+0x178/0x240
[   47.186284]  ide_cd_do_request+0x15c/0x350
[   47.186700]  ide_queue_rq+0x180/0x6b0
[   47.187070]  ? blk_mq_get_driver_tag+0xa1/0x110
[   47.187539]  blk_mq_dispatch_rq_list+0x90/0x550
[   47.187996]  ? __queue_delayed_work+0x63/0x90
[   47.188441]  ? deadline_fifo_request+0x41/0x90
[   47.188895]  blk_mq_do_dispatch_sched+0x80/0x100
[   47.189362]  blk_mq_sched_dispatch_requests+0xfc/0x170
[   47.189891]  __blk_mq_run_hw_queue+0x6f/0xd0
[   47.190320]  blk_mq_run_work_fn+0x1b/0x20
[   47.190727]  process_one_work+0x14c/0x450
[   47.191136]  worker_thread+0x4a/0x440
[   47.191509]  kthread+0x105/0x140
[   47.191845]  ? process_one_work+0x450/0x450
[   47.192273]  ? kthread_park+0x90/0x90
[   47.192649]  ret_from_fork+0x35/0x40
[   47.193009] ---[ end trace 4562f716e88fdeff ]---
[   47.193474] ------------[ cut here ]------------
[   47.193947] sched: Unexpected reschedule of offline CPU#6!
[   47.194494] WARNING: CPU: 5 PID: 146 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3f/0x50
[   47.195653] Modules linked in:
[   47.195966] CPU: 5 PID: 146 Comm: kworker/5:1H Tainted: G      D W         5.0.0-rc3 #1
[   47.196939] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   47.198056] Workqueue: kblockd blk_mq_run_work_fn
[   47.198526] RIP: 0010:native_smp_send_reschedule+0x3f/0x50
[   47.199075] Code: c0 84 c0 74 17 48 8b 05 3f ab 03 01 be fd 00 00 00 48 8b 40 30 e8 f1 eb bb 00 5d c3 89 fe 48 c7 c7 b0 d1 bc 89 e8 01 4b0
[   47.200930] RSP: 0018:ffff9e1ea4b43868 EFLAGS: 00010082
[   47.201456] RAX: 0000000000000000 RBX: ffff9e1ea08da400 RCX: 0000000000000006
[   47.202173] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9e1ea4b55410
[   47.202887] RBP: ffff9e1ea4b43868 R08: 000000000002f59b R09: 0000000000000005
[   47.203596] R10: 0000000000000000 R11: ffff9e1ea4b436cd R12: ffff9e1ea08daa94
[   47.204305] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000001
[   47.205036] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
[   47.205836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.206409] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
[   47.207123] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.207832] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.208545] Call Trace:
[   47.208797]  <IRQ>
[   47.209005]  try_to_wake_up+0x257/0x470
[   47.209392]  default_wake_function+0x12/0x20
[   47.209826]  __wake_up_common+0x8c/0x130
[   47.210220]  __wake_up_locked+0x16/0x20
[   47.210608]  ep_poll_callback+0x1c1/0x310
[   47.211012]  __wake_up_common+0x8c/0x130
[   47.211408]  __wake_up_common_lock+0x80/0xc0
[   47.211840]  __wake_up+0x13/0x20
[   47.212168]  wake_up_klogd_work_func+0x40/0x70
[   47.212622]  irq_work_run_list+0x4e/0x80
[   47.213022]  irq_work_tick+0x40/0x50
[   47.213382]  update_process_times+0x42/0x60
[   47.213806]  tick_sched_handle.isra.6+0x34/0x40
[   47.214261]  tick_nohz_handler+0x5b/0x90
[   47.214659]  smp_apic_timer_interrupt+0x70/0x180
[   47.215131]  apic_timer_interrupt+0xf/0x20
[   47.215544] RIP: 0010:panic+0x238/0x284
[   47.215931] Code: 48 83 c3 64 eb b0 83 3d 11 e0 47 01 00 74 05 e8 62 3b 02 00 48 c7 c6 c0 56 0e 8a 48 c7 c7 48 35 bd 89 e8 12 e0
[   47.217782] RSP: 0018:ffff9e1ea4b43c08 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[   47.218531] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
[   47.219256] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff9e1ea4b55410
[   47.219971] RBP: ffff9e1ea4b43c80 R08: 0000000000020a2f R09: 0000000000000005
[   47.220677] R10: 0000000000000000 R11: ffff9e1ea4b43a8d R12: 0000000000000000
[   47.221389] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
[   47.222104]  ? apic_timer_interrupt+0xa/0x20
[   47.222536]  ? panic+0x235/0x284
[   47.222866]  oops_end+0x8e/0xa0
[   47.223185]  die+0x42/0x50
[   47.223462]  do_trap+0xdd/0x110
[   47.223786]  do_error_trap+0x7b/0xa0
[   47.224147]  ? blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.224641]  do_invalid_op+0x3b/0x50
[   47.225004]  ? blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.225494]  invalid_op+0x14/0x20
[   47.225837] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
[   47.226388] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
[   47.228260] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
[   47.228790] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
[   47.229520] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
[   47.230246] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
[   47.230977] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
[   47.231699] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
[   47.232423]  blk_mq_requeue_request+0x58/0x60
[   47.232877]  ide_requeue_and_plug+0x20/0x50
[   47.233306]  ide_intr+0x21a/0x230
[   47.233648]  ? idecd_open+0xc0/0xc0
[   47.234022]  __handle_irq_event_percpu+0x43/0x1e0
[   47.234500]  handle_irq_event_percpu+0x32/0x80
[   47.234955]  handle_irq_event+0x39/0x60
[   47.235351]  handle_edge_irq+0xe8/0x1c0
[   47.235744]  handle_irq+0x20/0x30
[   47.236093]  do_IRQ+0x46/0xe0
[   47.236399]  common_interrupt+0xf/0xf
[   47.236779]  </IRQ>
[   47.237006] RIP: 0010:ide_output_data+0xbc/0x100
[   47.237477] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
[   47.239359] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
[   47.240130] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
[   47.240855] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
[   47.241581] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
[   47.242312] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
[   47.243038] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
[   47.243758]  ide_transfer_pc+0x216/0x310
[   47.244166]  ? __const_udelay+0x3d/0x40
[   47.244570]  ? ide_execute_command+0x85/0xb0
[   47.245021]  ? ide_pc_intr+0x3f0/0x3f0
[   47.245409]  ? ide_check_atapi_device+0x110/0x110
[   47.245886]  ide_issue_pc+0x178/0x240
[   47.246267]  ide_cd_do_request+0x15c/0x350
[   47.246689]  ide_queue_rq+0x180/0x6b0
[   47.247072]  ? blk_mq_get_driver_tag+0xa1/0x110
[   47.247536]  blk_mq_dispatch_rq_list+0x90/0x550
[   47.247998]  ? __queue_delayed_work+0x63/0x90
[   47.248457]  ? deadline_fifo_request+0x41/0x90
[   47.248914]  blk_mq_do_dispatch_sched+0x80/0x100
[   47.249395]  blk_mq_sched_dispatch_requests+0xfc/0x170
[   47.249922]  __blk_mq_run_hw_queue+0x6f/0xd0
[   47.250365]  blk_mq_run_work_fn+0x1b/0x20
[   47.250782]  process_one_work+0x14c/0x450
[   47.251188]  worker_thread+0x4a/0x440
[   47.251566]  kthread+0x105/0x140
[   47.251900]  ? process_one_work+0x450/0x450
[   47.252335]  ? kthread_park+0x90/0x90
[   47.252715]  ret_from_fork+0x35/0x40
[   47.253090] ---[ end trace 4562f716e88fdf00 ]---


Zhe

