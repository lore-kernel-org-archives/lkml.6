Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E78C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F16121855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfAXIYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:24:46 -0500
Received: from mail5.windriver.com ([192.103.53.11]:42266 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXIYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:24:46 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0O8NriP003447
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 24 Jan 2019 00:24:04 -0800
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 24 Jan
 2019 00:23:43 -0800
Subject: Re: LTP case read_all_proc fails on qemux86-64 since 5.0-rc1
To:     Jens Axboe <axboe@kernel.dk>
CC:     <davem@davemloft.net>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
 <C1903094-A3C8-4273-9869-72D400180E51@kernel.dk>
 <11b1b3ee-a94b-dd5e-3ba6-df3efa239c7f@kernel.dk>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <adb69f96-8825-ef14-3e02-98c046f72ecb@windriver.com>
Date:   Thu, 24 Jan 2019 16:23:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <11b1b3ee-a94b-dd5e-3ba6-df3efa239c7f@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 12:05 AM, Jens Axboe wrote:
> On 1/22/19 8:39 PM, Jens Axboe wrote:
>> On Jan 22, 2019, at 8:13 PM, He Zhe <zhe.he@windriver.com> wrote:
>>> LTP case read_all_proc(read_all -d /proc -q -r 10) often, but not every time, fails with the following call traces, since 600335205b8d "ide: convert to blk-mq"(5.0-rc1) till now(5.0-rc3).
>>>
>>> qemu-system-x86_64 -drive file=rootfs.ext4,if=virtio,format=raw -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -nographic -m 16192 -smp cpus=12 -cpu core2duo -enable-kvm -serial mon:stdio -serial null -kernel bzImage -append 'root=/dev/vda rw highres=off console=ttyS0 mem=16192M'
>>>
>>> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
>>> [   47.080156] Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
>>> [   47.085330] ------------[ cut here ]------------
>>> [   47.085810] kernel BUG at block/blk-mq.c:767!
>>> [   47.086498] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>> [   47.087022] CPU: 5 PID: 146 Comm: kworker/5:1H Not tainted 5.0.0-rc3 #1
>>> [   47.087858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>>> [   47.088992] Workqueue: kblockd blk_mq_run_work_fn
>>> [   47.089469] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>>> [   47.090035] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>>> [   47.091930] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>>> [   47.092458] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>>> [   47.093181] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>>> [   47.093906] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>>> [   47.094626] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>>> [   47.095347] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>>> [   47.096071] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>>> [   47.096898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   47.097477] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>>> [   47.098203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   47.098929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   47.099650] Call Trace:
>>> [   47.099910]  <IRQ>
>>> [   47.100128]  blk_mq_requeue_request+0x58/0x60
>>> [   47.100576]  ide_requeue_and_plug+0x20/0x50
>>> [   47.101014]  ide_intr+0x21a/0x230
>>> [   47.101362]  ? idecd_open+0xc0/0xc0
>>> [   47.101735]  __handle_irq_event_percpu+0x43/0x1e0
>>> [   47.102214]  handle_irq_event_percpu+0x32/0x80
>>> [   47.102668]  handle_irq_event+0x39/0x60
>>> [   47.103074]  handle_edge_irq+0xe8/0x1c0
>>> [   47.103470]  handle_irq+0x20/0x30
>>> [   47.103819]  do_IRQ+0x46/0xe0
>>> [   47.104128]  common_interrupt+0xf/0xf
>>> [   47.104505]  </IRQ>
>>> [   47.104731] RIP: 0010:ide_output_data+0xbc/0x100
>>> [   47.105201] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
>>> [   47.107092] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
>>> [   47.107862] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
>>> [   47.108581] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
>>> [   47.109293] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
>>> [   47.110016] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
>>> [   47.110731] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
>>> [   47.111446]  ide_transfer_pc+0x216/0x310
>>> [   47.111848]  ? __const_udelay+0x3d/0x40
>>> [   47.112236]  ? ide_execute_command+0x85/0xb0
>>> [   47.112668]  ? ide_pc_intr+0x3f0/0x3f0
>>> [   47.113051]  ? ide_check_atapi_device+0x110/0x110
>>> [   47.113524]  ide_issue_pc+0x178/0x240
>>> [   47.113901]  ide_cd_do_request+0x15c/0x350
>>> [   47.114314]  ide_queue_rq+0x180/0x6b0
>>> [   47.114686]  ? blk_mq_get_driver_tag+0xa1/0x110
>>> [   47.115153]  blk_mq_dispatch_rq_list+0x90/0x550
>>> [   47.115606]  ? __queue_delayed_work+0x63/0x90
>>> [   47.116054]  ? deadline_fifo_request+0x41/0x90
>>> [   47.116506]  blk_mq_do_dispatch_sched+0x80/0x100
>>> [   47.116976]  blk_mq_sched_dispatch_requests+0xfc/0x170
>>> [   47.117491]  __blk_mq_run_hw_queue+0x6f/0xd0
>>> [   47.117941]  blk_mq_run_work_fn+0x1b/0x20
>>> [   47.118342]  process_one_work+0x14c/0x450
>>> [   47.118747]  worker_thread+0x4a/0x440
>>> [   47.119125]  kthread+0x105/0x140
>>> [   47.119456]  ? process_one_work+0x450/0x450
>>> [   47.119880]  ? kthread_park+0x90/0x90
>>> [   47.120251]  ret_from_fork+0x35/0x40
>>> [   47.120619] Modules linked in:
>>> [   47.120952] ---[ end trace 4562f716e88fdefe ]---
>>> [   47.121423] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>>> [   47.121981] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>>> [   47.123851] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>>> [   47.124393] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>>> [   47.125108] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>>> [   47.125819] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>>> [   47.126539] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>>> [   47.127262] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>>> [   47.127988] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>>> [   47.128793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   47.129385] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>>> [   47.130104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   47.130823] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   47.131547] Kernel panic - not syncing: Fatal exception in interrupt
>>> [   47.132609] Kernel Offset: 0x7c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>> [   47.133679] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>> [   47.134432] ------------[ cut here ]-----------
>> I’ll take a look at this, thanks for the report.
> I can't reproduce this, unfortunately. But I'm guessing it might be related
> to a race with the requeue and request handling in IDE. Can you try with
> the below patch?

Thanks for attention, but this patch doesn't help.

From what I reached, to reproduce it, we need to use legacy CONFIG_IDE and friends where "ide: convert to blk-mq" sits, not CONFIG_ATA and so on.
I can reproduce it with qemux86-64 with "-drive ... if=ide" or "-drive ... if=virtio".


Zhe







