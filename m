Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5482133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfB0NM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:42366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfB0NM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:12:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 696C8AEB0;
        Wed, 27 Feb 2019 13:12:56 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:12:53 +0100
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
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Message-ID: <20190227131253.kdfmz4gmrufusihu@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
 <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
 <87o96yziau.fsf@linutronix.de>
 <20190227090249.fzigc7r237emlg6k@pathway.suse.cz>
 <874l8pft0y.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l8pft0y.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-02-27 11:02:53, John Ogness wrote:
> On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> > I mean that your patch does the reply on a very hidden location.
> 
> Right. I understand that and I agree.
> 
> > Regarding the per-console kthread. It would make sense if
> > we stop handling all consoles synchronously. For example,
> > when we push messages to fast consoles immediately and
> > offload the work for slow consoles.
> 
> My per-console kthread suggestion relating to fast consoles is so that
> some consoles (such as netconsole, which is quite fast) could drop less
> messages than a slow console (such as uart).

OK, it was not clear from the context.


> > Anyway, we first need to make the offload reliable enough.
> > It is not acceptable to always offload all messages.
> > We have been there last few years. We must keep a high
> > chance to see the messages. Any warning might be important
> > when it causes the system to die. Nobody knows what message
> > is such an important.
> 
> You seem to be missing the point of the series. It _is_ acceptable to
> offload all messages because they are being offloaded to non-emergency
> consoles. If messages are lost, it sucks (and the appropriate "dropped"
> messages are sent), but it isn't critical. Once we can agree to this
> point, printk becomes so much easier to work with.
> 
> Emergency consoles exist for handling important messages. They will not
> drop messages. They are synchronous and immediate.

We might start thinking about this only when the most common consoles
support the emergency mode. This patchset implemented it only
for serial consoles that are often very slow. It is contradicting
the above statement about fast consoles.

Also the emergency messages from different CPUs are synchronized.
This slows down all affected CPUs. They are serialized and blocked
by the speed of the consoles. It was the reason to handle all pending
messages only by the current owner. I am sure that it would cause
regressions.

Not to say that the synchronization is done using an unfair lock.
One CPU can simply get starved by others for non-predictable time.
This is why ticket spinlocks were invented.

You might argue that the amount of emergency messages should
be small but see below.


> >> It is not necessary. It is desired. Why should _any_ task be punished
> >> with console writing? That is what the printk kthread is for.
> >
> > I do not know about any acceptable solution without punishing
> > the tasks. But we might find a better compromise between the
> > punishment and reliability.
> 
> I do not want printk to compromise. That compromise is part of the
> problem. Let's partition printk to important and non-important so that
> we can optimize both. _That_ is the heart of this series.

No, this is just another compromise. Let's look at it from another
side.

The important and non-important messages already existed. The split
was done by console_loglevel. The emergency level just adds one
more category (show, show later, ignore). It allows more fine
grained setting but it does not remove the compromise.

People would still need to choose which messages should be seen
reliably and which might get lost. And the problem will be still
the same. The more messages will be printed reliably the more
delayed might get printk() callers. It might prevent softlockups
but only at the cost that all parallel writers are blocked by
waiting for the console.

Also note that printk configuration already is too complicated.
See the four numbers in /proc/sys/kernel/printk. Many people
would have troubles to set them reasonably even with description.
Fifth number would only make it worse.


And it is even more complicated because people are inconsistent
with using the log levels, see
https://lkml.kernel.org/r/20180619115726.3098-1-hdegoede@redhat.com
It is a lost fight. People always need to see messages from
the code that they work on. If we make it harder to see
some levels, people will just start using levels that are
not filtered.


This is why I suggest to split the work on the ring buffer
and consoles. The new ring buffer might be a clear win.
While the console handling is really complicated. But
I still think that we might and should do better even
in the consoles.

Best Regards,
Petr
