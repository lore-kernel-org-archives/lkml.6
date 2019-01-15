Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36F3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A81320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfAODq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:46:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAODq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:46:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3C9A2D7E4;
        Tue, 15 Jan 2019 03:46:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E07619C7E;
        Tue, 15 Jan 2019 03:46:18 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:46:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Real deadlock being suppressed in sbitmap
Message-ID: <20190115034612.GF10121@ming.t460p>
References: <20190114121414.450ab4ea@gandalf.local.home>
 <20190115032355.GE10121@ming.t460p>
 <31b9c76b-6f70-0af4-d854-e02bda25e4c0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b9c76b-6f70-0af4-d854-e02bda25e4c0@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 15 Jan 2019 03:46:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:41:16PM -0700, Jens Axboe wrote:
> On 1/14/19 8:23 PM, Ming Lei wrote:
> > Hi Steven,
> > 
> > On Mon, Jan 14, 2019 at 12:14:14PM -0500, Steven Rostedt wrote:
> >> It was brought to my attention (by this creating a splat in the RT tree
> >> too) this code:
> >>
> >> static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> >> {
> >> 	unsigned long mask, val;
> >> 	unsigned long __maybe_unused flags;
> >> 	bool ret = false;
> >>
> >> 	/* Silence bogus lockdep warning */
> >> #if defined(CONFIG_LOCKDEP)
> >> 	local_irq_save(flags);
> >> #endif
> >> 	spin_lock(&sb->map[index].swap_lock);
> >>
> >> Commit 58ab5e32e6f ("sbitmap: silence bogus lockdep IRQ warning")
> >> states the following:
> >>
> >>     For this case, it's a false positive. The swap_lock is used from process
> >>     context only, when we swap the bits in the word and cleared mask. We
> >>     also end up doing that when we are getting a driver tag, from the
> >>     blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
> >>     IRQs disabled. However, this isn't from an actual IRQ, it's still
> >>     process context.
> >>
> >> The thing is, lockdep doesn't define a lock as "irq-safe" based on it
> >> being taken under interrupts disabled or not. It detects when locks are
> >> used in actual interrupts. Further in that commit we have this:
> >>
> >>    [  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> >>     [  106.098231] 000000004c43fa71
> >>     (&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
> >>     [  106.099431]
> >>     [  106.099431] and this task is already holding:
> >>     [  106.100229] 000000007eec8b2f
> >>     (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
> >>     blk_mq_dispatch_rq_list+0x4c1/0xd7c
> >>     [  106.101630] which would create a new lock dependency:
> >>     [  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
> >>     (&(&sb->map[i].swap_lock)->rlock){+.+.}
> >>
> >> Saying that you are trying to take the swap_lock while holding the
> >> dispatch_wait_lock.
> >>
> >>
> >>     [  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
> >>     [  106.104580]  (&sbq->ws[i].wait){..-.}
> >>
> >> Which means that there's already a chain of:
> >>
> >>  sbq->ws[i].wait -> dispatch_wait_lock
> >>
> >>     [  106.104582]
> >>     [  106.104582] ... which became SOFTIRQ-irq-safe at:
> >>     [  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
> >>     [  106.106284]   __wake_up_common_lock+0x119/0x1b9
> >>     [  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
> >>     [  106.107456]   sbitmap_queue_clear+0x4c/0x9a
> >>     [  106.108046]   __blk_mq_free_request+0x188/0x1d3
> >>     [  106.108581]   blk_mq_free_request+0x23b/0x26b
> >>     [  106.109102]   scsi_end_request+0x345/0x5d7
> >>     [  106.109587]   scsi_io_completion+0x4b5/0x8f0
> >>     [  106.110099]   scsi_finish_command+0x412/0x456
> >>     [  106.110615]   scsi_softirq_done+0x23f/0x29b
> >>     [  106.111115]   blk_done_softirq+0x2a7/0x2e6
> >>     [  106.111608]   __do_softirq+0x360/0x6ad
> >>     [  106.112062]   run_ksoftirqd+0x2f/0x5b
> >>     [  106.112499]   smpboot_thread_fn+0x3a5/0x3db
> >>     [  106.113000]   kthread+0x1d4/0x1e4
> >>     [  106.113457]   ret_from_fork+0x3a/0x50
> >>
> >>
> >> We see that sbq->ws[i].wait was taken from a softirq context.
> > 
> > Actually sbq->ws[i].wait is taken from a softirq context only in case
> > of single-queue, see __blk_mq_complete_request(). For multiple queue,
> > sbq->ws[i].wait is taken from hardirq context.
> 
> That's a good point, but that's just current implementation, we can't
> assume any of those relationsships. Any completion can happen from
> softirq or hardirq. So the patch is inadequate.
> 
> > Sounds the correct fix may be the following one, and the irqsave cost
> > should be fine given sbitmap_deferred_clear is only triggered when one
> > word is run out of.
> 
> Yes, the _bh() variant isn't going to cut it. Can you send this patch
> against Linus's master?

OK, will post it out soon.

Thanks,
Ming
