Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A5222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfBPIAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:00:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbfBPIAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:00:14 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 670FB9BFCC4025B2C711
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 16:00:08 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 15:59:57 +0800
Subject: Re: possible deadlock in console_unlock
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
Date:   Sat, 16 Feb 2019 15:59:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190216073856.GA9979@tigerII.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/16/2019 3:46 PM, Sergey Senozhatsky wrote:
> On (02/16/19 16:21), Sergey Senozhatsky wrote:
>> On (02/16/19 14:36), Yao HongBo wrote:
>>> hi, sergey:
>>>
>>> As shown in that link, https://lkml.org/lkml/2018/6/6/397
>>>
>>> On the linux kernel 5.0-rc6, Syzkaller also hit 'possible deadlock in console_unlock'
>>> bug for several times in my environment.
>>>
>>> This solution fixes things for me. Do you have a plan to submit patches to
>>> solve this problem.
>>>
>>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>>> 	__printk_safe_enter();
>>> 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
>>> 	__printk_safe_exit();
>>
>> I would probably try the following:
> 
> Yao HongBo, could you please post the lockdep splat?
> 
> GFP_NOWARN is probably the best option for now. Yes, it, maybe,
> will not work for fault-injection cases; but printk_safe approach
> is harder to push for, especially given that printk_safe maybe will
> not even exist in the future.

I have tried GFP_NOWARN, but the problem still exists.
Only print_safe contexts for tty locks can solve the problem.
My test scenario is falt-injection.

deadlock report is shown as below:

RBP: 00007f1cf76cbc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1cf76cc6bc
R13: 00000000004c473d R14: 0000000000701f18 R15: 0000000000000005

======================================================
WARNING: possible circular locking dependency detected
4.19.18-514.55.6.9.x86_64+ #1 Not tainted
------------------------------------------------------
syz-executor0/23291 is trying to acquire lock:
00000000d73d87c0 (console_owner){-.-.}, at: log_next kernel/printk/printk.c:495 [inline]
00000000d73d87c0 (console_owner){-.-.}, at: console_unlock+0x36d/0xb30 kernel/printk/printk.c:2397

but task is already holding lock:
00000000dfbab914 (&(&port->lock)->rlock){-.-.}, at: pty_write+0xd2/0x1d0 drivers/tty/pty.c:119

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&(&port->lock)->rlock){-.-.}:
       tty_port_tty_get+0x20/0x80 drivers/tty/tty_port.c:288
       tty_port_default_wakeup+0x16/0x40 drivers/tty/tty_port.c:47
       serial8250_tx_chars+0x4dc/0xa80 drivers/tty/serial/8250/8250_port.c:1806
       serial8250_handle_irq.part.12+0x198/0x220 drivers/tty/serial/8250/8250_port.c:1879
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1899 [inline]
       serial8250_default_handle_irq+0xf8/0x120 drivers/tty/serial/8250/8250_port.c:1895
       serial8250_interrupt+0xfe/0x250 drivers/tty/serial/8250/8250_core.c:125
       __handle_irq_event_percpu+0xf5/0x730 kernel/irq/handle.c:149
       handle_irq_event_percpu+0x7b/0x170 kernel/irq/handle.c:189
       handle_irq_event+0xa6/0x140 kernel/irq/handle.c:206
       handle_edge_irq+0x1eb/0xa90 kernel/irq/chip.c:791
       generic_handle_irq_desc include/linux/irqdesc.h:154 [inline]
       handle_irq+0x3e/0x50 arch/x86/kernel/irq_64.c:78
       do_IRQ+0x92/0x200 arch/x86/kernel/irq.c:246
       ret_from_intr+0x0/0x22
       native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:57
       arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
       default_idle+0x24/0x2b0 arch/x86/kernel/process.c:561
       cpuidle_idle_call kernel/sched/idle.c:153 [inline]
       do_idle+0x2ca/0x420 kernel/sched/idle.c:262
       cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:368
       start_secondary+0x421/0x570 arch/x86/kernel/smpboot.c:271
       secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&port_lock_key){-.-.}:
       serial8250_console_write+0x68a/0x820 drivers/tty/serial/8250/8250_port.c:3247
       call_console_drivers kernel/printk/printk.c:1729 [inline]
       console_unlock+0x66a/0xb30 kernel/printk/printk.c:2410
       vprintk_emit+0x181/0x570 kernel/printk/printk.c:1927
       vprintk_default+0x68/0xe0 kernel/printk/printk.c:1968
       vprintk_func+0x57/0xf0 kernel/printk/printk_safe.c:398
       printk+0xb7/0xe2 kernel/printk/printk.c:2001
       register_console+0x752/0xc60 kernel/printk/printk.c:2725
       univ8250_console_init+0x31/0x3a drivers/tty/serial/8250/8250_core.c:685
       console_init+0x3ad/0x567 kernel/printk/printk.c:2811
       start_kernel+0x4c3/0x7e1 init/main.c:661
       secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #0 (console_owner){-.-.}:
       console_lock_spinning_enable kernel/printk/printk.c:1592 [inline]
       console_unlock+0x3d9/0xb30 kernel/printk/printk.c:2407
       vprintk_emit+0x181/0x570 kernel/printk/printk.c:1927
       vprintk_default+0x68/0xe0 kernel/printk/printk.c:1968
       vprintk_func+0x57/0xf0 kernel/printk/printk_safe.c:398
       printk+0xb7/0xe2 kernel/printk/printk.c:2001
       fail_dump lib/fault-inject.c:44 [inline]
       should_fail+0x5d3/0x700 lib/fault-inject.c:149
       __should_failslab+0x110/0x180 mm/failslab.c:32
       should_failslab+0xa/0x20 mm/slab_common.c:1557
       slab_pre_alloc_hook mm/slab.h:423 [inline]
       slab_alloc_node mm/slub.c:2632 [inline]
       slab_alloc mm/slub.c:2714 [inline]
       __kmalloc+0x6e/0x350 mm/slub.c:3747
       kmalloc include/linux/slab.h:518 [inline]
       tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
       __tty_buffer_request_room+0x1cf/0x5e0 drivers/tty/tty_buffer.c:268
       tty_insert_flip_string_fixed_flag+0x8f/0x220 drivers/tty/tty_buffer.c:313
       tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
       pty_write+0x104/0x1d0 drivers/tty/pty.c:121
       n_tty_write+0x9a3/0xd90 drivers/tty/n_tty.c:2354
       do_tty_write drivers/tty/tty_io.c:958 [inline]
       tty_write+0x451/0x8a0 drivers/tty/tty_io.c:1042
       __vfs_write+0xef/0x6a0 fs/read_write.c:485
       vfs_write+0x184/0x4c0 fs/read_write.c:549
       ksys_write+0xc6/0x1a0 fs/read_write.c:598
       do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  console_owner --> &port_lock_key --> &(&port->lock)->rlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&port->lock)->rlock);
                               lock(&port_lock_key);
                               lock(&(&port->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***


> 	-ss
> 
> 

