Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256D220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256D220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936011AbeFRJjW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:39:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935898AbeFRJjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:39:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F10DAB3D;
        Mon, 18 Jun 2018 09:39:18 +0000 (UTC)
Date:   Mon, 18 Jun 2018 11:39:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618063738.GC27996@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-18 15:37:38, Sergey Senozhatsky wrote:
> On (06/08/18 12:48), Petr Mladek wrote:
> [..]
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 6d7e800affd8..872fbdf8df26 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -148,9 +148,13 @@ void early_printk(const char *s, ...) { }
> >  #ifdef CONFIG_PRINTK_NMI
> >  extern void printk_nmi_enter(void);
> >  extern void printk_nmi_exit(void);
> > +extern void printk_nmi_direct_enter(void);
> > +extern void printk_nmi_direct_exit(void);
> >  #else
> >  static inline void printk_nmi_enter(void) { }
> >  static inline void printk_nmi_exit(void) { }
> > +static void printk_nmi_direct_enter(void) { }
> > +static void printk_nmi_direct_exit(void) { }
> 
> Can we have better names may be? Since direct printk_nmi is not
> in fact always `direct'.

What about printk_chatty_nmi_enter(), printk_large_nmi_enter()
or something similar?


> > +#ifdef CONFIG_PRINTK_NMI
> > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args);
> > +#else
> > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args) { return 0; }
> > +#endif
> 
> Hmm, printk_safe.c knows about printk.c, printk.c knows about
> printk_safe.c.

I am sorry but I do not understand the problem. The function is
defined in printk_safe.c and we need to call it also from printk.c.
It seems reasonable to declare it in kernel/printk/internal.h.


> >  __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
> >  __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> >  __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 247808333ba4..cf55bece43d9 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  	printk_delay();
> >  
> >  	/* This stops the holder of console_sem just where we want him */
> > -	logbuf_lock_irqsave(flags);
> > +	printk_safe_enter_irqsave(flags);
> > +	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
> > +		printed_len = vprintk_nmi(fmt, args);
> > +		printk_safe_exit_irqrestore(flags);
> > +		return printed_len;
> > +	} else
> > +		raw_spin_lock(&logbuf_lock);
> 
> OK... Can we do this in vprintk_func()? The race window should be super
> tiny [if matters at all], but in exchange we don't have to mix nmi, printk,
> printk_mni, etc.

You are right that it would still solve the main risk (NMI comes
inside logbuf_lock critical section).

In fact, the only real risk would be another lock serializing NMIs
and printk() called with that lock. This patch removes one in
nmi_backtrace() and I am not aware of any other.

The less hairy code really might be worth the rather theoretical risk.


> So over all I understand why you did it this way. May be I'd prefer to
> have less universal but shorter solution (e.g. modify only nmi_backtrace
> function and put there "printk_nmi_restricted_buffer"), but I won't really
> object your patch [unless I see some real issues with it].

Thanks in advance. I'll send v2 once we have a conclusion on
the function names and includes.

Best Regards,
Petr
