Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02900C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DB6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfBSVoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:44:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:44:25 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gwDBR-0000rp-LK; Tue, 19 Feb 2019 22:44:09 +0100
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
Subject: Re: [RFC PATCH v1 05/25] printk-rb: add basic non-blocking reading interface
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-6-john.ogness@linutronix.de>
        <20190218125407.ljvkuplvaa3zyj6n@pathway.suse.cz>
Date:   Tue, 19 Feb 2019 22:44:07 +0100
In-Reply-To: <20190218125407.ljvkuplvaa3zyj6n@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 18 Feb 2019 13:54:07 +0100")
Message-ID: <87o977v4go.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Below I make several comments, responding to your questions. But I like
the new API I believe you are trying to propose. So really only my final
comments are of particular importance. There I show you what I think
reader code would look like using your proposed API.

On 2019-02-18, Petr Mladek <pmladek@suse.com> wrote:
>> Add reader iterator static declaration/initializer, dynamic
>> initializer, and functions to iterate and retrieve ring buffer data.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  include/linux/printk_ringbuffer.h |  20 ++++
>>  lib/printk_ringbuffer.c           | 190 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 210 insertions(+)
>> 
>> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
>> index 1aec9d5666b1..5fdaf632c111 100644
>> --- a/include/linux/printk_ringbuffer.h
>> +++ b/include/linux/printk_ringbuffer.h
>> @@ -43,6 +43,19 @@ static struct prb_cpulock name = {					\
>>  	.irqflags = &_##name##_percpu_irqflags,				\
>>  }
>>  
>> +#define PRB_INIT ((unsigned long)-1)
>> +
>> +#define DECLARE_STATIC_PRINTKRB_ITER(name, rbaddr)			\
>> +static struct prb_iterator name = {					\
>
> Please, define the macro without static. The static variable
> should get declared as:
>
> static DECLARE_PRINTKRB_ITER();

OK.

>> +	.rb = rbaddr,							\
>> +	.lpos = PRB_INIT,						\
>> +}
>> +
>> +struct prb_iterator {
>> +	struct printk_ringbuffer *rb;
>> +	unsigned long lpos;
>> +};
>
> Please, define the structure before it is used (even in macros).
> It is strange to initialize something that is not yet defined.

Agreed.

>>  #define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
>>  static char _##name##_buffer[1 << (szbits)]				\
>>  	__aligned(__alignof__(long));					\
>> @@ -62,6 +75,13 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>>  		  unsigned int size);
>>  void prb_commit(struct prb_handle *h);
>>  
>> +/* reader interface */
>> +void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
>> +		   u64 *seq);
>> +void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src);
>> +int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq);
>> +int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq);
>> +
>>  /* utility functions */
>>  void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
>>  void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
>> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
>> index 90c7f9a9f861..1d1e886a0966 100644
>> --- a/lib/printk_ringbuffer.c
>> +++ b/lib/printk_ringbuffer.c
>> @@ -1,5 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/smp.h>
>> +#include <linux/string.h>
>> +#include <linux/errno.h>
>>  #include <linux/printk_ringbuffer.h>
>>  
>>  #define PRB_SIZE(rb) (1 << rb->size_bits)
>> @@ -8,6 +10,7 @@
>>  #define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
>>  #define PRB_WRAP_LPOS(rb, lpos, xtra) \
>>  	((PRB_WRAPS(rb, lpos) + xtra) << rb->size_bits)
>> +#define PRB_DATA_SIZE(e) (e->size - sizeof(struct prb_entry))
>>  #define PRB_DATA_ALIGN sizeof(long)
>>  
>>  static bool __prb_trylock(struct prb_cpulock *cpu_lock,
>> @@ -247,3 +250,190 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
>>  
>>  	return &h->entry->data[0];
>>  }
>> +
>> +/*
>> + * prb_iter_copy: Copy an iterator.
>> + * @dest: The iterator to copy to.
>> + * @src: The iterator to copy from.
>> + *
>> + * Make a deep copy of an iterator. This is particularly useful for making
>> + * backup copies of an iterator in case a form of rewinding it needed.
>> + *
>> + * It is safe to call this function from any context and state. But
>> + * note that this function is not atomic. Callers should not make copies
>> + * to/from iterators that can be accessed by other tasks/contexts.
>> + */
>> +void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src)
>> +{
>> +	memcpy(dest, src, sizeof(*dest));
>> +}
>> +
>> +/*
>> + * prb_iter_init: Initialize an iterator for a ring buffer.
>> + * @iter: The iterator to initialize.
>> + * @rb: A ring buffer to that @iter should iterate.
>> + * @seq: The sequence number of the position preceding the first record.
>> + *       May be NULL.
>> + *
>> + * Initialize an iterator to be used with a specified ring buffer. If @seq
>> + * is non-NULL, it will be set such that prb_iter_next() will provide a
>> + * sequence value of "@seq + 1" if no records were missed.
>> + *
>> + * It is safe to call this function from any context and state.
>> + */
>> +void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
>> +		   u64 *seq)
>> +{
>> +	memset(iter, 0, sizeof(*iter));
>> +	iter->rb = rb;
>> +	iter->lpos = PRB_INIT;
>> +
>> +	if (!seq)
>> +		return;
>> +
>> +	for (;;) {
>> +		struct prb_iterator tmp_iter;
>> +		int ret;
>> +
>> +		prb_iter_copy(&tmp_iter, iter);
>
> It looks strange to copy something that has been hardly initialized.
> I hope that we could do this without a copy, see below.
>
>> +
>> +		ret = prb_iter_next(&tmp_iter, NULL, 0, seq);
>
> prb_iter_next() and prb_iter_data() are too complex spaghetti
> code. They do basically the same but they do not share
> any helper function. The error handling is different
> which is really confusing. See below.

I don't follow why you think they do basically the same
thing. prb_iter_next() moves forward to the next entry, then calls
prb_iter_data() to retrieve the data. prb_iter_data() _is_ the helper
function.

(I do not intend to defend the ringbuffer API. I am only addressing your
comment that they do the same thing. I mentioned in the cover letter
that the API is not pretty. I am thankful on tips to improve it.)

>> +		if (ret < 0)
>> +			continue;
>> +
>> +		if (ret == 0)
>> +			*seq = 0;
>> +		else
>> +			(*seq)--;
>
> The decrement is another suspicious things here.

"seq" represents the last entry that we have seen. If we initialize the
iterator and then call prb_iter_next(), it is expected that we will see
the first unseen entry. The caller expects prb_iter_next() to yield a
seq that is 1 more than what prb_iter_init() set.

The purpose of the interface working this way is to have loops where we
do not need to call prb_iter_data() for the first entry and
prb_iter_next() for all other elements. The call order would be:

prb_iter_init();
while (prb_iter_next()) {
}

If prb_iter_init() can return a seq value, then the logic to check if
any entries were missed will verify that seq has incremented by exactly
1 for each prb_iter_next() call.


>> +		break;
>
> Finally, I am confused by the semantic of this function.
> What is supposed to be the initialized lpos, seq number,
> please?

lpos (an internal field) is initialized with the PRB_INIT constant so
mark that the iterator has been initialized but not yet used. This is so
that the next call to prb_iter_next() will be valid no matter what
(after which lpos is set to the seq of that returned entry). I did not
like the idea of iterators becoming invalid before they were even used.

seq (an optional by-reference variable from the caller), if non-NULL,
will be set with a seq number such that the next call to prb_iter_next()
will return that value + 1. As mentioned above, these semantics are to
simplify the init/next loop/logic.

But prb_iter_init() notis is only used for read loops. It is also used,
for example, by printk to set the clear_seq marker in some cases of
"dmesg -c". As I've mentioned, the API grew out of printk
requirements. I am more than happy to simplify this.

> I would expect a function that initializes the iterator
> either to the first valid entry (tail-one) or
> to the one defined by the given seq number.
>
> Well, I think that we need to start with a more low-level functions.
> IMHO. we need something to read one entry a safe way. Then it will
> be much easier to live with races in the rest of the code:
>
> /*
>  * Return valid entry on the given lpos. Data are read
>  * only when the buffer is is not zero.
>  */
> int prb_get_entry(struct struct printk_ringbuffer *rb,
> 		    unsigned long lpos,
> 		    struct prb_entry *entry,
> 		    unsigned int data_buf_size)
> {
> 	/*
> 	 * Pointer to the ring buffer. The data might get lost
> 	 * at any time.
> 	 */
> 	struct prb_entry *weak_entry;
>
> 	if (!is_valid(lpos))
> 		return -EINVAL;
>
> 	/* Make sure that data are valid for the given valid lpos. */
> 	smp_rmb();
>
> 	weak_entry = to_entry(lpos);
> 	entry->seq = weak_entry->seq;
>
> 	if (data_buf_size) {
> 		unsigned int size;
>
> 		size = min(data_buf_size, weak_entry->size);

weak_entry->size is untrusted data here. The following memcpy could grab
data beyond the data array. (But we can ignore these details for now. I
realize you are trying to refactor, not focus on these details.)

> 		memcpy(entry->data, weak_entry->data, size);
> 		entry->size = size;
> 	} else {
> 		entry->size = weak_data->size;
> 	}
>
> 	/* Make sure that the copy is done before we check validity. */
> 	smp_mb();
>
> 	return is_valid(lpos);
> }
>
> Then I would do the support for iterating the following way.
> First, I would extend the structure:
>
> struct prb_iterator {
> 	struct printk_ringbuffer *rb;
> 	struct prb_entry *entry;
> 	unsigned int data_buffer_size;
> 	unsigned long lpos;
> };
>
> And do something like:
>
> void prg_iter_init(struct struct printk_ringbuffer *rb,
> 		       struct prb_entry *entry,
> 		       unsigned int data_buffer_size,
> 		       struct prb_iterator *iter)
> {
> 	iter->rb = rb;
> 	iter->entry = entry;
> 	iter->data_buffer_size = data_buffer_size;
> 	lpos = 0UL;
> }
>
> Then we could do iterator support the following way:
>
> /* Start iteration with reading the tail entry. */
> int prb_iter_tail_entry(struct prb_iterator *iter);

A name like prb_iter_oldest_entry() might simplify things. I really
don't want the caller to be concerned with heads and tails and which is
which. That's an implementation detail of the ringbuffer.

> {
> 	unsigned long tail;
> 	int ret;
>
> 	for (;;) {
> 		tail = atomic_long_read(&rb->tail);
>
> 		/* Ring buffer is empty? */

The ring buffer is only empty at the beginning (when tail == head). Readers
are non-consuming, so it is never empty again once an entry is committed.

 		if (unlikely(atomic_long_read(head) == atomic_long_read(tail)))
 			return -EINVAL;

The check for valid is to make sure the tail we just read hasn't already
been overtaken by writers. I suppose this could be put into a nested
loop so that we continue trying again until we get a valid tail.

> 		if (unlikely(!is_valid(tail)))
> 			return -EINVAL;
>
> 		ret = prb_get_entry(iter->rb, tail,
> 				    iter->entry, iter->data_buf_size);
> 		if (!ret) {
> 			iter->lpos = tail;
> 			break;
> 		}
> 	}
>
> 	return 0;
> }
>
> unsigned long next_lpos(unsineg long lpos, struct prb_entry *entry)
> {
> 	return lpos + sizeof(struct entry) + entry->size;

entry->size already includes sizeof(struct prb_entry) plus alignment
padding. (Again, not important right now.)

> }
>
> /* Try to get next entry using a valid iterator */
> int prb_iter_next_entry(struct prb_iterator *iter)
> {
> 	iter->lpos = next_lpos(iter->lpos, iter->etnry);
>
> 	return prb_get_entry(rb, lpos, entry, data_buf_size;
> }
>
> /* Try to get the next entry. Allow to skip lost messages. */
> int prb_iter_next_valid_entry(struct prb_iterator *iter)
> {
> 	int ret;
>
> 	ret = prb_iter_next_entry(iter);
> 	if (!ret)
> 		return 0;
>
> 	/* Next entry has been lost. Skip to the current tail. */
> 	return prb_iter_tail_entry(rb, *lpos, entry, data_buf_size);

You return values are geting mixed up here and you are not
distinguishing between overtaken by writers and hit the end of the
ringbuffer, but I think what you are trying to write is that
prb_iter_next_valid_entry() should either return 0 for success or !0 if
the end of the ringbuffer was hit.

> }
>
>> +static bool is_valid(struct printk_ringbuffer *rb, unsigned long lpos)
>> +{
>> +	unsigned long head, tail;
>> +
>> +	tail = atomic_long_read(&rb->tail);
>> +	head = atomic_long_read(&rb->head);
>> +	head -= tail;
>> +	lpos -= tail;
>> +
>> +	if (lpos >= head)
>> +		return false;
>> +	return true;
>> +}

I am trying to understand what you want the reader code should look
like. Keep in mind that readers can be overtaken at any moment. They
also need to track entries they have missed. If I understand your idea,
it is something like this (trying to keep it as simple as possible):

void print_all_entries(...)
{
    char buf[sizeof(struct prb_entry) + DATASIZE + sizeof(long)];
    struct prb_entry *entry = (struct prb_entry *)&buf[0];
    struct prb_iterator iter;
    u64 last_seq;

    prb_iter_init(rb, entry, DATASIZE, &iter);
    if (prb_iter_oldest_entry(&iter) != 0)
        return; /* ringbuffer empty */

    for (;;) {
        do_print_entry(entry);
        last_seq = entry->seq;
        if (prb_iter_next_valid_entry(&iter) != 0)
            break; /* ringbuffer empty */
        if (entry->seq - last_seq != 1)
            print("lost %d\n", ((entry->seq - last_seq) + 1));
    }
}

I like the idea of the caller passing in a prb_entry struct. That really
helps to reduce the parameters. And having the functions
prb_iter_oldest_entry() and prb_iter_next_valid_entry() internally loop
until they get a valid result also helps so that the reader doesn't have
to do that. And if the reader doesn't have to track lost entries (for
example, /dev/kmsg), then it becomes even less code.

> IMPORTANT:
>
> Please, do not start rewriting the entire patchset after reading this
> mail. I suggest to take a rest from coding. Just read the feadback,
> ask if anything is unclear, and let your brain processing it on
> background.

Thank you for this tip.

John Ogness
