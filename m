Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBVJ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:41288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfBVJ6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:58:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEDF8AEC5;
        Fri, 22 Feb 2019 09:58:30 +0000 (UTC)
Date:   Fri, 22 Feb 2019 10:58:29 +0100
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
Subject: Re: [RFC PATCH v1 07/25] printk-rb: add functionality required by
 printk
Message-ID: <20190222095829.vaxwqgfpzfvr3gm2@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-8-john.ogness@linutronix.de>
 <20190218155921.rxksi2hyasxnmu7a@pathway.suse.cz>
 <87ftsjv3cb.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftsjv3cb.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-19 23:08:20, John Ogness wrote:
> On 2019-02-18, Petr Mladek <pmladek@suse.com> wrote:
> >> The printk subsystem needs to be able to query the size of the ring
> >> buffer, seek to specific entries within the ring buffer, and track
> >> if records could not be stored in the ring buffer.
> >> 
> >> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
> >> index c2ddf4cb9f92..ce33b5add5a1 100644
> >> --- a/lib/printk_ringbuffer.c
> >> +++ b/lib/printk_ringbuffer.c
> >> @@ -175,11 +175,16 @@ void prb_commit(struct prb_handle *h)
> >>  				head = PRB_WRAP_LPOS(rb, head, 1);
> >>  				continue;
> >>  			}
> >> +			while (atomic_long_read(&rb->lost)) {
> >> +				atomic_long_dec(&rb->lost);
> >> +				rb->seq++;
> 
> > On the contrary, the patch adding support for lost messages
> > should implement a way how to inform the user about lost messages.
> > E.g. to add a warning when some space becomes available again.
> 
> The readers will see that messages were lost. I think that is enough. I
> don't know how useful it would be to notify writers that space is
> available. The writers are holding the prb_cpulock, so they definitely
> shouldn't be waiting around for anything.

I see your intention. Well, it forces all readers to implement the
check and write a message. It might be fine if the code can be shared.

My original idea was the following. If any next writer succeeds
to reserve space for its own message. It would try to reserve
space also for the warning. If it succeeds, it would just
write the warning there (like a nested context or so). Then
all readers would get the warning for free.

But you inspired me to antoher idea. We could hadle this in
the krb_iter_get_next_entry() calls. They could fill
the given buffer with the warning message when they
detect missed messages. The real message might get
added into the same buffer. Or we might add a flag
into struct prb_iter so that the reader would need
to call krb_iter_get_next_entry() to get the real
message on the current lpos.

Both solutions allow to get the warnings trasparently.
There will be no duplicated extra code. Also all readers
would handle it consistently.

But there is a difference:

If we store the warning into the ring buffer directly
then we do not need to store the seq number. I mean
that we would not need to bump seq when reservation failed.
The amount of lost messages is handled by another
counter anyway.

On the other hand, using the fake messages would allow
to handle transparently even the messages lost by readers.
I mean that krb_iter_get_next_valid_entry() might fill
the given buffer with a warning when the next message
was overwriten and it had to reset lpos to tail.

I am not sure what is better out of my head. I would need
to play with the code.


> This situation should be quite rare because it means the _entire_ ring
> buffer was filled up by an NMI context that interrupted a context that
> was in the reserve/commit window. NMI contexts probably should not be
> doing _so_ much printk'ing within a single NMI.

Sure.

Best Regards,
Petr
