Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A131C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B458E21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfBNXhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:37:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfBNXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:37:06 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1guQYl-0004L2-I4; Fri, 15 Feb 2019 00:36:51 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
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
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-5-john.ogness@linutronix.de>
        <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
Date:   Fri, 15 Feb 2019 00:36:49 +0100
In-Reply-To: <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz> (Petr Mladek's
        message of "Thu, 14 Feb 2019 16:16:50 +0100")
Message-ID: <87ef8aosby.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-14, Petr Mladek <pmladek@suse.com> wrote:
>> Add the writer functions prb_reserve() and prb_commit(). These make
>> use of processor-reentrant spin locks to limit the number of possible
>> interruption scenarios for the writers.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  include/linux/printk_ringbuffer.h |  17 ++++
>>  lib/printk_ringbuffer.c           | 172 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 189 insertions(+)
>> 
>> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
>> index 0e6e8dd0d01e..1aec9d5666b1 100644
>> --- a/include/linux/printk_ringbuffer.h
>> +++ b/include/linux/printk_ringbuffer.h
>> @@ -24,6 +24,18 @@ struct printk_ringbuffer {
>>  	atomic_t ctx;
>>  };
>>  
>> +struct prb_entry {
>> +	unsigned int size;
>> +	u64 seq;
>> +	char data[0];
>> +};
>> +
>> +struct prb_handle {
>> +	struct printk_ringbuffer *rb;
>> +	unsigned int cpu;
>> +	struct prb_entry *entry;
>> +};
>
> Please, add a comment what these structures are for.

OK.

>>  #define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
>>  static DEFINE_PER_CPU(unsigned long, _##name##_percpu_irqflags);	\
>>  static struct prb_cpulock name = {					\
>> @@ -45,6 +57,11 @@ static struct printk_ringbuffer name = {				\
>>  	.ctx = ATOMIC_INIT(0),						\
>>  }
>>  
>> +/* writer interface */
>> +char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>> +		  unsigned int size);
>> +void prb_commit(struct prb_handle *h);
>> +
>>  /* utility functions */
>>  void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
>>  void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
>> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
>> index 28958b0cf774..90c7f9a9f861 100644
>> --- a/lib/printk_ringbuffer.c
>> +++ b/lib/printk_ringbuffer.c
>> @@ -2,6 +2,14 @@
>>  #include <linux/smp.h>
>>  #include <linux/printk_ringbuffer.h>
>>  
>> +#define PRB_SIZE(rb) (1 << rb->size_bits)
>
> 1 -> 1L

OK.

>> +#define PRB_SIZE_BITMASK(rb) (PRB_SIZE(rb) - 1)
>> +#define PRB_INDEX(rb, lpos) (lpos & PRB_SIZE_BITMASK(rb))
>> +#define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
>> +#define PRB_WRAP_LPOS(rb, lpos, xtra) \
>> +	((PRB_WRAPS(rb, lpos) + xtra) << rb->size_bits)
>
> It took me quite some time to understand the WRAP macros.
> The extra parameter makes it even worse.
>
> I suggest to distinguish the two situation by the macro names.
> For example:
>
>     PRB_THIS_WRAP_START_LPOS(rb, lpos)
>     PRB_NEXT_WRAP_START_LPOS(rb, lpos)

OK.

> Also they might deserve a comment.

Agreed.

>> +#define PRB_DATA_ALIGN sizeof(long)
>> +
>>  static bool __prb_trylock(struct prb_cpulock *cpu_lock,
>>  			  unsigned int *cpu_store)
>>  {
>> @@ -75,3 +83,167 @@ void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
>>  
>>  	put_cpu();
>>  }
>> +
>> +static struct prb_entry *to_entry(struct printk_ringbuffer *rb,
>> +				  unsigned long lpos)
>> +{
>> +	char *buffer = rb->buffer;
>> +	buffer += PRB_INDEX(rb, lpos);
>> +	return (struct prb_entry *)buffer;
>> +}
>> +
>> +static int calc_next(struct printk_ringbuffer *rb, unsigned long tail,
>> +		     unsigned long lpos, int size, unsigned long *calced_next)
>> +{
>
> The function is so tricky that it deserves a comment.
>
> Well, I am getting really lost because of the generic name
> and all the parameters. For example, I wonder what "calced" stands
> for.

"calced" is short for "calculated". Maybe "lpos_next" would be a good
name?

The function is only doing this: Given a reserve position and size to
reserve, calculate what the next reserve position would be.

It might seem complicated because it also detects/reports the special
cases that the tail would be overwritten (returns -1) or if the
ringbuffer wraps when performing the reserve (returns 1).

> I think that it will be much easiser to follow the logic if the entire
> for-cycle around calc_next() is implemented in a single function.

calc_next() is already sitting in 2 nested loops. And calc_next()
performs manual tail-recursion using a goto. I doubt it becomes easier
to follow when calc_next is inlined in prb_reserve().

> The function push_tail() should get called from inside this function.

I disagree. calc_next's job isn't to make any changes. It only
calculates what should be done. Outer cmpxchg loops take on the
responsibility for making the change. push_tail() is not trivial because
of dealing with the situation when it fails. Below you specifically ask
about this, so I'll go deeper into push_tail() there.

>> +	unsigned long next_lpos;
>> +	int ret = 0;
>> +again:
>> +	next_lpos = lpos + size;
>> +	if (next_lpos - tail > PRB_SIZE(rb))
>> +		return -1;
>
> push_tail() should get called here. prb_reserve() should bail
> out when the tail could not get pushed.

prb_reserve() does bail out if push_tail() fails. But I think it makes
more sense that it is clearly visible from prb_reserve() and not hidden
as a side-effect of calc_next(). And as I mentioned, I think things
become much more difficult to follow if calc_next is inlined in
prb_reserve().

>> +
>> +	if (PRB_WRAPS(rb, lpos) != PRB_WRAPS(rb, next_lpos)) {
>> +		lpos = PRB_WRAP_LPOS(rb, next_lpos, 0);
>> +		ret |= 1;
>
> This is a strange trick. The function should either return a valid
> lpos that might get reserved or an error. The error means that
> prb_reserve() must fail.

Again, calc_next() does not _do_ anything. It only calculates what needs
to be done. By returning 1, it is saying, "here is the next lpos value
and by the way, it is wrapped around". The caller could see this for
itself by comparing the PRB_WRAPS of lpos and lpos_next, but since
calc_next() already had this information I figured I might as well save
some CPU cycles and inform the caller.

The calc_next() caller is the one that will need to _do_ something about
this. In the case of a wrap, the caller will need to create the
terminating entry and provide the writer with the buffer at the
beginning of the data array.

>> +		goto again;
>> +	}
>> +
>> +	*calced_next = next_lpos;
>> +	return ret;
>> +}
>> +
>
> /* Try to remove the oldest message */

That is the kind of comment that I usually get in trouble for (saying
the obvious). But I have no problems adding it.

>> +static bool push_tail(struct printk_ringbuffer *rb, unsigned long tail)
>> +{
>> +	unsigned long new_tail;
>> +	struct prb_entry *e;
>> +	unsigned long head;
>> +
>> +	if (tail != atomic_long_read(&rb->tail))
>> +		return true;
>> +
>> +	e = to_entry(rb, tail);
>> +	if (e->size != -1)
>> +		new_tail = tail + e->size;
>> +	else
>> +		new_tail = PRB_WRAP_LPOS(rb, tail, 1);
>> +
>> +	/* make sure the new tail does not overtake the head */
>> +	head = atomic_long_read(&rb->head);
>> +	if (head - new_tail > PRB_SIZE(rb))
>> +		return false;
>> +
>> +	atomic_long_cmpxchg(&rb->tail, tail, new_tail);
>> +	return true;
>> +}
>> +
>> +/*
>> + * prb_commit: Commit a reserved entry to the ring buffer.
>> + * @h: An entry handle referencing the data entry to commit.
>> + *
>> + * Commit data that has been reserved using prb_reserve(). Once the data
>> + * block has been committed, it can be invalidated at any time. If a writer
>> + * is interested in using the data after committing, the writer should make
>> + * its own copy first or use the prb_iter_ reader functions to access the
>> + * data in the ring buffer.
>> + *
>> + * It is safe to call this function from any context and state.
>> + */
>> +void prb_commit(struct prb_handle *h)
>> +{
>> +	struct printk_ringbuffer *rb = h->rb;
>> +	struct prb_entry *e;
>> +	unsigned long head;
>> +	unsigned long res;
>> +
>> +	for (;;) {
>> +		if (atomic_read(&rb->ctx) != 1) {
>> +			/* the interrupted context will fixup head */
>> +			atomic_dec(&rb->ctx);
>> +			break;
>> +		}
>> +		/* assign sequence numbers before moving head */
>> +		head = atomic_long_read(&rb->head);
>> +		res = atomic_long_read(&rb->reserve);
>> +		while (head != res) {
>> +			e = to_entry(rb, head);
>> +			if (e->size == -1) {
>> +				head = PRB_WRAP_LPOS(rb, head, 1);
>> +				continue;
>> +			}
>> +			e->seq = ++rb->seq;
>> +			head += e->size;
>> +		}
>> +		atomic_long_set_release(&rb->head, res);
>
> This looks realy weird. It looks like you are commiting all
> reserved entries between current head and this entry.

I am.

> I would expect that every prb_entry has its own flag whether
> it was commited or not. This function should set this flag
> for its own entry. Then it should move the head to the
> first uncommited entry.

How could there be a reserved but uncommitted entry before this one? Or
after this one? The reserve/commit window is under the prb_cpulock. No
other CPU can be involved. If an NMI occurred anywhere here and it did a
reserve, it already did the matching commit.

> It will be racy because because more CPUs might commit their
> own entries in parallel and they might miss each other
> commit flags.

No other CPUs here.

> A solution might be to implement prb_push_head() that will
> do the safe thing. Then we could call it here, from klp_push_tail()
> and also from readers. I am still not sure if it will be
> race-free but it looks promissing.

Yes, this all can be implemented lockless, but it is considerably more
complex. Let's not think about that unless we decide we need it.

>> +		atomic_dec(&rb->ctx);
>
> With the above approach you will not need rb->ctx. It is
> racy anyway, see below.

See my comments below.

>> +
>> +		if (atomic_long_read(&rb->reserve) == res)
>> +			break;
>> +		atomic_inc(&rb->ctx);
>> +	}
>> +
>> +	prb_unlock(rb->cpulock, h->cpu);
>> +}
>> +
>> +/*
>> + * prb_reserve: Reserve an entry within a ring buffer.
>> + * @h: An entry handle to be setup and reference an entry.
>> + * @rb: A ring buffer to reserve data within.
>> + * @size: The number of bytes to reserve.
>> + *
>> + * Reserve an entry of at least @size bytes to be used by the caller. If
>> + * successful, the data region of the entry belongs to the caller and cannot
>> + * be invalidated by any other task/context. For this reason, the caller
>> + * should call prb_commit() as quickly as possible in order to avoid preventing
>> + * other tasks/contexts from reserving data in the case that the ring buffer
>> + * has wrapped.
>> + *
>> + * It is safe to call this function from any context and state.
>> + *
>> + * Returns a pointer to the reserved entry (and @h is setup to reference that
>> + * entry) or NULL if it was not possible to reserve data.
>> + */
>> +char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>> +		  unsigned int size)
>> +{
>> +	unsigned long tail, res1, res2;
>
> Please, better distinguish res1 and res2, e.g. old_res, new_res.

OK.

>> +	int ret;
>> +
>> +	if (size == 0)
>> +		return NULL;
>> +	size += sizeof(struct prb_entry);
>> +	size += PRB_DATA_ALIGN - 1;
>> +	size &= ~(PRB_DATA_ALIGN - 1);
>
> The above two lines should get hidden into PRB_ALLIGN_SIZE() or so.

OK.

>> +	if (size >= PRB_SIZE(rb))
>> +		return NULL;
>> +
>> +	h->rb = rb;
>> +	prb_lock(rb->cpulock, &h->cpu);
>> +
>> +	atomic_inc(&rb->ctx);
>
> This looks racy. NMI could come between prb_lock() and this
> atomic_inc().

It wouldn't matter. I haven't done anything before the inc so NMIs can
come in and do as much reserve/committing as they want.

>> +	do {
>> +		for (;;) {
>> +			tail = atomic_long_read(&rb->tail);
>> +			res1 = atomic_long_read(&rb->reserve);
>> +			ret = calc_next(rb, tail, res1, size, &res2);
>> +			if (ret >= 0)
>> +				break;
>> +			if (!push_tail(rb, tail)) {
>> +				prb_commit(h);
>
> I am a bit confused. Is it commiting a handle that haven't
> been reserved yet? Why, please?

If ctx is 1 we have the special responsibility of moving the head past
all the entries that interrupting NMIs have reserve/committed. (See the
check for "ctx != 1" in prb_commit().) The NMIs are already gone so we
are the only one that can do this.

Here we are in prb_reserve() and have already incremented ctx. We might
be the "ctx == 1" task and NMIs may have reserve/committed entries after
we incremented ctx, which means that they did not push the head. If we
now bail out because we couldn't push the tail, we still are obligated
to push the head if we are "ctx == 1".

prb_commit() does not actually care what is in the handle. It is going
to commit everything up to the reserve. The fact that I pass it a handle
is because that is what the function expects. I suppose I could create a
_prb_commit() that takes only a ringbuffer argument and prb_commit()
simply calls _prb_commit(h->rb). Then the bailout would be:

				_prb_commit(rb);

Or maybe it should have a more descriptive name:

				_prb_commit_all_reserved(rb);

>> +				return NULL;
>> +			}
>> +		}
>
> Please, try to refactor the above as commented in calc_next().

I'll play with it and see how it looks.

>> +	} while (!atomic_long_try_cmpxchg_acquire(&rb->reserve, &res1, res2));
>> +
>> +	h->entry = to_entry(rb, res1);
>> +
>> +	if (ret) {
>> +		/* handle wrap */
>
> 		/* Write wrapping entry that is part of our reservation. */

OK.

>> +		h->entry->size = -1;
>> +		h->entry = to_entry(rb, PRB_WRAP_LPOS(rb, res2, 0));
>> +	}
>> +
>> +	h->entry->size = size;
>> +
>> +	return &h->entry->data[0];
>> +}

Thank you for your comments.

John Ogness
