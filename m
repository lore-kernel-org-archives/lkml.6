Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51174C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E7F222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407524AbfBNPQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:16:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407500AbfBNPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46EB7AEDB;
        Thu, 14 Feb 2019 15:16:51 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:16:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 04/25] printk-rb: add writer interface
Message-ID: <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-5-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:42, John Ogness wrote:
> Add the writer functions prb_reserve() and prb_commit(). These make
> use of processor-reentrant spin locks to limit the number of possible
> interruption scenarios for the writers.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/printk_ringbuffer.h |  17 ++++
>  lib/printk_ringbuffer.c           | 172 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 189 insertions(+)
> 
> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
> index 0e6e8dd0d01e..1aec9d5666b1 100644
> --- a/include/linux/printk_ringbuffer.h
> +++ b/include/linux/printk_ringbuffer.h
> @@ -24,6 +24,18 @@ struct printk_ringbuffer {
>  	atomic_t ctx;
>  };
>  
> +struct prb_entry {
> +	unsigned int size;
> +	u64 seq;
> +	char data[0];
> +};
> +
> +struct prb_handle {
> +	struct printk_ringbuffer *rb;
> +	unsigned int cpu;
> +	struct prb_entry *entry;
> +};

Please, add a comment what these structures are for.

>  #define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
>  static DEFINE_PER_CPU(unsigned long, _##name##_percpu_irqflags);	\
>  static struct prb_cpulock name = {					\
> @@ -45,6 +57,11 @@ static struct printk_ringbuffer name = {				\
>  	.ctx = ATOMIC_INIT(0),						\
>  }
>  
> +/* writer interface */
> +char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
> +		  unsigned int size);
> +void prb_commit(struct prb_handle *h);
> +
>  /* utility functions */
>  void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
>  void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
> index 28958b0cf774..90c7f9a9f861 100644
> --- a/lib/printk_ringbuffer.c
> +++ b/lib/printk_ringbuffer.c
> @@ -2,6 +2,14 @@
>  #include <linux/smp.h>
>  #include <linux/printk_ringbuffer.h>
>  
> +#define PRB_SIZE(rb) (1 << rb->size_bits)

1 -> 1L

> +#define PRB_SIZE_BITMASK(rb) (PRB_SIZE(rb) - 1)
> +#define PRB_INDEX(rb, lpos) (lpos & PRB_SIZE_BITMASK(rb))
> +#define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
> +#define PRB_WRAP_LPOS(rb, lpos, xtra) \
> +	((PRB_WRAPS(rb, lpos) + xtra) << rb->size_bits)

It took me quite some time to understand the WRAP macros.
The extra parameter makes it even worse.

I suggest to distinguish the two situation by the macro names.
For example:

    PRB_THIS_WRAP_START_LPOS(rb, lpos)
    PRB_NEXT_WRAP_START_LPOS(rb, lpos)

Also they might deserve a comment.


> +#define PRB_DATA_ALIGN sizeof(long)
> +
>  static bool __prb_trylock(struct prb_cpulock *cpu_lock,
>  			  unsigned int *cpu_store)
>  {
> @@ -75,3 +83,167 @@ void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
>  
>  	put_cpu();
>  }
> +
> +static struct prb_entry *to_entry(struct printk_ringbuffer *rb,
> +				  unsigned long lpos)
> +{
> +	char *buffer = rb->buffer;
> +	buffer += PRB_INDEX(rb, lpos);
> +	return (struct prb_entry *)buffer;
> +}
> +
> +static int calc_next(struct printk_ringbuffer *rb, unsigned long tail,
> +		     unsigned long lpos, int size, unsigned long *calced_next)
> +{

The function is so tricky that it deserves a comment.

Well, I am getting really lost because of the generic name
and all the parameters. For example, I wonder what "calced" stands
for.

I think that it will be much easiser to follow the logic if the entire
for-cycle around calc_next() is implemented in a single function.
The function push_tail() should get called from inside this function.

> +	unsigned long next_lpos;
> +	int ret = 0;
> +again:
> +	next_lpos = lpos + size;
> +	if (next_lpos - tail > PRB_SIZE(rb))
> +		return -1;

push_tail() should get called here. prb_reserve() should bail
out when the tail could not get pushed.

> +
> +	if (PRB_WRAPS(rb, lpos) != PRB_WRAPS(rb, next_lpos)) {
> +		lpos = PRB_WRAP_LPOS(rb, next_lpos, 0);
> +		ret |= 1;

This is a strange trick. The function should either return a valid
lpos that might get reserved or an error. The error means that
prb_reserve() must fail.

> +		goto again;
> +	}
> +
> +	*calced_next = next_lpos;
> +	return ret;
> +}
> +

/* Try to remove the oldest message */
> +static bool push_tail(struct printk_ringbuffer *rb, unsigned long tail)
> +{
> +	unsigned long new_tail;
> +	struct prb_entry *e;
> +	unsigned long head;
> +
> +	if (tail != atomic_long_read(&rb->tail))
> +		return true;
> +
> +	e = to_entry(rb, tail);
> +	if (e->size != -1)
> +		new_tail = tail + e->size;
> +	else
> +		new_tail = PRB_WRAP_LPOS(rb, tail, 1);
> +
> +	/* make sure the new tail does not overtake the head */
> +	head = atomic_long_read(&rb->head);
> +	if (head - new_tail > PRB_SIZE(rb))
> +		return false;
> +
> +	atomic_long_cmpxchg(&rb->tail, tail, new_tail);
> +	return true;
> +}
> +
> +/*
> + * prb_commit: Commit a reserved entry to the ring buffer.
> + * @h: An entry handle referencing the data entry to commit.
> + *
> + * Commit data that has been reserved using prb_reserve(). Once the data
> + * block has been committed, it can be invalidated at any time. If a writer
> + * is interested in using the data after committing, the writer should make
> + * its own copy first or use the prb_iter_ reader functions to access the
> + * data in the ring buffer.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_commit(struct prb_handle *h)
> +{
> +	struct printk_ringbuffer *rb = h->rb;
> +	struct prb_entry *e;
> +	unsigned long head;
> +	unsigned long res;
> +
> +	for (;;) {
> +		if (atomic_read(&rb->ctx) != 1) {
> +			/* the interrupted context will fixup head */
> +			atomic_dec(&rb->ctx);
> +			break;
> +		}
> +		/* assign sequence numbers before moving head */
> +		head = atomic_long_read(&rb->head);
> +		res = atomic_long_read(&rb->reserve);
> +		while (head != res) {
> +			e = to_entry(rb, head);
> +			if (e->size == -1) {
> +				head = PRB_WRAP_LPOS(rb, head, 1);
> +				continue;
> +			}
> +			e->seq = ++rb->seq;
> +			head += e->size;
> +		}
> +		atomic_long_set_release(&rb->head, res);

This looks realy weird. It looks like you are commiting all
reserved entries between current head and this entry.

I would expect that every prb_entry has its own flag whether
it was commited or not. This function should set this flag
for its own entry. Then it should move the head to the
first uncommited entry.

It will be racy because because more CPUs might commit their
own entries in parallel and they might miss each other
commit flags.

A solution might be to implement prb_push_head() that will
do the safe thing. Then we could call it here, from klp_push_tail()
and also from readers. I am still not sure if it will be
race-free but it looks promissing.

> +		atomic_dec(&rb->ctx);

With the above approach you will not need rb->ctx. It is
racy anyway, see below.

> +
> +		if (atomic_long_read(&rb->reserve) == res)
> +			break;
> +		atomic_inc(&rb->ctx);
> +	}
> +
> +	prb_unlock(rb->cpulock, h->cpu);
> +}
> +
> +/*
> + * prb_reserve: Reserve an entry within a ring buffer.
> + * @h: An entry handle to be setup and reference an entry.
> + * @rb: A ring buffer to reserve data within.
> + * @size: The number of bytes to reserve.
> + *
> + * Reserve an entry of at least @size bytes to be used by the caller. If
> + * successful, the data region of the entry belongs to the caller and cannot
> + * be invalidated by any other task/context. For this reason, the caller
> + * should call prb_commit() as quickly as possible in order to avoid preventing
> + * other tasks/contexts from reserving data in the case that the ring buffer
> + * has wrapped.
> + *
> + * It is safe to call this function from any context and state.
> + *
> + * Returns a pointer to the reserved entry (and @h is setup to reference that
> + * entry) or NULL if it was not possible to reserve data.
> + */
> +char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
> +		  unsigned int size)
> +{
> +	unsigned long tail, res1, res2;

Please, better distinguish res1 and res2, e.g. old_res, new_res.

> +	int ret;
> +
> +	if (size == 0)
> +		return NULL;
> +	size += sizeof(struct prb_entry);
> +	size += PRB_DATA_ALIGN - 1;
> +	size &= ~(PRB_DATA_ALIGN - 1);

The above two lines should get hidden into PRB_ALLIGN_SIZE() or so.

> +	if (size >= PRB_SIZE(rb))
> +		return NULL;
> +
> +	h->rb = rb;
> +	prb_lock(rb->cpulock, &h->cpu);
> +
> +	atomic_inc(&rb->ctx);

This looks racy. NMI could come between prb_lock() and this atomic_inc().


> +	do {
> +		for (;;) {
> +			tail = atomic_long_read(&rb->tail);
> +			res1 = atomic_long_read(&rb->reserve);
> +			ret = calc_next(rb, tail, res1, size, &res2);
> +			if (ret >= 0)
> +				break;
> +			if (!push_tail(rb, tail)) {
> +				prb_commit(h);

I am a bit confused. Is it commiting a handle that haven't
been reserved yet? Why, please?

> +				return NULL;
> +			}
> +		}

Please, try to refactor the above as commented in calc_next().

> +	} while (!atomic_long_try_cmpxchg_acquire(&rb->reserve, &res1, res2));
> +
> +	h->entry = to_entry(rb, res1);
> +
> +	if (ret) {
> +		/* handle wrap */

		/* Write wrapping entry that is part of our reservation. */

> +		h->entry->size = -1;
> +		h->entry = to_entry(rb, PRB_WRAP_LPOS(rb, res2, 0));
> +	}
> +
> +	h->entry->size = size;
> +
> +	return &h->entry->data[0];
> +}

Best Regards,
Petr
