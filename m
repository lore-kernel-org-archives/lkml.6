Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1178C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73292075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfBVPZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:44094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfBVPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A497DAC63;
        Fri, 22 Feb 2019 15:25:41 +0000 (UTC)
Date:   Fri, 22 Feb 2019 16:25:41 +0100
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
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new
 ringbuffer
Message-ID: <20190222152541.33xp2btltwcecxz7@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-11-john.ogness@linutronix.de>
 <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
 <8736oijgpf.fsf@linutronix.de>
 <20190222144302.44zl37p75qgaixf3@pathway.suse.cz>
 <87va1byia5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va1byia5.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-22 16:06:26, John Ogness wrote:
> On 2019-02-22, Petr Mladek <pmladek@suse.com> wrote:
> >>>> +	rbuf = prb_reserve(&h, &sprint_rb, PRINTK_SPRINT_MAX);
> >>>
> >>> The second ring buffer for temporary buffers is really interesting
> >>> idea.
> >>>
> >>> Well, it brings some questions. For example, how many users might
> >>> need a reservation in parallel. Or if the nested use might cause
> >>> some problems when we decide to use printk-specific ring buffer
> >>> implementation. I still have to think about it.
> >> 
> >> Keep in mind that it is only used by the writers, which have the
> >> prb_cpulock. Typically there would only be 2 max users: a non-NMI
> >> writer that was interrupted during the reserve/commit window and the
> >> interrupting NMI that does printk. The only exception would be if the
> >> printk-code code itself triggers a BUG_ON or WARN_ON within the
> >> reserve/commit window. Then you will have an additional user per
> >> recursion level.
> >
> > I am not sure it is worth to call the ring buffer machinery just
> > to handle 2-3 buffers.
> 
> It may be slightly overkill, but:
> 
> 1. We have the prb_cpulock at this point anyway, so it will be
>    fast. (Both ring buffers share the same prb_cpulock.)

I am still not persuaded that we really need the lock. The
implementation looks almost ready for a fully lockless
writers. But I might be wrong.

The lock might be fine when it makes the code easier and does
not bring any deadlocks.


> 2. Getting a safe buffer is just 1 line of code: prb_reserve()

The problem is how complicated code is hidden behind
this 1 line of code.


> 3. Why should we waste _any_ lines of code implementing the handling of
>    these special 3-4 buffers?

It might be worth if it makes the code more strighforward
and less prone to bugs.


> > Well, it might be just my mental block. We need to be really careful
> > to avoid infinite recursion when storing messages into the log
> > buffer.
> 
> The recursion works well. I inserted a triggerable BUG_ON() in
> vprintk_emit() _within_ the reserve/commit window and I see a clean
> backtrace on the emergency console.

Have you tested all possible error situations that might happen?
Testing helps a lot. But the real life often brings surprises.

Best Regards,
Petr
