Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE68CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8820656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfAOEOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:14:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAOEOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:14:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B991DC0495A1;
        Tue, 15 Jan 2019 04:14:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 102C119C7C;
        Tue, 15 Jan 2019 04:14:31 +0000 (UTC)
Date:   Tue, 15 Jan 2019 12:14:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Real deadlock being suppressed in sbitmap
Message-ID: <20190115041426.GA13505@ming.t460p>
References: <20190114121414.450ab4ea@gandalf.local.home>
 <20190115032355.GE10121@ming.t460p>
 <20190114225017.336c2347@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114225017.336c2347@vmware.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 15 Jan 2019 04:14:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:50:17PM -0500, Steven Rostedt wrote:
> On Tue, 15 Jan 2019 11:23:56 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Given 'swap_lock' can be acquired from blk_mq_dispatch_rq_list() via
> > blk_mq_get_driver_tag() directly, the above deadlock may be possible.
> > 
> > Sounds the correct fix may be the following one, and the irqsave cost
> > should be fine given sbitmap_deferred_clear is only triggered when one
> > word is run out of.
> 
> Since the lockdep splat only showed SOFTIRQ issues, I figured I would
> only protect it from that. Linus already accepted my patch, can you run
> tests on that kernel with LOCKDEP enabled and see if it will trigger
> with IRQ issues, then we can most definitely upgrade that to
> spin_lock_irqsave(). But I was trying to keep the overhead down, as
> that's a bit more heavy weight than a spin_lock_bh().

As I mentioned, it should be fine given it is triggered only after one word
is run out of.

Follows the lockdep warning on the latest linus tree:

[  107.431033] ------------[ cut here ]------------

[  107.431786] IRQs not enabled as expected
[  107.432047] ================================
[  107.432633] WARNING: CPU: 2 PID: 919 at kernel/softirq.c:169 __local_bh_enable_ip+0x5c/0xe2
[  107.433302] WARNING: inconsistent lock state
[  107.433304] 5.0.0-rc2+ #554 Not tainted
[  107.434513] Modules linked in: null_blk iTCO_wdt iTCO_vendor_support crc32c_intel usb_storage virtio_scsi i2c_i801 i2c_core nvme lpc_ich nvme_core mfd_core qemu_fw_cfg ip_tables
[  107.435124] --------------------------------
[  107.435126] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  107.435679] CPU: 2 PID: 919 Comm: fio Not tainted 5.0.0-rc2+ #554
[  107.438082] fio/917 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  107.438084] 00000000b6dd09e0 (&sbq->ws[i].wait){+.?.}, at: blk_mq_dispatch_rq_list+0x149/0x45d
[  107.438696] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[  107.439599] {IN-SOFTIRQ-W} state was registered at:
[  107.439604]   _raw_spin_lock_irqsave+0x46/0x55
[  107.440481] RIP: 0010:__local_bh_enable_ip+0x5c/0xe2
[  107.441239]   __wake_up_common_lock+0x61/0xd0
[  107.441241]   sbitmap_queue_clear+0x38/0x59
[  107.442468] Code: 00 00 00 75 27 83 b8 a8 0c 00 00 00 75 1e 80 3d f9 15 1d 01 00 75 15 48 c7 c7 d4 43 e5 81 c6 05 e9 15 1d 01 01 e8 fa 91 ff ff <0f> 0b fa 66 0f 1f 44 00 00 e8 54 a8 0e 00 65 8b 05 57 b3 f8 7e 25
[  107.443760]   __blk_mq_free_request+0x7d/0x97
[  107.443764]   scsi_end_request+0x19d/0x2f5
[  107.444462] RSP: 0018:ffffc9000268b848 EFLAGS: 00010086
[  107.445171]   scsi_io_completion+0x290/0x52d
[  107.445173]   blk_done_softirq+0xa3/0xc0
[  107.445880] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000007
[  107.446502]   __do_softirq+0x1e7/0x3ff
[  107.446505]   run_ksoftirqd+0x2f/0x3c
[  107.447120] RDX: 0000000000000000 RSI: ffffffff81ea4392 RDI: 00000000ffffffff
[  107.447122] RBP: ffffffff813fc0c7 R08: 0000000000000001 R09: 0000000000000001
[  107.450027]   smpboot_thread_fn+0x1d8/0x1ef
[  107.450030]   kthread+0x115/0x11d
[  107.450656] R10: 0000000000000001 R11: ffffc9000268b6d7 R12: 0000000000000000
[  107.451305]   ret_from_fork+0x3a/0x50
[  107.451307] irq event stamp: 1066
[  107.452050] R13: 0000000000000000 R14: 0000000000000001 R15: ffff888470254c78
[  107.452052] FS:  00007f8eeefd3740(0000) GS:ffff888477a40000(0000) knlGS:0000000000000000
[  107.452665] hardirqs last  enabled at (1063): [<ffffffff8108aa50>] __local_bh_enable_ip+0xc8/0xe2
[  107.452669] hardirqs last disabled at (1064): [<ffffffff81756287>] _raw_spin_lock_irq+0x15/0x45
[  107.453241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.454355] softirqs last  enabled at (1066): [<ffffffff813fc0c7>] sbitmap_get+0xea/0x127
[  107.454357] softirqs last disabled at (1065): [<ffffffff813fc05a>] sbitmap_get+0x7d/0x127
[  107.454898] CR2: 00007f8eeefc1000 CR3: 0000000471fd2003 CR4: 0000000000760ee0
[  107.454902] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  107.455458] 
               other info that might help us debug this:
[  107.455460]  Possible unsafe locking scenario:

[  107.456482] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  107.456483] PKRU: 55555554
[  107.457515]        CPU0
[  107.457517]        ----
[  107.458114] Call Trace:
[  107.458119]  sbitmap_get+0xea/0x127
[  107.458585]   lock(&sbq->ws[i].wait);
[  107.459626]  __sbitmap_queue_get+0x3e/0x73
[  107.460207]   <Interrupt>
[  107.460208]     lock(&sbq->ws[i].wait);
[  107.460695]  blk_mq_get_tag+0xa6/0x2c6
[  107.461796] 
                *** DEADLOCK ***

[  107.461798] 3 locks held by fio/917:
[  107.462954]  ? wait_woken+0x6d/0x6d
[  107.464333]  #0: 00000000e24edc0f (rcu_read_lock){....}, at: hctx_lock+0x1a/0xcb
[  107.465561]  blk_mq_get_driver_tag+0x81/0xdb
[  107.466465]  #1: 00000000b6dd09e0 (&sbq->ws[i].wait){+.?.}, at: blk_mq_dispatch_rq_list+0x149/0x45d
[  107.467645]  blk_mq_dispatch_rq_list+0x1a7/0x45d
[  107.468912]  #2: 00000000b92e5983 (&(&hctx->dispatch_wait_lock)->rlock){+...}, at: blk_mq_dispatch_rq_list+0x15d/0x45d
[  107.469926]  ? _raw_spin_unlock+0x2e/0x40
[  107.471014] 
               stack backtrace:
[  107.471017] CPU: 10 PID: 917 Comm: fio Not tainted 5.0.0-rc2+ #554
[  107.471952]  blk_mq_do_dispatch_sched+0xcc/0xf2
[  107.472877] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[  107.472879] Call Trace:
[  107.473890]  blk_mq_sched_dispatch_requests+0xf7/0x14b
[  107.474303]  dump_stack+0x85/0xbc
[  107.474670]  __blk_mq_run_hw_queue+0xa4/0xcc
[  107.475069]  print_usage_bug+0x264/0x26f
[  107.475430]  __blk_mq_delay_run_hw_queue+0x4f/0x16b
[  107.475922]  ? check_usage_forwards+0x103/0x103
[  107.476455]  blk_mq_run_hw_queue+0xae/0xce
[  107.477027]  mark_lock+0x2e3/0x515
[  107.477030]  mark_held_locks+0x50/0x64
[  107.477418]  blk_mq_flush_plug_list+0x2f0/0x314
[  107.477969]  ? __local_bh_enable_ip+0xc8/0xe2
[  107.478520]  ? generic_make_request+0x32e/0x3d3
[  107.479354]  lockdep_hardirqs_on+0x184/0x1b4
[  107.479885]  blk_flush_plug_list+0xc0/0xe0
[  107.480381]  ? sbitmap_get+0xea/0x127
[  107.481435]  blk_finish_plug+0x25/0x32
[  107.482035]  __local_bh_enable_ip+0xc8/0xe2
[  107.483315]  blkdev_direct_IO+0x33e/0x3fe
[  107.484044]  sbitmap_get+0xea/0x127
[  107.485576]  ? aio_complete+0x3b0/0x3b0
[  107.486143]  __sbitmap_queue_get+0x3e/0x73
[  107.486769]  ? generic_file_read_iter+0x9c/0x116
[  107.487745]  blk_mq_get_tag+0xa6/0x2c6
[  107.488397]  generic_file_read_iter+0x9c/0x116
[  107.489725]  ? wait_woken+0x6d/0x6d
[  107.490086]  aio_read+0xe8/0x17c
[  107.490887]  blk_mq_get_driver_tag+0x81/0xdb
[  107.491372]  ? __lock_acquire+0x5a6/0x622
[  107.492029]  blk_mq_dispatch_rq_list+0x1a7/0x45d
[  107.492604]  ? find_held_lock+0x2b/0x6e
[  107.493375]  ? _raw_spin_unlock+0x2e/0x40
[  107.494024]  ? io_submit_one+0x395/0x908
[  107.494698]  blk_mq_do_dispatch_sched+0xcc/0xf2
[  107.495192]  io_submit_one+0x395/0x908
[  107.495726]  blk_mq_sched_dispatch_requests+0xf7/0x14b
[  107.496386]  ? find_held_lock+0x2b/0x6e
[  107.497002]  __blk_mq_run_hw_queue+0xa4/0xcc
[  107.497669]  ? __se_sys_io_submit+0xdb/0x22a
[  107.498340]  __blk_mq_delay_run_hw_queue+0x4f/0x16b
[  107.498925]  __se_sys_io_submit+0xdb/0x22a
[  107.499510]  blk_mq_run_hw_queue+0xae/0xce
[  107.500057]  ? up_read+0x1c/0x88
[  107.500659]  blk_mq_flush_plug_list+0x2f0/0x314
[  107.501245]  ? do_syscall_64+0x89/0x1bd
[  107.501736]  ? generic_make_request+0x32e/0x3d3
[  107.502297]  ? __se_sys_io_submit+0x22a/0x22a
[  107.502880]  blk_flush_plug_list+0xc0/0xe0
[  107.503562]  do_syscall_64+0x89/0x1bd
[  107.504164]  blk_finish_plug+0x25/0x32
[  107.504798]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  107.505358]  blkdev_direct_IO+0x33e/0x3fe
[  107.505834] RIP: 0033:0x7f8eee9b6687
[  107.506514]  ? aio_complete+0x3b0/0x3b0
[  107.507094] Code: 00 00 00 49 83 38 00 75 ed 49 83 78 08 00 75 e6 8b 47 0c 39 47 08 75 de 31 c0 c3 0f 1f 84 00 00 00 00 00 b8 d1 00 00 00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 b8 d2 00 00 00 0f 05 c3 0f 1f 84 00 00
[  107.507790]  ? generic_file_read_iter+0x9c/0x116
[  107.508342] RSP: 002b:00007fffc3317788 EFLAGS: 00000206 ORIG_RAX: 00000000000000d1
[  107.508957]  generic_file_read_iter+0x9c/0x116
[  107.508960]  aio_read+0xe8/0x17c
[  107.509537] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8eee9b6687
[  107.509539] RDX: 00000000011a9180 RSI: 0000000000000001 RDI: 00007f8eeefc1000
[  107.510230]  ? __lock_acquire+0x5a6/0x622
[  107.510761] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000011a2fb0
[  107.510762] R10: 000000000000000c R11: 0000000000000206 R12: 00007f8ecc425138
[  107.511582]  ? find_held_lock+0x2b/0x6e
[  107.512137] R13: 00000000011a91b0 R14: 00000000011a2f28 R15: 00000000011a90b0
[  107.512144] irq event stamp: 1085
[  107.512820]  ? io_submit_one+0x395/0x908
[  107.513436] hardirqs last  enabled at (1083): [<ffffffff8108aa50>] __local_bh_enable_ip+0xc8/0xe2
[  107.513440] hardirqs last disabled at (1084): [<ffffffff81756287>] _raw_spin_lock_irq+0x15/0x45
[  107.514137]  io_submit_one+0x395/0x908
[  107.514721] softirqs last  enabled at (1082): [<ffffffff813fc0c7>] sbitmap_get+0xea/0x127
[  107.514724] softirqs last disabled at (1085): [<ffffffff813fc05a>] sbitmap_get+0x7d/0x127
[  107.515383]  ? find_held_lock+0x2b/0x6e
[  107.515849] ---[ end trace 64dc949ae485cd67 ]---
[  107.545737]  ? __se_sys_io_submit+0xdb/0x22a
[  107.546346]  __se_sys_io_submit+0xdb/0x22a
[  107.546931]  ? up_read+0x1c/0x88
[  107.547398]  ? do_syscall_64+0x89/0x1bd
[  107.547960]  ? __se_sys_io_submit+0x22a/0x22a
[  107.548604]  do_syscall_64+0x89/0x1bd
[  107.549132]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  107.549849] RIP: 0033:0x7f8eee9b6687
[  107.550360] Code: 00 00 00 49 83 38 00 75 ed 49 83 78 08 00 75 e6 8b 47 0c 39 47 08 75 de 31 c0 c3 0f 1f 84 00 00 00 00 00 b8 d1 00 00 00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 b8 d2 00 00 00 0f 05 c3 0f 1f 84 00 00
[  107.552971] RSP: 002b:00007fffc3317788 EFLAGS: 00000206 ORIG_RAX: 00000000000000d1
[  107.554036] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8eee9b6687
[  107.555043] RDX: 00000000011a9100 RSI: 0000000000000001 RDI: 00007f8eeefc5000
[  107.556071] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000011a2f30
[  107.557078] R10: 000000000000000c R11: 0000000000000206 R12: 00007f8ecc3f3068
[  107.558078] R13: 00000000011a9130 R14: 00000000011a2ea8 R15: 00000000011a9030


Thanks,
Ming
