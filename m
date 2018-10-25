Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C590C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B71D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B71D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeJYRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbeJYRhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D5F3ABE2;
        Thu, 25 Oct 2018 09:06:04 +0000 (UTC)
Date:   Thu, 25 Oct 2018 11:06:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181025090603.7gkevv5l3zg7dj5e@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181023120441.GB10251@jagdpanzerIV>
 <20181023121057.GC10251@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023121057.GC10251@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-23 21:12:30, Sergey Senozhatsky wrote:
> On (10/23/18 21:04), Sergey Senozhatsky wrote:
> > 
> > Seems that s390 is the only arch which defines its own bust_spinlocks().
> > Not sure why... Just to play games with console_loglevel?
> > 
> > ---
> > 
> > void bust_spinlocks(int yes)
> > {
> > 	if (yes) {
> > 		oops_in_progress = 1;
> > 	} else {
> > 		int loglevel_save = console_loglevel;
> > 		console_unblank();
> > 		oops_in_progress = 0;
> > 		/*
> > 		 * OK, the message is on the console.  Now we call printk()
> > 		 * without oops_in_progress set so that printk will give klogd
> > 		 * a poke.  Hold onto your hats...
> > 		 */
> > 		console_loglevel = 15;
> > 		printk(" ");
> > 		console_loglevel = loglevel_save;
> > 	}
> > }
> > 
> > ---
> > 
> > The "printk(" "); without oops_in_progress" part is a bit worrisome.
> > This thing technically can deadlock. Unless s390 has no NMI panic().

The comment suggests that the main purpose it is to wake up
klogd(). It is done in the generic bust_spinlocks() a safe way.

The games with console_loglevel do not make much sense because
console_unblank() calls console_unlock() when it was able to
take the console_lock. It means that either console_unblank()
flush all messages to the console or console_trylock() would
most likely fail also in that extra printk().

IMHO, the custom s390 implementation can get removed.
The generic code should do the same job these days.


> And console_unblank() is not guaranteed to print anything (unlike
> console_flush_on_panic(), but oops is not panic() yet, so we can't
> replace it with flush_on_panic()) - console_sem can be locked, so
> console_unblank() would do nothing.

I see. I missed that console_unblank() returns early when
down_trylock_console_sem() fails.

I still would like to refactor the code somehow to avoid
the bust_spinlocks(0)/bust_spinlocks(1) ping-pong.

It might make sense to call console_unblank() from
console_flush_on_panic().

I wonder if it would make sense to call unblank_screen() in
console_unblank()...

Best Regards,
Petr
