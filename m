Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeEGVen (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:34:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35313 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeEGVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:34:41 -0400
X-Google-Smtp-Source: AB8JxZrgPZnxr4Gnb+nI0ukCwTmbXupSmFT/2eSmKE7F1qAPgNEyGdKDVWTgu3g4uCHT4+W2UnDGMw==
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() +
 spin_lock
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
 <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
 <20180505035154.GB20495@bombadil.infradead.org>
 <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
 <20180505155202.GA29992@bombadil.infradead.org>
 <20180507134731.GA28974@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c5151b40-9f2a-fa64-2652-01b109e85954@kernel.dk>
Date: Mon, 7 May 2018 15:34:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180507134731.GA28974@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/18 7:47 AM, Matthew Wilcox wrote:
> On Sat, May 05, 2018 at 08:52:02AM -0700, Matthew Wilcox wrote:
>> init and destroy seem to map to sbitmap_queue_init_node and
>> sbitmap_queue_free.  percpu_ida_free maps to sbitmap_queue_clear.
> 
> Hmm.
> 
> void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>                          unsigned int cpu)
> {
>         sbitmap_clear_bit_unlock(&sbq->sb, nr);
>         sbq_wake_up(sbq);
>         if (likely(!sbq->round_robin && nr < sbq->sb.depth))
>                 *per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
> }
> EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
> 
> If we free a tag on a CPU other than the one it's allocated on, that seems
> like it's going to guarantee a cacheline pingpong.  Is the alloc_hint
> really that valuable?  I'd be tempted to maintain the alloc_hint (if it's
> at all valuable) as being just a hint for which word to look at first,
> and only update it on allocation, rather than updating it on free.

The point is to update it on free, so we know where to start the search.
Ideally it'd still be free. Keep in mind that some of this was driven
by blk-mq developments, on how to retain fast allocations without
adding per-cpu caches (which we can't afford, see previous rant on
tag space utilization). On blk-mq, the free is generally on the CPU
you allocated, or close to in terms of caching. Even for shared tag
cases, I haven't seen any bad behavior from bouncing. Doesn't mean
that we could not, but I'd be wary of changing any of it without
substantial performance testing.

> Then we can drop the 'cpu' argument to sbitmap_queue_clear(), which
> would help this conversion because the percpu_ida users don't know what
> CPU their tag was allocated on.

What you want is something around the sbitmap_queue_{get,clear} that
wraps the alloc hint and wait queue mechanism, so the caller doesn't
have to deal with it. We don't have that, since the blk-mq mechanism
works out better just implementing it. We have things like queue
runs that are don't for the failure case.

-- 
Jens Axboe
