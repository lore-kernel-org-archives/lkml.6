Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84E20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBUQWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:22:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:38638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfBUQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:22:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5ACF1B640;
        Thu, 21 Feb 2019 16:22:49 +0000 (UTC)
Date:   Thu, 21 Feb 2019 17:22:48 +0100
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
Message-ID: <20190221162248.6zgrbjdh67srnlhd@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-6-john.ogness@linutronix.de>
 <20190218125407.ljvkuplvaa3zyj6n@pathway.suse.cz>
 <87o977v4go.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o977v4go.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-19 22:44:07, John Ogness wrote:
> Hi Petr,
> 
> Below I make several comments, responding to your questions. But I like
> the new API I believe you are trying to propose. So really only my final
> comments are of particular importance. There I show you what I think
> reader code would look like using your proposed API.
> 
> On 2019-02-18, Petr Mladek <pmladek@suse.com> wrote:
> >> + * prb_iter_init: Initialize an iterator for a ring buffer.
> >> + * @iter: The iterator to initialize.
> >> + * @rb: A ring buffer to that @iter should iterate.
> >> + * @seq: The sequence number of the position preceding the first record.
> >> + *       May be NULL.
> >> + *
> >> + * Initialize an iterator to be used with a specified ring buffer. If @seq
> >> + * is non-NULL, it will be set such that prb_iter_next() will provide a
> >> + * sequence value of "@seq + 1" if no records were missed.
> >> + *
> >> + * It is safe to call this function from any context and state.
> >> + */
> >> +void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
> >> +		   u64 *seq)
> >> +{
> >> +	memset(iter, 0, sizeof(*iter));
> >> +	iter->rb = rb;
> >> +	iter->lpos = PRB_INIT;
> >> +
> >> +	if (!seq)
> >> +		return;
> >> +
> >> +	for (;;) {
> >> +		struct prb_iterator tmp_iter;
> >> +		int ret;
> >> +
> >> +		prb_iter_copy(&tmp_iter, iter);
> >
> > It looks strange to copy something that has been hardly initialized.
> > I hope that we could do this without a copy, see below.
> >
> >> +
> >> +		ret = prb_iter_next(&tmp_iter, NULL, 0, seq);
> >
> > prb_iter_next() and prb_iter_data() are too complex spaghetti
> > code. They do basically the same but they do not share
> > any helper function. The error handling is different
> > which is really confusing. See below.
> 
> I don't follow why you think they do basically the same
> thing. prb_iter_next() moves forward to the next entry, then calls
> prb_iter_data() to retrieve the data. prb_iter_data() _is_ the helper
> function.

Ah, I missed the prb_iter_data() call in prb_iter_next(). I have to
admit that I did not have a courage to check them carefully. Both
functions looked like a compact maze of to_entry(), is_valid,
smp_rmb() calls ;-)

I got only the basic idea and started thinking about how
to achieve the same an easier to understand way.

> > Well, I think that we need to start with a more low-level functions.
> > IMHO. we need something to read one entry a safe way. Then it will
> > be much easier to live with races in the rest of the code:
> >
> > /*
> >  * Return valid entry on the given lpos. Data are read
> >  * only when the buffer is is not zero.
> >  */
> > int prb_get_entry(struct struct printk_ringbuffer *rb,
> > 		    unsigned long lpos,
> > 		    struct prb_entry *entry,
> > 		    unsigned int data_buf_size)
> > {
> > 	/*
> > 	 * Pointer to the ring buffer. The data might get lost
> > 	 * at any time.
> > 	 */
> > 	struct prb_entry *weak_entry;
> >
> > 	if (!is_valid(lpos))
> > 		return -EINVAL;
> >
> > 	/* Make sure that data are valid for the given valid lpos. */
> > 	smp_rmb();
> >
> > 	weak_entry = to_entry(lpos);
> > 	entry->seq = weak_entry->seq;
> >
> > 	if (data_buf_size) {
> > 		unsigned int size;
> >
> > 		size = min(data_buf_size, weak_entry->size);
> 
> weak_entry->size is untrusted data here. The following memcpy could grab
> data beyond the data array. (But we can ignore these details for now. I
> realize you are trying to refactor, not focus on these details.)

Great catch! Yes, we would need to check the overflow here.

> > 		memcpy(entry->data, weak_entry->data, size);
> > 		entry->size = size;
> > 	} else {
> > 		entry->size = weak_data->size;
> > 	}
> >
> > 	/* Make sure that the copy is done before we check validity. */
> > 	smp_mb();
> >
> > 	return is_valid(lpos);
> > }
> >
> > Then I would do the support for iterating the following way.
> > First, I would extend the structure:
> >
> > struct prb_iterator {
> > 	struct printk_ringbuffer *rb;
> > 	struct prb_entry *entry;
> > 	unsigned int data_buffer_size;
> > 	unsigned long lpos;
> > };
> >
> > And do something like:
> >
> > void prg_iter_init(struct struct printk_ringbuffer *rb,
> > 		       struct prb_entry *entry,
> > 		       unsigned int data_buffer_size,
> > 		       struct prb_iterator *iter)
> > {
> > 	iter->rb = rb;
> > 	iter->entry = entry;
> > 	iter->data_buffer_size = data_buffer_size;
> > 	lpos = 0UL;
> > }
> >
> > Then we could do iterator support the following way:
> >
> > /* Start iteration with reading the tail entry. */
> > int prb_iter_tail_entry(struct prb_iterator *iter);
> 
> A name like prb_iter_oldest_entry() might simplify things. I really
> don't want the caller to be concerned with heads and tails and which is
> which. That's an implementation detail of the ringbuffer.

Makes sense.

> > {
> > 	unsigned long tail;
> > 	int ret;
> >
> > 	for (;;) {
> > 		tail = atomic_long_read(&rb->tail);
> >
> > 		/* Ring buffer is empty? */
> 
> The ring buffer is only empty at the beginning (when tail == head). Readers
> are non-consuming, so it is never empty again once an entry is committed.

>  		if (unlikely(atomic_long_read(head) == atomic_long_read(tail)))
>  			return -EINVAL;

Yes, this is a check for empty buffer. And yes, it can be done
outside the cycle.

> The check for valid is to make sure the tail we just read hasn't already
> been overtaken by writers. I suppose this could be put into a nested
> loop so that we continue trying again until we get a valid tail.
>
> > 		if (unlikely(!is_valid(tail)))
> > 			return -EINVAL;

Heh, I wanted to add check for the empty buffer (the comment was correct).
But I added is_valid() check instead.

We could remove it. It is hidden in prb_get_entry(). The for-cycle
will get repeated when it fails.

> >
> > 		ret = prb_get_entry(iter->rb, tail,
> > 				    iter->entry, iter->data_buf_size);
> > 		if (!ret) {
> > 			iter->lpos = tail;
> > 			break;
> > 		}
> > 	}
> >
> > 	return 0;
> > }
> >
> > unsigned long next_lpos(unsineg long lpos, struct prb_entry *entry)
> > {
> > 	return lpos + sizeof(struct entry) + entry->size;
> 
> entry->size already includes sizeof(struct prb_entry) plus alignment
> padding. (Again, not important right now.)

I see. I have missed it.

> > }
> >
> > /* Try to get next entry using a valid iterator */
> > int prb_iter_next_entry(struct prb_iterator *iter)
> > {
> > 	iter->lpos = next_lpos(iter->lpos, iter->etnry);
> >
> > 	return prb_get_entry(rb, lpos, entry, data_buf_size;
> > }
> >
> > /* Try to get the next entry. Allow to skip lost messages. */
> > int prb_iter_next_valid_entry(struct prb_iterator *iter)
> > {
> > 	int ret;
> >
> > 	ret = prb_iter_next_entry(iter);
> > 	if (!ret)
> > 		return 0;
> >
> > 	/* Next entry has been lost. Skip to the current tail. */
> > 	return prb_iter_tail_entry(rb, *lpos, entry, data_buf_size);
> 
> You return values are geting mixed up here and you are not
> distinguishing between overtaken by writers and hit the end of the
> ringbuffer, but I think what you are trying to write is that
> prb_iter_next_valid_entry() should either return 0 for success or !0 if
> the end of the ringbuffer was hit.

The -1,0,1 return values were hard to follow. It might get improved
by using -EINVAL,0,-EAGAIN or so. But I hope that the two return
values are even better and will be enough.

First, I proposed two functions to distinguish the two situations:

	prb_iter_next_entry() - fails when the next entry gets
				overtaken or at the end of the buffer
	prb_iter_next_valid_entry() - fails only at the end of the buffer

Second, the lost messages might get counted by comparing seq numbers.
You actually used this in the sample code below.


> > }
> >
> >> +static bool is_valid(struct printk_ringbuffer *rb, unsigned long lpos)
> >> +{
> >> +	unsigned long head, tail;
> >> +
> >> +	tail = atomic_long_read(&rb->tail);
> >> +	head = atomic_long_read(&rb->head);
> >> +	head -= tail;
> >> +	lpos -= tail;
> >> +
> >> +	if (lpos >= head)
> >> +		return false;
> >> +	return true;
> >> +}
> 
> I am trying to understand what you want the reader code should look
> like. Keep in mind that readers can be overtaken at any moment. They
> also need to track entries they have missed. If I understand your idea,
> it is something like this (trying to keep it as simple as possible):
> 
> void print_all_entries(...)
> {
>     char buf[sizeof(struct prb_entry) + DATASIZE + sizeof(long)];
>     struct prb_entry *entry = (struct prb_entry *)&buf[0];
>     struct prb_iterator iter;
>     u64 last_seq;
> 
>     prb_iter_init(rb, entry, DATASIZE, &iter);
>     if (prb_iter_oldest_entry(&iter) != 0)
>         return; /* ringbuffer empty */
> 
>     for (;;) {
>         do_print_entry(entry);
>         last_seq = entry->seq;
>         if (prb_iter_next_valid_entry(&iter) != 0)
>             break; /* ringbuffer empty */
>         if (entry->seq - last_seq != 1)
>             print("lost %d\n", ((entry->seq - last_seq) + 1));
>     }
> }

Yes, this was my idea.

I wonder if we might allow to omit prb_iter_oldest_entry() call.
In fact, prb_iter_next_valid_entry() restarts from the oldest
entry when the expected one gets lost. But it might cause more
harm than good. I need to see it in the various existing use cases.

Anyway, the data_buf_size parameter is supposed to allow reading only
the metadata. This is useful in situations where you just need
to find which entries would fit into the given buffer. For example,
the first loop in syslog_print_all().

> I like the idea of the caller passing in a prb_entry struct. That really
> helps to reduce the parameters. And having the functions
> prb_iter_oldest_entry() and prb_iter_next_valid_entry() internally loop
> until they get a valid result also helps so that the reader doesn't have
> to do that. And if the reader doesn't have to track lost entries (for
> example, /dev/kmsg), then it becomes even less code.

I am glad to read this.

Best Regards,
Petr
