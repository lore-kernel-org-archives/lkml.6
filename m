Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeBZUe3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:34:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753953AbeBZUe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:34:27 -0500
Date: Mon, 26 Feb 2018 22:34:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
Message-ID: <20180226223252-mutt-send-email-mst@kernel.org>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
 <01aff5eb-a92f-2170-05f7-664220985070@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01aff5eb-a92f-2170-05f7-664220985070@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:15:42AM +0800, Jason Wang wrote:
> 
> 
> On 2018年02月26日 09:17, Michael S. Tsirkin wrote:
> > So pointer rings work fine, but they have a problem: make them too small
> > and not enough entries fit.  Make them too large and you start flushing
> > your cache and running out of memory.
> > 
> > This is a new idea of mine: a ring backed by a linked list. Once you run
> > out of ring entries, instead of a drop you fall back on a list with a
> > common lock.
> > 
> > Should work well for the case where the ring is typically sized
> > correctly, but will help address the fact that some user try to set e.g.
> > tx queue length to 1000000.
> > 
> > In other words, the idea is that if a user sets a really huge TX queue
> > length, we allocate a ptr_ring which is smaller, and use the backup
> > linked list when necessary to provide the requested TX queue length
> > legitimately.
> > 
> > My hope this will move us closer to direction where e.g. fw codel can
> > use ptr rings without locking at all.  The API is still very rough, and
> > I really need to take a hard look at lock nesting.
> > 
> > Compiled only, sending for early feedback/flames.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > changes from v1:
> > - added clarifications by DaveM in the commit log
> > - build fixes
> > 
> >   include/linux/ptr_ring.h | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 61 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index d72b2e7..8aa8882 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -31,11 +31,18 @@
> >   #include <asm/errno.h>
> >   #endif
> > +/* entries must start with the following structure */
> > +struct plist {
> > +	struct plist *next;
> > +	struct plist *last; /* only valid in the 1st entry */
> > +};
> 
> So I wonder whether or not it's better to do this in e.g skb_array
> implementation. Then it can use its own prev/next field.

XDP uses ptr ring directly, doesn't it?

> > +
> >   struct ptr_ring {
> >   	int producer ____cacheline_aligned_in_smp;
> >   	spinlock_t producer_lock;
> >   	int consumer_head ____cacheline_aligned_in_smp; /* next valid entry */
> >   	int consumer_tail; /* next entry to invalidate */
> > +	struct plist *consumer_list;
> >   	spinlock_t consumer_lock;
> >   	/* Shared consumer/producer data */
> >   	/* Read-only by both the producer and the consumer */
> > @@ -120,10 +127,40 @@ static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
> >   }
> >   /*
> > - * Note: resize (below) nests producer lock within consumer lock, so if you
> > - * consume in interrupt or BH context, you must disable interrupts/BH when
> > - * calling this.
> > + * Note: resize API with the _fallback should be used when calling this.
> >    */
> > +static inline int ptr_ring_produce_fallback(struct ptr_ring *r, void *ptr)
> > +{
> > +	int ret;
> > +	unsigned long flags;
> > +	struct plist *p = ptr;
> > +
> > +	p->next = NULL;
> > +	p->last = p;
> > +
> > +	spin_lock_irqsave(&r->producer_lock, flags);
> > +	ret = __ptr_ring_produce(r, ptr);
> > +	if (ret) {
> > +		spin_lock(&r->consumer_lock);
> > +		ret = __ptr_ring_produce(r, ptr);
> > +		if (ret) {
> > +			int producer = r->producer ? r->producer - 1 :
> > +				r->size - 1;
> > +			struct plist *first = r->queue[producer];
> > +
> > +			BUG_ON(!first);
> > +
> > +			first->last->next = p;
> > +			first->last = p;
> 
> I believe we still need a limitation on the total size of the queue.

OK, I'll implement that - it's pretty easy to do.

> Thanks
> 
> > +		}
> > +		spin_unlock(&r->consumer_lock);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&r->producer_lock, flags);
> > +
> > +	return ret;
> > +}
> > +
> >   static inline int ptr_ring_produce(struct ptr_ring *r, void *ptr)
> >   {
> >   	int ret;
> > @@ -135,6 +172,7 @@ static inline int ptr_ring_produce(struct ptr_ring *r, void *ptr)
> >   	return ret;
> >   }
> > +
> >   static inline int ptr_ring_produce_irq(struct ptr_ring *r, void *ptr)
> >   {
> >   	int ret;
> > @@ -359,6 +397,26 @@ static inline void *ptr_ring_consume_bh(struct ptr_ring *r)
> >   	return ptr;
> >   }
> > +static inline void *ptr_ring_consume_fallback(struct ptr_ring *r)
> > +{
> > +	unsigned long flags;
> > +	struct plist *ptr;
> > +
> > +	spin_lock_irqsave(&r->consumer_lock, flags);
> > +	if (r->consumer_list) {
> > +		ptr = r->consumer_list;
> > +		r->consumer_list = ptr->next;
> > +	} else {
> > +		ptr = __ptr_ring_consume(r);
> > +		if (ptr) {
> > +			r->consumer_list = ptr->next;
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&r->consumer_lock, flags);
> > +
> > +	return ptr;
> > +}
> > +
> >   static inline int ptr_ring_consume_batched(struct ptr_ring *r,
> >   					   void **array, int n)
> >   {
