Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD12320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jq2eebw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAODlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:41:22 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34992 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAODlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:41:21 -0500
Received: by mail-pf1-f170.google.com with SMTP id z9so644239pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUVY+59A6BVhcZEA7urUHTXyKPK1s+sj9dacdYiuqRo=;
        b=Jq2eebw3rf2eXbLynxYgyMmKuY6fxJTTcVShbIYkfqFTP9Y+6UmdS7IfbqmZUpe9XR
         Z4pKQ4ksLZ/RExmrxpJ0kmQEcC455+T51NzHPI6v96L708V9KmPS/ZeY6S36uf7Q+BT6
         mo6ZvhNMRwxUOoP2quTpYySLa1+RXXAWnvWyx5Dg6gYTEELAlmT2r2ADExvNOV5VqgYM
         Fzltg7fSRVABG3myQ9q602dVtCsQZ05YDTWO98K6Izc0PJG4jR2qeoTs0xcZaV4J38vv
         WPdw0+qjM1AefdZ95fpYWmJWLqJWArKhaqUEeUr+71yKgImw8nm1v5tvjA69pwnBcbAG
         V8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUVY+59A6BVhcZEA7urUHTXyKPK1s+sj9dacdYiuqRo=;
        b=N9GcfBSRtJisu6octmVtjhs97Jo+DxSkPgdKgEi3sC6tms+ocy1y3fEmk3R3qr5uL1
         Bp/ekDHDHUdWZxIt+b1qBDkf071nFa/QrLJ48MFmWhaDU6AwsHKHj5TUTeTHeOJAuYHl
         UQEfqCEjGWhflmchOwRMNMq6+cpkXIsy8WCA6Ps2B8Ue0M0lUwBV87SnDK6F3+nr5gi4
         mScK1GbsZIhtrToGIKghgk1PPUZo9ag6LcEArl3DMIiinxZvgDqVM6Ej5F58OxWqiyX2
         vEJPtcsE/2RFjyazyu07kWr1zP4qFFTrSulHmBZ5STLNgJmMkmWEq7ypv9pTWKsr8ZjA
         WiSw==
X-Gm-Message-State: AJcUukd3Ek+sEJEJDpGW7k2DRoae76xEQa/0LqqF6MZxzPBJiHrfbKYd
        rttUZ3e5shcAUheIX/um0FKOyg==
X-Google-Smtp-Source: ALg8bN5LIwpNgG/oCseSPdOcHLx/IMMvzt2rFpMMBAFdIjNUxmsya5hH962ldFHO+1CON56dFg/VZA==
X-Received: by 2002:a65:610d:: with SMTP id z13mr1854983pgu.427.1547523679951;
        Mon, 14 Jan 2019 19:41:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l70sm1824871pgd.20.2019.01.14.19.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:41:18 -0800 (PST)
Subject: Re: Real deadlock being suppressed in sbitmap
To:     Ming Lei <ming.lei@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190114121414.450ab4ea@gandalf.local.home>
 <20190115032355.GE10121@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31b9c76b-6f70-0af4-d854-e02bda25e4c0@kernel.dk>
Date:   Mon, 14 Jan 2019 20:41:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115032355.GE10121@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 8:23 PM, Ming Lei wrote:
> Hi Steven,
> 
> On Mon, Jan 14, 2019 at 12:14:14PM -0500, Steven Rostedt wrote:
>> It was brought to my attention (by this creating a splat in the RT tree
>> too) this code:
>>
>> static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>> {
>> 	unsigned long mask, val;
>> 	unsigned long __maybe_unused flags;
>> 	bool ret = false;
>>
>> 	/* Silence bogus lockdep warning */
>> #if defined(CONFIG_LOCKDEP)
>> 	local_irq_save(flags);
>> #endif
>> 	spin_lock(&sb->map[index].swap_lock);
>>
>> Commit 58ab5e32e6f ("sbitmap: silence bogus lockdep IRQ warning")
>> states the following:
>>
>>     For this case, it's a false positive. The swap_lock is used from process
>>     context only, when we swap the bits in the word and cleared mask. We
>>     also end up doing that when we are getting a driver tag, from the
>>     blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
>>     IRQs disabled. However, this isn't from an actual IRQ, it's still
>>     process context.
>>
>> The thing is, lockdep doesn't define a lock as "irq-safe" based on it
>> being taken under interrupts disabled or not. It detects when locks are
>> used in actual interrupts. Further in that commit we have this:
>>
>>    [  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>>     [  106.098231] 000000004c43fa71
>>     (&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
>>     [  106.099431]
>>     [  106.099431] and this task is already holding:
>>     [  106.100229] 000000007eec8b2f
>>     (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
>>     blk_mq_dispatch_rq_list+0x4c1/0xd7c
>>     [  106.101630] which would create a new lock dependency:
>>     [  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
>>     (&(&sb->map[i].swap_lock)->rlock){+.+.}
>>
>> Saying that you are trying to take the swap_lock while holding the
>> dispatch_wait_lock.
>>
>>
>>     [  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
>>     [  106.104580]  (&sbq->ws[i].wait){..-.}
>>
>> Which means that there's already a chain of:
>>
>>  sbq->ws[i].wait -> dispatch_wait_lock
>>
>>     [  106.104582]
>>     [  106.104582] ... which became SOFTIRQ-irq-safe at:
>>     [  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
>>     [  106.106284]   __wake_up_common_lock+0x119/0x1b9
>>     [  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
>>     [  106.107456]   sbitmap_queue_clear+0x4c/0x9a
>>     [  106.108046]   __blk_mq_free_request+0x188/0x1d3
>>     [  106.108581]   blk_mq_free_request+0x23b/0x26b
>>     [  106.109102]   scsi_end_request+0x345/0x5d7
>>     [  106.109587]   scsi_io_completion+0x4b5/0x8f0
>>     [  106.110099]   scsi_finish_command+0x412/0x456
>>     [  106.110615]   scsi_softirq_done+0x23f/0x29b
>>     [  106.111115]   blk_done_softirq+0x2a7/0x2e6
>>     [  106.111608]   __do_softirq+0x360/0x6ad
>>     [  106.112062]   run_ksoftirqd+0x2f/0x5b
>>     [  106.112499]   smpboot_thread_fn+0x3a5/0x3db
>>     [  106.113000]   kthread+0x1d4/0x1e4
>>     [  106.113457]   ret_from_fork+0x3a/0x50
>>
>>
>> We see that sbq->ws[i].wait was taken from a softirq context.
> 
> Actually sbq->ws[i].wait is taken from a softirq context only in case
> of single-queue, see __blk_mq_complete_request(). For multiple queue,
> sbq->ws[i].wait is taken from hardirq context.

That's a good point, but that's just current implementation, we can't
assume any of those relationsships. Any completion can happen from
softirq or hardirq. So the patch is inadequate.

> Sounds the correct fix may be the following one, and the irqsave cost
> should be fine given sbitmap_deferred_clear is only triggered when one
> word is run out of.

Yes, the _bh() variant isn't going to cut it. Can you send this patch
against Linus's master?

-- 
Jens Axboe

