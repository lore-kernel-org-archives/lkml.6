Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFB32151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1aCdJlnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFB32151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJQV4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:56:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQV4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A0XIpTmZkyT/rZDyLZYHfWpFmc4juPHbdRbVMizOW3o=; b=1aCdJlnpzroyuzKpjfaqPzGxK
        U/dflovY0MYMG3vZsdddHbDftqLVisLOMiMjz1QMBLcqb6jSujIIytXBJagtvmFQ/HOlJc1Hro7hL
        y5gZDxsfEccUS4IgD/qaSvT1FfP8ZxCMr6JcgkP74PHoSSMAR/jx7KqS+KQVuLHOyB2KlMa3wGwd7
        DgdSlRjNhYfMJhn8Hj2gnFjBCok7eXA+ftGvEs27I6lPTHiJ6GF2XkusnmuZzGuoQOCC119BQcRdr
        c/2oGYAZULix6brM3erUBTMHofDOkSkmeUs6vFPX90RHqMuZmkzkvKrQG4bFHvNmjKtoXw70g8cYX
        2jGaBrDqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCmNR-0001zo-Qv; Wed, 17 Oct 2018 14:00:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FBDB2029856A; Wed, 17 Oct 2018 16:00:44 +0200 (CEST)
Date:   Wed, 17 Oct 2018 16:00:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        john.ogness@linutronix.de
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181017140044.GK3121@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
 <20181016121752.GA2537@hirez.programming.kicks-ass.net>
 <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:50:15PM +0200, Petr Mladek wrote:

> > If you have a lockless buffer and a trailing printk thread, that's
> > deferred.
> > 
> > And earlycon _should_ be lockless (yes, I know, some suck)
> > 
> > But if you do this deferred nonsense that's currently in printk, then
> > you risk never seeing the message -- the same problem I have with the
> > whole printk_safe thing too.
> 
> What do you mean with printing the message, please? Storing it
> into a buffer or showing on console?
> 
> I guess that it is storing because you suggest handling
> the console by a printk kthread.

I'm not sure from the context you quoted.

> Now, please, what is your vision of the lock less buffer?
> Would it be similar with the one used by ftrace?

No, exactly not like ftrace in fact.

> The current implementation of the lockless buffer is very tricky
> and supports only one reader. It will be even bigger maze
> of code when we add such a support.

The ftrace thing is way complicated and unsuitable. It does what it
does, but I would've never build it that way around.

> IMHO, the current printk buffer is much more easy from
> this point of view. It is one global buffer plus
> two per-cpu buffers that are mostly empty.

I'm arguing for a single (global) lockless buffer with per-cpu line
buffers.

> I still think that the buffer is the minor problem these
> days. The big problem are consoles and I do not see
> how any lockless buffer could help with it.

Yes, the consoles are horrible unfixable crap (some far worse than
others).

But the logbuf is also horrible, and that we can in fact fix.

> Also note that by deferred printk I mean deferring the console
> handling! IMHO, there are _no more problems_ with storing
> the messages into the buffer if we accept that the current
> very limited use of printk_safe per-cpu buffers is easier
> than any complicated generic lockless buffer.

They hide messages. The whole two radically different printk paths is
also quite horrible.

And lockless buffers aren't all _that_ complicated, esp. not when
performance isn't the top priority.

And earlycon is mostly usable, esp. the serial ones. Those, when
configured, should synchronously print along. The current design
also makes that difficult.

A wee little like so; typed in a hurry, never been near a compiler.

struct ll_buffer {
	void *buffer;
	unsigned int size;

	unsigned int tail, reserve, head;

	unsigned int cpu;
	unsigned int ctx;
};

struct ll_entry {
	unsigned int size;
	char data[0];
};

struct ll_handle {
	unsigned int cpu;
	struct ll_entry *lhe;
};

static struct ll_buffer logbuf = {
	.buffer = /* static storage */,
	.cpu = -1;
};

static void __ll_get(struct ll_buffer *llb, struct ll_handle *llh)
{
	unsigned int cpu, old;

	cpu = smp_processor_id();
	for (;;) {
		old = READ_ONCE(llb->cpu);
		if (old == -1) {
			if (try_cmpxchg_acquire(&llb->cpu, &old, cpu))
				break;
		}
		if (old == cpu)
			break;

		cpu_relax();
	}

	llh->cpu = old;
}

static void __ll_put(struct ll_buffer *llb, struct ll_handle *llh)
{
	smp_store_release(llb->cpu, llh->cpu);
}

static char *__ll_reserve(struct ll_buffer *llb, struct ll_hande *llh, unsigned int size)
{
	unsigned int tail, res;
	struct ll_entry *lle;

	__ll_get(llb, llh);

	llb->ctx++;

	size += sizeof(struct ll_entry);
	size += 3;
	size &= ~3;

	do {
		for (;;) {
			tail = READ_ONCE(llb->tail);
			res = READ_ONCE(llb->resserve);

			if (CIRC_SPACE(tail, res, llb->size) > size)
				break;

			lle = llb->buffer + (tail % llb->size);
			cmpxchg(&llb->tail, tail, tail + lhe->size);
		}

	} while (cmpxchg(&llb->reserve, res, res + size) != res);

	llh->lhe = llb->buffer + (res % llb->size);
	llh->lhe->size = size;
}

static void __ll_commit(struct ll_buffer *llb, struct ll_handle *llh)
{
	for (;;) {
		unsigned int ctx, res;

		res = READ_ONCE(llb->res);
		barrier();
		ctx = --llb->ctx;
		if (ctx)
			break;

		smp_store_release(llb->head, res);

		if (likely(READ_ONCE(llb->res) == res))
			break;

		llb->ctx++;
	}

	__ll_put(llb, llh);
}

#define MAX_LINE	1020
#define MAX_CTX		4

struct line_buffers {
	int ctx;
	char buffers[MAX_CTX][MAX_LINE];
};

static DEFINE_PER_CPU(struct line_buffers, linbufs);

int vprintk(const char *fmt, va_list args)
{
	struct ll_handle handle;
	struct line_buffers *lb;
	struct ll_entry *lhe;
	char linbuf;
	int sz;

	preempt_disable();
	lb = this_cpu_ptr(&linbufs);
	linbuf = lb->buffers[lb->ctx++];

	sz = scnprintf(linbuf, MAX_LINE, fmt, args);

	__ll_reserve(&logbuf, &handle, sz);
	memcpy(llh->lhe->data, linbuf, sz); // XXX doesn't wrap on llb->size
	__ll_commit(&logbuf, &handle);

	ln->ctx--;
	preempt_enable();
}


struct ll_reader {
	unsigned int tail;
	char line[MAX_LINE];
};

static bool __ll_read(struct ll_buffer *llb, struct ll_reader *llr)
{
	unsigned int tail, reader, head, sz;
	struct ll_entry *lhe;
	bool lost = false;

	for (;;) {
		head = READ_ONCE(llb->head);
		smp_rmb();
		tail = READ_ONCE(llb->tail);
		reader = READ_ONCE(llr->tail);
		if (unlikely((signed)(tail - reader) < 0)) {
			lost = true;
			reader = tail;
		}
		smp_rmb();
		lhe = llb->buffer + reader;
		sz = lhe->size;
		llr->tail = reader + sz;
		sz -= sizeof(struct ll_entry);

		if ((signed)(head - reader) > 0)
			memcpy(llr->line, lhe->data, sz); // XXX wrap

		smp_rmb();
		tail = READ_ONCE(llb->tail);
		if ((signed)(tail - reader) >= 0)
			break;
	}

	return lost;
}
