Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04749C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA5120869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeIFTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:07:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729937AbeIFTH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:07:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E14BCAF43;
        Thu,  6 Sep 2018 14:31:36 +0000 (UTC)
Date:   Thu, 6 Sep 2018 16:31:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180906143136.vqka4dsetbhjc4fs@pathway.suse.cz>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <eeada499-1624-6a6c-783a-d017301bbd86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeada499-1624-6a6c-783a-d017301bbd86@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-05 17:20:53, Hans de Goede wrote:
> HI,
> 
> On 05-09-18 13:02, Petr Mladek wrote:
> > On Wed 2018-09-05 17:33:26, Sergey Senozhatsky wrote:
> > > On (09/05/18 14:36), Sergey Senozhatsky wrote:
> > > > 
> > > > Just a demonstration of the idea. It does not look very good, tho.
> > > > I'd rather have just one suppress_message_printing() in printk code.
> > > > 
> > > > // This is not a proposed patch, hence the 80-cols violation.
> > > > 
> > > > ---
> > > > 
> > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > index c036f128cdc3..231ac18423e1 100644
> > > > --- a/kernel/printk/printk.c
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -2416,7 +2416,7 @@ void console_unlock(void)
> > > >   			break;
> > > >   		msg = log_from_idx(console_idx);
> > > > -		if (msg->flags & LOG_NOCONS) {
> > > > +		if (msg->flags & LOG_NOCONS || (exclusive_console && suppress_message_printing(msg->level))) {
> > > >   			/*
> > > >   			 * Skip record if !ignore_loglevel, and
> > > >   			 * record has level above the console loglevel.
> > > 
> > > D'oh... Sorry about that, but, believe it or not, this is completely
> > > not what I had in my mind. What I had, was something like this:
> > > 
> > > ---
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index c036f128cdc3..dadb8c11b0d6 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2416,6 +2416,11 @@ void console_unlock(void)
> > >   			break;
> > >   		msg = log_from_idx(console_idx);
> > > +
> > > +		if (exclusive_console &&
> > > +				!suppress_message_printing(msg->level))
> > > +			msg->flags &= ~LOG_NOCONS;
> > 
> > Hmm, this does not help with consoles without CON_PRINTBUFFER
> > flag. Note that the first registered console prints all messages
> > even without this flag.
> > 
> > Also there is "debug" earlyparam where we need the opposite. I mean
> > that we want to show messages that were suppressed by default.
> > 
> > I played with another solution, see the patch below. It defines
> > which messages have a valid NOCONS flag according to the msg_seq
> > number. IMHO, it is a bit more straightforward but it is still
> > a hack. I am not super happy about it.
> > 
> > 
> > Hmm, I seriously think about reverting the commit 375899cddcbb
> > ("printk: make sure to print log on console.") and solving it
> > another way.
> > 
> > For example, the commit was primary about locations that
> > wanted to make some messages always visible or always
> > suppressed. We could create LOG_FORCE_NOCONS and
> > LOG_FORCE_CONS for these two special cases.
> > 
> > 
> > 
> > Possible solution:
> 
> So do you want me to give this solution a try or was this mainly for
> discussion purposes?   If you've a fix which you think you are
> happy with and plan to merge I would be happy to try it.

It was rather for discussion purposes. I prefer the revert
for the moment.

If nobody comes with a better idea or is not against, I am going
to send the revert.

Best Regards,
Petr
