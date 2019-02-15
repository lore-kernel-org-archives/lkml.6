Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfBONrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:47:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfBONrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:47:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35782AE06;
        Fri, 15 Feb 2019 13:47:12 +0000 (UTC)
Date:   Fri, 15 Feb 2019 14:47:11 +0100
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
Message-ID: <20190215134711.pimxhuwipkzlgq23@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-5-john.ogness@linutronix.de>
 <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
 <87ef8aosby.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef8aosby.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-15 00:36:49, John Ogness wrote:
> On 2019-02-14, Petr Mladek <pmladek@suse.com> wrote:
> >> Add the writer functions prb_reserve() and prb_commit(). These make
> >> use of processor-reentrant spin locks to limit the number of possible
> >> interruption scenarios for the writers.
> >> 
> >> --- a/lib/printk_ringbuffer.c
> >> +++ b/lib/printk_ringbuffer.c
> >>  static bool __prb_trylock(struct prb_cpulock *cpu_lock,
> >>  			  unsigned int *cpu_store)
> >>  {
> >> @@ -75,3 +83,167 @@ void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
> >>  
> >>  	put_cpu();
> >>  }
> >> +
> >> +static struct prb_entry *to_entry(struct printk_ringbuffer *rb,
> >> +				  unsigned long lpos)
> >> +{
> >> +	char *buffer = rb->buffer;
> >> +	buffer += PRB_INDEX(rb, lpos);
> >> +	return (struct prb_entry *)buffer;
> >> +}
> >> +
> >> +static int calc_next(struct printk_ringbuffer *rb, unsigned long tail,
> >> +		     unsigned long lpos, int size, unsigned long *calced_next)
> >> +{
> >
> > The function is so tricky that it deserves a comment.
> >
> > Well, I am getting really lost because of the generic name
> > and all the parameters. For example, I wonder what "calced" stands
> > for.
> 
> "calced" is short for "calculated". Maybe "lpos_next" would be a good
> name?

Yes. It would help if the name is the same as the variable passed
from prb_reserve().


> The function is only doing this: Given a reserve position and size to
> reserve, calculate what the next reserve position would be.
> 
> It might seem complicated because it also detects/reports the special
> cases that the tail would be overwritten (returns -1) or if the
> ringbuffer wraps when performing the reserve (returns 1).

> > I think that it will be much easiser to follow the logic if the entire
> > for-cycle around calc_next() is implemented in a single function.
> 
> calc_next() is already sitting in 2 nested loops. And calc_next()
> performs manual tail-recursion using a goto. I doubt it becomes easier
> to follow when calc_next is inlined in prb_reserve().

Of course, it is possible that it will be worse. But we need to do
something to make it better. The current interaction between calc_next(),
push_tail() and prb_reserve using -1,0,1 values and many parameters
is really hard to follow.


> > The function push_tail() should get called from inside this function.
> 
> I disagree. calc_next's job isn't to make any changes.

It is only about the name. If you rename it to klp_get_next_reserve()
then it will be allowed to push the tail ;-) I believe that it will
simplify the code. I might be wrong but please try it.

[...]

> >
> > /* Try to remove the oldest message */
> 
> That is the kind of comment that I usually get in trouble for (saying
> the obvious). But I have no problems adding it.

It is obvious for you. But it helps to understand the meaning
for people that see the code for the first time. Especially
when they need to get familiar with the tail/head/reserve
naming scheme. Note that the current printk buffer used
first/next names.

> >> +static bool push_tail(struct printk_ringbuffer *rb, unsigned long tail)

[...]

> >> +/*
> >> + * prb_commit: Commit a reserved entry to the ring buffer.
> >> + * @h: An entry handle referencing the data entry to commit.
> >> + *
> >> + * Commit data that has been reserved using prb_reserve(). Once the data
> >> + * block has been committed, it can be invalidated at any time. If a writer
> >> + * is interested in using the data after committing, the writer should make
> >> + * its own copy first or use the prb_iter_ reader functions to access the
> >> + * data in the ring buffer.
> >> + *
> >> + * It is safe to call this function from any context and state.
> >> + */
> >> +void prb_commit(struct prb_handle *h)
> >> +{
> >> +	struct printk_ringbuffer *rb = h->rb;
> >> +	struct prb_entry *e;
> >> +	unsigned long head;
> >> +	unsigned long res;
> >> +
> >> +	for (;;) {
> >> +		if (atomic_read(&rb->ctx) != 1) {
> >> +			/* the interrupted context will fixup head */
> >> +			atomic_dec(&rb->ctx);
> >> +			break;
> >> +		}
> >> +		/* assign sequence numbers before moving head */
> >> +		head = atomic_long_read(&rb->head);
> >> +		res = atomic_long_read(&rb->reserve);
> >> +		while (head != res) {
> >> +			e = to_entry(rb, head);
> >> +			if (e->size == -1) {
> >> +				head = PRB_WRAP_LPOS(rb, head, 1);
> >> +				continue;
> >> +			}
> >> +			e->seq = ++rb->seq;
> >> +			head += e->size;
> >> +		}
> >> +		atomic_long_set_release(&rb->head, res);
> >
> > This looks realy weird. It looks like you are commiting all
> > reserved entries between current head and this entry.
> 
> I am.
> 
> > I would expect that every prb_entry has its own flag whether
> > it was commited or not. This function should set this flag
> > for its own entry. Then it should move the head to the
> > first uncommited entry.
> 
> How could there be a reserved but uncommitted entry before this one? Or
> after this one? The reserve/commit window is under the prb_cpulock. No
> other CPU can be involved. If an NMI occurred anywhere here and it did a
> reserve, it already did the matching commit.

Heh, I missed this. But then all the reserve/commit complexity is
used just to handle the race with NMIs. Other contexts do both actions
atomically.

Hmm, prb_reserve() code looks almost ready to be used
lockless. And if you have reservation then it looks natural
to leave the lock and fill the data lockless.

I understand that your approach solve some problems, especially
with the commit. Also I know that fixing all races often
makes the code much more complicated than one expected.

OK, I am going to continue with the review and will think about it.
Some complexity is surely needed also because of the readers.
I have to get familiar with them as well.


> >> +char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
> >> +		  unsigned int size)
> >> +{

[...]

> >> +	do {
> >> +		for (;;) {
> >> +			tail = atomic_long_read(&rb->tail);
> >> +			res1 = atomic_long_read(&rb->reserve);
> >> +			ret = calc_next(rb, tail, res1, size, &res2);
> >> +			if (ret >= 0)
> >> +				break;
> >> +			if (!push_tail(rb, tail)) {
> >> +				prb_commit(h);
> >
> > I am a bit confused. Is it commiting a handle that haven't
> > been reserved yet? Why, please?
> 
> If ctx is 1 we have the special responsibility of moving the head past
> all the entries that interrupting NMIs have reserve/committed. (See the
> check for "ctx != 1" in prb_commit().) The NMIs are already gone so we
> are the only one that can do this.
> 
> Here we are in prb_reserve() and have already incremented ctx. We might
> be the "ctx == 1" task and NMIs may have reserve/committed entries after
> we incremented ctx, which means that they did not push the head. If we
> now bail out because we couldn't push the tail, we still are obligated
> to push the head if we are "ctx == 1".
>
> prb_commit() does not actually care what is in the handle. It is going
> to commit everything up to the reserve. The fact that I pass it a handle
> is because that is what the function expects. I suppose I could create a
> _prb_commit() that takes only a ringbuffer argument and prb_commit()
> simply calls _prb_commit(h->rb). Then the bailout would be:

This is tricky like hell. Please add more comments in your code.
For example, see rb_remove_pages() or rb_tail_page_update().
Even trivial operations are commented there:

   + describe complex interactions between various variables,
     flags, etc.

   + the author spent non-trivial time to realize that
     the operation has to be done exactly there

   + some non-trivial computing

   + some corner case is handled

   + the operation has some non-obvious side effects or
     prerequisites


> Or maybe it should have a more descriptive name:
>
> 				_prb_commit_all_reserved(rb);

This would have helped. But it would still deserve a comment
why it is called there.


Best Regards,
Petr
