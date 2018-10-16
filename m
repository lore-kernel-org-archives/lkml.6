Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E65FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F742086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F742086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJPTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeJPTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:30:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 636B5ACB7;
        Tue, 16 Oct 2018 11:40:07 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:40:06 +0200
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
Message-ID: <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016072719.GB4030@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-16 09:27:19, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 02:04:26PM +0900, Sergey Senozhatsky wrote:
> > Make printk_safe_enter_irqsave()/etc macros available to the
> > rest of the kernel.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  include/linux/printk.h      | 40 +++++++++++++++++++++++++++++++++++++
> >  kernel/printk/internal.h    | 37 ----------------------------------
> >  kernel/printk/printk_safe.c |  6 ++++--
> >  3 files changed, 44 insertions(+), 39 deletions(-)
> > 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index cf3eccfe1543..75f99441fd54 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -157,6 +157,46 @@ static inline void printk_nmi_direct_enter(void) { }
> >  static inline void printk_nmi_direct_exit(void) { }
> >  #endif /* PRINTK_NMI */
> >  
> > +#ifdef CONFIG_PRINTK
> > +extern void printk_safe_enter(void);
> > +extern void printk_safe_exit(void);
> > +
> > +#define printk_safe_enter_irqsave(flags)	\
> > +	do {					\
> > +		local_irq_save(flags);		\
> > +		printk_safe_enter();		\
> > +	} while (0)
> > +
> > +#define printk_safe_exit_irqrestore(flags)	\
> > +	do {					\
> > +		printk_safe_exit();		\
> > +		local_irq_restore(flags);	\
> > +	} while (0)
> > +
> > +#define printk_safe_enter_irq()		\
> > +	do {					\
> > +		local_irq_disable();		\
> > +		printk_safe_enter();		\
> > +	} while (0)
> > +
> > +#define printk_safe_exit_irq()			\
> > +	do {					\
> > +		printk_safe_exit();		\
> > +		local_irq_enable();		\
> > +	} while (0)
> 
> So I really _really_ hate all this. Utterly detest it.
> 
> That whole magic 'safe' printk buffer crap is just that crap.
> 
> Instead of this tinkering around the edges, why don't you make the main
> logbuf a lockless ringbuffer and then delegate the actual printing of
> that buffer to a kthread, except for earlycon, which can do synchronous
> output.

In fact, there is no problem with printk log buffer. This patchset
tries to avoid deadlock caused by console-specific locks
used by console->write() methods.

By other words, we neither need printk_safe or lockless log buffer
to fix this prolem. Instead, we need either printk_deferred context
or lockless consoles.

Best Regards,
Petr
