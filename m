Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3837C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6CF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfBSVry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:47:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfBSVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:47:54 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gwDEw-0000yh-PT; Tue, 19 Feb 2019 22:47:46 +0100
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
Subject: Re: [RFC PATCH v1 06/25] printk-rb: add blocking reader support
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-7-john.ogness@linutronix.de>
        <20190218140538.5sug36qiji2rurxx@pathway.suse.cz>
Date:   Tue, 19 Feb 2019 22:47:45 +0100
In-Reply-To: <20190218140538.5sug36qiji2rurxx@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 18 Feb 2019 15:05:38 +0100")
Message-ID: <87k1hvv4am.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-18, Petr Mladek <pmladek@suse.com> wrote:
>> Add a blocking read function for readers. An irq_work function is
>> used to signal the wait queue so that write notification can
>> be triggered from any context.
>
> I would be more precise what exacly is problematic in which context.
> Something like:
>
> An irq_work function is used because wake_up() cannot be called safely
> from NMI and scheduler context.

OK.

>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  include/linux/printk_ringbuffer.h | 20 ++++++++++++++++
>>  lib/printk_ringbuffer.c           | 49 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 69 insertions(+)
>> 
>> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
>> index 5fdaf632c111..106f20ef8b4d 100644
>> --- a/include/linux/printk_ringbuffer.h
>> +++ b/include/linux/printk_ringbuffer.h
>> @@ -2,8 +2,10 @@
>>  #ifndef _LINUX_PRINTK_RINGBUFFER_H
>>  #define _LINUX_PRINTK_RINGBUFFER_H
>>  
>> +#include <linux/irq_work.h>
>>  #include <linux/atomic.h>
>>  #include <linux/percpu.h>
>> +#include <linux/wait.h>
>>  
>>  struct prb_cpulock {
>>  	atomic_t owner;
>> @@ -22,6 +24,10 @@ struct printk_ringbuffer {
>>  
>>  	struct prb_cpulock *cpulock;
>>  	atomic_t ctx;
>> +
>> +	struct wait_queue_head *wq;
>> +	atomic_long_t wq_counter;
>> +	struct irq_work *wq_work;
>>  };
>>  
>>  struct prb_entry {
>> @@ -59,6 +65,15 @@ struct prb_iterator {
>>  #define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
>>  static char _##name##_buffer[1 << (szbits)]				\
>>  	__aligned(__alignof__(long));					\
>> +static DECLARE_WAIT_QUEUE_HEAD(_##name##_wait);				\
>> +static void _##name##_wake_work_func(struct irq_work *irq_work)		\
>> +{									\
>> +	wake_up_interruptible_all(&_##name##_wait);			\
>> +}									\
>
> All ring buffers might share the same generic function, something like:
>
> void prb_wake_readers_work_func(struct irq_work *irq_work)
> {
> 	struct printk_ringbuffer *rb;
>
> 	rb = container_of(irq_work, struct printk_ring_buffer, wq_work);
> 	wake_up_interruptible_all(rb->wq);			\
> }

Agreed.

>> +static struct irq_work _##name##_wake_work = {				\
>> +	.func = _##name##_wake_work_func,				\
>> +	.flags = IRQ_WORK_LAZY,						\
>> +};									\
>>  static struct printk_ringbuffer name = {				\
>>  	.buffer = &_##name##_buffer[0],					\
>>  	.size_bits = szbits,						\
>> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
>> index 1d1e886a0966..c2ddf4cb9f92 100644
>> --- a/lib/printk_ringbuffer.c
>> +++ b/lib/printk_ringbuffer.c
>> @@ -185,6 +188,12 @@ void prb_commit(struct prb_handle *h)
>>  	}
>>  
>>  	prb_unlock(rb->cpulock, h->cpu);
>> +
>> +	if (changed) {
>> +		atomic_long_inc(&rb->wq_counter);
>> +		if (wq_has_sleeper(rb->wq))
>> +			irq_work_queue(rb->wq_work);
>> +	}
>>  }
>>  
>>  /*
>> @@ -437,3 +446,43 @@ int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
>>  
>>  	return 1;
>>  }
>> +
>> +/*
>> + * prb_iter_wait_next: Advance to the next record, blocking if none available.
>> + * @iter: Iterator tracking the current position.
>> + * @buf: A buffer to store the data of the next record. May be NULL.
>> + * @size: The size of @buf. (Ignored if @buf is NULL.)
>> + * @seq: The sequence number of the next record. May be NULL.
>> + *
>> + * If a next record is already available, this function works like
>> + * prb_iter_next(). Otherwise block interruptible until a next record is
>> + * available.
>> + *
>> + * When a next record is available, @iter is advanced and (if specified)
>> + * the data and/or sequence number of that record are provided.
>> + *
>> + * This function might sleep.
>> + *
>> + * Returns 1 if @iter was advanced, -EINVAL if @iter is now invalid, or
>> + * -ERESTARTSYS if interrupted by a signal.
>> + */
>> +int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
>> +{
>> +	unsigned long last_seen;
>> +	int ret;
>> +
>> +	for (;;) {
>> +		last_seen = atomic_long_read(&iter->rb->wq_counter);
>> +
>> +		ret = prb_iter_next(iter, buf, size, seq);
>> +		if (ret != 0)
>> +			break;
>> +
>> +		ret = wait_event_interruptible(*iter->rb->wq,
>> +			last_seen != atomic_long_read(&iter->rb->wq_counter));
>
> Do we really need yet another counter here?
>
> I think that rb->seq might do the same job. Or if there is problem
> with atomicity then rb->head might work as well. Or do I miss
> anything?

You are correct. rb->head would be appropriate.

John Ogness
