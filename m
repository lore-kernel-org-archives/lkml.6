Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733722085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAODuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAODuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:50:21 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE70820859;
        Tue, 15 Jan 2019 03:50:19 +0000 (UTC)
Date:   Mon, 14 Jan 2019 22:50:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Real deadlock being suppressed in sbitmap
Message-ID: <20190114225017.336c2347@vmware.local.home>
In-Reply-To: <20190115032355.GE10121@ming.t460p>
References: <20190114121414.450ab4ea@gandalf.local.home>
        <20190115032355.GE10121@ming.t460p>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 11:23:56 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> Given 'swap_lock' can be acquired from blk_mq_dispatch_rq_list() via
> blk_mq_get_driver_tag() directly, the above deadlock may be possible.
> 
> Sounds the correct fix may be the following one, and the irqsave cost
> should be fine given sbitmap_deferred_clear is only triggered when one
> word is run out of.

Since the lockdep splat only showed SOFTIRQ issues, I figured I would
only protect it from that. Linus already accepted my patch, can you run
tests on that kernel with LOCKDEP enabled and see if it will trigger
with IRQ issues, then we can most definitely upgrade that to
spin_lock_irqsave(). But I was trying to keep the overhead down, as
that's a bit more heavy weight than a spin_lock_bh().

-- Steve
