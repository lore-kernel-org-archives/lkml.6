Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E30BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17A220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GVaHLjFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfANToB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:44:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36558 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:44:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so97353pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdKUtuysBZYfq2BIe2DE/V4q1rgbp6XG4ebepD/XAXM=;
        b=GVaHLjFJ5vLwxY8XmR0tOiOxKThxDHjkATmsGDz3pPxqPz0YfAWTsCstkghfSivLiR
         V0x9zsLLNrjkB/d0i0S0mCV88DsjpSGwZ3/vbU4cEdrw111MqmhdtSIoSFQmlb8j+hH6
         yNkDcXLn3u9kCLysDbHBTdKcQMX803hie9k5OPoo8Cj4P6ssha2K40pqItXHkPostYPm
         OQfGrj8akhxCoDXb8fEjtfrklbTWQKEfg2JS4rReSk63PNsU8r0Yl3W6e5avH71OLb2Z
         /2E64s5J24OqOsGnvGTTkGmey0CJmkd9PydzZxKAMCEOWlhjgH1q4I5986KRBNyfYJqZ
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdKUtuysBZYfq2BIe2DE/V4q1rgbp6XG4ebepD/XAXM=;
        b=VHOVrqRJF1Kd7kEu3JsmVjIaUiPZDGm2iWnRxQVPRiiiejcFzeuikEaSwulECoRJDR
         NwLfMmD2MlFaW+KBHbarPn+0yCi6owR0lxRa+kdDsVUpJz915B3XpcbKdn3Re9uincxU
         giSPnriTQpAkXFaEQG8mju+KRMTNL/b03utzbFtKTMgArolDZVOshJRHyM1ImC37q2BX
         9IFQpbmof+D+lXleC0OhOTQCitGX9UxNnhlb77sVaCV21sk6F6op7q/ISeMWYHHRK8W9
         3TC/oWbgcTopme2vGLgp+EZLRNY8OsfroP45G89VjaS0yNS2W3mJY7wGknop5LOFHghM
         hUkg==
X-Gm-Message-State: AJcUukd13hylpjEYV6gFr1bjNfTXx2/I7RWiHgpANoLfC57YoW9utZcp
        ff3sWb4LtQLUAjLbY1TbJGJzqQ==
X-Google-Smtp-Source: ALg8bN73X1n9+XqbxIkZd0sz/rsB/83S71XUqIl4D49XZWvm3HdS2rVNq3f6Tmr3NbCU5KJkJH5XRg==
X-Received: by 2002:a63:5107:: with SMTP id f7mr122178pgb.218.1547495039344;
        Mon, 14 Jan 2019 11:43:59 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 24sm4577001pfl.32.2019.01.14.11.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:43:58 -0800 (PST)
Subject: Re: Real deadlock being suppressed in sbitmap
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20190114121414.450ab4ea@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <986b3710-350f-c454-f0ee-4e013c6656e3@kernel.dk>
Date:   Mon, 14 Jan 2019 12:43:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114121414.450ab4ea@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 10:14 AM, Steven Rostedt wrote:
> It was brought to my attention (by this creating a splat in the RT tree
> too) this code:
> 
> static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> {
> 	unsigned long mask, val;
> 	unsigned long __maybe_unused flags;
> 	bool ret = false;
> 
> 	/* Silence bogus lockdep warning */
> #if defined(CONFIG_LOCKDEP)
> 	local_irq_save(flags);
> #endif
> 	spin_lock(&sb->map[index].swap_lock);
> 
> Commit 58ab5e32e6f ("sbitmap: silence bogus lockdep IRQ warning")
> states the following:
> 
>     For this case, it's a false positive. The swap_lock is used from process
>     context only, when we swap the bits in the word and cleared mask. We
>     also end up doing that when we are getting a driver tag, from the
>     blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
>     IRQs disabled. However, this isn't from an actual IRQ, it's still
>     process context.
> 
> The thing is, lockdep doesn't define a lock as "irq-safe" based on it
> being taken under interrupts disabled or not. It detects when locks are
> used in actual interrupts. Further in that commit we have this:
> 
>    [  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>     [  106.098231] 000000004c43fa71
>     (&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
>     [  106.099431]
>     [  106.099431] and this task is already holding:
>     [  106.100229] 000000007eec8b2f
>     (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
>     blk_mq_dispatch_rq_list+0x4c1/0xd7c
>     [  106.101630] which would create a new lock dependency:
>     [  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
>     (&(&sb->map[i].swap_lock)->rlock){+.+.}
> 
> Saying that you are trying to take the swap_lock while holding the
> dispatch_wait_lock.
> 
> 
>     [  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
>     [  106.104580]  (&sbq->ws[i].wait){..-.}
> 
> Which means that there's already a chain of:
> 
>  sbq->ws[i].wait -> dispatch_wait_lock
> 
>     [  106.104582]
>     [  106.104582] ... which became SOFTIRQ-irq-safe at:
>     [  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
>     [  106.106284]   __wake_up_common_lock+0x119/0x1b9
>     [  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
>     [  106.107456]   sbitmap_queue_clear+0x4c/0x9a
>     [  106.108046]   __blk_mq_free_request+0x188/0x1d3
>     [  106.108581]   blk_mq_free_request+0x23b/0x26b
>     [  106.109102]   scsi_end_request+0x345/0x5d7
>     [  106.109587]   scsi_io_completion+0x4b5/0x8f0
>     [  106.110099]   scsi_finish_command+0x412/0x456
>     [  106.110615]   scsi_softirq_done+0x23f/0x29b
>     [  106.111115]   blk_done_softirq+0x2a7/0x2e6
>     [  106.111608]   __do_softirq+0x360/0x6ad
>     [  106.112062]   run_ksoftirqd+0x2f/0x5b
>     [  106.112499]   smpboot_thread_fn+0x3a5/0x3db
>     [  106.113000]   kthread+0x1d4/0x1e4
>     [  106.113457]   ret_from_fork+0x3a/0x50
> 
> 
> We see that sbq->ws[i].wait was taken from a softirq context.
> 
> 
> 
>     [  106.131226] Chain exists of:
>     [  106.131226]   &sbq->ws[i].wait -->
>     &(&hctx->dispatch_wait_lock)->rlock -->
>     &(&sb->map[i].swap_lock)->rlock
> 
> This is telling us that we now have a chain of:
> 
>  sbq->ws[i].wait -> dispatch_wait_lock -> swap_lock
> 
>     [  106.131226]
>     [  106.132865]  Possible interrupt unsafe locking scenario:
>     [  106.132865]
>     [  106.133659]        CPU0                    CPU1
>     [  106.134194]        ----                    ----
>     [  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
>     [  106.135318]                                local_irq_disable();
>     [  106.136014]                                lock(&sbq->ws[i].wait);
>     [  106.136747]
>     lock(&(&hctx->dispatch_wait_lock)->rlock);
>     [  106.137742]   <Interrupt>
>     [  106.138110]     lock(&sbq->ws[i].wait);
>     [  106.138625]
>     [  106.138625]  *** DEADLOCK ***
>     [  106.138625]
> 
> I need to make this more than just two levels deep. Here's the issue:
> 
> 
> 	CPU0			CPU1			CPU2
> 	----			----			----
>   lock(swap_lock)
> 			local_irq_disable()
> 			lock(dispatch_lock);
> 							local_irq_disable()
> 							lock(sbq->ws[i].wait)
> 							lock(dispatch_lock)
> 			lock(swap_lock)
>   <interrupt>
>   lock(sbq->ws[i].wait)
> 
> 
> DEADLOCK!
> 
> In other words, it is not bogus, and can be a real potential for a
> deadlock. Please talk with the lockdep maintainers before saying
> there's a bogus deadlock, because lockdep is seldom wrong.

Thanks Steven, your analysis looks good. I got fooled by the fact that
the path where we do grab them both is never in irq/soft-irq context,
but that doesn't change the fact that the wq lock IS grabbed in irq
context.

Patch also looks good, but I see Linus already applied it.

-- 
Jens Axboe

