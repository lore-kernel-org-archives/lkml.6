Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F159217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfBRMyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:54:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:36682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728249AbfBRMyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:54:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDAA9ADE1;
        Mon, 18 Feb 2019 12:54:08 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:54:07 +0100
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
Subject: Re: [RFC PATCH v1 05/25] printk-rb: add basic non-blocking reading
 interface
Message-ID: <20190218125407.ljvkuplvaa3zyj6n@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-6-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:43, John Ogness wrote:
> Add reader iterator static declaration/initializer, dynamic
> initializer, and functions to iterate and retrieve ring buffer data.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/printk_ringbuffer.h |  20 ++++
>  lib/printk_ringbuffer.c           | 190 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 210 insertions(+)
> 
> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
> index 1aec9d5666b1..5fdaf632c111 100644
> --- a/include/linux/printk_ringbuffer.h
> +++ b/include/linux/printk_ringbuffer.h
> @@ -43,6 +43,19 @@ static struct prb_cpulock name = {					\
>  	.irqflags = &_##name##_percpu_irqflags,				\
>  }
>  
> +#define PRB_INIT ((unsigned long)-1)
> +
> +#define DECLARE_STATIC_PRINTKRB_ITER(name, rbaddr)			\
> +static struct prb_iterator name = {					\

Please, define the macro without static. The static variable
should get declared as:

static DECLARE_PRINTKRB_ITER();

> +	.rb = rbaddr,							\
> +	.lpos = PRB_INIT,						\
> +}
> +
> +struct prb_iterator {
> +	struct printk_ringbuffer *rb;
> +	unsigned long lpos;
> +};

Please, define the structure before it is used (even in macros).
It is strange to initialize something that is not yet defined.


>  #define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
>  static char _##name##_buffer[1 << (szbits)]				\
>  	__aligned(__alignof__(long));					\
> @@ -62,6 +75,13 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>  		  unsigned int size);
>  void prb_commit(struct prb_handle *h);
>  
> +/* reader interface */
> +void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
> +		   u64 *seq);
> +void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src);
> +int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq);
> +int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq);
> +
>  /* utility functions */
>  void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
>  void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
> index 90c7f9a9f861..1d1e886a0966 100644
> --- a/lib/printk_ringbuffer.c
> +++ b/lib/printk_ringbuffer.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/smp.h>
> +#include <linux/string.h>
> +#include <linux/errno.h>
>  #include <linux/printk_ringbuffer.h>
>  
>  #define PRB_SIZE(rb) (1 << rb->size_bits)
> @@ -8,6 +10,7 @@
>  #define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
>  #define PRB_WRAP_LPOS(rb, lpos, xtra) \
>  	((PRB_WRAPS(rb, lpos) + xtra) << rb->size_bits)
> +#define PRB_DATA_SIZE(e) (e->size - sizeof(struct prb_entry))
>  #define PRB_DATA_ALIGN sizeof(long)
>  
>  static bool __prb_trylock(struct prb_cpulock *cpu_lock,
> @@ -247,3 +250,190 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>  
>  	return &h->entry->data[0];
>  }
> +
> +/*
> + * prb_iter_copy: Copy an iterator.
> + * @dest: The iterator to copy to.
> + * @src: The iterator to copy from.
> + *
> + * Make a deep copy of an iterator. This is particularly useful for making
> + * backup copies of an iterator in case a form of rewinding it needed.
> + *
> + * It is safe to call this function from any context and state. But
> + * note that this function is not atomic. Callers should not make copies
> + * to/from iterators that can be accessed by other tasks/contexts.
> + */
> +void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src)
> +{
> +	memcpy(dest, src, sizeof(*dest));
> +}
> +
> +/*
> + * prb_iter_init: Initialize an iterator for a ring buffer.
> + * @iter: The iterator to initialize.
> + * @rb: A ring buffer to that @iter should iterate.
> + * @seq: The sequence number of the position preceding the first record.
> + *       May be NULL.
> + *
> + * Initialize an iterator to be used with a specified ring buffer. If @seq
> + * is non-NULL, it will be set such that prb_iter_next() will provide a
> + * sequence value of "@seq + 1" if no records were missed.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
> +		   u64 *seq)
> +{
> +	memset(iter, 0, sizeof(*iter));
> +	iter->rb = rb;
> +	iter->lpos = PRB_INIT;
> +
> +	if (!seq)
> +		return;
> +
> +	for (;;) {
> +		struct prb_iterator tmp_iter;
> +		int ret;
> +
> +		prb_iter_copy(&tmp_iter, iter);

It looks strange to copy something that has been hardly initialized.
I hope that we could do this without a copy, see below.

> +
> +		ret = prb_iter_next(&tmp_iter, NULL, 0, seq);

prb_iter_next() and prb_iter_data() are too complex spaghetti
code. They do basically the same but they do not share
any helper function. The error handling is different
which is really confusing. See below.


> +		if (ret < 0)
> +			continue;
> +
> +		if (ret == 0)
> +			*seq = 0;
> +		else
> +			(*seq)--;

The decrement is another suspicious things here.

> +		break;

Finally, I am confused by the semantic of this function.
What is supposed to be the initialized lpos, seq number,
please?

I would expect a function that initializes the iterator
either to the first valid entry (tail-one) or
to the one defined by the given seq number.


Well, I think that we need to start with a more low-level functions.
IMHO. we need something to read one entry a safe way. Then it will
be much easier to live with races in the rest of the code:

/*
 * Return valid entry on the given lpos. Data are read
 * only when the buffer is is not zero.
 */
int prb_get_entry(struct struct printk_ringbuffer *rb,
		    unsigned long lpos,
		    struct prb_entry *entry,
		    unsigned int data_buf_size)
{
	/*
	 * Pointer to the ring buffer. The data might get lost
	 * at any time.
	 */
	struct prb_entry *weak_entry;

	if (!is_valid(lpos))
		return -EINVAL;

	/* Make sure that data are valid for the given valid lpos. */
	smp_rmb();

	weak_entry = to_entry(lpos);
	entry->seq = weak_entry->seq;

	if (data_buf_size) {
		unsigned int size;

		size = min(data_buf_size, weak_entry->size);
		memcpy(entry->data, weak_entry->data, size);
		entry->size = size;
	} else {
		entry->size = weak_data->size;
	}

	/* Make sure that the copy is done before we check validity. */
	smp_mb();

	return is_valid(lpos);
}

Then I would do the support for iterating the following way.
First, I would extend the structure:

struct prb_iterator {
	struct printk_ringbuffer *rb;
	struct prb_entry *entry;
	unsigned int data_buffer_size;
	unsigned long lpos;
};

And do something like:

void prg_iter_init(struct struct printk_ringbuffer *rb,
		       struct prb_entry *entry,
		       unsigned int data_buffer_size,
		       struct prb_iterator *iter)
{
	iter->rb = rb;
	iter->entry = entry;
	iter->data_buffer_size = data_buffer_size;
	lpos = 0UL;
}

Then we could do iterator support the following way:

/* Start iteration with reading the tail entry. */
int prb_iter_tail_entry(struct prb_iterator *iter);
{
	unsigned long tail;
	int ret;

	for (;;) {
		tail = atomic_long_read(&rb->tail);

		/* Ring buffer is empty? */
		if (unlikely(!is_valid(tail)))
			return -EINVAL;

		ret = prb_get_entry(iter->rb, tail,
				    iter->entry, iter->data_buf_size);
		if (!ret) {
			iter->lpos = tail;
			break;
		}
	}

	return 0;
}

unsigned long next_lpos(unsineg long lpos, struct prb_entry *entry)
{
	return lpos + sizeof(struct entry) + entry->size;
}

/* Try to get next entry using a valid iterator */
int prb_iter_next_entry(struct prb_iterator *iter)
{
	iter->lpos = next_lpos(iter->lpos, iter->etnry);

	return prb_get_entry(rb, lpos, entry, data_buf_size;
}

/* Try to get the next entry. Allow to skip lost messages. */
int prb_iter_next_valid_entry(struct prb_iterator *iter)
{
	int ret;

	ret = prb_iter_next_entry(iter);
	if (!ret)
		return 0;

	/* Next entry has been lost. Skip to the current tail. */
	return prb_iter_tail_entry(rb, *lpos, entry, data_buf_size);
}

> +static bool is_valid(struct printk_ringbuffer *rb, unsigned long lpos)
> +{
> +	unsigned long head, tail;
> +
> +	tail = atomic_long_read(&rb->tail);
> +	head = atomic_long_read(&rb->head);
> +	head -= tail;
> +	lpos -= tail;
> +
> +	if (lpos >= head)
> +		return false;
> +	return true;
> +}
> +

IMPORTANT:

Please, do not start rewriting the entire patchset after reading this
mail. I suggest to take a rest from coding. Just read the feadback,
ask if anything is unclear, and let your brain processing it
on background.

The motivation:

1. This is a really complex patchset and it will be a long run. For
   example, I worked on atomic livepatch replace patchset more
   than 1 year. There were 15 iterations, see
   https://lkml.kernel.org/r/20190109123739.21841-1-pmladek@suse.com
   And I was really familiar with this subsystem, was reviewer from
   the beginning.

   Another example is kthread worker API. It took more than
   1 year from RFC until v10 was accepted, see
   1470754545-17632-1-git-send-email-pmladek@suse.com

   In both cases, the final revision looked completely
   different from the initial RFC.

   Printk word is even more complicated. I worked several months
   on race-free NMI buffer (it was my first big kernel project).
   It was put into a garbage dump within 1 day, see
   https://lkml.kernel.org/r/CA+55aFzseOqF-EpKMvwKpfhBJZQSLqKpJ3shzVee9s0+mvyCuA@mail.gmail.com

   The patches offloading printk console to a kthread was
   floating around few years and was never accepted.

   That said, I do not want to discourage you. Your patchset has
   interesting ideas that are worth finishing. I just think
   that it is better to take a rest when you need to wait
   for feedback. It will help you to see it from another
   perspective and start working on v2 with a fresh mind.


2. There are 25 patches already. It might be hard to follow
   the discussion. And it will be even harder if there
   are more variants of the patches discussed in the same
   thread.

   I suggest to just proceed the feedback. Ask if anything
   is unclear. Eventually discuss code alternatives but
   do not send entire patches. Send full v2. Then we could
   start with a clean table again.


3. I have seen only 5 patches out of 25 so far. My feedback
   is based past experience and common sense. I might
   view some things differently once I get to the other
   patches.

   You might feel frustrated when you rework something
   based on my feedback and I later change my mind
   and suggest something different.

   I do not want to make you frustrated. Therefore I feel
   stressed and afraid to send more feedback before I get
   the full picture. But then it might take weeks until
   I send something. Many ideas might be lost in the meantime.
   The result might be hard to understand because I would
   describe some final statements without explaining
   all the reasons.


4. There might be feedback from other people and they
   might have another opinion.


Thanks for working on it.

Best Regards,
Petr
