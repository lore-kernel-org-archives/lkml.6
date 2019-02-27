Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB30218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfB0JCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:02:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:55806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbfB0JCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:02:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DB0EAEBD;
        Wed, 27 Feb 2019 09:02:51 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:02:49 +0100
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
Message-ID: <20190227090249.fzigc7r237emlg6k@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
 <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
 <87o96yziau.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o96yziau.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-26 16:22:01, John Ogness wrote:
> On 2019-02-26, Petr Mladek <pmladek@suse.com> wrote:
> >> When new consoles register, they currently print how many messages
> >> they have missed. However, many (or all) of those messages may still
> >> be in the ring buffer. Add functionality to print as much of the
> >> history as available. This is a clean replacement of the old
> >> exclusive console hack.
> >> 
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 897219f34cab..6c875abd7b17 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1524,6 +1595,10 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
> >>  	for_each_console(con) {
> >>  		if (!(con->flags & CON_ENABLED))
> >>  			continue;
> >> +		if (!con->wrote_history) {
> >> +			printk_write_history(con, seq);
> >
> > This looks like an alien. The code is supposed to write one message
> > from the given buffer. And some huge job is well hidden there.
> 
> This is a very simple implementation of a printk kthread. It probably
> makes more sense to have a printk kthread per console. That would allow
> fast consoles to not be penalized by slow consoles. Due to the
> per-console seq tracking, the code would already support it.

I mean that your patch does the reply on a very hidden location.
I think that a cleaned design would be to implement something like:

void console_check_and_reply(void)
{
	struct console *con;

	if (!console_drivers)
		return;

	for_each_console(con) {
		if (con->flags & CON_PRINTBUFFER) {
			printk_write_history(con, console_seq);
			con->flags &= ~CON_PRINTBUFFER;
		}
	}
}

Then there is no recursion. Also you are much more flexible.
You could call this on any reasonable place. For example, you
could call this in the printk_kthread right after taking
console_lock and before processing new messages.


Regarding the per-console kthread. It would make sense if
we stop handling all consoles synchronously. For example,
when we push messages to fast consoles immediately and
offload the work for slow consoles.

Anyway, we first need to make the offload reliable enough.
It is not acceptable to always offload all messages.
We have been there last few years. We must keep a high
chance to see the messages. Any warning might be important
when it causes the system to die. Nobody knows what message
is such an important.


> > In addition, the code is actually recursive. It will become
> > clear when it is deduplicated as suggested above. We should
> > avoid it when it is not necessary. Note that recursive code
> > is always more prone to mistakes and it is harder to think of.
> 
> Agreed.
> 
> > I guess that the motivation is to do everything from the printk
> > kthread. Is it really necessary? register_console() takes
> > console_lock(). It has to be sleepable context by definition.
> 
> It is not necessary. It is desired. Why should _any_ task be punished
> with console writing? That is what the printk kthread is for.

I do not know about any acceptable solution without punishing
the tasks. But we might find a better compromise between the
punishment and reliability.

Best Regards,
Petr
