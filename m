Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A5D21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbfBROIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390562AbfBROIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:16 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E441F98C08107983E3E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:08:10 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 22:07:59 +0800
Subject: Re: possible deadlock in console_unlock
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
 <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
 <20190218054649.GA26686@jagdpanzerIV>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <3fece106-baed-92f6-1389-62b8f2c4578b@huawei.com>
Date:   Mon, 18 Feb 2019 22:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190218054649.GA26686@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 1:46 PM, Sergey Senozhatsky wrote:
> Hi,
> 
> On (02/16/19 15:59), Yao HongBo wrote:
>>> GFP_NOWARN is probably the best option for now. Yes, it, maybe,
>>> will not work for fault-injection cases; but printk_safe approach
>>> is harder to push for, especially given that printk_safe maybe will
>>> not even exist in the future.
>>
>> I have tried GFP_NOWARN, but the problem still exists.
>> Only print_safe contexts for tty locks can solve the problem.
>> My test scenario is falt-injection.
> 
> Oh, I see. Yes, fault-injection is special.
> 
> I suspect that this patch series can be helpful then
> https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com/T/#u

hi, sergey.
I merged this patch series on linux-4.19.18, but it didn't work for the fault-injection cases.
The failure seems to be the same as before.

deadlock log:
-------
[  193.213385] FAULT_INJECTION: forcing a failure.
[  193.213385] name failslab, interval 1, probability 0, space 0, times 1
[  193.216518] CPU: 1 PID: 6317 Comm: syz-executor0 Not tainted 4.19.18-514.55.6.9.x86_64+ #5
[  193.217383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[  193.217383] Call Trace:
[  193.217383]  dump_stack+0xca/0x13e
[  193.217383]  should_fail+0x607/0x700
[  193.217383]  ? fault_create_debugfs_attr+0x1d0/0x1d0
[  193.217383]  ? __lock_is_held+0xbc/0x160
[  193.225711]  __should_failslab+0x110/0x180
[  193.225711]  should_failslab+0xa/0x20
[  193.225711]  __kmalloc+0x6e/0x350
[  193.225711]  ? tty_write+0x65e/0x8a0
[  193.225711]  tty_write+0x65e/0x8a0
[  193.225711]  ? process_echoes+0x140/0x140
[  193.225711]  ? rw_verify_area+0xe2/0x2b0
[  193.225711]  do_iter_write+0x3dc/0x580
[  193.233550]  vfs_writev+0x16c/0x300
[  193.233550]  ? vfs_iter_write+0xa0/0xa0
[  193.233550]  ? lock_downgrade+0x5e0/0x5e0
[  193.233550]  ? __lock_is_held+0xbc/0x160
[  193.233550]  ? __fget+0x336/0x540
[  193.238589]  ? do_dup2+0x3d0/0x3d0
[  193.239291]  ? __mutex_unlock_slowpath+0xe1/0x690
[  193.239291]  ? do_writev+0xd1/0x230
[  193.239291]  do_writev+0xd1/0x230
[  193.239291]  ? vfs_writev+0x300/0x300
[  193.239291]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  193.239291]  ? trace_hardirqs_off_caller+0x40/0x190
[  193.239291]  ? do_syscall_64+0x3b/0x580
[  193.239291]  do_syscall_64+0xc8/0x580
[  193.239291]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  193.239291] RIP: 0033:0x462589
[  193.239291] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
[  193.239291] RSP: 002b:00007f2a92dbcc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[  193.239291] RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 0000000000462589
[  193.239291] RDX: 0000000000000001 RSI: 0000000020000040 RDI: 0000000000000003
[  193.239291] RBP: 00007f2a92dbcc70 R08: 0000000000000000 R09: 0000000000000000
[  193.239291] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2a92dbd6bc
[  193.239291] R13: 00000000004c222e R14: 0000000000702110 R15: 0000000000000004
[  193.266429] FAULT_INJECTION: forcing a failure.
[  193.266429] name failslab, interval 1, probability 0, space 0, times 0
[  193.266767] CPU: 0 PID: 6340 Comm: syz-executor13 Not tainted 4.19.18-514.55.6.9.x86_64+ #5
[  193.266767] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[  193.266767] Call Trace:
[  193.266767]  dump_stack+0xca/0x13e
[  193.266767]  should_fail+0x607/0x700
[  193.266767]  ? n_tty_write+0x96a/0xd90
[  193.266767]  ? fault_create_debugfs_attr+0x1d0/0x1d0
[  193.266767]  ? mark_held_locks+0x120/0x120
[  193.266767]  __should_failslab+0x110/0x180
[  193.266767]  should_failslab+0xa/0x20
[  193.266767]  __kmalloc+0x6e/0x350
[  193.266767]  ? __tty_buffer_request_room+0x1cf/0x5e0
[  193.266767]  __tty_buffer_request_room+0x1cf/0x5e0
[  193.266767]  tty_insert_flip_string_fixed_flag+0x8f/0x220
[  193.266767]  pty_write+0x104/0x1d0
[  193.266767]  n_tty_write+0x9a3/0xd90
[  193.266767]  ? process_echoes+0x140/0x140
[  193.266767]  ? do_wait_intr_irq+0x2a0/0x2a0
[  193.266767]  ? __might_fault+0x17c/0x1c0
[  193.266767]  tty_write+0x451/0x8a0
[  193.266767]  ? process_echoes+0x140/0x140
[  193.266767]  do_iter_write+0x3dc/0x580
[  193.266767]  vfs_writev+0x16c/0x300
[  193.266767]  ? vfs_iter_write+0xa0/0xa0
[  193.266767]  ? lock_downgrade+0x5e0/0x5e0
[  193.266767]  ? __lock_is_held+0xbc/0x160
[  193.266767]  ? __fget+0x336/0x540
[  193.266767]  ? do_dup2+0x3d0/0x3d0
[  193.266767]  ? __mutex_unlock_slowpath+0xe1/0x690
[  193.266767]  ? do_writev+0xd1/0x230
[  193.266767]  do_writev+0xd1/0x230
[  193.266767]  ? vfs_writev+0x300/0x300
[  193.266767]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  193.266767]  ? trace_hardirqs_off_caller+0x40/0x190
[  193.266767]  ? do_syscall_64+0x3b/0x580
[  193.266767]  do_syscall_64+0xc8/0x580
[  193.266767]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  193.266767] RIP: 0033:0x462589
[  193.266767] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
[  193.266767] RSP: 002b:00007f008dcc9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[  193.266767] RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 0000000000462589
[  193.266767] RDX: 0000000000000001 RSI: 0000000020000040 RDI: 0000000000000003
[  193.266767] RBP: 00007f008dcc9c70 R08: 0000000000000000 R09: 0000000000000000
[  193.266767] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f008dcca6bc
[  193.266767] R13: 00000000004c222e R14: 0000000000702110 R15: 0000000000000004
[  193.266767]
[  193.266767] ======================================================
[  193.266767] WARNING: possible circular locking dependency detected
[  193.266767] 4.19.18-514.55.6.9.x86_64+ #5 Not tainted
[  193.266767] ------------------------------------------------------
[  193.266767] syz-executor13/6340 is trying to acquire lock:
[  193.266767] 0000000026c0d2ca (console_owner){-.-.}, at: console_unlock+0x36d/0xb30
[  193.266767]
[  193.266767] but task is already holding lock:
[  193.266767] 00000000f655eadd (&(&port->lock)->rlock){-.-.}, at: pty_write+0xd2/0x1d0
[  193.266767]
[  193.266767] which lock already depends on the new lock.
[  193.266767]
[  193.266767]
[  193.266767] the existing dependency chain (in reverse order) is:
[  193.266767]
[  193.266767] -> #2 (&(&port->lock)->rlock){-.-.}:
[  193.266767]        tty_port_tty_get+0x20/0x80
[  193.266767]        tty_port_default_wakeup+0x16/0x40
[  193.266767]        serial8250_tx_chars+0x4dc/0xa80
[  193.266767]        serial8250_handle_irq.part.12+0x16b/0x270
[  193.266767]        serial8250_default_handle_irq+0xf8/0x120
[  193.266767]        serial8250_interrupt+0xfe/0x250
[  193.266767]        __handle_irq_event_percpu+0xf5/0x730
[  193.266767]        handle_irq_event_percpu+0x7b/0x170
[  193.266767]        handle_irq_event+0xa6/0x140
[  193.266767]        handle_edge_irq+0x1eb/0xa90
[  193.266767]        handle_irq+0x3e/0x50
[  193.266767]        do_IRQ+0x92/0x200
[  193.266767]        ret_from_intr+0x0/0x22
[  193.266767]        native_safe_halt+0x2/0x10
[  193.266767]        default_idle+0x24/0x2b0
[  193.266767]        do_idle+0x2ca/0x420
[  193.266767]        cpu_startup_entry+0xcb/0xe0
[  193.266767]        start_secondary+0x421/0x570
[  193.266767]        secondary_startup_64+0xa4/0xb0
[  193.266767]
[  193.266767] -> #1 (&port_lock_key){-.-.}:
[  193.266767]        serial8250_console_write+0x663/0x810
[  193.266767]        console_unlock+0x66a/0xb30
[  193.266767]        vprintk_emit+0x181/0x570
[  193.266767]        vprintk_default+0x68/0xe0
[  193.266767]        vprintk_func+0x57/0xf0
[  193.266767]        printk+0xb7/0xe2
[  193.266767]        register_console+0x752/0xc60
[  193.266767]        univ8250_console_init+0x31/0x3a
[  193.266767]        console_init+0x3ad/0x567
[  193.266767]        start_kernel+0x4c3/0x7e1
[  193.266767]        secondary_startup_64+0xa4/0xb0
[  193.266767]
[  193.266767] -> #0 (console_owner){-.-.}:
[  193.266767]        console_unlock+0x3d9/0xb30
[  193.266767]        vprintk_emit+0x181/0x570
[  193.266767]        vprintk_default+0x68/0xe0
[  193.266767]        vprintk_func+0x57/0xf0
[  193.266767]        printk+0xb7/0xe2
[  193.266767]        should_fail+0x5d3/0x700
[  193.266767]        __should_failslab+0x110/0x180
[  193.266767]        should_failslab+0xa/0x20
[  193.266767]        __kmalloc+0x6e/0x350
[  193.266767]        __tty_buffer_request_room+0x1cf/0x5e0
[  193.266767]        tty_insert_flip_string_fixed_flag+0x8f/0x220
[  193.266767]        pty_write+0x104/0x1d0
[  193.266767]        n_tty_write+0x9a3/0xd90
[  193.266767]        tty_write+0x451/0x8a0
[  193.266767]        do_iter_write+0x3dc/0x580
[  193.266767]        vfs_writev+0x16c/0x300
[  193.266767]        do_writev+0xd1/0x230
[  193.266767]        do_syscall_64+0xc8/0x580
[  193.266767]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  193.266767]
[  193.266767] other info that might help us debug this:
[  193.266767]
[  193.266767] Chain exists of:
[  193.266767]   console_owner --> &port_lock_key --> &(&port->lock)->rlock
[  193.266767]
[  193.266767]  Possible unsafe locking scenario:
[  193.266767]
[  193.266767]        CPU0                    CPU1
[  193.266767]        ----                    ----
[  193.266767]   lock(&(&port->lock)->rlock);
[  193.266767]                                lock(&port_lock_key);
[  193.266767]                                lock(&(&port->lock)->rlock);
[  193.266767]   lock(console_owner);
[  193.266767]
[  193.266767]  *** DEADLOCK ***




> but first we need to figure out if printk_safe will
> stay in the kernel (this will take some time).
> 
> 	-ss
> 
> 

