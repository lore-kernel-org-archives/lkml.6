Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeCZFM3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 01:12:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38535 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeCZFM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:12:27 -0400
X-Google-Smtp-Source: AG47ELslxl6RkbeCUtaEYQQd1BlCo5BU97E5K83tbnt73kC9HIxzTeT2BT/5fTfT0emWBV2Wg9HsdQ==
Date: Mon, 26 Mar 2018 14:12:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180326051222.GA7779@jagdpanzerIV>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
 <20180322021437.GA3181@jagdpanzerIV>
 <20180322182517.511aad9d@gandalf.local.home>
 <20180323120622.GA510@jagdpanzerIV>
 <20180323131653.4bsco3v7xdb7ifvu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323131653.4bsco3v7xdb7ifvu@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/23/18 14:16), Petr Mladek wrote:
[..]
> If I get it correctly, the reporter of this bug has not tried
> Steven's patches yet.

It's not immediately clear.

It's not even completely clear if we are looking at "X cpus printk
1 cpu prints it all scenario" and it's not clear if hand off will be
helpful here. I'll try to explain.

What we see is:

CPU0 locked up on blkg->q->queue_lock

  [<ffffffff8130f236>] cfqg_print_rwstat_recursive+0x36/0x40
  [<ffffffff81109393>] cgroup_seqfile_show+0x73/0x80
  [<ffffffff81222b57>] ? seq_buf_alloc+0x17/0x40
  [<ffffffff8122305a>] seq_read+0x10a/0x3b0
  [<ffffffff811fe9be>] vfs_read+0x9e/0x170
  [<ffffffff811ff58f>] SyS_read+0x7f/0xe0
  [<ffffffff81697ac9>] system_call_fastpath+0x16/0x1b

blkg->q->queue_lock was held by CPU7, which was spinnig in wait_for_xmitr().

 #5 [ffff881ffb0b7548] __const_udelay at ffffffff81326678
 #6 [ffff881ffb0b7558] wait_for_xmitr at ffffffff814056e0
 #7 [ffff881ffb0b7580] serial8250_console_putchar at ffffffff814058ac
 #8 [ffff881ffb0b75a0] uart_console_write at ffffffff8140035a
 #9 [ffff881ffb0b75d0] serial8250_console_write at ffffffff814057fe
#10 [ffff881ffb0b7618] call_console_drivers.constprop.17 at ffffffff81087011
#11 [ffff881ffb0b7640] console_unlock at ffffffff810889e9
#12 [ffff881ffb0b7680] vprintk_emit at ffffffff81088df4
#13 [ffff881ffb0b76f0] dev_vprintk_emit at ffffffff81428e72
#14 [ffff881ffb0b77a8] dev_printk_emit at ffffffff81428eee
#15 [ffff881ffb0b7808] __dev_printk at ffffffff8142937e
#16 [ffff881ffb0b7818] dev_printk at ffffffff8142942d
#17 [ffff881ffb0b7888] sdev_prefix_printk at ffffffff81463771
#18 [ffff881ffb0b7918] scsi_prep_state_check at ffffffff814598e4
#19 [ffff881ffb0b7928] scsi_prep_fn at ffffffff8145992d
#20 [ffff881ffb0b7960] blk_peek_request at ffffffff812f0826
#21 [ffff881ffb0b7988] scsi_request_fn at ffffffff8145b588
#22 [ffff881ffb0b79f0] __blk_run_queue at ffffffff812ebd63
#23 [ffff881ffb0b7a08] blk_queue_bio at ffffffff812f1013     <<< acquired q->queue_lock
#24 [ffff881ffb0b7a50] generic_make_request at ffffffff812ef209
#25 [ffff881ffb0b7a98] submit_bio at ffffffff812ef351
#26 [ffff881ffb0b7af0] xfs_submit_ioend_bio at ffffffffa0146a63 [xfs]
#27 [ffff881ffb0b7b00] xfs_submit_ioend at ffffffffa0146b31 [xfs]
#28 [ffff881ffb0b7b40] xfs_vm_writepages at ffffffffa0146e18 [xfs]
#29 [ffff881ffb0b7bb8] do_writepages at ffffffff8118da6e
#30 [ffff881ffb0b7bc8] __writeback_single_inode at ffffffff812293a0
#31 [ffff881ffb0b7c08] writeback_sb_inodes at ffffffff8122a08e
#32 [ffff881ffb0b7cb0] __writeback_inodes_wb at ffffffff8122a2ef
#33 [ffff881ffb0b7cf8] wb_writeback at ffffffff8122ab33
#34 [ffff881ffb0b7d70] bdi_writeback_workfn at ffffffff8122cb2b
#35 [ffff881ffb0b7e20] process_one_work at ffffffff810a851b
#36 [ffff881ffb0b7e68] worker_thread at ffffffff810a9356
#37 [ffff881ffb0b7ec8] kthread at ffffffff810b0b6f
#38 [ffff881ffb0b7f50] ret_from_fork at ffffffff81697a18


Given how slow serial8250_console_putchar()->wait_for_xmitr() can be -
10ms of delay for every char - it's possible that we had no concurrent
printk()-s from other CPUs. So may be we had just one printing CPU,
and several CPUs spinning on a spin_lock which was owned by the printing
CPU.

So that's why printk_deferred() helped here. It simply detached 8250
and made spin_lock critical secrtion to be as fast as printk->log_store().


But here comes the tricky part. Suppose that we:
a) have at least two CPUs that call printk concurrently
b) have hand off enabled


Now, what will happen if we have something like this

CPU0					CPU1				CPU2
					spin_lock(queue_lock)
					 printk				printk
cfqg_print_rwstat_recursive()		  serial8250
 spin_lock(queue_lock)			 printk				 serial8250
 					  serial8250			printk
									 serial8250


I suspect that handoff may not be very helpful. CPU1 and CPU2 will wait for
each to finish serial8250 and to hand off printing to each other. So CPU1
will do 2 serial8250 invocations to printk its messages, and in between it
will spin waiting for CPU2 to do its printk->serial8250 and to handoff
printing to CPU1. The problem is that CPU1 will be under spin_lock() all
that time, so CPU0 is going to suffer just like before.

Opinions?

	-ss
