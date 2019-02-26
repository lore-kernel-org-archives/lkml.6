Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54827C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C19620651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfBZNLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:11:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBZNLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:11:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1458AF72;
        Tue, 26 Feb 2019 13:11:09 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:11:08 +0100
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
Subject: Re: [RFC PATCH v1 13/25] printk: track seq per console
Message-ID: <20190226131108.rr5komehfqitg6di@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-14-john.ogness@linutronix.de>
 <20190225145954.62zl3tndmo2t372h@pathway.suse.cz>
 <87lg230whd.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg230whd.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-26 09:45:02, John Ogness wrote:
> On 2019-02-25, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index ece54c24ea0d..ebd9aac06323 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
> >>  		if (!cpu_online(raw_smp_processor_id()) &&
> >>  		    !(con->flags & CON_ANYTIME))
> >>  			continue;
> >> +		if (con->printk_seq >= seq)
> >> +			continue;
> >> +
> >> +		con->printk_seq++;
> >> +		if (con->printk_seq < seq) {
> >> +			print_console_dropped(con, seq - con->printk_seq);
> >> +			con->printk_seq = seq;
> >
> > It would be great to print this message only when the real one
> > is not superseded.
> 
> You mean if there was some function to check if "seq" is the newest
> entry. And only in that situation would any dropped information be
> presented?

Not newest but not suppressed.

Example: Only every 10th message is important enough to reach
        console (see suppress_message_printing).

Instead of seeing:

message 10
message 20
7 messages dropped
20 another messages dropped because of printing the warning
20 another messages dropped because of printing the warning
20 another messages dropped because of printing the warning
message 100

see something like:

message 10
message 20
13 messages dropped
message 40
13 messages dropped
message 60
13 messages dropped
message 80
message 90
message100

The original code would print only warnings because the important
lines are lost when printing the warnings.

A better code would show more messages because the warning
is printed when a visible message is already buffered.

You might wonder why there are only 13 messages dropped in
the new state. It is because the other 6 messages are
quickly read and suspended (filtered out). They are
skipped by intention.

I hope that it will be more clear with the patch that I have
just sent, see
https://lkml.kernel.org/r/20190226124945.7078-1-pmladek@suse.com

Best Regards,
Petr
