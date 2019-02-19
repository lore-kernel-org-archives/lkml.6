Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B91A21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfBSWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:08:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfBSWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:08:31 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gwDYs-0001LF-K4; Tue, 19 Feb 2019 23:08:22 +0100
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
Subject: Re: [RFC PATCH v1 07/25] printk-rb: add functionality required by printk
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-8-john.ogness@linutronix.de>
        <20190218155921.rxksi2hyasxnmu7a@pathway.suse.cz>
Date:   Tue, 19 Feb 2019 23:08:20 +0100
In-Reply-To: <20190218155921.rxksi2hyasxnmu7a@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 18 Feb 2019 16:59:21 +0100")
Message-ID: <87ftsjv3cb.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-18, Petr Mladek <pmladek@suse.com> wrote:
>> The printk subsystem needs to be able to query the size of the ring
>> buffer, seek to specific entries within the ring buffer, and track
>> if records could not be stored in the ring buffer.
>> 
>> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
>> index c2ddf4cb9f92..ce33b5add5a1 100644
>> --- a/lib/printk_ringbuffer.c
>> +++ b/lib/printk_ringbuffer.c
>> @@ -175,11 +175,16 @@ void prb_commit(struct prb_handle *h)
>>  				head = PRB_WRAP_LPOS(rb, head, 1);
>>  				continue;
>>  			}
>> +			while (atomic_long_read(&rb->lost)) {
>> +				atomic_long_dec(&rb->lost);
>> +				rb->seq++;
>
> The lost-messages handling should be in a separate patch.
> At least I do not see any close relation with prb_iter_seek().

Agreed.

> I would personally move prb_iter_seek() to the 5th patch that
> implements the other get/iterator functions.

Agreed.

> On the contrary, the patch adding support for lost messages
> should implement a way how to inform the user about lost messages.
> E.g. to add a warning when some space becomes available again.

The readers will see that messages were lost. I think that is enough. I
don't know how useful it would be to notify writers that space is
available. The writers are holding the prb_cpulock, so they definitely
shouldn't be waiting around for anything.

This situation should be quite rare because it means the _entire_ ring
buffer was filled up by an NMI context that interrupted a context that
was in the reserve/commit window. NMI contexts probably should not be
doing _so_ much printk'ing within a single NMI.

>> +			}
>>  			e->seq = ++rb->seq;
>>  			head += e->size;
>>  			changed = true;
>>  		}
>>  		atomic_long_set_release(&rb->head, res);
>> +
>>  		atomic_dec(&rb->ctx);
>>  
>>  		if (atomic_long_read(&rb->reserve) == res)
>> @@ -486,3 +491,93 @@ int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
>>  
>>  	return ret;
>>  }
>> +
>> +/*
>> + * prb_iter_seek: Seek forward to a specific record.
>> + * @iter: Iterator to advance.
>> + * @seq: Record number to advance to.
>> + *
>> + * Advance @iter such that a following call to prb_iter_data() will provide
>> + * the contents of the specified record. If a record is specified that does
>> + * not yet exist, advance @iter to the end of the record list.
>> + *
>> + * Note that iterators cannot be rewound. So if a record is requested that
>> + * exists but is previous to @iter in position, @iter is considered invalid.
>> + *
>> + * It is safe to call this function from any context and state.
>> + *
>> + * Returns 1 on succces, 0 if specified record does not yet exist (@iter is
>> + * now at the end of the list), or -EINVAL if @iter is now invalid.
>> + */
>
> Do we really need to distinguish when the iterator is invalid and when
> we are at the end of the buffer?

Sure! There is big difference between "stop iterating because we hit the
newest entry" and "reset the iterator to the oldest entry because we
were overtaken by a writer".

> It seems that the reaction in both situation always is to call
> prb_iter_init(&iter, &printk_rb, &some_seq).

prb_iter_init() is only called to reset the iterator to the oldest
entry. That's all it is really doing. The fact that it can optionally
return a sequence number is just a convenience side-effect implemented
for some printk demands.

> I am still a bit
> confused what your prb_iter_init() does. Therefore I am not
> sure what it is supposed to do.
>
> Anyway, it seems to be typically used when you need to start
> from tail. I would personally do something like (based on my code
> in reply to 5th patch:
>
> int prb_iter_seek_to_seq(struct prb_iterator *iter, u64 seq)
> {
> 	int ret;
>
> 	ret = prb_iter_tail_entry(iter);
>
> 	while (!ret && iter->entry->seq != seq)
> 		ret = prb_iter_next_valid_entry(iter);
>
> 	return ret;
> }

Yes. Moving the loops inside prb_iter_tail_entry() and
prb_iter_next_valid_entry() definitely simplify the code.

> When I see it, I would make the functionality more obvious
> by renaming:
>
>     prb_iter_tail_entry() -> prb_iter_set_tail_entry()

I would say: prb_iter_set_oldest_entry()

>> +int prb_iter_seek(struct prb_iterator *iter, u64 seq)
>> +{
>> +	u64 cur_seq;
>> +	int ret;
>> +
>> +	/* first check if the iterator is already at the wanted seq */
>> +	if (seq == 0) {
>> +		if (iter->lpos == PRB_INIT)
>> +			return 1;
>> +		else
>> +			return -EINVAL;
>> +	}
>> +	if (iter->lpos != PRB_INIT) {
>> +		if (prb_iter_data(iter, NULL, 0, &cur_seq) >= 0) {
>> +			if (cur_seq == seq)
>> +				return 1;
>> +			if (cur_seq > seq)
>> +				return -EINVAL;
>> +		}
>> +	}
>> +
>> +	/* iterate to find the wanted seq */
>> +	for (;;) {
>> +		ret = prb_iter_next(iter, NULL, 0, &cur_seq);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		if (cur_seq == seq)
>> +			break;
>> +
>> +		if (cur_seq > seq) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>
> This is a good example why prb_iter_data() and prb_iter_next() is
> a weird interface. You need to read the documentation very carefully
> to understand the difference (functionality, error codes). At least
> for me, it is far from obvious why they are used this way and
> if it is correct.

Agreed. I prefer your suggested API. They significantly simplify the
reader code, which as you'll see in later printk.c patches, is
everywhere.

John Ogness
