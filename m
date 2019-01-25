Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C41C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705FF218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfAYCWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:22:49 -0500
Received: from mail.windriver.com ([147.11.1.11]:63222 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfAYCWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:22:49 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0P2MgUq001915
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 24 Jan 2019 18:22:42 -0800 (PST)
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 24 Jan
 2019 18:22:41 -0800
Subject: Re: LTP case read_all_proc fails on qemux86-64 since 5.0-rc1
To:     Jens Axboe <axboe@kernel.dk>
CC:     <davem@davemloft.net>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
 <C1903094-A3C8-4273-9869-72D400180E51@kernel.dk>
 <11b1b3ee-a94b-dd5e-3ba6-df3efa239c7f@kernel.dk>
 <adb69f96-8825-ef14-3e02-98c046f72ecb@windriver.com>
 <31660451-9ab4-43b8-b468-ae7b9a8d2279@kernel.dk>
 <eae853aa-de54-42d6-a9bc-254c152cec5b@windriver.com>
 <29f3b60d-922e-001a-0c1c-ed8482c6e409@kernel.dk>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <0905efc0-d4f2-08d8-0f87-bd4bfab6e46e@windriver.com>
Date:   Fri, 25 Jan 2019 10:22:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <29f3b60d-922e-001a-0c1c-ed8482c6e409@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/19 10:05 AM, Jens Axboe wrote:
> On 1/24/19 6:40 PM, He Zhe wrote:
>>
>> On 1/24/19 11:40 PM, Jens Axboe wrote:
>>> On 1/24/19 1:23 AM, He Zhe wrote:
>>>> On 1/24/19 12:05 AM, Jens Axboe wrote:
>>>>> On 1/22/19 8:39 PM, Jens Axboe wrote:
>>>>>> On Jan 22, 2019, at 8:13 PM, He Zhe <zhe.he@windriver.com> wrote:
>>>>>>> LTP case read_all_proc(read_all -d /proc -q -r 10) often, but not every time, fails with the following call traces, since 600335205b8d "ide: convert to blk-mq"(5.0-rc1) till now(5.0-rc3).
>>>>>>>
>>>>>>> qemu-system-x86_64 -drive file=rootfs.ext4,if=virtio,format=raw -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -nographic -m 16192 -smp cpus=12 -cpu core2duo -enable-kvm -serial mon:stdio -serial null -kernel bzImage -append 'root=/dev/vda rw highres=off console=ttyS0 mem=16192M'
>>>>>>>
>>>>>>> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
>>>>>>> [   47.080156] Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
>>>>>>> [   47.085330] ------------[ cut here ]------------
>>>>>>> [   47.085810] kernel BUG at block/blk-mq.c:767!
>>>>>>> [   47.086498] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>>>>>> [   47.087022] CPU: 5 PID: 146 Comm: kworker/5:1H Not tainted 5.0.0-rc3 #1
>>>>>>> [   47.087858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>>>>>>> [   47.088992] Workqueue: kblockd blk_mq_run_work_fn
>>>>>>> [   47.089469] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>>>>>>> [   47.090035] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>>>>>>> [   47.091930] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>>>>>>> [   47.092458] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>>>>>>> [   47.093181] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>>>>>>> [   47.093906] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>>>>>>> [   47.094626] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>>>>>>> [   47.095347] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>>>>>>> [   47.096071] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>>>>>>> [   47.096898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [   47.097477] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>>>>>>> [   47.098203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> [   47.098929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> [   47.099650] Call Trace:
>>>>>>> [   47.099910]  <IRQ>
>>>>>>> [   47.100128]  blk_mq_requeue_request+0x58/0x60
>>>>>>> [   47.100576]  ide_requeue_and_plug+0x20/0x50
>>>>>>> [   47.101014]  ide_intr+0x21a/0x230
>>>>>>> [   47.101362]  ? idecd_open+0xc0/0xc0
>>>>>>> [   47.101735]  __handle_irq_event_percpu+0x43/0x1e0
>>>>>>> [   47.102214]  handle_irq_event_percpu+0x32/0x80
>>>>>>> [   47.102668]  handle_irq_event+0x39/0x60
>>>>>>> [   47.103074]  handle_edge_irq+0xe8/0x1c0
>>>>>>> [   47.103470]  handle_irq+0x20/0x30
>>>>>>> [   47.103819]  do_IRQ+0x46/0xe0
>>>>>>> [   47.104128]  common_interrupt+0xf/0xf
>>>>>>> [   47.104505]  </IRQ>
>>>>>>> [   47.104731] RIP: 0010:ide_output_data+0xbc/0x100
>>>>>>> [   47.105201] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
>>>>>>> [   47.107092] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
>>>>>>> [   47.107862] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
>>>>>>> [   47.108581] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
>>>>>>> [   47.109293] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
>>>>>>> [   47.110016] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
>>>>>>> [   47.110731] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
>>>>>>> [   47.111446]  ide_transfer_pc+0x216/0x310
>>>>>>> [   47.111848]  ? __const_udelay+0x3d/0x40
>>>>>>> [   47.112236]  ? ide_execute_command+0x85/0xb0
>>>>>>> [   47.112668]  ? ide_pc_intr+0x3f0/0x3f0
>>>>>>> [   47.113051]  ? ide_check_atapi_device+0x110/0x110
>>>>>>> [   47.113524]  ide_issue_pc+0x178/0x240
>>>>>>> [   47.113901]  ide_cd_do_request+0x15c/0x350
>>>>>>> [   47.114314]  ide_queue_rq+0x180/0x6b0
>>>>>>> [   47.114686]  ? blk_mq_get_driver_tag+0xa1/0x110
>>>>>>> [   47.115153]  blk_mq_dispatch_rq_list+0x90/0x550
>>>>>>> [   47.115606]  ? __queue_delayed_work+0x63/0x90
>>>>>>> [   47.116054]  ? deadline_fifo_request+0x41/0x90
>>>>>>> [   47.116506]  blk_mq_do_dispatch_sched+0x80/0x100
>>>>>>> [   47.116976]  blk_mq_sched_dispatch_requests+0xfc/0x170
>>>>>>> [   47.117491]  __blk_mq_run_hw_queue+0x6f/0xd0
>>>>>>> [   47.117941]  blk_mq_run_work_fn+0x1b/0x20
>>>>>>> [   47.118342]  process_one_work+0x14c/0x450
>>>>>>> [   47.118747]  worker_thread+0x4a/0x440
>>>>>>> [   47.119125]  kthread+0x105/0x140
>>>>>>> [   47.119456]  ? process_one_work+0x450/0x450
>>>>>>> [   47.119880]  ? kthread_park+0x90/0x90
>>>>>>> [   47.120251]  ret_from_fork+0x35/0x40
>>>>>>> [   47.120619] Modules linked in:
>>>>>>> [   47.120952] ---[ end trace 4562f716e88fdefe ]---
>>>>>>> [   47.121423] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>>>>>>> [   47.121981] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>>>>>>> [   47.123851] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>>>>>>> [   47.124393] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>>>>>>> [   47.125108] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>>>>>>> [   47.125819] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>>>>>>> [   47.126539] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>>>>>>> [   47.127262] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>>>>>>> [   47.127988] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>>>>>>> [   47.128793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [   47.129385] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>>>>>>> [   47.130104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> [   47.130823] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> [   47.131547] Kernel panic - not syncing: Fatal exception in interrupt
>>>>>>> [   47.132609] Kernel Offset: 0x7c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>>>> [   47.133679] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>>>>>> [   47.134432] ------------[ cut here ]-----------
>>>>>> I’ll take a look at this, thanks for the report.
>>>>> I can't reproduce this, unfortunately. But I'm guessing it might be related
>>>>> to a race with the requeue and request handling in IDE. Can you try with
>>>>> the below patch?
>>>> Thanks for attention, but this patch doesn't help.
>>> OK, thanks for trying.
>>>
>>>> From what I reached, to reproduce it, we need to use legacy CONFIG_IDE
>>>> and friends where "ide: convert to blk-mq" sits, not CONFIG_ATA and so
>>>> on.  I can reproduce it with qemux86-64 with "-drive ... if=ide" or
>>>> "-drive ... if=virtio".
>>> Yes of course, I am trying to reproduce with the legacy stack. Just not
>>> having any luck doing it, even thousands of read_all iterations on /proc
>>> with IO to the IDE drives is still not doing it. From your trace, it
>>> looks like ide-cd causing it, which would mean a cdrom of some sort.
>>>
>>> I'll try again!
>> My .config is attached.
> Can you try with this patch?

With this patch, it cannot boot up.

[    7.832554] Uniform Multi-Platform E-IDE driver
[    7.833067] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
[    7.833796] piix 0000:00:01.1: not 100% native mode: will probe irqs later
[    7.834493]     ide0: BM-DMA at 0xc060-0xc067
[    7.835361]     ide1: BM-DMA at 0xc068-0xc06f
[    8.104196] hda: QEMU HARDDISK, ATA DISK drive
[    8.728309] hda: MWDMA2 mode selected
[    9.413190] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
[   10.037303] hdc: MWDMA2 mode selected
[   10.037863] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   10.038333] ide: failed to init hda
[   10.038733] ide1 at 0x170-0x177,0x376 on irq 15
[   10.039195] ide: failed to init hdc
[   10.039646] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
[   10.040364] piix 0000:00:01.1: not 100% native mode: will probe irqs later
[   10.041054]     ide0: BM-DMA at 0xc060-0xc067
[   10.041508]     ide1: BM-DMA at 0xc068-0xc06f
[   10.310192] hda: QEMU HARDDISK, ATA DISK drive
[   10.934172] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.1/ide0'
[   10.935001] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc3 #5
[   10.935134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   10.935134] Call Trace:
[   10.935134]  dump_stack+0x62/0x95
[   10.935134]  sysfs_warn_dup+0x79/0x90
[   10.935134]  sysfs_create_dir_ns+0x211/0x290
[   10.935134]  ? sysfs_create_mount_point+0x80/0x80
[   10.935134]  ? kernel_init_freeable+0x4c9/0x659
[   10.935134]  ? kasan_check_read+0x16/0x20
[   10.935134]  ? _raw_spin_lock+0x8c/0xf0
[   10.935134]  ? _raw_spin_lock_irq+0xf0/0xf0
[   10.935134]  ? msleep+0x55/0x80
[   10.935134]  kobject_add_internal+0x1f7/0x770
[   10.935134]  kobject_add+0x11f/0x1f0
[   10.935134]  ? kobject_add_internal+0x770/0x770
[   10.935134]  ? __kmalloc_track_caller+0x6d/0x250
[   10.935134]  ? kasan_kmalloc+0x11/0x20
[   10.935134]  device_add+0x2ca/0x1460
[   10.935134]  ? kobject_set_name_vargs+0xb4/0x130
[   10.935134]  ? get_device_parent.isra.13+0x5e0/0x5e0
[   10.935134]  ? pm_runtime_init+0x341/0x3f0
[   10.935134]  device_register+0x1a/0x20
[   10.935134]  ide_host_register+0x965/0x1a20
[   10.935134]  ide_pci_init_two+0xb63/0x18e0
[   10.935134]  ? kmem_cache_alloc+0x170/0x200
[   10.935134]  ? __kernfs_new_node+0xd8/0x610
[   10.935134]  ? ide_pci_setup_ports+0x920/0x920
[   10.935134]  ? radix_tree_iter_tag_clear+0x50/0x90
[   10.935134]  ? idr_alloc_u32+0x1a9/0x340
[   10.935134]  ? __save_stack_trace+0x82/0x100
[   10.935134]  ? __fprop_inc_percpu_max+0x1f0/0x1f0
[   10.935134]  ? devres_free+0x40/0x60
[   10.935134]  ? idr_alloc_cyclic+0xf2/0x1e0
[   10.935134]  ? __mutex_lock_slowpath+0x20/0x20
[   10.935134]  ? mutex_lock+0x88/0xf0
[   10.935134]  ? kasan_check_read+0x16/0x20
[   10.935134]  ? rpm_resume+0x1d5/0x1600
[   10.935134]  ? _raw_spin_lock+0x8c/0xf0
[   10.935134]  ? rpm_put_suppliers+0x140/0x140
[   10.935134]  ? kasan_check_read+0x16/0x20
[   10.935134]  ? _raw_spin_lock_irqsave+0x92/0x100
[   10.935134]  ? _raw_read_unlock_irq+0x40/0x40
[   10.935134]  ? mutex_lock+0x88/0xf0
[   10.935134]  ? __mutex_lock_slowpath+0x20/0x20
[   10.935134]  ide_pci_init_one+0x16/0x20
[   10.935134]  piix_init_one+0x4a/0x60
[   10.935134]  pci_device_probe+0x27c/0x490
[   10.935134]  really_probe+0x465/0x720
[   10.935134]  driver_probe_device+0xd1/0x210
[   10.935134]  __driver_attach+0x214/0x280
[   10.935134]  ? driver_probe_device+0x210/0x210
[   10.935134]  bus_for_each_dev+0x11d/0x1e0
[   10.935134]  ? subsys_dev_iter_exit+0x10/0x10
[   10.935134]  ? kasan_check_write+0x19/0x20
[   10.935134]  ? klist_node_init+0x66/0x120
[   10.935134]  driver_attach+0x3d/0x50
[   10.935134]  bus_add_driver+0x421/0x5d0
[   10.935134]  driver_register+0x18c/0x420
[   10.935134]  __pci_register_driver+0x1a8/0x270
[   10.935134]  ide_scan_pcibus+0x20b/0x26d
[   10.935134]  ? piix_ide_init+0x15d/0x15d
[   10.935134]  do_one_initcall+0xd1/0x3b0
[   10.935134]  ? initcall_blacklisted+0x160/0x160
[   10.935134]  ? __memset+0x27/0x30
[   10.935134]  ? kasan_unpoison_shadow+0x3b/0x50
[   10.935134]  kernel_init_freeable+0x4c9/0x659
[   10.935134]  ? rest_init+0x100/0x100
[   10.935134]  kernel_init+0x13/0x130
[   10.935134]  ? rest_init+0x100/0x100
[   10.935134]  ret_from_fork+0x35/0x40
[   10.964317] kobject_add_internal failed for ide0 with -EEXIST, don't try to register things with the same name in the same directory.
[   10.965504] IDE: ide_register_port: device_register error: -17
[   10.966082] ide0: disabling port
[   11.651191] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
[   12.275172] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.1/ide1'
[   12.276019] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc3 #5
[   12.276134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   12.276134] Call Trace:
[   12.276134]  dump_stack+0x62/0x95
[   12.276134]  sysfs_warn_dup+0x79/0x90
[   12.276134]  sysfs_create_dir_ns+0x211/0x290
[   12.276134]  ? sysfs_create_mount_point+0x80/0x80
[   12.276134]  ? kernel_init_freeable+0x4c9/0x659
[   12.276134]  ? kasan_check_read+0x16/0x20
[   12.276134]  ? _raw_spin_lock+0x8c/0xf0
[   12.276134]  ? _raw_spin_lock_irq+0xf0/0xf0
[   12.276134]  ? msleep+0x55/0x80
[   12.276134]  kobject_add_internal+0x1f7/0x770
[   12.276134]  kobject_add+0x11f/0x1f0
[   12.276134]  ? kobject_add_internal+0x770/0x770
[   12.276134]  ? __kmalloc_track_caller+0x6d/0x250
[   12.276134]  ? kasan_kmalloc+0x11/0x20
[   12.276134]  device_add+0x2ca/0x1460
[   12.276134]  ? kobject_set_name_vargs+0xb4/0x130
[   12.276134]  ? get_device_parent.isra.13+0x5e0/0x5e0
[   12.276134]  ? pm_runtime_init+0x341/0x3f0
[   12.276134]  device_register+0x1a/0x20
[   12.276134]  ide_host_register+0x965/0x1a20
[   12.276134]  ide_pci_init_two+0xb63/0x18e0
[   12.276134]  ? kmem_cache_alloc+0x170/0x200
[   12.276134]  ? __kernfs_new_node+0xd8/0x610
[   12.276134]  ? ide_pci_setup_ports+0x920/0x920
[   12.276134]  ? radix_tree_iter_tag_clear+0x50/0x90
[   12.276134]  ? idr_alloc_u32+0x1a9/0x340
[   12.276134]  ? __save_stack_trace+0x82/0x100
[   12.276134]  ? __fprop_inc_percpu_max+0x1f0/0x1f0
[   12.276134]  ? devres_free+0x40/0x60
[   12.276134]  ? idr_alloc_cyclic+0xf2/0x1e0
[   12.276134]  ? __mutex_lock_slowpath+0x20/0x20
[   12.276134]  ? mutex_lock+0x88/0xf0
[   12.276134]  ? kasan_check_read+0x16/0x20
[   12.276134]  ? rpm_resume+0x1d5/0x1600
[   12.276134]  ? _raw_spin_lock+0x8c/0xf0
[   12.276134]  ? rpm_put_suppliers+0x140/0x140
[   12.276134]  ? kasan_check_read+0x16/0x20
[   12.276134]  ? _raw_spin_lock_irqsave+0x92/0x100
[   12.276134]  ? _raw_read_unlock_irq+0x40/0x40
[   12.276134]  ? mutex_lock+0x88/0xf0
[   12.276134]  ? __mutex_lock_slowpath+0x20/0x20
[   12.276134]  ide_pci_init_one+0x16/0x20
[   12.276134]  piix_init_one+0x4a/0x60
[   12.276134]  pci_device_probe+0x27c/0x490
[   12.276134]  really_probe+0x465/0x720
[   12.276134]  driver_probe_device+0xd1/0x210
[   12.276134]  __driver_attach+0x214/0x280
[   12.276134]  ? driver_probe_device+0x210/0x210
[   12.276134]  bus_for_each_dev+0x11d/0x1e0
[   12.276134]  ? subsys_dev_iter_exit+0x10/0x10
[   12.276134]  ? kasan_check_write+0x19/0x20
[   12.276134]  ? klist_node_init+0x66/0x120
[   12.276134]  driver_attach+0x3d/0x50
[   12.276134]  bus_add_driver+0x421/0x5d0
[   12.276134]  driver_register+0x18c/0x420
[   12.276134]  __pci_register_driver+0x1a8/0x270
[   12.276134]  ide_scan_pcibus+0x20b/0x26d
[   12.276134]  ? piix_ide_init+0x15d/0x15d
[   12.276134]  do_one_initcall+0xd1/0x3b0
[   12.276134]  ? initcall_blacklisted+0x160/0x160
[   12.276134]  ? __memset+0x27/0x30
[   12.276134]  ? kasan_unpoison_shadow+0x3b/0x50
[   12.276134]  kernel_init_freeable+0x4c9/0x659
[   12.276134]  ? rest_init+0x100/0x100
[   12.276134]  kernel_init+0x13/0x130
[   12.276134]  ? rest_init+0x100/0x100
[   12.276134]  ret_from_fork+0x35/0x40
[   12.305202] kobject_add_internal failed for ide1 with -EEXIST, don't try to register things with the same name in the same directory.
[   12.306385] IDE: ide_register_port: device_register error: -17
[   12.306961] ide1: disabling port
[   12.307320] PIIX_IDE: probe of 0000:00:01.1 failed with error -1
[   12.307948] ide-gd driver 1.18
[   12.308280] ide-cd driver 5.00


Zhe


>
>
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 63627be0811a..3e13c7c243f4 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -778,7 +778,7 @@ static int ide_init_queue(ide_drive_t *drive)
>  	set = &drive->tag_set;
>  	set->ops = &ide_mq_ops;
>  	set->nr_hw_queues = 1;
> -	set->queue_depth = 32;
> +	set->queue_depth = 1;
>  	set->reserved_tags = 1;
>  	set->cmd_size = sizeof(struct ide_request);
>  	set->numa_node = hwif_to_node(hwif);
>

