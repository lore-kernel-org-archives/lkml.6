Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC220844
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeGCVfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:35:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeGCVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:35:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faSxX-0003B5-LP; Tue, 03 Jul 2018 23:35:39 +0200
Date:   Tue, 3 Jul 2018 23:35:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] cgroup: use irqsave in cgroup_rstat_flush_locked()
Message-ID: <20180703213539.i3mozfuhi7j7xefm@linutronix.de>
References: <20180703164544.25268-1-bigeasy@linutronix.de>
 <20180703202424.GB72677@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703202424.GB72677@devbig577.frc2.facebook.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 13:24:24 [-0700], Tejun Heo wrote:
> (cc'ing Peter and Ingo for lockdep)
> 
> Hello, Sebastian.
Hi Tejun,

> On Tue, Jul 03, 2018 at 06:45:44PM +0200, Sebastian Andrzej Siewior wrote:
> > All callers of cgroup_rstat_flush_locked() acquire cgroup_rstat_lock
> > either with spin_lock_irq() or spin_lock_irqsave().
> 
> So, irq is always disabled in cgroup_rstat_flush_locked().

on not RT enabled kernels. On RT enabled kernels spin_lock_irq.*() is
turned into a sleeping spinlock which do not disable interrupts.

> > cgroup_rstat_flush_locked() itself acquires cgroup_rstat_cpu_lock which
> > is a raw_spin_lock. This lock is also acquired in cgroup_rstat_updated()
> > in IRQ context and therefore requires _irqsave() locking suffix in
> > cgroup_rstat_flush_locked().
> 
> Yes, the cpu locks should be irqsafe too; however, as irq is always
> disabled in that function, save/restore is redundant, no?

as I pointed out above only the raw_spin_lock_t really disables
interrupts on -RT. That is the difference between those two.

> > Since there is no difference between spin_lock_t and raw_spin_lock_t
> > on !RT lockdep does not complain here. On RT lockdep complains because
> > the interrupts were not disabled here and a deadlock is possible.
> 
> We at least used to do this in the kernel - manipulating irqsafe locks
> with spin_lock/unlock() if the irq state is known, whether enabled or
> disabled, and ISTR lockdep being smart enough to track actual irq
> state to determine irq safety.  Am I misremembering or is this
> different on RT kernels?

No, this is correct. So on !RT kernels the spin_lock_irq() disables
interrupts and the raw_spin_lock() has the interrupts already disabled,
everything is good. On RT kernels the spin_lock_irq() does not disable
interrupts and the raw_spin_lock() acquires the lock with enabled
interrupts and lockdep complains properly.
lockdep sees the hardirq path via:

 {IN-HARDIRQ-W} state was registered at:
   lock_acquire+0x9e/0x250
   _raw_spin_lock_irqsave+0x38/0x50
   cgroup_rstat_updated+0x57/0x100
   cgroup_base_stat_cputime_account_end.isra.6+0x17/0x60
   __cgroup_account_cputime_field+0x49/0x60
   account_system_index_time+0xdb/0x1f0
   account_system_time+0x3f/0x70
   account_process_tick+0x59/0x80
   update_process_times+0x1d/0x50
   tick_sched_handle+0x20/0x60
   tick_sched_timer+0x37/0x80
   __hrtimer_run_queues+0x12c/0x6d0
   hrtimer_interrupt+0xed/0x240
   smp_apic_timer_interrupt+0x89/0x3c0
   apic_timer_interrupt+0xf/0x20
   pin_current_cpu+0xa/0x120
   migrate_disable+0x9a/0x200
   rt_spin_lock+0x1d/0x60
   put_unused_fd+0x2c/0x50
   do_sys_open+0x23a/0x250
   __x64_sys_openat+0x1b/0x20
   do_syscall_64+0x50/0x190
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

> Thanks.

Sebastian
