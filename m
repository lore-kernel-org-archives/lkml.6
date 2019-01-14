Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2089C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA332086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:14:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DA32070B;
        Mon, 14 Jan 2019 17:14:16 +0000 (UTC)
Date:   Mon, 14 Jan 2019 12:14:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Real deadlock being suppressed in sbitmap
Message-ID: <20190114121414.450ab4ea@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was brought to my attention (by this creating a splat in the RT tree
too) this code:

static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
{
	unsigned long mask, val;
	unsigned long __maybe_unused flags;
	bool ret = false;

	/* Silence bogus lockdep warning */
#if defined(CONFIG_LOCKDEP)
	local_irq_save(flags);
#endif
	spin_lock(&sb->map[index].swap_lock);

Commit 58ab5e32e6f ("sbitmap: silence bogus lockdep IRQ warning")
states the following:

    For this case, it's a false positive. The swap_lock is used from process
    context only, when we swap the bits in the word and cleared mask. We
    also end up doing that when we are getting a driver tag, from the
    blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
    IRQs disabled. However, this isn't from an actual IRQ, it's still
    process context.

The thing is, lockdep doesn't define a lock as "irq-safe" based on it
being taken under interrupts disabled or not. It detects when locks are
used in actual interrupts. Further in that commit we have this:

   [  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
    [  106.098231] 000000004c43fa71
    (&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
    [  106.099431]
    [  106.099431] and this task is already holding:
    [  106.100229] 000000007eec8b2f
    (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
    blk_mq_dispatch_rq_list+0x4c1/0xd7c
    [  106.101630] which would create a new lock dependency:
    [  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
    (&(&sb->map[i].swap_lock)->rlock){+.+.}

Saying that you are trying to take the swap_lock while holding the
dispatch_wait_lock.


    [  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
    [  106.104580]  (&sbq->ws[i].wait){..-.}

Which means that there's already a chain of:

 sbq->ws[i].wait -> dispatch_wait_lock

    [  106.104582]
    [  106.104582] ... which became SOFTIRQ-irq-safe at:
    [  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
    [  106.106284]   __wake_up_common_lock+0x119/0x1b9
    [  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
    [  106.107456]   sbitmap_queue_clear+0x4c/0x9a
    [  106.108046]   __blk_mq_free_request+0x188/0x1d3
    [  106.108581]   blk_mq_free_request+0x23b/0x26b
    [  106.109102]   scsi_end_request+0x345/0x5d7
    [  106.109587]   scsi_io_completion+0x4b5/0x8f0
    [  106.110099]   scsi_finish_command+0x412/0x456
    [  106.110615]   scsi_softirq_done+0x23f/0x29b
    [  106.111115]   blk_done_softirq+0x2a7/0x2e6
    [  106.111608]   __do_softirq+0x360/0x6ad
    [  106.112062]   run_ksoftirqd+0x2f/0x5b
    [  106.112499]   smpboot_thread_fn+0x3a5/0x3db
    [  106.113000]   kthread+0x1d4/0x1e4
    [  106.113457]   ret_from_fork+0x3a/0x50


We see that sbq->ws[i].wait was taken from a softirq context.



    [  106.131226] Chain exists of:
    [  106.131226]   &sbq->ws[i].wait -->
    &(&hctx->dispatch_wait_lock)->rlock -->
    &(&sb->map[i].swap_lock)->rlock

This is telling us that we now have a chain of:

 sbq->ws[i].wait -> dispatch_wait_lock -> swap_lock

    [  106.131226]
    [  106.132865]  Possible interrupt unsafe locking scenario:
    [  106.132865]
    [  106.133659]        CPU0                    CPU1
    [  106.134194]        ----                    ----
    [  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
    [  106.135318]                                local_irq_disable();
    [  106.136014]                                lock(&sbq->ws[i].wait);
    [  106.136747]
    lock(&(&hctx->dispatch_wait_lock)->rlock);
    [  106.137742]   <Interrupt>
    [  106.138110]     lock(&sbq->ws[i].wait);
    [  106.138625]
    [  106.138625]  *** DEADLOCK ***
    [  106.138625]

I need to make this more than just two levels deep. Here's the issue:


	CPU0			CPU1			CPU2
	----			----			----
  lock(swap_lock)
			local_irq_disable()
			lock(dispatch_lock);
							local_irq_disable()
							lock(sbq->ws[i].wait)
							lock(dispatch_lock)
			lock(swap_lock)
  <interrupt>
  lock(sbq->ws[i].wait)


DEADLOCK!

In other words, it is not bogus, and can be a real potential for a
deadlock. Please talk with the lockdep maintainers before saying
there's a bogus deadlock, because lockdep is seldom wrong.

-- Steve
