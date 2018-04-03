Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeDCLlf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755135AbeDCLle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:41:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBF62133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Tue, 3 Apr 2018 13:41:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, cmetcalf@mellanox.com, cl@linux.com,
        lcapitulino@redhat.com, efault@gmx.de, peterz@infradead.org,
        riel@redhat.com, tglx@linutronix.de, kernellwp@gmail.com,
        mingo@kernel.org
Subject: Re: NO_HZ_FULL and tick running within a reasonable amount of time
Message-ID: <20180403114130.GA22765@lerouge>
References: <20180402220438.GA15885@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402220438.GA15885@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 03:04:38PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I am hitting the following on today's mainline under rcutorture, but
> only on scenarios built with CONFIG_NO_HZ_FULL=y:
> 
> ------------------------------------------------------------------------
> 
> WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0x113/0x120
> Modules linked in:
> CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> Workqueue: events_unbound sched_tick_remote
> RIP: 0010:sched_tick_remote+0x113/0x120
> RSP: 0018:ffff94d540103e20 EFLAGS: 00010002
> RAX: 000000012e9bb357 RBX: ffff8f95dfd21840 RCX: 000000000000001f
> RDX: 00000000b2d05e00 RSI: 00000000ffffffff RDI: ffff8f95dfd21858
> RBP: ffff94d540103e48 R08: 00000000f6499019 R09: 00000000f6499000
> R10: 00000000b163d33b R11: ffffffffa5c8c212 R12: ffff8f95dfd25518
> R13: ffff8f95de9e4200 R14: 0000000000003402 R15: ffff8f95dfd21858
> FS:  0000000000000000(0000) GS:ffff8f95dfc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000a015b40 CR3: 000000001de14000 CR4: 00000000000006f0
> Call Trace:
>  process_one_work+0x1d9/0x6a0
>  worker_thread+0x42/0x420
>  kthread+0xf3/0x130
>  ? rescuer_thread+0x340/0x340
>  ? kthread_delayed_work_timer_fn+0x80/0x80
>  ret_from_fork+0x3a/0x50
> Code: ff 48 8b 83 80 0b 00 00 48 85 c0 0f 85 41 ff ff ff e9 45 ff ff ff be ff ff ff ff 4c 89 ff e8 55 44 02 00 85 c0 75 87 0f 0b eb 83 <0f> 0b eb 97 66 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54
> ---[ end trace fbdcbe529a8ae799 ]--
> 
> ------------------------------------------------------------------------
> 
> The WARN_ON_ONCE() triggering is this guy:
> 
> 	delta = rq_clock_task(rq) - curr->se.exec_start;
> 	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);

Weird. Can you try to print up those values and see how much they drift?

        if (WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3))
               printk_once("clock_task: %lld exec_start: %lld\n", rq_clock_task(rq), curr->se.exec_start);

> 
> But given that ->se.exec_start is zeroed from time to time, for example,
> in migrate_task_rq_fair(), I am a bit suspicious of this check.
> 
> What am I missing here?
> 
> 							Thanx, Paul
> 
