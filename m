Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96908ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655EB204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJQSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbeJQSp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF2DCAED2;
        Wed, 17 Oct 2018 10:50:16 +0000 (UTC)
Date:   Wed, 17 Oct 2018 12:50:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
 <20181016121752.GA2537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016121752.GA2537@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-16 14:17:52, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 01:40:06PM +0200, Petr Mladek wrote:
> > On Tue 2018-10-16 09:27:19, Peter Zijlstra wrote:
> 
> > > Instead of this tinkering around the edges, why don't you make the main
> > > logbuf a lockless ringbuffer and then delegate the actual printing of
> > > that buffer to a kthread, except for earlycon, which can do synchronous
> > > output.
> > 
> > In fact, there is no problem with printk log buffer. This patchset
> > tries to avoid deadlock caused by console-specific locks
> > used by console->write() methods.
> > 
> > By other words, we neither need printk_safe or lockless log buffer
> > to fix this prolem. Instead, we need either printk_deferred context
> > or lockless consoles.
> 
> If you have a lockless buffer and a trailing printk thread, that's
> deferred.
> 
> And earlycon _should_ be lockless (yes, I know, some suck)
> 
> But if you do this deferred nonsense that's currently in printk, then
> you risk never seeing the message -- the same problem I have with the
> whole printk_safe thing too.

What do you mean with printing the message, please? Storing it
into a buffer or showing on console?

I guess that it is storing because you suggest handling
the console by a printk kthread.

Now, please, what is your vision of the lock less buffer?
Would it be similar with the one used by ftrace?

The current implementation of the lockless buffer is very tricky
and supports only one reader. It will be even bigger maze
of code when we add such a support.

Also the messages are spread in many page-size buffers that
are linked in a per-cpu lists. The page used by the reader
is put outside the list. This all makes it very hard to
reconstruct the log. AFAIK, people use ftrace_dump_on_oops
even with a crashdump because nobody improved crash
to extract the messages from the complicated lockless
buffer for years.

IMHO, the current printk buffer is much more easy from
this point of view. It is one global buffer plus
two per-cpu buffers that are mostly empty.


I still think that the buffer is the minor problem these
days. The big problem are consoles and I do not see
how any lockless buffer could help with it.

Also note that by deferred printk I mean deferring the console
handling! IMHO, there are _no more problems_ with storing
the messages into the buffer if we accept that the current
very limited use of printk_safe per-cpu buffers is easier
than any complicated generic lockless buffer.

Best Regards,
Petr
