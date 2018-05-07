Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeEGNrd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:47:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeEGNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:47:32 -0400
Date: Mon, 7 May 2018 06:47:31 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() +
 spin_lock
Message-ID: <20180507134731.GA28974@bombadil.infradead.org>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
 <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
 <20180505035154.GB20495@bombadil.infradead.org>
 <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
 <20180505155202.GA29992@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505155202.GA29992@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 08:52:02AM -0700, Matthew Wilcox wrote:
> init and destroy seem to map to sbitmap_queue_init_node and
> sbitmap_queue_free.  percpu_ida_free maps to sbitmap_queue_clear.

Hmm.

void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
                         unsigned int cpu)
{
        sbitmap_clear_bit_unlock(&sbq->sb, nr);
        sbq_wake_up(sbq);
        if (likely(!sbq->round_robin && nr < sbq->sb.depth))
                *per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
}
EXPORT_SYMBOL_GPL(sbitmap_queue_clear);

If we free a tag on a CPU other than the one it's allocated on, that seems
like it's going to guarantee a cacheline pingpong.  Is the alloc_hint
really that valuable?  I'd be tempted to maintain the alloc_hint (if it's
at all valuable) as being just a hint for which word to look at first,
and only update it on allocation, rather than updating it on free.
Then we can drop the 'cpu' argument to sbitmap_queue_clear(), which
would help this conversion because the percpu_ida users don't know what
CPU their tag was allocated on.
