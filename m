Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEEPwG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:52:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:52:05 -0400
Date: Sat, 5 May 2018 08:52:02 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() +
 spin_lock
Message-ID: <20180505155202.GA29992@bombadil.infradead.org>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
 <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
 <20180505035154.GB20495@bombadil.infradead.org>
 <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 08:10:20AM -0600, Jens Axboe wrote:
> On 5/4/18 9:51 PM, Matthew Wilcox wrote:
> > On Fri, May 04, 2018 at 04:22:16PM -0700, Andrew Morton wrote:
> >> I'm feeling a bit hostile toward lib/percpu_ida.c in general ;) It has
> >> very few users and seems rather complicated (what's with that
> >> schedule() in percpu_ida_alloc?).  I'm suspecting and hoping that if
> >> someone can figure out what the requirements were, this could all be
> >> zapped and reimplemented using something else which we already have.
> > 
> > Note that I have no code in percpu_ida ... it's quite different from
> > the regular IDA.  But I have noticed the stunning similarity between the
> > percpu_ida and the code in lib/sbitmap.c.  I have no idea which one is
> > better, but they're essentially doing the same thing.
> 
> Not sure where you see that "stunning similarity"? The sbitmap code is
> basically the blk-mq tagging sparse bitmaps, abstracted into a generally
> usable form. The percpu_ida design works fine for lower utilization, but
> it fell apart for the tagging use case where we can easily run at full
> utilization. percpu_ida has percpu caches, sbitmap gets away with just
> percpu hints. These caches are why it doesn't work well for > 50%
> utilization. sbitmap also supports shallow operations, and online
> resizing. Outside of the sharing the same basic functionality of "give
> me some free ID", I really don't see a lot of similarities. In terms of
> functionality, yes, I don't think it would be hard to get rid of
> percpu_ida and just replace it with sbitmap. Probably a worthwhile
> pursuit.

Yes, I meant stunning similarity in terms of functionality, rather than
implementation.  I didn't intend to imply that you'd filed off the serial
numbers, given it a fresh coat of paint and called it yours ;-)

I've been looking into what it'll take to replace percpu_ida with sbitmap.
The good news is that there's large chunks of the percpu_ida API that
aren't being used, and the better news is that there's actually only
one percpu_ida, although it gets used by a lot of target drivers.

Looking at the functions in the header file ...

percpu_ida_alloc - seven drivers, all sess_tag_pool
percpu_ida_free - seven drivers, all sess_tag_pool
percpu_ida_destroy - target_core_transport.c (sess_tag_pool)
percpu_ida_init - target_core_transport.c (sess_tag_pool)
percpu_ida_for_each_free - unused
percpu_ida_free_tags - unused

percpu_ida_alloc uses 'state' in a little bit of an unusual way.  It seems
to me that TASK_RUNNING means "Do not sleep", and any other value means
"sleep in this TASK_ state".  As I understand the sbitmap code, that
means we want an sbitmap_queue.

init and destroy seem to map to sbitmap_queue_init_node and
sbitmap_queue_free.  percpu_ida_free maps to sbitmap_queue_clear.
percpu_ida_alloc(x, TASK_RUNNING) maps to sbitmap_queue_get, and any
other state is going to involve the kind of code we see in blk_mq_get_tag.

Does all of that make sense, or have I missed something?

And, Kent, do you see any reason to keep percpu_ida around?  Is there
an important way in which it's superior to sbitmap?
